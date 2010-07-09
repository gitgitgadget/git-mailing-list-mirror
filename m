From: Jonathan Nieder <jrnieder@gmail.com>
Subject: t0005 failing with ksh93 on linux
Date: Thu, 8 Jul 2010 22:08:12 -0500
Message-ID: <20100709030812.GA16877@dert.cs.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 09 05:08:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OX3wo-0007mm-SD
	for gcvg-git-2@lo.gmane.org; Fri, 09 Jul 2010 05:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752366Ab0GIDIO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Jul 2010 23:08:14 -0400
Received: from camembert.cs.uchicago.edu ([128.135.11.243]:60787 "EHLO
	smtp.cs.uchicago.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750985Ab0GIDIN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 23:08:13 -0400
X-Greylist: delayed 1299 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Jul 2010 23:08:13 EDT
Received: from dert.cs.uchicago.edu (dert.cs.uchicago.edu [128.135.11.157])
	by smtp.cs.uchicago.edu (Postfix) with ESMTP id 40028A08E;
	Thu,  8 Jul 2010 22:08:13 -0500 (CDT)
Received: by dert.cs.uchicago.edu (Postfix, from userid 10442)
	id 1D9B52038A; Thu,  8 Jul 2010 22:08:13 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150633>

Hi,

I can=E2=80=99t seem to get test-sigchain to run with ksh93 on linux:

 $ ksh
=20
 ksh>$ ../bin-wrappers/test-sigchain=20
 three
 two
 one
 Terminated
 ksh>$ echo $?
 271
 ksh>$ exit
 $ ../bin-wrappers/test-sigchain=20
 three
 two
 one
 Terminated
 $ echo $?
 143

As a result, t0005-signals.sh fails when run through that
shell.  Ideas?

$ ksh t0005-signals.sh  -v
Initialized empty Git repository in /dev/shm/alt-git/t/trash directory.=
t0005-signals/.git/
expecting success:=20
[...]
        test_cmp expect actual

not ok - 1 sigchain works
[...]
$ git describe
v1.7.2-rc2
$ ksh --version
  version         sh (AT&T Research) 93s+ 2008-01-31
$ uname -s -r -m
Linux 2.6.26-2-686-bigmem i686
