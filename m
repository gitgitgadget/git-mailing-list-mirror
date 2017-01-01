Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B795205F4
	for <e@80x24.org>; Sun,  1 Jan 2017 09:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753888AbdAAJZV (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Jan 2017 04:25:21 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34223 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753230AbdAAJZT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Jan 2017 04:25:19 -0500
Received: by mail-lf0-f45.google.com with SMTP id y21so257382849lfa.1
        for <git@vger.kernel.org>; Sun, 01 Jan 2017 01:25:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=/3cT3NDVnnmYEWcia8ddAS6AULHfQEJLwcVUVh5wHgQ=;
        b=jOfOw1tI4kn+6Q3wtyewdx9ktnVDXMQuU6QB6daZ3wiVSNLuFeO+zSFqb5mcQUVxIR
         jXDOiDysUb33HxXqKQFQRZJBeiZ+RcFk/Tw39kAfn+uV4whQiGAi5c2eRCBdV0zX3Jri
         nWZ5+R4/a1ZFBeG8+eRPWyPFmOASO8xnBEfjqeon5XFF1os/ILpq/i+B0xXkg1/uFzkU
         mD34ofv6LLxL37vSFjcydzIZ/a8x0nW1LAZPd3w1UIIb4i0lwadvaBzCxmPhiGldjk0T
         k8YxZ3aq8NqSlpFYvo5PuoMcgP8WlshHbKLlsm3wVSktAR7bIJFYFjlGnt5OzSqYQ44I
         8f/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=/3cT3NDVnnmYEWcia8ddAS6AULHfQEJLwcVUVh5wHgQ=;
        b=WYVhwOwbVmPlGr4vVgcrPLGBFRwPgC/gNo/NZOzklIwfN71QjMSQKLEhjQpIP2lzzg
         a348P6+hvz0HQDDaYdrZBpATOUb8bdjT1I6b1YOl7FG/vf3Od/JU1BjfOwAlQekwjqFj
         JVZ6CHOUIpRnynpPYXFvDROxNuu2zxDke8Jij9Xdd9U77wkEOdvgqC7z4Fzl8UaBQK1T
         yVqXb+8bEo+qD+zsvyowMpbyWwwCZwMFE7Tq4i2JSrFMWZuGWUdKzVxq020iRbT/Hzbd
         SzLyyNlkLFd8KkiNRBpjeiY7r8ldcxEv7IjdFFp9kaJ35IwjnBMyoU58O0/1mCLGQ+6n
         tb1w==
X-Gm-Message-State: AIkVDXLriRsAuqmyHwU1msoDw3jlzGgBOk/lXkeWyqssIbceNTrML+hHMj4UkjkTVp1fsuclWnfb67vKbSKYLg==
X-Received: by 10.25.72.215 with SMTP id v206mr19155059lfa.12.1483262717843;
 Sun, 01 Jan 2017 01:25:17 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.79 with HTTP; Sun, 1 Jan 2017 01:24:57 -0800 (PST)
In-Reply-To: <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com>
References: <cover.1483153436.git.mhagger@alum.mit.edu> <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
 <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 1 Jan 2017 01:24:57 -0800
Message-ID: <CA+P7+xqqVFvDKSCTrGVVdpZB_VHwGdZ3gFQzo+RQqCu0FpOsAQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Michael Haggerty <mhagger@alum.mit.edu>,
        Git mailing list <git@vger.kernel.org>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 31, 2016 at 6:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>
>> On Sat, Dec 31, 2016 at 04:12:40AM +0100, Michael Haggerty wrote:
>>
>>> This is a re-roll of an old patch series. v1 [1] got some feedback,
>>> which I think was all addressed in v2 [2]. But it seems that v2 fell
>>> on the floor, and I didn't bother following up because it was in the
>>> same area of code that was undergoing heavy changes due to the
>>> pluggable reference backend work. Sorry for the long delay before
>>> getting back to it.
>>
>> I've read through the whole thing, and aside from a few very minor nits
>> (that I am not even sure are worth a re-roll), I didn't see anything
>> wrong. And the overall goal and approach seem obviously sound.
>>
>>> Michael Haggerty (23):
>>
>> I'll admit to being daunted by the number of patches, but it was quite a
>> pleasant and easy read. Thanks.
>>
>> -Peff
>
> Thanks, both.  These patches indeed were pleasant.

I do have one comment regarding this series. Is it ever possible for
an older version of git to be running a process while a new version of
git which cleans up dirs runs? Is this expected? I just want to make
sure we don't need to worry about that scenario since otherwise it
makes it much more challenge.

My thought as far as I understand it is that it is possible, because a
user COULD choose to run both this and an older version, but that it
is unlikely in practice outside of a few developer boxes who
periodically switch between versions of git, and are unlikely to
actually run multiple versions at exactly the same time.

Thanks,
Jake
