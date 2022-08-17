Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB3DC25B0E
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 01:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiHQB1w (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 21:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238251AbiHQB1b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 21:27:31 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0263595AF0
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 18:27:03 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id j1so4381033qvv.8
        for <git@vger.kernel.org>; Tue, 16 Aug 2022 18:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=g0m+6HflTDLr1S4AaJBqo3cF9Ob0D3VdTMQbCYRzzgU=;
        b=TIBRZvqCjOr/bstfFNrgUA+uKMZtGXi4fx4cYUkiEmJQLxfjY6zFsyFCdm+2MUP4ZD
         L1KSjQvxZfJ0bIxlL39rYkuKkI0jnCkliWFLEEYIE2r1uF4Rpei8TrPNNRjlQn9cHav0
         qP+NzdTWIGlvzhbRww6ZQpu+u80U7Awik5hzBU61ywL+nkDEXS0FhUosXqZGeEWSJ/hv
         8s/cbKXJYTO2Srb/bElIn1jOLxDljVahephC+jCKFFDtyark500Bd2jGM+4ICqRTdKas
         FZZRm7u8vSkHZd4o4aRvRnMzRs4v8s2wcUOgI2OJdlx+bQ663DDoE94oo3ZnFNoyzG7r
         PodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=g0m+6HflTDLr1S4AaJBqo3cF9Ob0D3VdTMQbCYRzzgU=;
        b=h9RwkGQxeiTzwLnf7PfIeICfZ8ZN6AuT9tcRWHIPG/cQyfNt/8Z7uLdN44DHvsSQWg
         hUm6+/ENF0+P0Ze7DW61whHeddss3qAZZZ8c1KA723KbJBcf8D1pyGIMvcX4RgTjBIFx
         05lsvuc845hWpWOhwjpcrCQziATNOATZGAhSp8o+Owx+AaYtujPw683gle1tZFHkGJ9j
         H9iOvVJzRKtQUKHZrZOOpi0xj+3GwuvF9Cd4zSrmJ0MRuMhz5NlPSzrKtYJmpaRgOZXd
         2Ije9CjsxZBYOGLiy6KPwIRwbUwZgJgBkMJeJ5FAVP3DxcmKpcLfCwxpZ+34sEIq8g6Z
         kUkQ==
X-Gm-Message-State: ACgBeo0UcosC12/Kddz05M9I5FxAuXMBhv4YdSNt/PHEz5oV9g1kBE3A
        SVIjWyRFyj2sxbvDmowx9rNu9H++nl5uwq2o34AjfyY0A8o=
X-Google-Smtp-Source: AA6agR7MRvM5QdjUnfELAQ7ZCf35JPksmjlk4dnnC7+kS2xUvtW3ZlDcM9G5nqHFIkHhLLj37jVFf8io3ITtz5WZa6A=
X-Received: by 2002:a05:6214:62a:b0:476:858d:b2c8 with SMTP id
 a10-20020a056214062a00b00476858db2c8mr19726844qvx.65.1660699622040; Tue, 16
 Aug 2022 18:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq5yityzcu.fsf@gitster.g> <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
In-Reply-To: <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 16 Aug 2022 18:26:51 -0700
Message-ID: <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022, #05;
 Mon, 15)
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, Aug 16, 2022 at 3:49 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Junio,
>
> On Mon, 15 Aug 2022, Junio C Hamano wrote:
>
> > * js/bisect-in-c (2022-06-27) 16 commits
> >  - bisect: no longer try to clean up left-over `.git/head-name` files
> >  - bisect: remove Cogito-related code
> >  - Turn `git bisect` into a full built-in
> >  - bisect: move even the command-line parsing to `bisect--helper`
> >  - bisect: teach the `bisect--helper` command to show the correct usage=
 strings
> >  - bisect--helper: return only correct exit codes in `cmd_*()`
> >  - bisect--helper: move the `BISECT_STATE` case to the end
> >  - bisect--helper: make `--bisect-state` optional
> >  - bisect--helper: align the sub-command order with git-bisect.sh
> >  - bisect--helper: using `--bisect-state` without an argument is a bug
> >  - bisect--helper: really retire `--bisect-autostart`
> >  - bisect--helper: really retire --bisect-next-check
> >  - bisect--helper: retire the --no-log option
> >  - bisect: avoid double-quoting when printing the failed command
> >  - bisect run: fix the error message
> >  - bisect: verify that a bogus option won't try to start a bisection
> >
> >  Final bits of "git bisect.sh" have been rewritten in C.
> >
> >  Expecting a (hopefully final) reroll.
> >  cf. <20627.86ilolhnnn.gmgdl@evledraar.gmail.com>

Junio: This link came up dead for me; I think the intended link was
220627.86ilolhnnn.gmgdl@evledraar.gmail.com ?

> >  source: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
>
> I had another look at the thread and did not see any feedback that focuse=
s
> on the actual scope of the patch series. Conversions from scripted parts
> of Git to built-ins are always a bit finicky (and hard to review, I
> admit).
>
> Therefore I would like to move the status to "needs review".
>
> I do not think that there are any major issues with it (=C3=86var's feedb=
ack
> notwithstanding, it focuses on tangents that should be addressed after th=
e
> conversion, to avoid losing focus), but I would love to see a thorough
> review of the conversion to avoid obvious regressions like the one in the
> built-in interactive `add` I had to fix recently.

I reviewed it --
https://lore.kernel.org/git/CABPp-BEOX+zxR9-yyx-EaiOV-Z9yD0YP_Kwvu4iGB8enz4=
0XXQ@mail.gmail.com/.
I looked over the subsequent iterations too, and they still look good
to me.

Could I vote for just merging it down, as-is?  As far as I can tell,
this series was stalled for 6-7 months over "doesn't use
parse_options() API", even though Dscho addressed that directly in v1
in one of his commit messages stating he had already investigated that
route and found it wanting, at least in its current state[1].  It
appears, from my reading, that using parse_options() API was insisted
upon...though it turns out that making parse_options() capable of
handling such things is at least another 20-patch series[2] (which may
not be enough either[3]).  Further, such changes, while likely
desirable for consistency among Git commands, would likely move us
away from "faithful conversion from shell to C", and thus is likely
better to be done as a separate step on top of the existing series
anyway[4].

If we merge down, as-is, then =C3=86var can go to town on it, possibly
using SZEDER's changes[2], and convert the new bisect code over to
using parse_options(), and show Dscho what he meant by how it could be
done.  Maybe =C3=86var will even demonstrate that it is quite simple to do.
Or, perhaps, =C3=86var will discover what Dscho did and agree that
parse_options() really can't handle that case.  I wouldn't be
surprised by either outcome.  Either way, I think it'd resolve the
issue much faster than going round and round in discussions.

And I think the result would be more to everyone's liking -- Dscho
gets to concentrate on the stuff he cares about (user experience,
converting shell to C faithfully), and =C3=86var gets to concentrate on the
stuff he cares about (internal code consistency, tree-wide
refactorings).  And in the meantime, the rest of us get to enjoy the
fruits of three separate GSoC projects plus Dscho's attempt to tie it
all together.  I think Dscho's Dscho's submission improves upon
current Git and is good enough to merge, even if there may be ways to
make it even better.

Anyway, just my $0.02.

[1] https://lore.kernel.org/git/515e86e20758ed7f5b4a8ce8f38bfbbac27ec42a.16=
43328752.git.gitgitgadget@gmail.com/
[2] https://lore.kernel.org/git/20220812150420.GA3790@szeder.dev/
[3] https://lore.kernel.org/git/1p04q351-9938-r0r7-snr6-9s8237s27459@tzk.qr=
/
[4] https://lore.kernel.org/git/8o63pp64-4s00-1000-42s1-38so68398337@tzk.qr=
/
