Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FDC220756
	for <e@80x24.org>; Mon,  9 Jan 2017 11:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965576AbdAILTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jan 2017 06:19:24 -0500
Received: from mail-io0-f176.google.com ([209.85.223.176]:36464 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935824AbdAILTI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jan 2017 06:19:08 -0500
Received: by mail-io0-f176.google.com with SMTP id j13so23042945iod.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2017 03:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8KSGNIz3Ujqr/sYFTXZdT0ABDeXVmHwOxYvlCEcwZrk=;
        b=nhCiIBE5BJ5dxF01WUWt0ZVfHgVfeb4JP1+S2NHyqliiqnk8FADwffyB0bWAmkyj1u
         LmFskRvGqb6rU8TbndRh1FyvepLNIZxs0cxsSoIzqJUrsC/ZX+lMuzpFDdxJwWovxebT
         3NpNRiysmWm4+iBQshP7lAD/t1XPx7YhoZL2qM8XZhJYAfFH8X10KS/LBpWEBYKZWWKl
         MyZozQJncBnG/bckcKu7BxE0DGC6o7b7+eg69fzwVLPx4PKjhrfAUkkEHHuKJmp18ki+
         FPZ1CTnYMiIeASFlfj+Bs+w9wS2dggfY8aDIDd4NSZEUCzCn+ficsHP41qhHGDi9JS0L
         sKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8KSGNIz3Ujqr/sYFTXZdT0ABDeXVmHwOxYvlCEcwZrk=;
        b=nXIsT+DKM+/fpPmKYtCMsZggUn4dr0x4o8Wg4gsc6ES/j7t15asWf8deeXWrtQ7iv2
         epbvBilO4f3fpq1L6I7nOTxZ29/GrhSXsRiBX12rbIcnX53qDZcSAlIPMzAzj/mJbPja
         lfOlStfTP6LZrsi9Ien51bD+zs+iZ7znvUuuxDB6gomn1Fzr2QnBA1pcU7GCYXcZPSiT
         exxFkhUu+U/WcUW3N7Fe9pTXvLFSfj+dXetpGMwxQ8LSk+xgdiNR9RM9Lu5YS+M3nhFd
         nPKiKzN5v+oxJHKqsMtKO7SOggJ3Wr22ZdN501LLiUGu1JeS+p9fQJSTpjUpewjLkVAY
         mUAg==
X-Gm-Message-State: AIkVDXLWNxuQ39FLFJNq3RbSci1fzvYiTPRlbJYM7DcycF/Yny4osDIHiHaiXFgzUwtS9vIBnMYN47lfZGNeLQ==
X-Received: by 10.107.44.83 with SMTP id s80mr3424677ios.212.1483960747240;
 Mon, 09 Jan 2017 03:19:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Mon, 9 Jan 2017 03:18:36 -0800 (PST)
In-Reply-To: <xmqqshou35zr.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-9-chriscool@tuxfamily.org> <xmqqpokd9ocw.fsf@gitster.mtv.corp.google.com>
 <CAP8UFD06mxGiZmr4Lwv3M8CedBZaamswzz-Q+mOxuuUFet8KNQ@mail.gmail.com> <xmqqshou35zr.fsf@gitster.mtv.corp.google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 9 Jan 2017 18:18:36 +0700
Message-ID: <CACsJy8D1Pf6zTS8gqv5Gq6xMxNNbDrTpKHGADRMKNqW1FAzZvA@mail.gmail.com>
Subject: Re: [PATCH v3 08/21] Documentation/git-update-index: talk about
 core.splitIndex config var
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 8, 2017 at 4:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> It feels strange that when I do things one way, you suggest another
>> way, and the next time in a similar situation when I do things the way
>> you suggested previously, then you suggest the way I did it initially
>> the first time...
>
> Perhaps because neither is quite satisfactory and I am being forced
> to choose between the two unsatifactory designs?  In any case, I
> mostly am and was pointing out the issues and not saying the other
> one is the most preferred solution in these threads.
>
> I think there should just be one authoritative source of the truth,

Either that, or we make sure all sources of truth are consistent. In
this case, 'update --split-index' could update core.splitIndex if it
finds that the config tells a different story. As a plumbing though, I
rather leave update-index do simple things, even if it means the user
has to clean up after it (or before it) with "git config -unset
core.splitIndex". Another option is refuse to execute --split-index in
the presence of (conflicting) core.splitIndex. We kind of force the
user to keep all sources of truth consistent this way while leaving a
back door ("git -c core.splitIndex= update-index") for those who need
tools to recover from a bad case.

> and I have always thought it should be the bit set in the index file
> when the command line option is used, because that was the way the
> feature was introduced first and I am superstitious about end-user
> inertia.  And from that point of view, no matter how you make this
> new "config" thing interact with it, it would always give a strange
> and unsatifactory end-user experience, at least to me.
>
> Perhaps we should declare that config will be the one and only way
> in the future and start deprecating the command line option way.
> That will remove the need for two to interact with each other.
>
> I dunno.



-- 
Duy
