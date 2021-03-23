Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A1FC433C1
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 763E2619B4
	for <git@archiver.kernel.org>; Tue, 23 Mar 2021 16:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbhCWQyM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Mar 2021 12:54:12 -0400
Received: from mout.web.de ([212.227.15.3]:46269 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhCWQxp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Mar 2021 12:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1616518416;
        bh=2Lx0YAmVCzxiHbQ9CqIk/EfXgAfq4wby7VcJ7ee/sQM=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=MoXsWVonYRB1ia/M1fifKSKtsF58F3sXw8ik/XZ7GuSo4M7AmwwpoQ8AHeE6Q2s+B
         CtOctSj3H0pqVmhCTk9Z3HrfrdMYQC1+PGvybbRIHotQZQWnVoLwlzKbVqgrkU1Ufu
         3AgCv9WpzyD0jC82LD6XQL1ukWMqB1+3zDGNwAxw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LdrkJ-1m6dpD28N1-00j2Eb; Tue, 23
 Mar 2021 17:53:36 +0100
Date:   Tue, 23 Mar 2021 17:53:35 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Madhu <enometh@meer.net>, git@vger.kernel.org
Subject: Re: [PATCH] init: don't reset core.filemode on git-new-workdirs.
Message-ID: <20210323165335.urvvccwnhahxmokt@tb-raspi4>
References: <xmqq7dlz94by.fsf@gitster.g>
 <20210322.143437.212295420302618690.enometh@meer.net>
 <xmqqr1k76p8d.fsf@gitster.g>
 <20210323.092748.1559327071188512317.enometh@meer.net>
 <xmqqr1k64bmk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1k64bmk.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:Fl8yShPWUnbNEyXEpQPrOSsQWndbkPbkrv0+k0B1YBi9CHBlQjv
 iE95y6TbcvQE8WkZ8diThgWnDjjQ++5uVWXVRSnZgbsOerZSOImqhNWUR2WT+iwf+Yc/q05
 ddsJXSB0tVGfQRgOnE0K9/oi362+4nbLn0Bmte/5Xvk6LtN6w2qHpGZg+GiB+yKCtDAtaKO
 4avx5F57AmXb2/W+Bl2QQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u+sIClq3/Q4=:L7N1PDbqCEnsuj77CKQRH8
 /KP+52ESJHWN9erXV1B6sqhAVeMKPPaZ77iMifRA50w1Ydu0Kjf6bNStSoaIKduiJfAgxyH5v
 6brReH0/di6Wwb2K0ZjuH8rW008X3SCUIu7dgIuqGgjVEQoRCFQGpd4t8oLIKUm1q0AKPKruk
 6ZRfs9rSTeTI8qHAbpxN9ye/BOZSX1cbEczcE8sjDq5FFh+cnRLLtviALlusY0nazuGpZwxh/
 rjlsuxk//+IZUl1YrkxoN9zIf1u0XS7CP/l962bDCvGYhiAlp2XHogRuCj5a+Ok8tkW6832j3
 O0vTFrHo1tmfxk7n4dacpNUMNYSpXUtFXU0ZpR7OGOVhyL0ReJxhkjYtuZQ9iQAoXsCoqWPK0
 qfQ2fAEisjA7YT0QXUAWMiy77xA1pKhFnzeade1UOgwxCcpJl76ZXCTFt8oawau3PPgxpGUym
 i241OPYdvdvvUku/t3vO7LNkiqK5SMIWWukExImgX+XRyrKJgFELCWGOKDhDF7dDREjZ1BIac
 aqPvdOWZGkEglmAqFaKOJJhhtztz6otsDEQoVvOfadaFPchc/ofjX9Y7VRQPUjSC1CvYJn9bQ
 HP/rCZ47n3uSh4HRWujhyQbbAWon/m5RL/WFWTGptXtCrq3KX20aI/2YvObrgD6qocAWj4YQ8
 pmSfrEuaXfUpJmA/VpklW6+s8Kg4ExJA8UHkXHCrIhcc66hWG3NcNYwzuU/q6vFnJUxP8HzKA
 UdcNZ3a2aJj/hw6bLZ41b82bHIpUNumqimIUX4A6965GL0smJfzHJ9XEuQMUT8rR3n8qzSQ1u
 dpmPNKijot8Xs53WjZVklKTNIuq22ogSzKWNuT/TAAZx5nHhOj8oYGf9rYVk00Xc8WXf0ItGJ
 Nm+b+6JLhIOcIY6gizcCHzts2iyi/YCKgA15wsQp/bOsDuw0RjhTb+H2rRfCws3qAyXcH0d8M
 Tzd0h9giuo2p5bK47TECtfcESI+mWLCrQO+gTeamzKA+L4s1jk8Gmv5hg70XgP/RQ3WMWO5S8
 Z9cgMdlDzFCCzE6x/61Cva9L0HnAOLutev27t+OLVgJ40rtXSGOz5VPxfUETPqXLLcPcfLrLB
 ylIxaB3Uk1f9jrI4NvebF/Xpq9HN1b2NG+2G8fj5UFbpFHy/7p+GMdMdUcgd3FDGnkNv77OLq
 sDzQWCsRdZAu23IY4zBwUIVxr3UXISxS9AKYuubcc2uHAbzfXfUWWm/UB/mY2IVMwTpBc=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 11:39:31PM -0700, Junio C Hamano wrote:
> Madhu <enometh@meer.net> writes:
>
> > Avoiding the filemode check completely during reinit is ok with me
> > because it gave me wrong results.  I can't speak for the original
> > author of the code - if his intention was to do it explicitly as part
> > of "reinitialization".
>
> As the original author of the code, I know I meant filemode check to
> be done and redone upon reinitialization in 4f629539 (init-db: check
> template and repository format., 2005-11-25).
>
> But then when 75d24499 (git-init: autodetect core.symlinks,
> 2007-08-31) started to autodetect symbolic link support, I somehow
> ended up doing it only upon the repository creation.  Later,
> 2455406a (git-init: autodetect core.ignorecase, 2008-05-11) imitated
> to check case sensitivity in the same block, doing it only once.
>
> Either of these two commits would have been a good chance for us to
> realize that filemode check should be done the same way, but somehow
> nobody noticed X-<.
>

In the very long run, there may be room for improvements:
While core.filemode works for a loal repo on a local disk,
there are lots of cases where I whish a better handling.

Exporting a git repo from e.g.
Linux/ext4 to MacOs : Linux sees the execute-bit as is, MacOs has it alway=
s on
Linux/ext4 to Windows : Linux sees the execute-bit as is, MacOs has it alw=
ays off

Visiting the same repo under Git-for-Windows and cygwin:
cygwin supports the executable bit, Git-for-Windows does not.

And now we have the worktree (which may cross filesytem borders)

Today there are many use cases, where a single config variable is not idea=
l.

If there is a chance to have a "core.filemode=3Dauto", which does probe th=
e
filemode for this very OS/filesytem/worktree combination:
I would be happy to test/review/mentor such a code change.
