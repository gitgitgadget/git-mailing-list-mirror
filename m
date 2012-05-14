From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH v2] git-svn: clarify the referent of dcommit's optional argument
Date: Mon, 14 May 2012 22:48:14 +1000
Message-ID: <CAH3Anroxjn6sCBYa71Y-H1AvitiFn=dRUapGxgQ1Nu6=Tf03Uw@mail.gmail.com>
References: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, normalperson@yhbt.net, trast@student.ethz.ch,
	Jon Seymour <jon.seymour@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 14 14:48:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1STuhJ-0007YX-0U
	for gcvg-git-2@plane.gmane.org; Mon, 14 May 2012 14:48:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755938Ab2ENMsQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 May 2012 08:48:16 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49299 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755830Ab2ENMsQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 May 2012 08:48:16 -0400
Received: by wgbdr13 with SMTP id dr13so4615025wgb.1
        for <git@vger.kernel.org>; Mon, 14 May 2012 05:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=4NrcOdaqO6fGmBqC45UnVCf7UJytVdoJJFo0d60aozo=;
        b=lhmytTOeZhxdvazxE6D8xExDhKlpshOn2Br1vJ3zKzxkJAoKc2X3XnoNmJAL72EGaE
         W5gLEGZ0xBJPBckEYnTig4NRNZNsRCSPGt3dWbutwARRw7oC2haDWgZdP5JJ4hS1u3EE
         HN/GCjeGpm3fyzW+bXaMhJZbvvvnwKV6Y01k+aydGcmUu6+CkP8dgd/WjfdqAEfhPzDE
         xdpZxHuEtzJ51hxKmgFJ6dIZ8CgCCMJFR/wbN32fMBkPERqMDvpzyspWu30GX3+JtdGo
         8w0P4LMEJ+I0Bmep0huYHNgxTuAdGk0orkA/WxdkKigYo9LWjStZajlP1SUs0mHpauC5
         Drqw==
Received: by 10.180.92.130 with SMTP id cm2mr19728530wib.4.1336999694857; Mon,
 14 May 2012 05:48:14 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Mon, 14 May 2012 05:48:14 -0700 (PDT)
In-Reply-To: <1336978405-17943-1-git-send-email-jon.seymour@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197769>

On Mon, May 14, 2012 at 4:53 PM, Jon Seymour <jon.seymour@gmail.com> wr=
ote:
> The documentation of the dcommit subcommand is reworded to clarify th=
at
> the optional argument refers to a git branch, not an SVN branch.
>
> The discussion of the optional argument is put into its own paragraph
> as is the guidance about using 'dcommit' in preference to 'set-tree'.
>
> Signed-off-by: Jon Seymour <jon.seymour@gmail.com>
> ---
> =C2=A0Documentation/git-svn.txt | 14 ++++++++------
> =C2=A01 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 34ee785..27c4840 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -189,18 +189,20 @@ and have no uncommitted changes.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0last fetched commit from the upstream SVN.
>
> =C2=A0'dcommit'::
> - =C2=A0 =C2=A0 =C2=A0 Commit each diff from a specified head directl=
y to the SVN
> + =C2=A0 =C2=A0 =C2=A0 Commit each diff from the current branch direc=
tly to the SVN
> =C2=A0 =C2=A0 =C2=A0 =C2=A0repository, and then rebase or reset (depe=
nding on whether or
> =C2=A0 =C2=A0 =C2=A0 =C2=A0not there is a diff between SVN and head).=
 =C2=A0This will create
> =C2=A0 =C2=A0 =C2=A0 =C2=A0a revision in SVN for each commit in git.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0It is recommended that you run 'git svn' f=
etch and rebase (not
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pull or merge) your commits against the la=
test changes in the
> =C2=A0 =C2=A0 =C2=A0 =C2=A0SVN repository.
> - =C2=A0 =C2=A0 =C2=A0 An optional revision or branch argument may be=
 specified, and
> - =C2=A0 =C2=A0 =C2=A0 causes 'git svn' to do all work on that revisi=
on/branch
> - =C2=A0 =C2=A0 =C2=A0 instead of HEAD.
> - =C2=A0 =C2=A0 =C2=A0 This is advantageous over 'set-tree' (below) b=
ecause it produces
> - =C2=A0 =C2=A0 =C2=A0 cleaner, more linear history.
> ++
> +When an optional git branch name (or a git commit object name)
> +is specified as an argument, the subcommand works on the specified
> +branch, not on the current branch.
> ++
> +Use of 'dcommit' is preferred to 'set-tree' (below) because it produ=
ces
> +cleaner, more linear history.
> =C2=A0+

Mmmm. I wonder if I should have left the original wording of this
paragraph, but switched the order with respect to the disucssion of
the optional argument, so that the text reads:

    It is recommended that you run 'git svn' fetch and rebase (not
pull or merge) your commits against the latest changes in the =C2=A0SVN
repository.
    This is advantageous over'set-tree' (below) because it produces
cleaner, more linear history.

    When an optional git branch name (or a git commit object name) is
specified as an argument, the subcommand works on
    the specified branch, not on the current branch.

> =C2=A0--no-rebase;;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0After committing, do not rebase or reset.
> --
> 1.7.10.1.514.ge33c7ea
>
