From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Introducing vcsh - manage config files in $HOME via fake bare git repositories
Date: Tue, 20 Dec 2011 07:55:04 +0530
Message-ID: <CAMK1S_hc4H7rUSY=SSR0EZwgBLy9CGa7b5H44eP6=fw+YC-inw@mail.gmail.com>
References: <CAD77+gTO35ZFdcOjTEEcymgDKMq4Uh3JZcqgXWR07kGksfkBqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Richard Hartmann <richih.mailinglist@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 03:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcpOC-0004sA-8b
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 03:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab1LTCZH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 19 Dec 2011 21:25:07 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:43525 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751490Ab1LTCZF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 21:25:05 -0500
Received: by obcwo16 with SMTP id wo16so2099814obc.19
        for <git@vger.kernel.org>; Mon, 19 Dec 2011 18:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=fEJpmxcM9jl78J1RRs0tNfAao51cDMGcqTw99qPU0CI=;
        b=d/fQ26H+SFTqb4KMdBiiAqKRS9/sf1etPk6+L1JuEjbcnuBtbBeFSq5YS4xm0WsbTo
         mRxE7IXGH1Li5qb62CLUn9Wx3+CUfmGo2e9JS1oa+Xy2tM2AdUFGgcaAYoxIh94TP1HZ
         EiiWLm7dXy/JP1c6iKamH30CY4VmddxIUxoJM=
Received: by 10.182.221.72 with SMTP id qc8mr107346obc.49.1324347904825; Mon,
 19 Dec 2011 18:25:04 -0800 (PST)
Received: by 10.182.50.129 with HTTP; Mon, 19 Dec 2011 18:25:04 -0800 (PST)
In-Reply-To: <CAD77+gTO35ZFdcOjTEEcymgDKMq4Uh3JZcqgXWR07kGksfkBqg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187496>

On Tue, Dec 20, 2011 at 5:47 AM, Richard Hartmann
<richih.mailinglist@gmail.com> wrote:
> Hi all,
>
>
> some of you may be familiar with fake bare git repositories[1].
>
> Basically, they allow you to keep the git directory and its working
> directory separate from each other. This allows you to have an
> arbitrary number of repositories with working trees in $HOME. That, i=
n
> turn, allows you to have one repo for zsh, one for vim, one for git,
> etc pp.

My method is to put everything in one repo (I call it "hobbits" --
little things that save the world, heh).

My reasoning is that nothing is an island.  I am a heavy user of vim,
fugitive (git plugin for vim), tig, and ranger, and at least these 4
are linked to each other.  You could argue that I should use
submodules or gitslave or something but I keep it simple.  Even my
"irssi" settings are tied into that, because of certain macros I use
to reply quickly to queries.

There's a piece of my ".additional.bashrc" that automatically symlinks
everything that are best left in $HOME (like ~/.gitconfig) and sets up
environment variables for everything else (like TIGRC_USER) that can
get along without.

There are 2 helper scripts.  One packs all of this into a tarball so I
can easily untar it on any machine on which I have to work
temporarily, and the other cleans up the unpacked directory and
symlinks when I leave.

Just offering a different perspective.

regards

sitaram

>
> vcsh[2] is a front-end for dealing with fake bare git repos, i.e. it
> saves you a lot of typing and automates many things. It's written in
> pure POSIX shell.
>
>
> vcsh's userbase is slowly expanding and as it's feature set and synta=
x
> are stable and there are no known bugs I think this is a good time to
> try to increase adoption rate. I strongly believe that a lot of peopl=
e
> on this list could benefit from using it; hopefully you agree.
> Publishing it here makes sense as if you are reading this, you are
> obviously familiar with and using git already, anyway.
>
> Feedback is very welcome. Good, bad or indifference, I will take it a=
ll.
>
> Two notes:
>
> * There is no test suite, yet. If anyone has a suggestion as to which
> test suite has a reasonable feature set while having a syntax that
> does not make you violently sick, or is even interested in helping to
> write said test suite, do let me know.
> * I am pondering renaming/aliasing vcsh to git-fbare.sh or similar.
> That has a few issues, though..
> ** extra typing involved
> ** adds another command level of to otherwise standard git commands,
> for example `git fbare zsh commit -a -m 'new feature'`
> ** forces everyone to have a default location for vcsh repos
>
>
> Regards,
> Richard
>
> [1] http://lists.madduck.net/pipermail/vcs-home/2011-April/000378.htm=
l
> [2] https://github.com/RichiH/vcsh
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml



--=20
Sitaram
