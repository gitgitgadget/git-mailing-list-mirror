Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A098C00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 17:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234404AbiHBRos (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 13:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbiHBRoq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 13:44:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492AB1D7
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 10:44:45 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p5so18505729edi.12
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=XE/CaUb2WDVyy0MjNQe5SMquGMZyjO4t3WyV3QlxWOc=;
        b=AoiJxfPuF/BxQDEURjk1T1QT3oAfqPb/4soom8hL+yyCx6ybga4QZkloXQ8xyWvEa9
         mYjb5ea5G36amAQNQal/a8AzboIdvWdA6VFaH/uqYAfCDSUHj4SGKcSn2KKyQVcYGcpI
         nUJRTshG+W8ThrYWjOnvV2FKW0z330XfgdjnImt4ZFzDU7gQHwrrI6X1p7pht0BzJPoV
         qyRDaJgiwWXtTmeMeFwNPrK39Yh6vAI2Ut59wMhVzfle1Pn2n+235vKUzcFeZuMdlkbM
         EdKXKn0e2Akj2cMghPeBcCJJYEkuHWwXRYalpItJO9m26ssUtqMgcJFl90YhClBCwsDt
         TgcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=XE/CaUb2WDVyy0MjNQe5SMquGMZyjO4t3WyV3QlxWOc=;
        b=1Yi6z4aDajIZj+ddVGNXfz6qMXrrzdR0wb0KsrdPWh4tmvTjdZTmuVCZMSVK8ctxBF
         1uZaOUvgq4Plqvaqqud7iRmazVv+hgqGW6+KXfbOUbi85JjwEpi4DACimiPDFphhDD7y
         Uw1j1O+ZVlkMSf4AfJJfNbG0TUgmPs738RtzJwhxidY4viUg6gVvTAlbZY3ITB2XAsjl
         YM+dEBLU4GaLBCIj9xXS8ubzLzzLygelypi7nP5cIJm2Qy39wkmdL6Zh/06llarhKruy
         qMKjKzpyDvm5n24+zHUrJImXNyYZ6UhRjk4nnyfU2brfdZN1Xi+/Uhi/929xqx7D44qX
         HfDg==
X-Gm-Message-State: AJIora9f1WT1b0pGIdTQxUlQx1AmoXfK15/lmc2MSkmEDe8Ci1RkACsA
        W5kPMe67eHAuGq/gjak1CV9ocZBpqCTQ9mhipj4=
X-Google-Smtp-Source: AGRyM1vSifzHUN646oHU5etPl0+CBfQpWfTItHUkMSLmIfyOlMaif/o+h6RLS04SA+k6etajfitzLm/7fiOrg6azfxI=
X-Received: by 2002:a05:6402:2386:b0:43d:a74:cd44 with SMTP id
 j6-20020a056402238600b0043d0a74cd44mr21356065eda.280.1659462283746; Tue, 02
 Aug 2022 10:44:43 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1266.v4.git.1658325913.gitgitgadget@gmail.com>
 <pull.1266.v5.git.1658342304.gitgitgadget@gmail.com> <59b465e5a7817c145172f25e73ad807c7ba67e84.1658342304.git.gitgitgadget@gmail.com>
 <p3r70610-8n52-s8q0-n641-onp4ps01330n@tzk.qr> <CAPOJW5xBUaAJtOvrefwbXv_WDTLa=6PTL5kEoOpRQfqqFAx3oA@mail.gmail.com>
 <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
In-Reply-To: <6s4n3600-q5p7-92sr-4206-non3s8rr3n46@tzk.qr>
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Date:   Tue, 2 Aug 2022 23:14:32 +0530
Message-ID: <CAPOJW5yUi471cfAXuXaM4BCzVsfZ15J1Era4NuEpxEnmY6md9Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] pack-bitmap-write: learn pack.writeBitmapLookupTable
 and add tests
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 2, 2022 at 9:05 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> > But I am sure it is not related to the lookup table implementation code.
> > Because when I swap the order of calling  `test_midx_bitmap_cases
> > "pack.writeBitmapLookupTable"` and `test_midx_bitmap_cases` (in
> > t5326-multi-pack-bitmaps.sh), in that case, the error is being generated
> > in  `test_midx_bitmap_cases` call. Generally speaking, the error is
> > always being generated in the second call.
>
> Indeed, it probably has something to do with the test tick (which gives
> rise to the author/committer date of the commits that are generated, and
> hence with the SHA order of said commits).
>
> With this patch:
>
> -- snip --
> diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
> index 3b206adcee6..a340f005b89 100755
> --- a/t/t5326-multi-pack-bitmaps.sh
> +++ b/t/t5326-multi-pack-bitmaps.sh
> @@ -347,7 +347,11 @@ test_midx_bitmap_cases () {
>         '
>  }
>
> -test_midx_bitmap_cases
> +# test_midx_bitmap_cases
> +
> +GIT_COMMITTER_DATE='1112928553 -0700'
> +GIT_AUTHOR_DATE='1112928553 -0700'
> +test_tick='1112928553'
>
>  test_midx_bitmap_cases "pack.writeBitmapLookupTable"
>
> -- snap --
>
> I can reproduce it quicker via
>
>         GIT_TEST_DEFAULT_HASH=sha256 sh t5326-*.sh --run=1,71,91,92,93,124,145
>
> Without setting those variables, I cannot skip the first
> `test_midx_bitmap_cases` invocation _and_ reproduce the failure.

Yeah, this works for me also.

> > I am still not able to figure out the problem here. But let me further
> > investigate.
> >
> > If anyone has some idea about what could be the culprit, I will be
> > very happy to know.
>
> So I noticed that the test will pass every 4th to 5th time over here,
> which means that it is a racy condition that is the culprit.

I also encountered the same and it blew my mind at first (because it
is the first race condition that I faced in my life) :)

> I dug a bit deeper and reduced the reproducer even further, by running
> this command with a trash directory just after above test script
> invocation failed:
>
>         bin-wrappers/git -C t/trash\ directory.t5326-multi-pack-bitmaps/ \
>                 -c pack.threads=1 pack-objects --revs --thin --stdout \
>                 --progress --delta-base-offset </tmp/a5 |
>         bin-wrappers/git -C t/trash\ directory.t5326-multi-pack-bitmaps/ \
>                 -c pack.threads=1 index-pack --stdin -v --fix-thin \
>                 '--keep=fetch-pack 12345 on labtop' \
>                 --check-self-contained-and-connected
>
> where `/tmp/a5` contains these lines:
>
> -- snip --
> 0ae5a358dcea86d81c0903aaec1e21857688cdb36c7fd89b04bd293fb2cceaa6
> 67df8a01ac84cf5f028855c48384eac3336bb02a52603bac285c4b31d66b3ab5
> 098a57f7753320c8a37cf0cb84526a9e50439d9f70fb673c91436a5283a7efe8
> --not
> -- snap --
>
> This allowed me to instrument the code with _many_ debug printf statements
> (I actually use `error("%s:d: ...", __FILE__, __LINE__, ...)` calls) to
> dive deeper into the weeds.
>
> One relatively obvious difference I can see is that when the code reaches
> builtin/pack-objects.c:1198, in the passing case after writing the reused
> pack we're at offset 900 in the written pack file, but in the failing case
> we're at offset 269.
>
> Another difference I first saw was that the mtime of
> `.git/objects/pack/multi-pack-index` was identical to the mtime of
> `.git/objects/pack/multi-pack-index-2ec3c30357d2fff78db9b36cc749b393087e989bffdd278771d6f62089406061.bitmap`
> in the failing case, while the mtimes of the corresponding files were
> different in the passing case.
>
> But in another failing run, the mtimes were also non-identical. Meaning:
> the race cannot be caused by identical or non-identical timestamps there.
>
> One consistent difference, however, was the SHA-256 in that `.bitmap` file
> name: In the failing case it was always
> 2ec3c30357d2fff78db9b36cc749b393087e989bffdd278771d6f62089406061, while in
> the succeeding case it was always
> 0c275657a915eeff1f2a1c17e5ded43cc3b232b0e178923e44fc15c1970516fb.
>
> My suspicion is that this `.bitmap` file is written out in an earlier test
> case, and is already incorrect at that stage. Maybe it should have been
> updated, but isn't, and the result is an incorrectly-reused partial pack
> file.

I agree with you.

> I also noticed that deleting the `multi-pack-index-*.bitmap` file in the
> failing case will "fix" the `pack-objects | index-pack` command I showed
> above.
>
> Hopefully this will help you dig in further because even if the bug is not
> in your code, it needs to be fixed. And I suspect that it is a bug in the
> code we already have in the main branch, so that fix is really, really
> needed, now.

Yeah, definitely! Thanks for all the information! It will truly help
me to identify the problem.

> Since you are very familiar with the details of bitmaps now, I would like
> to encourage you to work on some kind of validator/inspector, e.g.
> something along the lines of a `test-tool midx-bitmap dump` (and later
> `... verify`) that would help future you (and future me) investigate
> similar breakages. Ideally, that tool will not only parse the `.bitmap`
> file but immediately print out everything in a human-readable form.
>
> The reason I suggest this: I got a bit tired of staring at the output of
> `hexdump -C` and comparing it to the documentation in
> https://git-scm.com/docs/pack-format, so I had to stop after looking too
> long at one broken pack file (i.e. the output of the `pack-objects`
> command I showed above, where already the first entry seems to have an
> infinite delta chain that pretends that
> 4d332072f161629ffe4652ecd3ce377ef88447bec73f05ab0f3515f98bd061cf has
> itself as delta base) before I even could analyze the MIDX bitmap files.
>
> The proposed tool would make analyzing MIDX bitmaps substantially more
> fun, and would also help stave off future breakages if it was taught some
> `verify` mode that would essentially automate what right now has to be
> done manually: to verify that the MIDX bitmap file contents are sound and
> consistent with the contents of the pack files.
>
> Obviously, this `verify` command should be called in strategic places of
> t5326.

Ok, sure!

Thanks :)
