Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E37A1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 19:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729804AbfBDTNo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 14:13:44 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43233 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfBDTNo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 14:13:44 -0500
Received: by mail-wr1-f65.google.com with SMTP id r2so1044707wrv.10
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 11:13:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=6GSvNut0AVa7EM4nZcgZYR6MWws30hUORPyFvHqInkg=;
        b=swm8kfcl2r/lipQpb+nRm8iSLP6eXh15xGuXStylmmDOARX2xKexuW5CwdM+Arxayr
         UVAdksX738MnY+Lq0c9xKsT3q3bOJsU9+niSa8Pi6BAfW9wM4AcmFhG3UPmJGo/roZRc
         /VnsbwKpFZ6zPHNQs9DsZSzIF53uIa+bVh9X7SEWGD8SQYSF/+YOjRKMhRtS7uzSrE1D
         xGK2n0yxMIpw+8oGAA1V4AUNtJneCnhs54lYnZPu72cNQaL+VLq6WeXtxljwkVPiPccJ
         9FKHnkmAMG/4/4jzojI3zLtjdYlP99LQ09O0HFTRCGrlU/NB7/C4Zao8Uv0b7963E7Oe
         puSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=6GSvNut0AVa7EM4nZcgZYR6MWws30hUORPyFvHqInkg=;
        b=iwNyUYxXsZWHXPySDAtFrdK9+YONhsTcpMv36ra0zPKLY5D/2Y7yJPvx0X0aYkBp3q
         wtWb/EzvdTDQv4BMNszwuZqEAwDHBwcIRz5+b1j4dgHN6fHDi3uncn0fHYWqoiCNtmgx
         TRBkQSB+OVaKWhYjMn3UKzZ9+mnOOn+HFH9l6T7XxTGLB8ryUWqNMyMfAIia5jPRR/fZ
         UNdWV/P9ZzKjfa6KOn3viWQZvMb/AmRm+jVdvMLwKBIFFdrpAxoZOiYF1gxedbXiiZgC
         vhuQiIY8jt9+IgJOczDm3PO/oQpEdcaQDEv12JzrPJmpHMambk2aR17oaKAtDSm7Z/FS
         04yQ==
X-Gm-Message-State: AHQUAua0Rn+bAVFP1c9yzUkVRZexFtl5Ydh3XXqJz1B71P7Q/0tRcjxb
        umRzk2O171RNSJO29tsyuoQ=
X-Google-Smtp-Source: AHgI3IYRPkEmznYL5iV8L5M91DOgOhVgReKSKAsBxW06IrohwSZTGfzM6Qde/XOsDmkTVTTfPQSuYA==
X-Received: by 2002:a5d:438a:: with SMTP id i10mr659693wrq.111.1549307622541;
        Mon, 04 Feb 2019 11:13:42 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id a14sm2582070wrh.47.2019.02.04.11.13.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 11:13:41 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
        <20190204161217.20047-1-avarab@gmail.com>
Date:   Mon, 04 Feb 2019 11:13:41 -0800
In-Reply-To: <20190204161217.20047-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 4 Feb 2019 17:12:17 +0100")
Message-ID: <xmqq7eefv02i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> +The algorithm to pick the the current abbreviation length is
> +considered an implementation detail, and might be changed in the
> +future. Since Git version 2.11, the length has been configured to
> +auto-scale based on the estimated number of objects in the
> +repository. We pick a length such that if all objects in the
> +repository were abbreviated, we'd have a 50% chance of a *single*
> +collision.

Correct and reads well.

> +For example, with 2^14-1 is the last object count at which we'll pick
> +a short length of "7", and will roll over to "8" once we have one more
> +object at 2^14. Since each hexdigit we add (4 bits) allows us to have
> +four times (2 bits) as many objects in the repository

Something is missing at this point in the sentence. 

	"without raising the chance of a single collision higher"

or something like that.

> , we'll roll over
> +to a length of "9" at 2^16 objects, "10" at 2^18 etc.

Correct and reads well.

> We'll never
> +automatically pick a length less than "7", which effectively hardcodes
> +2^12 as the minimum number of objects in a repository we'll consider
> +when choosing the abbreviation length.

This may be technicaly correct, but to me, it seems to place stress
on the wrong side of the equation.  Since nobody would find "Ah, so
I can create up to 2^12 objects without fearing that my abbreviated
object name would become longer than 7", I do not see much point in
saying "hardcoded floor for the number of objects".

On the other hand, saying that 7 is the hardcoded floor for the
abbreviation length does make sense, as those adept at math after
reading the paragraph up to this point would wonder why their tiny
repository still uses 7 hexdigits, which is way too many to ensure
the low collision rate for the size of their toy repository.

	We do not use abbreviation shorter than 7 hexdigits by default,
	so a small repository with less than 2^12 objects may have even
	smaller chance than 50% to have a single collision.

may be an improvement.

