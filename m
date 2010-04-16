From: Heikki Orsila <shdl@zakalwe.fi>
Subject: A bug in git 1.6.5.2 with git log --stat: shows a negative number
	as a size
Date: Fri, 16 Apr 2010 16:59:48 +0300
Message-ID: <20100416135948.GA26918@zakalwe.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 16 16:09:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O2mEL-0002h0-AA
	for gcvg-git-2@lo.gmane.org; Fri, 16 Apr 2010 16:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab0DPOJG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 16 Apr 2010 10:09:06 -0400
Received: from zakalwe.fi ([91.90.49.150]:43974 "EHLO zakalwe.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757268Ab0DPOJF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Apr 2010 10:09:05 -0400
X-Greylist: delayed 465 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Apr 2010 10:09:05 EDT
Received: by zakalwe.fi (Postfix, from userid 1023)
	id 059D83E494D; Fri, 16 Apr 2010 16:59:49 +0300 (EEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145064>

I'm running git version 1.6.5.2. git log --stat shows a negative
diffstat size for two files that are each 2049MiB in size.

Steps to reproduce:

$=A0for f in 0 1 ; do dd bs=3D$((1024*1024)) if=3D/dev/zero of=3D$f cou=
nt=3D2049 ; done
$=A0git add 0 1
$=A0git commit -m "test commit"
$ git log --stat
commit 6afe3d3c889daa92bd79956c4bb733eb5cb408dc
Author: Heikki Orsila <heikki.orsila@iki.fi>
Date:   2010-04-16 16:54:52 +0300

    test commit

 0 |  Bin 0 -> -2146435072 bytes
 1 |  Bin 0 -> -2146435072 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

--=20
Heikki Orsila
heikki.orsila@iki.fi
http://www.iki.fi/shd
