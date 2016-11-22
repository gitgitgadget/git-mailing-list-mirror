Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3EA71FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 13:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933195AbcKVNNi (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 08:13:38 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34601 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932656AbcKVNNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 08:13:37 -0500
Received: by mail-vk0-f67.google.com with SMTP id p9so1585845vkd.1
        for <git@vger.kernel.org>; Tue, 22 Nov 2016 05:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=d/aqXVgQKSESwMM39gG7MmTCTuaqz4cBJTh4N9gnPd8=;
        b=p3gD75bHfT07C+n7EiS2JoP53Y4/hm6wR5hU+RWpLb2W/ifnM70zeD53pI3thrUvHF
         telo8XuomVOWU0ox2XlED8lzkx88AlK/w8EmXvY5kQ9yt5vzq099U2Pnq6HBP5fTeu35
         MRRJvk/F8WvqRmXF9VTTvDUa2Zb5GJg2mdZWQDWt62iV0AESq4LGbyrrRcic2RYf814G
         PKq/AYvnVmiIhKAN21DshbX6h3XlcVfcUzvDDAv8ca7G9b8xTtc0PSsILqt3GaETcoKV
         d+Nf5erd4OabpPK7rEL/xctskaK5lFt24L/qN1+WD0DuBJ8WTMBbDv66p7ToiibvwHea
         HstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=d/aqXVgQKSESwMM39gG7MmTCTuaqz4cBJTh4N9gnPd8=;
        b=E9TlvdVleF6dVtmTO2nsoz8lp6a3g/SjvDRa/caXEJBXvjMhECC+nNcfnGfk4s9GQl
         7W2Brpk/x43dUoRLdlj2QdkqJRU70tBjgmruCn7DgdUogBKE0BzByn1DvWM9gwZVmZRC
         od9vSY/7SIjpEinZ72apG9KopNvrFVJQC+YEuhdQYM2nuxaVNksdad/Frs6wXf8efd+8
         Q8HbJrroFG5Ec0z5FldEuKtdARuHK0TIfz4+u0UGmrS9tgmeZphN7/G6ScMsRs79jxhO
         5G7j4i3DHNfx89pzmcugptM1j8e5hy5X45/OwDmyszBCJnlsCV3hjpXl9y/KHiecntGy
         EXLQ==
X-Gm-Message-State: AKaTC01jCby9tSgkdhoG8K8MGfVhoshPQdfR0PGVmLz4xH/SqphRJEd7x96jnJ43taJ2SqW41z3tkn2j57iVaQ==
X-Received: by 10.25.199.198 with SMTP id x189mr4524740lff.164.1479820383988;
 Tue, 22 Nov 2016 05:13:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.25.142 with HTTP; Tue, 22 Nov 2016 05:13:03 -0800 (PST)
In-Reply-To: <CACsJy8BazeR=4tz3q2f35x=fCfp-Ld9LJz0mQh_CZoR_iXKEEQ@mail.gmail.com>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
 <20161023092648.12086-13-chriscool@tuxfamily.org> <xmqq8tt3ovnp.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD2H6rZNQqg1VGNkes65KAk-4P160rjQSjFY3NjgZydZmA@mail.gmail.com>
 <xmqqoa1scyuy.fsf@gitster.mtv.corp.google.com> <CAP8UFD1YL+RgdqbV0V1OnC=sJHJFc_an02Q9JeDNapW+u1CZcA@mail.gmail.com>
 <CACsJy8BZNfESmFv=V89Cq-b+aMJWLH=qhXHNE8inZZRjvXB33Q@mail.gmail.com>
 <CAP8UFD1mun7wz2WqV8GCj6MODVjP2mPEBRGbJTf_ypiGCgtb9Q@mail.gmail.com> <CACsJy8BazeR=4tz3q2f35x=fCfp-Ld9LJz0mQh_CZoR_iXKEEQ@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 22 Nov 2016 14:13:03 +0100
Message-ID: <CAP8UFD2VFQs2X14omWEy-iJzEeTEeEOa+fxMEq3HTQK3rFyuCg@mail.gmail.com>
Subject: Re: [PATCH v1 12/19] Documentation/config: add splitIndex.maxPercentChange
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 22, 2016 at 11:35 AM, Duy Nguyen <pclouds@gmail.com> wrote:

[...]

>>> In my opinion, "true" _is_ auto, which is a way to say "I trust you to
>>> do the right thing, just re-split the index when it makes sense", "no"
>>> is disabled of course. If the user wants to be specific, just write
>>> "10" or some other percentage.(and either 0 or 100 would mean enable
>>> split-index but do not re-split automatically, let _me_ do it when I
>>> want it)
>>
>> The meaning of a future "auto" option for "core.splitIndex" could be
>> "use the split-index feature only if the number of entries in whole
>> index is greater than 10000 (by default)".
>
> Well.. with the "just re-split the index when it makes sense" part,
> the user entrusts git to do something sensible in all cases,

That's an interpretation of what "core.splitIndex=true" could mean,
but there could be users who trust Git to re-split when it makes
sense, but who do want to use the split-index on all theirs repos even
the small ones or who just don't trust Git to choose when it might be
better to use it or not.

Yeah, a typical git user would most of the time just trust Git for all
those things, but on the other hand there are companies out there that
are willing to tweak many configuration options to get the better
possible behavior for them.

In fact I am working on this for Booking.com, and if we find out later
that we would gain something significant, like performance
improvements or configuration simplification, by adding "auto" and/or
other configuration variables to tweak more split-index related
things, we might very well post patch series to do that.

So if we now mix things up just to avoid one more configuration
option, we could very well make things harder to develop, to
configure, to parse and to understand later, so it is not a trade off
worth making.

> and going
> with absolute numbers might not be the best way, I think. It's big
> responsibility :)

About going with absolute number, yeah I am not sure at all it is the
best way, but this was just part of an example to try to explain what
I am saying above.
