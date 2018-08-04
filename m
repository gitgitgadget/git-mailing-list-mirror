Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E05C1F597
	for <e@80x24.org>; Sat,  4 Aug 2018 00:39:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732073AbeHDChw (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 22:37:52 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38213 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732001AbeHDChw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 22:37:52 -0400
Received: by mail-lf1-f68.google.com with SMTP id a4-v6so5281393lff.5
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 17:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=XEzx14HrMWFUulSszw9dZz+9jtZDgVdYpJ1NTX7bExs=;
        b=f2XRuzKH7LvRuv+QXw630Z/wIvA21CnJ7l4VKP+NADABj/rOMGU0DONWMYN+eT4Szy
         dfIwXIFU/4VdI/0iPhl7yKCNGzsHGgJ8GIFdHwnu/6wIjAdMNizAYKTMDgzDNlha3Zx+
         s2bmviNvLxN/ZVHg/sY4c+PRXJWk6B8tnyGj3P/6SKJviCArZumSE+1hYrRU0U+Chlgc
         Lm89C7RVeEKj4qQurINa1D0W+cmvoMN505C5BnssLeFw2LeOAV6+0Q3KnwqmV8jmrDvs
         0wBY+TtxLYkC8BBFTaxiaD0OWHTxG7CT1PB0tPsD07lbiUP/d2EEaO2vHzJaHr8zcwkX
         CaTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XEzx14HrMWFUulSszw9dZz+9jtZDgVdYpJ1NTX7bExs=;
        b=Qf5ekU8fzjjTL4x2R7WaXvYKA1H07mGYrCLx7m/9jwQk+4gCssKlo4dG06gmvpFJy4
         qugXzw4+SbWohT10WL+ppGXO9m+Lmdz1FE89SvWrToPLnax3USluHRWK1blU9wx7mtW9
         YR/AneF34Kfv26nvBHNlheqZ/dH+VEyFtQ07fJC+3QQ6qn9d8TCTlG2ay7MFiSE9xQIE
         kcFkNu4jFmjrfnw2NcKIrASpLGy7Hzq4RyFtWAKadr6yWyJ5tiMtyWVqZOR7fxUymBfE
         MXndI94PRtRv6zTpaRwS6lrO6NdObXw4VdhLQ7bBJ6pjWZyB3c/uJw61YXd2GCELHOhZ
         admg==
X-Gm-Message-State: AOUpUlFSFiLbufVHQV2ZX2Hq4wHukrNzFg2+l8dd2VQxz5L4IC7N4BrR
        YzDPQ7I3HiuGIVg9pSaN+Pk=
X-Google-Smtp-Source: AAOMgpfmla3YLD5g+ZdOMyahWfuzzt9xi0buA5pffj0CFZvl1JBS5jgF/QIyWgTomakDufWJMdbeQw==
X-Received: by 2002:a19:cc0f:: with SMTP id c15-v6mr5638545lfg.145.1533343155558;
        Fri, 03 Aug 2018 17:39:15 -0700 (PDT)
Received: from [192.168.221.164] ([185.79.217.61])
        by smtp.gmail.com with ESMTPSA id h90-v6sm1105207lji.66.2018.08.03.17.39.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Aug 2018 17:39:14 -0700 (PDT)
Subject: Re: [PATCH] t4150: fix broken test for am --scissors
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Paul Tan <pyokagan@gmail.com>
References: <f91c7393-4f1b-1cf5-b870-f42e9bd18d64@gmail.com>
 <8f69d82b-0f35-754f-0096-853d6b463db7@gmail.com>
 <xmqqh8kbuk4t.fsf@gitster-ct.c.googlers.com>
From:   Andrei Rybak <rybak.a.v@gmail.com>
Message-ID: <80465ead-3bf5-ffc7-59d1-7ab3770430b6@gmail.com>
Date:   Sat, 4 Aug 2018 02:39:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8kbuk4t.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-08-04 01:04, Junio C Hamano wrote:
> Hmph, I am not quite sure what is going on.  Is the only bug in the
> original that scissors-patch.eml and no-scissors-patch.eml files were
> incorrectly named?  IOW, if we fed no-scissors-patch.eml (which has
> a scissors line in it) with --scissors option to am, would it have
> worked just fine without other changes in this patch?

Just swapping eml files wouldn't be enough, because in old tests the
prepared commits touch different files: scissors-file and
no-scissors-file. And since tests are about cutting/keeping commit
message, it doesn't make much sense to keep two eml files which differ
only in contents of their diffs. I'll try to reword the commit message
to also include this bit.
 
> I am not saying that we shouldn't make other changes or renaming the
> confusing .eml files.  I am just trying to understand what the
> nature of the breakage was.  For example, it is not immediately
> obvious why the new test needs to prepare the message _with_
> "Subject:" in front of the first line when it prepares the commit
> to be used for testing.
> 
> 	... goes back and thinks a bit ...
> 
> OK, the Subject: thing that appears after the scissors line serves
> as an in-body header to override the subject line of the e-mail
> itself.  That change is necessary to _drop_ the subject from the
> outer e-mail and replace it with the subject we do want to use.
> 
> So I can explain why "Subject:" thing needed to be added.

Yes, the adding of "Subject: " prefix is completely overlooked in the
commit message. I'll add explanation in re-send.

> I cannot still explain why a blank line needs to be removed after
> the scissors line, though.  We should be able to have blank lines
> before the in-body header, IIRC.

I'll double check this and restore the blank line in v2, if the
removal is not needed. IIRC, I removed it by accident and didn't
think too much of it.

Thank you for review.
