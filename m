Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E73F01F404
	for <e@80x24.org>; Tue, 27 Feb 2018 05:16:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751861AbeB0FQe (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 00:16:34 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:45739 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751679AbeB0FQc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 00:16:32 -0500
Received: by mail-pl0-f67.google.com with SMTP id v9-v6so8747309plp.12
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 21:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZnsQGY5NYJodYRU3MrDNUodlmRS0geEIVcQVhfTNHu4=;
        b=rkF5UVAvyhYMoIuca51Ahexqn0ZhIF3u6R7SdN4EqX8mmUb2suW8F8aO0dtr6IuxHX
         SBHCq1NKrTjs4SY023JzPRJ6av1kYeqJFc310Yl7DQFK1D+1DxErK1ldzsBH9efgyY8l
         9F3CX2cpPQH4rfbHBElzNntb/TzWwIZXqDJ0WVq2SchTpl3VJff+F125z7H2d7nRbFw+
         /s0DTcjQtq4CyVtjQGEm1O6c8e0yoSEI+1rbfQpV3KmdxB9LpRvFoD/dQhFKTcT3oFT8
         njngYx2DmW3p16VjQdhSXEgiSTh55EJ7pHXQC7twxAXhGv9vELXyIsIrLW8IeDk96H+q
         wwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZnsQGY5NYJodYRU3MrDNUodlmRS0geEIVcQVhfTNHu4=;
        b=YgSvG8dXZKbNvrYtqkyJtGK20t6RsEt6Yw1ZOKrPnCDw0BRsyno3B0Jlq5PJko6sh1
         jTVv32yMKACaPWZwvGKyYJksFPhAoGYUvjhSbjuSxiMRG3LDJS0lM+PN0zLighjBkvEO
         +Y+SFGZNqf33tFhz/lr8Zwv0nTwWBPmf2k7l7CALpm8CfpNFZ032FFnM5ZjoL6tgDAd4
         9HQ0GXxkWzDx4s0Hxj+nch2BAOqo01601QfxsjkkCLYUtEqZsTz5KxfAoIoOEhkfluOn
         HvHeC1M+cKg125DZtYYCOy6nR2hO8hB500WAPXSGT3CivBIV5pO6mSBaIBlxQHDyab9v
         ucKw==
X-Gm-Message-State: APf1xPAN0YEBkzJSevIiWKQZ+QyPP4TFItX+Q3bGQh+yFRm/spBIU7zQ
        jbubmnhLxpH2qMVDkXglNwA=
X-Google-Smtp-Source: AH8x224c87A57QrkQeuEAZA9qfNQJzzAiLq53jumXUDOeuEXwvJMa271+PLQr8yCP4zsNR9Z3WnViw==
X-Received: by 2002:a17:902:9002:: with SMTP id a2-v6mr12965423plp.412.1519708591328;
        Mon, 26 Feb 2018 21:16:31 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id j64sm22747681pfe.68.2018.02.26.21.16.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Feb 2018 21:16:30 -0800 (PST)
Date:   Mon, 26 Feb 2018 21:15:55 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>, Brandon Williams <bmwill@google.com>,
        git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        stolee@gmail.com, git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 13/35] ls-refs: introduce ls-refs server command
Message-ID: <20180227051555.GA65699@aiede.svl.corp.google.com>
References: <20180125235838.138135-1-bmwill@google.com>
 <20180207011312.189834-1-bmwill@google.com>
 <20180207011312.189834-14-bmwill@google.com>
 <20180222094831.GB12442@sigill.intra.peff.net>
 <20180223004514.GP185096@google.com>
 <20180224040149.GA16743@sigill.intra.peff.net>
 <87inaje1uv.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87inaje1uv.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Sat, Feb 24 2018, Jeff King jotted:

>> I actually wonder if we should just specify that the patterns must
>> _always_ be fully-qualified, but may end with a single "/*" to iterate
>> over wildcards. Or even simpler, that "refs/heads/foo" would find that
>> ref itself, and anything under it.
>
> I agree that this is a very good trade-off for now, but I think having
> an escape hatch makes sense. It looks like the protocol is implicitly
> extendible since another parameter could be added, but maybe having such
> a parameter from the get-go would make sense:

I prefer to rely on the implicit extensibility (following the general
YAGNI principle).

In other words, we can introduce a pattern-type later and make the
current pattern-type the default.

Thanks for looking to the future.

[...]
> E.g. if the refs were stored indexed using the method described at
> https://swtch.com/~rsc/regexp/regexp4.html tail matching becomes no less
> efficient than prefix matching, but a function of how many trigrams in
> your index match the pattern given.

I think the nearest planned change to ref storage is [1], which is
still optimized for prefix matching.  Longer term, maybe some day
we'll want a secondary index that supports infix matching, or maybe
we'll never need it. :)

Sincerely,
Jonathan

[1] https://public-inbox.org/git/CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com/#t
