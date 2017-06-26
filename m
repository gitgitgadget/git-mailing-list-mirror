Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A80207D2
	for <e@80x24.org>; Mon, 26 Jun 2017 17:35:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751393AbdFZRfW (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Jun 2017 13:35:22 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:37876 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdFZRfV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jun 2017 13:35:21 -0400
Received: by mail-wm0-f42.google.com with SMTP id i127so4264458wma.0
        for <git@vger.kernel.org>; Mon, 26 Jun 2017 10:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+cbLsqrWQpPqPeCQKkJObSAVNZgzgkKDqJB8SC7WGUM=;
        b=p0gm4dFnUurWl3dnjm6zFkXyj2BNt4hVetZ7i+9umzXInFILYzOmwPNWsNG+c7Hxmn
         /lMgXdawdPBivHBHacOcy5FSUJ4lods0mwyCwPGDevsdU2zMxXlRa+0U69DmpglW6K3i
         rigBn6kQ2jstFKRWg1AqZztG0uym33bzzcEm6HEcoKwu4gX3Wlx26HKsNgsaWhhvYIJ5
         5U8T/0mwhun4TX53LaU/oKCK7LFaq629VBuSKGBLp6UqoUtvbGq//7u56t+T5+3MNahU
         e33jSHN/6Pwn4tMLRyqSNDOwSefEk+PC6bMAAjtQnsh5syb9OknQzfQlt62S9IfN25n5
         kD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+cbLsqrWQpPqPeCQKkJObSAVNZgzgkKDqJB8SC7WGUM=;
        b=dh7w3iHmGpz/4L51sA7xgAWmZ/oQ8upEZHf55u49BY73OK0JqrIhdEWI2GXcJ4aL8Z
         voENYx7yW46ZXHSnIOaosAFT+3OFnUm3+x3024Vj3EEXanAsU31k5Qo3EzEfyaXUnj2n
         9AXnu65xVWC2K2X+Vm7FtJIN85zq0cWqQ9VjZNoLbym6MBKa0PAeFUpjq0KlcwLdfjqs
         b4IioZSjgHamakjzUCRou/G0nIhFq3RxbbltXc7MK2rV5yOcsC0IjMUGxHTxbeH5mI4G
         c19T3UdK7G8r8eNNxnBO3d0bCeTUi/uw5oO37RI4lbkUUAnQi2qtaY6qt7BcJzMnIUU4
         fy0A==
X-Gm-Message-State: AKS2vOzg+E/OwvtOoRcrCMUVoU+Yk/oVkRGq6OaHrNI4TEFHEmtqyQS6
        6+Ok8ep3lsAD9A7li20V8f2Ryuz0ciut
X-Received: by 10.28.130.196 with SMTP id e187mr541110wmd.24.1498498519805;
 Mon, 26 Jun 2017 10:35:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.133.200 with HTTP; Mon, 26 Jun 2017 10:35:19 -0700 (PDT)
In-Reply-To: <xmqqzicu64lj.fsf@gitster.mtv.corp.google.com>
References: <cover.1497035376.git.jonathantanmy@google.com>
 <cover.1497920092.git.jonathantanmy@google.com> <ad3b02bae9db62400f89f387f0a1bb714e0a432d.1497920092.git.jonathantanmy@google.com>
 <20170624124522.p2dnwdah75e4ngya@sigill.intra.peff.net> <CAGf8dgJ8C0chOxZo5CPt56225XGBgrjaGy8HDAST+0-USfW6mA@mail.gmail.com>
 <xmqqzicu64lj.fsf@gitster.mtv.corp.google.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Mon, 26 Jun 2017 10:35:19 -0700
Message-ID: <CAGf8dgK8T5ZKWq7yhPs9DPoubMyBERSrbPvwspJLjPXWc6Vf8A@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 26, 2017 at 10:28 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jonathan Tan <jonathantanmy@google.com> writes:
>
>> On Sat, Jun 24, 2017 at 5:45 AM, Jeff King <peff@peff.net> wrote:
>>> On Mon, Jun 19, 2017 at 06:03:13PM -0700, Jonathan Tan wrote:
>>>
>>>> Subject: [PATCH v4 6/8] sha1_file: improve sha1_object_info_extended
>>>> Improve sha1_object_info_extended() by supporting additional flags. This
>>>> allows has_sha1_file_with_flags() to be modified to use
>>>> sha1_object_info_extended() in a subsequent patch.
>>>
>>> A minor nit, but try to avoid vague words like "improve" in your subject
>>> lines. Something like:
>>>
>>>   sha1_file: teach sha1_object_info_extended more flags
>>>
>>> That's not too specific either, but I think in --oneline output it gives
>>> you a much better clue about what part of the function it touches.
>>>
>>>> ---
>>>>  cache.h     |  4 ++++
>>>>  sha1_file.c | 43 ++++++++++++++++++++++++-------------------
>>>>  2 files changed, 28 insertions(+), 19 deletions(-)
>>>
>>> The patch itself looks good.
>>
>> Thanks. I did try, but all my attempts exceeded 50 characters. Maybe
>> "sha1_file: support more flags in object info query" is good enough.
>
> Between the two, I personally find that Peff's is more descriptive,
> so unless there are other changes planned, let me "rebase -i" to
> retitle the commit.
>
> Thanks.

His suggestion does exceed 50 characters, but I see that that's a soft
limit. Either title is fine with me, thanks.
