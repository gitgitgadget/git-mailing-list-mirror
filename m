Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB08C433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38222619CE
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 20:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhCWUbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 16:31:49 -0400
Received: from mout.web.de ([212.227.15.14]:57061 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233371AbhCWUbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 16:31:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616531485;
        bh=b6h5QVEumMHIsW5nPvh55OiRv7k2DFJxHQ6IfisHBAI=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kxqYCehVf2T4nNvQJMKRhzs/SJzFvfsUPyJOqEGOQ9buoChRvbQCK0ILenkwJqJ4F
         mSZxz+8G4pmV2IXfCIkyysDCkA0pcR0Xr8pET3RD89hUF8reMjBPtFpouFv3gH4C+3
         CL7vH6asuyitZxkyU34dTH9o0yxwHj3tgmDJA9zw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqoAk-1ltAgZ1BtS-00ePBt; Tue, 23
 Mar 2021 21:31:25 +0100
Date:   Tue, 23 Mar 2021 21:31:24 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Madhu <enometh@meer.net>, git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
Message-ID: <20210323203124.oxzqad2wmedelstu@tb-raspi4>
References: <xmqq7dlz94by.fsf@gitster.g>
 <20210322.143437.212295420302618690.enometh@meer.net>
 <xmqqr1k76p8d.fsf@gitster.g>
 <20210323.092748.1559327071188512317.enometh@meer.net>
 <xmqqr1k64bmk.fsf@gitster.g>
 <20210323165335.urvvccwnhahxmokt@tb-raspi4>
 <xmqqo8f93gsd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqo8f93gsd.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:g8fVnlA0V7FJxzf4qROn2nT/qE/1vpCI/eOdKJmlEWuMVUqsj3T
 udSChP+74p6j+YhAJDCuLyrzXYda1gJHoitH338Af0aSWnyy6Sg7+dD6GLFzklKfm9aV5YN
 DPTclX/v8vehvMGHcpUT6F3SLAOwM3/MFH+BAVqKcdKHMt4jMYe4GXvYDSPxisNrJWn9Q5P
 x/U6qptwzSLtVBUyNRwjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a815x+45i5w=:4wzsucGw8VHCHtbzNcbVkQ
 ctxoDScXpmfIE2O5NbEJAJ10oRJsMPhZ2MRImq3AeOn0M7V6ieB2as502NxJi4qLji5zVuKYn
 webPNtzHsnsxyiygqhskfhZy/3RyGzWnb7leANC6DEd//yxK6wGUlcZXXaoHBBc84Z7gMEipP
 IkJCsnvQWz8fga8fkhRwvTPSNUqBbdzF0ZF3g7MiLeuRSccEQLS5KhrgL/B3MvO1O+kvw90fa
 zE0ESqgAj3qkc6xp+M3AFAyGbYEiX2oqGZy+K+gn0LBlyg7GsLZq1dIW2mnUa4y4pt90t5MK5
 bYYOsdQm5l+77rZqTqW+AZF9fbEcxziBdXIHkjKDIbsCFAT2L0jSjy6shmSD+DT3jz2QEIb1j
 EL0e5OaWVshn+5DI7wqN/clDgg/eN0PAxKvAjxsv6HXjCykYNTVHh/b97G0i10ZI3qMzSRkXb
 iWtZQvX/HB9rWzlhKMgApt8IgzPXeGF9vUiBYOZIGXaPEEYgC507j4oGcE+jNFi73SPcL7udB
 m6KIO2ETkzH9rkGbyRWqPlA2q5NWNIL4H450bwBu6ejg/4bZlYKMkghQAvIw342xYYdNge4LP
 kXKtRFUN0reuPtoP/2QfGNv18KeUJBcdJkfPiCqRXVqv+C2pxea0fY07P/yVx/REK8lsFdwKq
 vMPlrwW5ncEgZMTnZYM1s8mJzBG8S+DfTEOpUS2nMvyg1M5Rk+/Hz/NDJ8MC7oxVSp7CPCh9A
 Cw1wVaZGt3Z6I8SleCf29iIDqA1vfgH828f/L6ugt4byosaKuWd8eHm0i7YK+WqZve9OOMBvb
 IqHpLMf5XPbDVr3Cy1FEM6ZK3XbQz9toBmR7faF+5ynG82msQiRHygMofRfCy46NS3uDCImLW
 pIzQs5equQ0PcV2p6UxQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 23, 2021 at 10:45:38AM -0700, Junio C Hamano wrote:
> Torsten B=F6gershausen <tboegi@web.de> writes:
>
> > In the very long run, there may be room for improvements:
> > While core.filemode works for a loal repo on a local disk,
> > there are lots of cases where I whish a better handling.
>
> But that is why we have multiple worktrees and per worktree
> configuration, no?
>
> Fundamentally, you cannot share a worktree from two systems and let
> one work with filemode on while the other with filemode off, as you
> summarized here:
>
> > Exporting a git repo from e.g.
> > Linux/ext4 to MacOs : Linux sees the execute-bit as is, MacOs has it a=
lways on
> > Linux/ext4 to Windows : Linux sees the execute-bit as is, MacOs has it=
 always off
> >
> > Visiting the same repo under Git-for-Windows and cygwin:
> > cygwin supports the executable bit, Git-for-Windows does not.
>
> The "new-workdirs" was a cute hack that was quite useful before the
> multiple worktree support materialized, and it and (proper) worktree
> share the quirk that by default the per-repo configuration file is
> shared.
>
> > And now we have the worktree (which may cross filesytem borders)
> >
> > Today there are many use cases, where a single config variable is not =
ideal.
> >
> > If there is a chance to have a "core.filemode=3Dauto", which does prob=
e the
> > filemode for this very OS/filesytem/worktree combination:
> > I would be happy to test/review/mentor such a code change.
>
> I do not think we want to go there.  filemode is not the only thing
> that would be shared.  What do you want to do with core.eol=3Dnative,
> for example?  Paths touched while switching branches get the 'native'
> line endings on the system that the user happened to be on when the
> "switch" command was run, and working tree files end up with mixture?

I don't intend to solve all possible confusions caused by sharing all
config variables - just this very one.

After some thinking, the following may illustrate a brute-force method,
not nice, neither optimized, nor perfect or bug free:

$ alias
alias git=3D'~/bin2/git.sh'

cat ~/bin2/git.sh

#!/bin/sh

probe_executable()
{
  touch $$.xxx
  if test -x $$.xxx; then
    rm $$.xxx
    echo "-c core.filemode=3Dfalse"
    return
  fi
  chmod +x $$.xxx
  if ! test -x $$.xxx; then
    rm $$.xxx
    echo "-c core.filemode=3Dfalse"
    return
  fi
  rm $$.xxx
  return
}
git $(probe_executable) "$@"
