Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C00C3F6B0
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 07:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbiHPHgB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Aug 2022 03:36:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiHPHfH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Aug 2022 03:35:07 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C7742AC4
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 21:21:27 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id 66so9062893vse.4
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 21:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7EK279c3g9JwtxFS9d8ef01EdjRIpu9UF765hGMbkqY=;
        b=F6waIWp/MlAm4Ciia4rtezgAWzfX4u43kUZM1k5naqKjqhK1HGyyGqnOxsG0kL//D3
         aUSXmcGJRaDtyrY1/VgqEnBuSDEz3VUHQfhAXRsux9Oa8VASt+xTLl4nYyJpNj9wuscv
         Ugl9ZBmxtzhwpk9wLR7xIL+cdilPCjuvMQMuyRjGTgRDpCdoqJWkwNL9N4rRymMWeRbb
         473Ovr2ZWs1BYFrB7L1iHIM0FThqlX62I7UJueEQ5P3Rok7tZ6nPhfJWRicHdKvnzLlO
         KzMKsNUsbMnZNx1t95+0tzQCkIl1e08x91mV0+XJ/xzZoKcrZmUd6LCR9BIFfynFL95D
         Upxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7EK279c3g9JwtxFS9d8ef01EdjRIpu9UF765hGMbkqY=;
        b=qNaGY51EkUjL/olBwyK5WKSpqcHKwzDlOfwpa1a7i5BN1eipnYSKJZBPTWMwFtatqF
         NvO/ski0SmmMqyucItV/VEngWpRKfz9esaPWZ/TDgPzsETy27KysrndU+cs4M3a/pQqU
         99Mgo9+flvvXP5w7ajUwzwH4//A3nmA1U6aLQgCES3Vgt12qj3DL+WQ1WMKdPxud0ECH
         yhEDHpsKLiWlH4wsb0iLcDfBQXZuLjbFohDSNMNCyntB7CBkl4pBN0guvMwI1MP8rsDK
         RTP6SOxEH5YpChm0Yg2mmdScZw4sifcQnW8ufepH8UUbpBxH8Any7/ApIJUjSC2zkcKT
         m+Kg==
X-Gm-Message-State: ACgBeo1zfsGCXsR4j2WgvPXFyXnO7EhV4YbNNdqRUd+0UK9E49gAjlNr
        +ePlEFxgY4QRVJ2pKpGjMQBVYf66Azltf9DiuqysFReg
X-Google-Smtp-Source: AA6agR6V/LkviX8ry9gs2/jUFfF1rXGXDNXgIUe5bcz70tPgoXzuChC30WfzqOPa+w7UIj3GPj3Kcwn0uABFHj7Lxko=
X-Received: by 2002:a67:ae05:0:b0:357:8b59:3a84 with SMTP id
 x5-20020a67ae05000000b003578b593a84mr7098116vse.51.1660623686581; Mon, 15 Aug
 2022 21:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1302.git.1658798595633.gitgitgadget@gmail.com>
 <pull.1302.v2.git.1659132518935.gitgitgadget@gmail.com> <CAGTqyRw-SYDbQy9aktq5s3ZhoDhUOCf-pEopjH9m7v5+PH7Qqg@mail.gmail.com>
 <xmqqy1vq3zm3.fsf@gitster.g> <08a8e78d-7861-3da3-f6f6-bba466655071@gmail.com> <xmqqilmt4huq.fsf@gitster.g>
In-Reply-To: <xmqqilmt4huq.fsf@gitster.g>
From:   Justin Donnelly <justinrdonnelly@gmail.com>
Date:   Tue, 16 Aug 2022 00:20:50 -0400
Message-ID: <CAGTqyRyuV42-NRW_OKzy9F+LbFcZp-QZkM73LqrNkmOi60oU+w@mail.gmail.com>
Subject: Re: [PATCH v2] git-prompt: show presence of unresolved conflicts at
 command prompt
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Justin Donnelly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        newren@gmail.com, phillip.wood@dunelm.org.uk,
        Johannes.Schindelin@gmx.de
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2022 at 12:00 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > I had not commented as I don't use the prompt. I have just had a quick
> > read and I wonder if it would be more efficient to use
> >     git diff --cached --quiet --diff-filter=U
> > rather than
> >     git ls-files --unmerged 2>/dev/null
> > to check if there are unmerged entries,
>
> The former reads the on-disk index into in-core index, and reads
> tree objects (recursively for subdirectories) referenced by the
> HEAD, walks both in parallel to find differences and filters out the
> result to unmerged (I am not sure how well diff-filter works with
> unmerged paths, though).
>
> The latter rads the on-disk index into in-core index, scans the
> entries and finds unmerged entries.
>
> So if we compare the overhead to run either command standalone, I am
> reasonably sure that the latter would be a lot more efficient.
>

Here's how I tested performance. The setup and test execution code are
below. I tested each technique (`git ls-files --unmerged 2>/dev/null`
and `git diff --cached --quiet --diff-filter=U`) 3 times and listed
the results. Please let me know if you see any problems with the
methodology.

Setup:
mkdir -p /tmp/perf/base && cd /tmp/perf/base
git clone https://github.com/torvalds/linux.git

Each test:
cd /tmp/perf
rm -rf test
cp -r base test
cd test/linux/drivers/watchdog
git switch --detach v6.0-rc1 # pick some commit for consistency
for f in *; do echo "/* a */" >> $f; done # 182 files
git stash
for f in *; do echo "/* b */" >> $f; done
git commit -am "adding to end of files in watchdog directory"
git stash pop
time [[ $(git ls-files --unmerged 2>/dev/null) ]]
# OR run the next one instead
# time ! git diff --cached --quiet --diff-filter=U 2>/dev/null

Results (hopefully this text lines up better for others than it does for me):
time [[ $(git ls-files --unmerged 2>/dev/null) ]]
      run 1     run 2     run3
real  0m0.008s  0m0.009s  0m0.008s
user  0m0.005s  0m0.001s  0m0.004s
sys   0m0.004s  0m0.008s  0m0.004s

time ! git diff --cached --quiet --diff-filter=U 2>/dev/null
      run 1     run 2     run3
real  0m0.009s  0m0.009s  0m0.007s
user  0m0.004s  0m0.009s  0m0.007s
sys   0m0.004s  0m0.000s  0m0.000s

As you can see, the results are basically the same. I'm not sure if
real world usage would yield different results. So for now, I'll defer
to Junio's analysis and stick with `ls-files --unmerged`.

> But if the shell prompt code already needs to run the diff-index for
> other reasons (e.g. to show if there is any modification added to
> the index), that may change the equation.  Instead of adding a
> separate and extra call to "ls-files -u", it might be more efficient
> if you can somehow piggy-back on an existing diff-index call.  For
> example, you may be running "git diff --cached --quiet" for exit code
> to show if any change has been added, but you can instead run "git
> diff --no-ext-diff --no-renames --cached --name-status" and (1) if
> there is any output, then the index is dirty, and (2) if there is a
> line that begins with "U", you have an unmerged path right there.

It had not occurred to me to consolidate and piggy-back off of other
commands. I find the idea intriguing, but am not sure it makes sense
to do it for only a single feature (especially this feature since the
time to determine the conflict is short). I think it would make the
code more complex, and it might be better to take a holistic approach
to such an effort. Let me know if you strongly disagree.

Thanks,
Justin
