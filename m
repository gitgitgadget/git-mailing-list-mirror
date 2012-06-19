From: =?ISO-8859-1?Q?J=F6rg_Olschewski?= <jo@bitvalve.org>
Subject: git-svn v1 layout migration even though there was no git-svn layout
Date: Tue, 19 Jun 2012 21:43:44 +0200
Message-ID: <4FE0D670.5000504@bitvalve.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 19 21:50:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sh4Rd-0001jr-67
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jun 2012 21:50:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754806Ab2FSTu0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Jun 2012 15:50:26 -0400
Received: from mail.bitvalve.org ([78.47.24.65]:60297 "EHLO mail.bitvalve.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754784Ab2FSTuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jun 2012 15:50:24 -0400
X-Greylist: delayed 381 seconds by postgrey-1.27 at vger.kernel.org; Tue, 19 Jun 2012 15:50:23 EDT
Received: from [192.168.2.102] (dslb-178-001-228-175.pools.arcor-ip.net [178.1.228.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.bitvalve.org (Postfix) with ESMTPSA id AE7F216C94
	for <git@vger.kernel.org>; Tue, 19 Jun 2012 21:44:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:13.0) Gecko/20120616 Thunderbird/13.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200231>

Sometimes I accidentally try to fetch changes by doing a "git-svn fetch=
"=20
in a git repository that is not connected to any SVN repository.
Then git tells me that data from a previous version of git-svn exists,=20
and migrates to a new git-svn layout.
I think this is unexpected and unintended behavior and thus I consider=20
this to be a bug.

How to reproduce:

   $ git init tmp && cd tmp && git svn fetch
   Initialized empty Git repository in /home/jo/tmp/.git/
   Migrating from a git-svn v1 layout...
   Data from a previous version of git-svn exists, but
       .git/svn
       (required for this version (1.7.11) of git-svn) does not exist.
   Done migrating from a git-svn v1 layout
   [svn-remote "svn"] unknown

   $

I would expect some output like "this is not a git-svn layout", but=20
maybe I miss a point here?

Best regards
J=F6rg
