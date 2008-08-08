From: =?ISO-8859-1?Q?=22Peter_Valdemar_M=F8rch_=28Lists=29=22?= 
	<4ux6as402@sneakemail.com>
Subject: How to fix (and find) many git-* --check errors?
Date: Fri, 08 Aug 2008 14:49:00 +0200
Message-ID: <489C40BC.8000008@sneakemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 14:50:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRRQ2-0003QC-2E
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 14:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752031AbYHHMtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 8 Aug 2008 08:49:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751720AbYHHMtG
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 08:49:06 -0400
Received: from morch.com ([193.58.255.207]:47542 "EHLO morch.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbYHHMtF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 08:49:05 -0400
Received: from [192.168.1.214] (ANice-157-1-71-161.w90-36.abo.wanadoo.fr [90.36.206.161])
	by morch.com (Postfix) with ESMTP id 18708278E
	for <git@vger.kernel.org>; Fri,  8 Aug 2008 14:51:33 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080724)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91661>

We have > 37000 white space "errors" in HEAD, mostly trailing=20
whitespace, and I'm looking for a

$ git diff --check | git??? --whitespace=3Dfix

command.

Is there such a beast?

I see that git-apply has a --whitespace=3D<action> option, but I don't=20
seem to grock how to be able to use it for fixing my working directory.

Details follow:

I can create a perl script that does this for me (e.g. inspired by=20
1.5.6's hooks/pre-commit's perl version of git diff --check) and post i=
t=20
here if anybody would like it, but I'd rather use some well-tested=20
method if one exists. And it seems git-apply has the functionality some=
how.

Of course, I can also:

$ git diff --check > tmpcfile
# (Or some other command to find all of them under ./)
$ vim
:cfile tmpcfile

Thank you for --check having a handy output format, BTW! But I prefer=20
automation (and automated auditing of the results) for 37000 lines.

Also the way I found them is like this:

$ git diff --check $(git log --pretty=3Dformat:%H | tail -1)..HEAD .

(The diff between "the empty commit" and HEAD - well between the first=20
commit and HEAD anyway. Is there a ref for "totally empty" or the=20
revision before the first commit? Or a more elegant way to get this lis=
t?)

Peter
--=20
Peter Valdemar M=F8rch
http://www.morch.com
