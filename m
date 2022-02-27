Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07285C433F5
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 00:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbiB0AeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Feb 2022 19:34:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiB0AeE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Feb 2022 19:34:04 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0514892A
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 16:33:28 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id d21so13268464yba.11
        for <git@vger.kernel.org>; Sat, 26 Feb 2022 16:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BE+5u7qgUeM+p63Ui+SYxBSBPrt+ouU8PW94kQOH+IY=;
        b=qdy/HL+IYTdZfR6o0u0MuPXmmkrjinhRmMpgH2uiBrcCNhkG7juDpbVjjjYhIjH0rv
         pHMpghuXGS+BY7rwm2AEqKx0OOQ4hCX/K0Ziqgikli7KWNZMsGjQM0VmShuIxnH4Pqkm
         CcLLKAX0aCaW8vQy7o6trn4Dmk+IR+AwkDdU2zGsD2ytO+9WCbcEWkV9taIrKKUF6Y3J
         qrMRFFoB7gvC54mm6J2/tZNgUzcnwp/jbZVQF7XYBZn0+RQplN86Daiem8LbTYBVQW/S
         zOcybjXNIhpoSX05fvG5vtGmBizcS6/9RJa3p5m7W/ow9sCegLqqjhSwrHk/h/zRDcdI
         uGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BE+5u7qgUeM+p63Ui+SYxBSBPrt+ouU8PW94kQOH+IY=;
        b=owxt9TkPrg72fe4R0oa6G9jOYE56VQTy+jeDKNBxm05vBWB529XaBEtIG7N2e6mPiW
         K7FDOtGNTE+EW5/wnINWKJWcpFw83zzz9xEMmth8zXrXW1zDwStwwxCFshM+MH1id9BX
         EP++Y/xQuU9qf6CnwfXf/lqpnW1YiSFa8pe1UCwEvtbG3V6vnBfNkpuKtsqUMhEXeENn
         PN05K4DrTe7c7ELzq6y5nECrx0oljClc+WG6Mjb1nW1c6PdZd94HfRXGM3O9j8sIWuel
         D2uchO8wamJxaI1M+3BXcELvi2tTFYBess04NHJz9cSSdQI11fmIOif2w/0vTG7gr2oW
         JCrQ==
X-Gm-Message-State: AOAM530KnSG3YwoWCalGQifny5HbAL/fuRh1sRFFIK+8ZDjBbf9uhVaU
        3h+FD/pu2Hv+mPFnFXqUiQkU159QJUVCZrktzR7QKHlTjp0=
X-Google-Smtp-Source: ABdhPJy0ZyxPWi+fu3JrVvGaahcW5778HZg+tJVKB3x1DT/TBIHr1TfhL04xrYowR1BDLHIGVrbD0O3m1HZD+zYqYAQ=
X-Received: by 2002:a25:748e:0:b0:624:3bae:fa32 with SMTP id
 p136-20020a25748e000000b006243baefa32mr13402202ybc.255.1645922008059; Sat, 26
 Feb 2022 16:33:28 -0800 (PST)
MIME-Version: 1.0
References: <pull.1162.git.1645789446.gitgitgadget@gmail.com> <220225.86czjb874f.gmgdl@evledraar.gmail.com>
In-Reply-To: <220225.86czjb874f.gmgdl@evledraar.gmail.com>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Sat, 26 Feb 2022 19:32:52 -0500
Message-ID: <CAGTqyRwTEdwut4HKD2=MaBfG_tZqN_TjGPAjChzmjBubC0-wuQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] In PS1 prompt, make upstream state indicators
 consistent with other state indicators
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the feedback. Comments interleaved below.

On Fri, Feb 25, 2022 at 7:26 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Feb 25 2022, Justin Donnelly via GitGitGadget wrote:
>
> I couldn't find any glaring issues here on a quick review, just a note.
>
> > These patches are about the characters and words that can be configured=
 to
> > display in the PS1 prompt after the branch name. I've been unable to fi=
nd a
> > consistent terminology. I refer to them as follows: [short | long] [typ=
e]
> > state indicator where short is for characters (e.g. ?), long is for wor=
ds
> > (e.g. |SPARSE), and type is the type of indicator (e.g. sparse or upstr=
eam).
> > I'd be happy to change the commit messages to a different terminology i=
f
> > that's preferred.
>
> I think that terminology is correct, in case you haven't seen it
> git-for-each-ref(1) talks about the "short" here as "short",
> "trackshort" etc.
>
> > There are a few inconsistencies with the PS1 prompt upstream state indi=
cator
> > (GIT_PS1_SHOWUPSTREAM).
> >
> >  * With GIT_PS1_SHOWUPSTREAM=3D"auto", if there are no other short stat=
e
> >    indicators (e.g. + for staged changes, $ for stashed changes, etc.),=
 the
> >    upstream state indicator appears adjacent to the branch name (e.g.
> >    (main=3D)) instead of being separated by SP or GIT_PS1_STATESEPARATO=
R (e.g.
> >    (main =3D)).
> >  * If there are long state indicators (e.g. |SPARSE), a short upstream =
state
> >    indicator (i.e. GIT_PS1_SHOWUPSTREAM=3D"auto") is to the right of th=
e long
> >    state indicator (e.g. (main +|SPARSE=3D)) instead of with the other =
short
> >    state indicators (e.g. (main +=3D|SPARSE)).
>
> I think it would really help to in each commit message have a
> before/after comparison of the relevant PS1 output that's being changed.

I agree that a before/after comparison would probably make it easier
to understand. Maybe some examples without upstream (for a baseline to
compare against) and a table that shows before/after for upstream.

`__git_ps1` examples without upstream:
(main)
(main %)
(main *%)
(main|SPARSE)
(main %|SPARSE)
(main *%|SPARSE)
(main|SPARSE|REBASE 1/2)
(main %|SPARSE|REBASE 1/2)

Of note:
1. If there are short state indicators, they appear together after the
branch name and separated from it by `SP` or `GIT_PS1_STATESEPARATOR`.
2. If there are long state indicators, they appear after short state
indicators if there are any, or after the branch name if there are no
short state indicators. Each long state indicator begins with a pipe
(`|`) as a separator.

Patch 2 before/after:
| Before           | After            |
| ---------------- | ---------------- |
| (main=3D)          | (main =3D)         |
| (main|SPARSE=3D)   | (main =3D|SPARSE)  |
| (main %|SPARSE=3D) | (main %=3D|SPARSE) |

Patch 3 before/after:
| Before                          | After                           |
| ------------------------------- | ------------------------------- |
| (main u=3D)                       | (main|u=3D)                       |
| (main u=3D origin/main)           | (main|u=3D origin/main)           |
| (main u+1)                      | (main|u+1)                      |
| (main u+1 origin/main)          | (main|u+1 origin/main)          |
| (main % u=3D)                     | (main %|u=3D)                     |
| (main % u=3D origin/main)         | (main %|u=3D origin/main)         |
| (main % u+1)                    | (main %|u+1)                    |
| (main % u+1 origin/main)        | (main %|u+1 origin/main)        |
| (main|SPARSE u=3D)                | (main|SPARSE|u=3D)                |
| (main|SPARSE u=3D origin/main)    | (main|SPARSE|u=3D origin/main)    |
| (main|SPARSE u+1)               | (main|SPARSE|u+1)               |
| (main|SPARSE u+1 origin/main)   | (main|SPARSE|u+1 origin/main)   |
| (main %|SPARSE u=3D)              | (main %|SPARSE|u=3D)              |
| (main %|SPARSE u=3D origin/main)  | (main %|SPARSE|u=3D origin/main)  |
| (main %|SPARSE u+1)             | (main %|SPARSE|u+1)             |
| (main %|SPARSE u+1 origin/main) | (main %|SPARSE|u+1 origin/main) |

Note: These tables are inspired by [Markdown Guide extended
syntax](https://www.markdownguide.org/extended-syntax/#tables), but I
didn't wrap the PS1 prompt text in backticks or escape the pipe
because I thought that would make it more confusing. In short, they're
meant to be viewed as (monospaced font) text, not Markdown.

>
>
> I'm not sure how to readthis example. So before we said "main +=3D|SPARSE=
"
> but now we'll say "main +|SPARSE=3D", but without sparse we'll say
> "main=3D"?
>
> Aren't both of those harder to read than they need to be, shouldn't it
> be closer to:
>
>     main=3D |SPARSE
>
> Or:
>
>     main=3D |+SPARSE
>
> Or:
>
>     main=3D +|SPARSE
>
> I can't recall what the "+" there is (if any).


`+` is for staged changes (if `GIT_PS1_SHOWDIRTYSTATE` is a nonempty
value). So it's not directly related to upstream, but the addition of
another short state indicator changes things.

>
>
> I.e. the "=3D" refers to the ahead/behind state of "main, it seems odd in
> both versions of your example that we're splitting it off from "main"
> because we have "SPARSE" too.
>
> But maybe I'm missing something...
