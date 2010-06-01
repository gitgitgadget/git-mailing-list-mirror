From: Antriksh Pany <antriksh.pany@gmail.com>
Subject: Re: [PATCH 8/8] Documentation/revert: describe passing more than one 
	commit
Date: Tue, 1 Jun 2010 14:28:57 +0100
Message-ID: <AANLkTilu8C68FlLkNg_3wEjRRX25TaydZCve_P4r4_X7@mail.gmail.com>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
	<20100531194240.28729.15284.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 15:29:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJRWn-0001uR-FQ
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 15:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756406Ab0FAN3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 09:29:03 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:57533 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756098Ab0FAN3A convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Jun 2010 09:29:00 -0400
Received: by gwaa12 with SMTP id a12so3528382gwa.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 06:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=eDGQ/o1pN030dVVJpbuydf5EicuLp52gPwC8/sAtw6Y=;
        b=kB3Twi8HskbRS2ERsqQO+8Qrq+tKWkPQ3m18jUhWXIXAeX6yeJNSItbTKLMwzN0BOU
         OzrA2NrdsTRhmp5QStFL6Hm4kPDhiAnj+9jYaNYJ7g6byLNrMiWJjuI1NWjwoYY9RYe7
         Q4ayZwEBoEPgZYJH2yLxaRAZixPJyRL+dCTxQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Soh3Rf3JNZSmWTVWWvoHZBQw4CFZJEUU50AsjDmtdAs3u5MhKuw0PGqwZw7M5wsBaG
         NskyU1LSbQdWF4mbi37qoedd/Ge51P3/U613mN+U8uG4j4VMMsXxB6MydTvrCzkgTnbW
         MQRD2pakprx/7AU5Z7Yrf75Zt2XWIwgvLMbQY=
Received: by 10.151.16.4 with SMTP id t4mr6212364ybi.107.1275398937281; Tue, 
	01 Jun 2010 06:28:57 -0700 (PDT)
Received: by 10.151.111.3 with HTTP; Tue, 1 Jun 2010 06:28:57 -0700 (PDT)
In-Reply-To: <20100531194240.28729.15284.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148113>

On Mon, May 31, 2010 at 8:42 PM, Christian Couder
<chriscool@tuxfamily.org> wrote:
> And while at it, add an "Examples" section.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> =A0Documentation/git-revert.txt | =A0 52 ++++++++++++++++++++++++++++=
-------------
> =A01 files changed, 35 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.=
txt
> index c66bf80..5740f37 100644
> --- a/Documentation/git-revert.txt
> +++ b/Documentation/git-revert.txt
> @@ -3,20 +3,22 @@ git-revert(1)
>
> =A0NAME
> =A0----
> -git-revert - Revert an existing commit
> +git-revert - Revert some existing commits
>
> =A0SYNOPSIS
> =A0--------
> -'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <comm=
it>
> +'git revert' [--edit | --no-edit] [-n] [-m parent-number] [-s] <comm=
it>...
>
> =A0DESCRIPTION
> =A0-----------
> -Given one existing commit, revert the change the patch introduces, a=
nd record a
> -new commit that records it. =A0This requires your working tree to be=
 clean (no
> -modifications from the HEAD commit).
>
> -Note: 'git revert' is used to record a new commit to reverse the
> -effect of an earlier commit (often a faulty one). =A0If you want to
> +Given one or more existing commits, revert the changes that the
> +related patches introduce, and record some new commits that record
> +them. =A0This requires your working tree to be clean (no modificatio=
ns
> +from the HEAD commit).
> +
> +Note: 'git revert' is used to record some new commits to reverse the
> +effect of some earlier commits (often only a faulty one). =A0If you =
want to
> =A0throw away all uncommitted changes in your working directory, you
> =A0should see linkgit:git-reset[1], particularly the '--hard' option.=
 =A0If
> =A0you want to extract specific files as they were in another commit,=
 you
> @@ -26,10 +28,13 @@ both will discard uncommitted changes in your wor=
king directory.
>
> =A0OPTIONS
> =A0-------
> -<commit>::
> - =A0 =A0 =A0 Commit to revert.
> +<commit>...::
> + =A0 =A0 =A0 Commits to revert.
> =A0 =A0 =A0 =A0For a more complete list of ways to spell commit names=
, see
> =A0 =A0 =A0 =A0"SPECIFYING REVISIONS" section in linkgit:git-rev-pars=
e[1].
> + =A0 =A0 =A0 Sets of commits can also be given but no traversal is d=
one by
> + =A0 =A0 =A0 default, see linkgit:git-rev-list[1] and its '--no-walk=
'
> + =A0 =A0 =A0 option.
>
> =A0-e::
> =A0--edit::
> @@ -59,14 +64,13 @@ more details.
>
> =A0-n::
> =A0--no-commit::
> - =A0 =A0 =A0 Usually the command automatically creates a commit with
> - =A0 =A0 =A0 a commit log message stating which commit was
> - =A0 =A0 =A0 reverted. =A0This flag applies the change necessary
> - =A0 =A0 =A0 to revert the named commit to your working tree
> - =A0 =A0 =A0 and the index, but does not make the commit. =A0In addi=
tion,
> - =A0 =A0 =A0 when this option is used, your index does not have to m=
atch
> - =A0 =A0 =A0 the HEAD commit. =A0The revert is done against the
> - =A0 =A0 =A0 beginning state of your index.
> + =A0 =A0 =A0 Usually the command automatically creates some commits =
with
> + =A0 =A0 =A0 commit log messages stating which commits were reverted=
=2E =A0This
> + =A0 =A0 =A0 flag applies the changes necessary to revert the named =
commits
> + =A0 =A0 =A0 to your working tree and the index, but does not make t=
he
> + =A0 =A0 =A0 commits. =A0In addition, when this option is used, your=
 index
> + =A0 =A0 =A0 does not have to match the HEAD commit. =A0The revert i=
s done
> + =A0 =A0 =A0 against the beginning state of your index.
> =A0+
> =A0This is useful when reverting more than one commits'
> =A0effect to your index in a row.
> @@ -75,6 +79,20 @@ effect to your index in a row.
> =A0--signoff::
> =A0 =A0 =A0 =A0Add Signed-off-by line at the end of the commit messag=
e.
>
> +Examples
> +--------
> +git revert HEAD~3::
> +
> + =A0 =A0 =A0 Revert the changes specified by the fourth last commit =
in HEAD
> + =A0 =A0 =A0 and create a new commit with the reverted changes.
> +
> +git revert -n master\~5..master~2::

Is the backslash correct?

> +
> + =A0 =A0 =A0 Revert the changes done by commits from the fiveth last=
 commit

'fifth' instead of 'fiveth' may be more appropriate :)

> + =A0 =A0 =A0 in master (included) to the third last commit in master
> + =A0 =A0 =A0 (included), but do not create any commit with the rever=
ted
> + =A0 =A0 =A0 changes. The revert only modifies the working tree and =
the
> + =A0 =A0 =A0 index.
>
> =A0Author
> =A0------
> --
> 1.7.1.361.g42de.dirty
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
