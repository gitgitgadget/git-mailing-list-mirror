Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D760205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 16:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756262AbdABQEP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 11:04:15 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36168 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756234AbdABQEO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 11:04:14 -0500
Received: by mail-lf0-f65.google.com with SMTP id t196so23740636lff.3
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 08:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IEHzBFsq+pg7jRDDfe8uaF5ln7KzeDqSAIArlaGLxCA=;
        b=qkoxIj70YaftpfqdNZSypf+Q8Ibasv6ajamWa0A9PdgayBcdFmLz6CoDeLmNsjNFuy
         OWKIPatyM4AADm/zJve9rHqlNXroc0S81nKVYUzsiHBiWUlOLSkLXMKF0ZRLj+gSKXXg
         R53u3B8BA5UoJ8OXq8GnKHIaGeOybmP/lwzcO4jXEu66Iqa6PN8gv252OmN0+Ykranpn
         nZ4Fgf+G0E2zrExeOVatYF8jLOHnHANkUVtrAkLYgL0N5/5w0DTYUtP+w5R3C90qrzzN
         G8yglX85UJjofykhalk96RKc6z51pL7vCY8eBPCmi5vBk2/UPxO96lMUfI8yhGC2J033
         2mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IEHzBFsq+pg7jRDDfe8uaF5ln7KzeDqSAIArlaGLxCA=;
        b=XbI2KbUggwD/LC32k+ixZt5KCDXRfwH3DoK0i1XOwMIsM4/FEv0+0jZi5Lpp0rFWjd
         inb44uCyxP+f19ilmye8yRrkaAws4iPJ5Tu9xaKHu4Mr4ofHaZ1lsMtMHV4jnsHZtlNK
         nukRWYekcGsO0yWXu+XmHV6IuDOdNOGwWIYNcGECwvsnu4LS45hUhgELOJi1vRJIBL+m
         W+mzFTZpC+v0LwbwpgnsIxZCeG6J3t7xMdkM7bf9Hw/rJbJWvvTrqmXEHkhv3cx8AiZM
         AXfjf07U2dnTmap1thRCq9xw3VIYQ2dOTbFo4crMs5IXaOhO/EHzQe/x8zpzqFzqiZrS
         myxQ==
X-Gm-Message-State: AIkVDXK2DnrnKbi/G/SCoqoCH8+X4CiEJUJ7bZ0sk3ixAW0gPAOC2ZkyzuH767f87mBbTgED+/qgpMdSLq4Qmg==
X-Received: by 10.25.209.73 with SMTP id i70mr16354398lfg.24.1483373052417;
 Mon, 02 Jan 2017 08:04:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 08:04:11 -0800 (PST)
In-Reply-To: <xmqq8tr19ocs.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-22-chriscool@tuxfamily.org> <xmqq8tr19ocs.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 17:04:11 +0100
Message-ID: <CAP8UFD2qK5uv5mrCOe1h48H8sUezC_Jk3-fftBxdOhBssmxTgA@mail.gmail.com>
Subject: Re: [PATCH v3 21/21] Documentation/git-update-index: explain splitIndex.*
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:13 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>>  --split-index::
>>  --no-split-index::
>> -     Enable or disable split index mode. If enabled, the index is
>> -     split into two files, $GIT_DIR/index and $GIT_DIR/sharedindex.<SHA-1>.
>> -     Changes are accumulated in $GIT_DIR/index while the shared
>> -     index file contains all index entries stays unchanged. If
>> -     split-index mode is already enabled and `--split-index` is
>> -     given again, all changes in $GIT_DIR/index are pushed back to
>> -     the shared index file. This mode is designed for very large
>> -     indexes that take a significant amount of time to read or write.
>> +     Enable or disable split index mode. If split-index mode is
>> +     already enabled and `--split-index` is given again, all
>> +     changes in $GIT_DIR/index are pushed back to the shared index
>> +     file.
>
> In the world after this series that introduced the percentage-based
> auto consolidation, it smells strange, or even illogical, that index
> is un-split after doing this:
>
>     $ git update-index --split-index
>     $ git update-index --split-index
>
> Before this series, it may have been a quick and dirty way to force
> consolidating the split index without totally disabling the feature,
> i.e. it would have looked more like
>
>     $ git update-index --split-index
>     ... work work work to accumulate more modifications
>     ... consolidate into one --- there was no other way than
>     ... disabling it temporarily
>     $ git update-index --no-split-index
>     ... but the user likes the feature so re-enable it.
>     $ git update-index --split-index
>
> which I guess is where this strange behaviour comes from.
>
> It may be something we need to fix to unconfuse the end-users after
> this series lands.  Even though "first disable and then re-enable"
> takes two commands (as opposed to one), it is far more logical.  And
> the percentage-based auto consolidation feature is meant to reduce
> the need for manual consolidation, so it probably makes sense to
> remove this illogical feature.

Yeah, I tend to agree that this feature could be removed later. Though
before removing it, I'd like to hear Duy's opinion on this as he
created the feature in the first place.

>> @@ -394,6 +390,31 @@ Although this bit looks similar to assume-unchanged bit, its goal is
>>  different from assume-unchanged bit's. Skip-worktree also takes
>>  precedence over assume-unchanged bit when both are set.
>>
>> +Split index
>> +-----------
>> +
>> +This mode is designed for very large indexes that take a significant
>> +amount of time to read or write.
>
> This is not a new problem, but it probably is incorrect to say "to
> read or write".  It saves time by not rewriting the whole thing but
> instead write out only the updated bits.  You'd still read the whole
> thing while populating the in-core index from the disk, and if
> anything, you'd probably spend _more_ cycles because you'd essentially
> be reading the base and then reading the delta to apply on top.

Ok, then what about:

+This mode is designed for repositories with very large indexes, and aims
+at reducing the time it takes to repeatedly write these indexes.

>> +To avoid deleting a shared index file that is still used, its mtime is
>> +updated to the current time everytime a new split index based on the
>> +shared index file is either created or read from.
>
> The same comment on the mention of "mtime" in another patch applies
> here as well.

Ok, I will use "modification time" instead of "mtime".

Thanks.
