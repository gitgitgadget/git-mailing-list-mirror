Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B136420248
	for <e@80x24.org>; Thu, 21 Mar 2019 05:19:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbfCUFTY (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Mar 2019 01:19:24 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:36307 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbfCUFTY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Mar 2019 01:19:24 -0400
Received: by mail-wm1-f52.google.com with SMTP id h18so1363450wml.1
        for <git@vger.kernel.org>; Wed, 20 Mar 2019 22:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=bRbVJgxDQt4xNPcGH2twm0mu5gjq9Ak9LrUCOXk111o=;
        b=VVY0+nqFWAD/Zj1Osn7uKZb9gC4CcMsqzoi6hOgDYHxgGEUBTkYW3BPIbux1cFuSOk
         Bqx2yUiWILHWC/cZIcIxi79S6uoRh2R6Y17Ajmg5VvS0E34Dp9LwEWPBj7NjKQPvEiPB
         6LpWKErowX1omDC2+e5KaotCSfWL/zF4U6gZXR3ul8I3z77ZqxskgVAtFN2+c3ET2uM9
         HQSeGsRK/L+NDGxLTkhd394yIgDGRraSqeprZ88teqF4ldfwU6XXqjEtWO4Lyzl/PQJl
         mwvXsYYuj7mjo2IICozpfs5vXSiErCvpGexOAoRFSl/1icbkxaiUd2t7hmrrxeTzQL/2
         c7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=bRbVJgxDQt4xNPcGH2twm0mu5gjq9Ak9LrUCOXk111o=;
        b=j1ij/NP7oh9NaFMvaHC6CbObrXvVVp4lCsg5FmvlTT7JMbESv9yCHcDtT7KqjcniC0
         sWqf0jw6Q9dW0xfPk6mwgWp5ee88GETEzDiiIRx+MZq0p+ku63FBg/fSMw0BNH6lqNht
         i/OF1UJXJDiL4YL7gtqIxGraGptDuzzAXmlYL7rHCeyXl2RG4tjtBpKrH9PFXAtlXTT4
         rmogZNe6AHbzxyYOoRovN6lGGhfuSiFT2hxVr/56pz0DbYmIRaIAwJ6oDpVojzoAx1+E
         UYhN4q5x8LTKCFZJJgKjIzn9hB8ZVBWCS1ogJCKsqEQ7Nxhv7Y0p10S/Fg2IV6ZlWWWg
         Eibw==
X-Gm-Message-State: APjAAAXdHi03qKGcsdyGDrANab8UvwJetW/4lFD7QsYXwWO91eZLvBWi
        1AGId2eDmrlNkU+VOpBCDX0=
X-Google-Smtp-Source: APXvYqzBoCmnspzR0HxzgscIs2NqYXwU8H/tEOZR9FkKA38NZZtUHzGVcTocso5F5JayWxws6UchaQ==
X-Received: by 2002:a1c:2543:: with SMTP id l64mr1145378wml.116.1553145562505;
        Wed, 20 Mar 2019 22:19:22 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id f7sm3009945wru.3.2019.03.20.22.19.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 20 Mar 2019 22:19:21 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2019, #04; Wed, 20)
References: <xmqqa7hqw844.fsf@gitster-ct.c.googlers.com>
        <871s31dv6o.fsf@evledraar.gmail.com>
        <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 21 Mar 2019 14:19:21 +0900
In-Reply-To: <xmqqef71uk8t.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 21 Mar 2019 09:46:58 +0900")
Message-ID: <xmqqpnqkst2e.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>> On Wed, Mar 20 2019, Junio C Hamano wrote:
>>
>>> Here are the topics that have been cooking.  Commits prefixed with
>>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>>> '+' are in 'next'.  The ones marked with '.' do not appear in any of
>>> the integration branches, but I am still holding onto them.
>>
>> I have re-rolls & re-submissions of some of my stuff as a WIP, but one
>> thing that's fallen between the cracks & should be ready for queuing is
>> my commit-graph segfault bugfix series:
>>
>> https://public-inbox.org/git/20190314214740.23360-1-avarab@gmail.com/
>
> Thanks.  I quickly looked at the difference between the updated one
> and the old one; will take a deeper look later.

It does not seem to play well in 'pu', unfortunately.  In my local
tests, 'pu' without this topic passes, but what I pushed out to
public has this topic on top and t5318 does not pass for me.

