From: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>
Subject: Re: [PATCH] completion: add completer for status
Date: Fri, 28 Jun 2013 12:56:01 +0200
Message-ID: <20130628105601.GB16562@goldbirke>
References: <1372094575-20799-1-git-send-email-artagnon@gmail.com>
 <20130628102936.GA16562@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 28 12:56:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsWLZ-000571-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 12:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755631Ab3F1K4F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Jun 2013 06:56:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:56490 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755605Ab3F1K4D (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 06:56:03 -0400
Received: from localhost6.localdomain6 (g226130042.adsl.alicedsl.de [92.226.130.42])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LtQnI-1U9SgH2cgm-010y0i; Fri, 28 Jun 2013 12:56:01 +0200
Content-Disposition: inline
In-Reply-To: <20130628102936.GA16562@goldbirke>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V02:K0:sAVXXakNK0O7S6x1kA6mFuR4W4rZ9ibR4VeggGHTM7s
 Y06ynNBGiICbRGmTiuuW/zRLCuHfGqnFg+94l3/ADWGR0NlEfd
 VWapzDXtIbpnNzC9b1uyIY3jzVc6uCuOoX/qf6UR5QmKTieC9L
 L9PE8g7YHxsbraV+HpzJ3vySwkL+5MDDSwGIUsDXknBCmiKBXv
 L3nRTaI3uZcR/mCP0AQMgoxjp9qOkSU8IhcCRIU0VhFu9e/FZ1
 m3rZFjeyJF378zDOX+0d63jw2UXZ6Iuc8AsmcJ170NmArl/O46
 hPDfmvLryKiruum2fy4+yJ6PwCbGvCE2HMm5IET+tvQp3a8fOL
 oUl9F3b5jTcbHNltyPuLcwbtRdYjdQWc0JgiXT4lQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229187>

On Fri, Jun 28, 2013 at 12:29:36PM +0200, SZEDER G=E1bor wrote:
> On Mon, Jun 24, 2013 at 10:52:55PM +0530, Ramkumar Ramachandra wrote:
> > Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> > +	__git_complete_index_file
>=20
> With or without this change we can't ask for the status of a certain
> deleted file:
>=20
> $ git rm version.h
> rm 'version.h'
> $ git status=20
> # On branch master
> # Changes to be committed:
> #   (use "git reset HEAD <file>..." to unstage)
> #
> #       deleted:    version.h
> #
> $ git status v<TAB>
> varint.c   varint.h   vcs-svn/   version.c =20

Well, at least the deleted is there if I only remove it from the work
tree (i.e. use 'rm' instead of 'git rm'):

$ rm version.h
$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add/rm <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working
#   directory)
#
#       deleted:    version.h
#
no changes added to commit (use "git add" and/or "git commit -a")
$ git status v<TAB>
varint.c   varint.h   vcs-svn/   version.c  version.h =20


G=E1bor
