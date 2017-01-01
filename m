Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12C71FCA5
	for <e@80x24.org>; Sun,  1 Jan 2017 20:36:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932393AbdAAUgf (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 15:36:35 -0500
Received: from mail-lf0-f47.google.com ([209.85.215.47]:36016 "EHLO
        mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbdAAUge (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 15:36:34 -0500
Received: by mail-lf0-f47.google.com with SMTP id t196so262444462lff.3
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 12:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hR6Bjpce4xKjbH0HXUG0M+NNOpNSPfMUQ2BTveqCxWY=;
        b=Ymwrlg+Ae8uwEycZ24QPrfU585cWQJCYdwzGZigdwRnKu4ljrGf5jWHox0GurZL1ca
         NN5vPr8o7QmLmonwkSg+soUB4X+pDEaGRqJHjPf88/WPYU6MTTzGBzPzGj+Ox9yq8IxG
         7jvKiAn8kQbyVdoZ0Kl33YcJMs8NmTOMbv8b8lfpnnvAaRTUNe2IM8DJHgeRfjVlJkDv
         YG7sEQLNSBIEnKichwhbxXf/kZqlK7VT34Zejz+ZQJNnZdHZ9AZBLMlupTYqVpqhrT7p
         SN6fK/CgiWWktJQcmsBK6ZupqEtweMYtDnBNCcPXdNKrLNAxBGBeH+tq1L3RSaI1MreO
         KUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hR6Bjpce4xKjbH0HXUG0M+NNOpNSPfMUQ2BTveqCxWY=;
        b=EsFj+TOgEiUr5icHnfYq1HSp2tehbZBbGX07+XNW5nryi5YfZ0V1fXqbCamhvM4YYk
         LZFL1o8NdWDhrVT2xX+Ws8YieWvs85glhk/YRw3mkSNwW0YmOZuQWewde7B5HsWY9mHO
         q4jYPt9FvofDJWsvhE6N4HRKcB6LPexFK6kMmYoBYGT+d8JMOe6XgHltvQW7f1tBQ16m
         KRzmRC0JLMSwiUO8vleqJfcy5G05k7PfeqHSVohK7KyXfNRALkJbVBrkj453CSaXYHv3
         pyq8vw+GnDzkNF4xpRGGZUHQBBitCWCvyQi3G+7Zp0DgxJVyeNKpGN+oE3DTIrpbmEeh
         RgdA==
X-Gm-Message-State: AIkVDXJ4PuGaMw7Zw46HJ/xILnctRHz+DesJVRf2HF+CxitCu3Yg2IcowKY89OZKfrjqKJCUeLhGnIOQdkdOMg==
X-Received: by 10.25.72.215 with SMTP id v206mr19727825lfa.12.1483302992383;
 Sun, 01 Jan 2017 12:36:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Sun, 1 Jan 2017 12:36:11 -0800 (PST)
In-Reply-To: <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley>
References: <cover.1483153436.git.mhagger@alum.mit.edu> <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com> <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
 <994A5650F89F4B0080530BF7FD1879FD@PhilipOakley>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 1 Jan 2017 12:36:11 -0800
Message-ID: <CA+P7+xqxSpV4yOjE+Lv0kw19Kq6UAbcN_-7O3U_EeBoT7AOtfw@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 1, 2017 at 4:43 AM, Philip Oakley <philipoakley@iee.org> wrote:
> From: "Jacob Keller" <jacob.keller@gmail.com>
>> I do have one comment regarding this series. Is it ever possible for
>> an older version of git to be running a process while a new version of
>> git which cleans up dirs runs? Is this expected? I just want to make
>> sure we don't need to worry about that scenario since otherwise it
>> makes it much more challenge.
>
>
> It is easily possible in the Windows environment where the install philosphy
> is different, and some external vendor tools may even bring in their own
> copy of Git as well. There is also the Portable Git version, so the
> possibility of multiple versions running concurrently is there, though it is
> on Windows...
>
> I certainly have a Git-for-Windows published version, and a recent SDK
> version on my home machines.
>
>

Ok.

>>
>> My thought as far as I understand it is that it is possible, because a
>> user COULD choose to run both this and an older version, but that it
>> is unlikely in practice outside of a few developer boxes who
>> periodically switch between versions of git, and are unlikely to
>> actually run multiple versions at exactly the same time.
>>
>> Thanks,
>> Jake
>>
> Philip

But how likely is it to end up with differing binaries running on the
exact same repository concurrently? Basically, I am trying to see
whether or not we could accidentally end up causing problems by trying
to race with other git processes that haven't yet been made safe
against race? Is the worst case only that some git operation would
fail and you would have to retry?

Thanks,
Jake
