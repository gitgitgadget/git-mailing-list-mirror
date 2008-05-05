From: Christian Couder <chriscool@tuxfamily.org>
Subject: Documentation status (was Re: [PATCH 3/3] Documentation: convert tutorials to man pages)
Date: Mon, 5 May 2008 05:48:58 +0200
Message-ID: <200805050548.58905.chriscool@tuxfamily.org>
References: <20080502053051.c8066c4e.chriscool@tuxfamily.org> <200805030604.32123.chriscool@tuxfamily.org> <7vfxszuvs6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	"J. Bruce Fields" <bfields@fieldses.org>,
	"Manoj Srivastava" <srivasta@ieee.org>,
	"Ping Yin" <pkufranky@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 05 05:45:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsrdX-0008KI-MN
	for gcvg-git-2@gmane.org; Mon, 05 May 2008 05:45:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757169AbYEEDoM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 May 2008 23:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757408AbYEEDoK
	(ORCPT <rfc822;git-outgoing>); Sun, 4 May 2008 23:44:10 -0400
Received: from smtp1-g19.free.fr ([212.27.42.27]:43676 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755543AbYEEDoH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2008 23:44:07 -0400
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 95DAB1AB2BA;
	Mon,  5 May 2008 05:44:05 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 379491AB2AE;
	Mon,  5 May 2008 05:44:05 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vfxszuvs6.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81221>

Le samedi 3 mai 2008, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > About man page sections, Perl is consistent because every thing is =
in
> > section 1.
>
> I do not think it is a good example to follow, though.

I agree.

> > Now for git we already have git commands in section 1 and some
> > other documentation (gitattributes, gitignore, gitmodules) in secti=
on 5
> > and "git" in section 7. Do we want to keep "git" alone in section 7=
 and
> > put tutorials in section 1 ? Or put everything in section 1 ?
>
> My preference is to move git(7) to git(1) because it is describing a
> command at the end-user level (distros are much better than us to com=
e up
> with a way to deal with conflict resolution between us and the other
> git), keep file format description in section 5 (that's where they be=
long
> to).

Ok, I will do that.
Then what about tutorials (that I put in section 7) ?

After the patch I just sent and if I move git(7) to git(1) we will have=
:

Section 1:

git, gitk, git-COMMAND

Section 5:

gitattributes gitignore gitmodules githooks gitdiffcore gitrepository-l=
ayout

Section 7:

gitcli gittutorial gittutorial-2 gitcvs-migration giteveryday=20
gitcore-tutorial gitglossary

The logic is:

- the commands are in section 1 with a name git-COMMAND
- the documents about files and file formats are in section 5 with a na=
me=20
gitSTUFF so that it is different from commands
- the tutorials and manual stuff are in section 7 with a name gitSTUFF =
so=20
that it is different from commands

Jakub suggests to use "git-core-tutorial" instead of "gitcore-tutorial"=
=20
and "git-repository-layout" instead of "gitrepository-layout" but=20
that would break the gitSTUFF logic for section 5 and 7, except if we d=
ecide=20
to name everything git-STUFF in these sections too.

Naming everything "git-STUFF" also makes "git help STUFF" works with no=
 code=20
change, and is perhaps more readable.

Then there are also the following documents that I may not convert to m=
an=20
pages:

- howto-index:

This file lists and describes the documents in the "howto" directory. T=
here=20
are 11 documents in this directory but only 2 of them are converted by =
the=20
Makefile into HTML. And those that are converted have their own formati=
ng=20
rules according to the Makefile. So in the current state there is no po=
int=20
to convert the "howto-index".

- user-manual:

It also has its own formatting rules. But it may be usefull to convert =
it=20
though it will be big (the .txt has 4550 lines).

- git-tools:

It lists and describe the git related tools, but seems a bit outdated a=
nd=20
does not follow the gitSTUFF convention.=20

- technical/*

Only the api-* documents here are converted to HTML and many of them ar=
e=20
stubs. They have their own formating rules too.

Thanks,
Christian.
=20
