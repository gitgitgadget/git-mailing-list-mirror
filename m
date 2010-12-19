From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Basic Git Questions
Date: Mon, 20 Dec 2010 02:08:39 +0300
Message-ID: <20101219230839.GM3264@localhost.localdomain>
References: <AANLkTiki2e4-YD0P9kb7g-WbLTPhAXQ22R2jCAXVtjN1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Parag Kalra <paragkalra@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 20 00:09:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PUSNl-0002DT-4k
	for gcvg-git-2@lo.gmane.org; Mon, 20 Dec 2010 00:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932528Ab0LSXIo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 19 Dec 2010 18:08:44 -0500
Received: from mailhub.007spb.ru ([84.204.203.130]:46098 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932511Ab0LSXIo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Dec 2010 18:08:44 -0500
Received: from proxysrv.domain007.com ([10.8.0.42])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id oBJN8eN7004514;
	Mon, 20 Dec 2010 02:08:41 +0300
Received: by proxysrv.domain007.com (Postfix, from userid 1000)
	id D7B91B2003B; Mon, 20 Dec 2010 02:08:39 +0300 (MSK)
Content-Disposition: inline
In-Reply-To: <AANLkTiki2e4-YD0P9kb7g-WbLTPhAXQ22R2jCAXVtjN1@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Scanned-By: MIMEDefang 2.51 (www.roaringpenguin.com/mimedefang) on 192.168.2.20
X-Antivirus: Dr.Web (R) for Mail Servers on proxysrv host
X-Antivirus-Code: 100000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163973>

On Sun, Dec 19, 2010 at 02:32:41PM -0800, Parag Kalra wrote:

> 1. I generally add the files in my working directory using "git add
> .". But sometimes you want to add all the files except 1 or 2 file. I=
s
> there a shortcut way we can tell git to add all the files but exclude
> a particular file.
Use `git add .` to add all the files and then `git rm --cached` those
one or two you don't need to be committed. See the git-rm manual for
details.

> 2. Also sometime when the code is=A0committed, I realize that I have
> forgot to change or add a file. Is there a way we can we commit a fil=
e
> to existing commit number with git log showing only the old git commi=
t
> number and not creating a new one for the last commit.
`git commit --amend` does exactly that -- amends the last commit
(pointed by the HEAD ref).
If you need to modify a commit older than the last one, you have to
rebase a part of the branch starting with that commit and then edit
(amend) that commit during the rebasing process. This might have
certain caveats though, so refer to git-rebase manual.
More on rebasing can be found in various pieces of documentation and
books listed at http://git-scm.com/documentation
