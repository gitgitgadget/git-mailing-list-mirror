Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CC1A1F424
	for <e@80x24.org>; Tue, 24 Apr 2018 23:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750826AbeDXX53 (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 19:57:29 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:50784 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbeDXX52 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 19:57:28 -0400
Received: by mail-wm0-f42.google.com with SMTP id t67so4141526wmt.0
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 16:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=s9vgjJOZq8gLiZV3lsM+5fLqz9STZaOEla7YJi69YcE=;
        b=J70Dp55tvjIXEGqKclJM9zWHsG1yAYtjPzQ/riEePnj69L78GtnUdop7sBpjKN+Kyz
         jp2Ox18v0skqrJfrEJdLi6OcQELV23G7kvFv2tLwuvWXlqR0aN4ToX4x3qcm1atADi44
         ij3AMgB2O21/9ZR/tg3OsQjUcMPWmjdQuw7+V+G3nSQijoHyg8+vg6G7KDi77lhc5Y/H
         bHxZWnBbOeLlHuBHBadGQxxUirRaP8qH4r9+kDH0bAuXlCKNTVfRV4k+IPFZ1UyboJ2g
         JNecHjO1vOyg5lpqPir8DBsurUeyhhQr3sebuZPSLCjWjvxwt2CsT3h6pCUoYrKOYkW9
         WHQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=s9vgjJOZq8gLiZV3lsM+5fLqz9STZaOEla7YJi69YcE=;
        b=bw8Atn7La4/fF7JDyBQ9cdgw5sSGhMXaPNZsj7dvgJ+s3b0Nn53GcUUcb6Aj9Tb/Pr
         WBAfeN0OQsNlb+OzbE/bn9UnuIbGzFBrqO4Xul61M7CrueuXr6imwrDo5rzq7c0UmIFK
         q7bEZLI9r66A41NlnSCHrfVeroodRf5QzOtIj4sub48g6kSS5XDiCMVZsAG3fgCw0MMQ
         +0nefr9ChOtSIwW6zI0ibrMlTgdoeBgnHc21wPjwYxSUdaicI/KNEgMJFBV9BNWnTPRa
         PUMTzh35AEdgnijGtEt/19QCRtz/VoOu+5tVohvOu4745gb24b21V0pLAbYHK6gSScEL
         FIsA==
X-Gm-Message-State: ALQs6tADdZ8KF5rlhyhmRZPqPZny4AFn6BTq96jpw4A5rKfNBdGu6Zl9
        Bux7MYwmGmSnvgmdoJMcgOk=
X-Google-Smtp-Source: AB8JxZo3hpHXxs0XhLObilFESkIySXk9LJghWHM3XOG9B8YyS/jer85L9lJIO7+YexrsfB1I9NEY6A==
X-Received: by 10.28.72.196 with SMTP id v187mr250877wma.115.1524614246872;
        Tue, 24 Apr 2018 16:57:26 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id k126sm18321863wmg.6.2018.04.24.16.57.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Apr 2018 16:57:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Ben Peart <Ben.Peart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        "peff\@peff.net" <peff@peff.net>,
        "pclouds\@gmail.com" <pclouds@gmail.com>,
        "vmiklos\@frugalware.org" <vmiklos@frugalware.org>,
        Kevin Willford <kewillf@microsoft.com>,
        "Johannes.Schindelin\@gmx.de" <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v1 2/2] merge: Add merge.aggressive config setting
References: <20180420133632.17580-1-benpeart@microsoft.com>
        <20180420133632.17580-3-benpeart@microsoft.com>
        <CABPp-BFXwbZfFe0bZYMwWxz_Qxw=KQ6XE5SEBmgiE+TzaSycuQ@mail.gmail.com>
        <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com>
Date:   Wed, 25 Apr 2018 08:57:25 +0900
In-Reply-To: <a34144ff-b91e-6f00-93e8-b472ad5887d0@gmail.com> (Ben Peart's
        message of "Tue, 24 Apr 2018 12:45:00 -0400")
Message-ID: <xmqqlgdc5fa2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> That said, it makes sense to me to do
>> this when rename detection is turned off.  In fact, I think you'd
>> automatically want to set aggressive to true whenever rename detection
>> is turned off (whether by your merge.renames option or the
>> -Xno-renames flag).
>> ...
>
> While combining them would work for our specific use scenario (since
> we turn both on already along with turning off merge.stat), I really
> hesitate to tie these two different flags and code paths together with
> a single config setting.

The cases that non-agressive variant leaves unmerged are not
auto-resolved only because marking them as merged will rob the
chance from the rename detection logic to notice which ones are
"new" paths that could be matched with "deleted" ones to turn into
renames.  If rename deteciton is not done, there is no reason to
leave it non aggressive, as "#1 = missing, #2 = something and #3 =
missing" entry (just one example that is not auto-resolved by
non-agressive, but the principle is the same) left unmerged in the
index will get resolved to keep the current entry by the post
processing logic anyway.

In fact, checking git-merge-resolve would tell us that we already
use "aggresive" variant there unconditionally.

So, I think Elijah is correct---there is no reason not to enable
this setting when the other one to refuse rename detection is in
effect.
