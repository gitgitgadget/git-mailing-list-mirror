Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 18B621F404
	for <e@80x24.org>; Mon, 13 Aug 2018 18:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729748AbeHMVIB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 17:08:01 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38151 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729708AbeHMVIB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 17:08:01 -0400
Received: by mail-wr1-f67.google.com with SMTP id v14-v6so15082372wro.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 11:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=kz9r40oEY1fFPHfyKK396wZOVSQAC0fsoa1ZW7LIMbY=;
        b=eWyeaRtOIszvqCi74NLS+/KiF1qbHgOaAt/9iSr5Dw/9R38FKpz7txhOXcAHyKLShx
         vrX3hIZs3cqho4pR63kxOoJA6lj7JWuBb2Ss4P1TFJwpfLsVq8QhdUvVX2Yc6BUkp5t8
         7D7NzwhczsntUofs8S09lCmEnEz4Q6kvCttPmY7Nzi3agl2n18zjT1oml6dTxyWscVeF
         vBwqo+lfnJNn4vt3DHflWxLgcXsn7uSm+xt+FrMppSnGFnUtrglqnfsiG/2F5E45qVcm
         y7vQGjTO+QZ6sMX1lkC43aZ3EEbWA1ET7ttzsFdRh5r4uJU2ejkFXk2ZetL6BHWpot6X
         5LSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=kz9r40oEY1fFPHfyKK396wZOVSQAC0fsoa1ZW7LIMbY=;
        b=X3GuCqNjDtb9kFIAukqcJ0YpRzu+QmP7JBL2waX7QYlPj1jkjJQ2VJjBLci490WxZH
         7+2odLcrZIQeltmMKfa6cGloLbYSnNutrYEM8IEYTHnRNeRfcNxc0I9eYS1bbF67ZJfO
         ufdX809Y9vbW3L+pgzxmbtUOb5h8Bj9J48u0QwONCpsBGbEOqhYiwrm9eaICM8PdyCJD
         USpMnKqVT+BKyWHdxYym3lqO9glqRQugprqOlmBcqWIJPyzCrJYrCRORC4YSfXSILhg6
         28690eGBp5DUShj+1+84TVSm7d34XzgZlPHELnVJtBbGE4jj+7QXsHAddX15A450pGhS
         +tsw==
X-Gm-Message-State: AOUpUlF+Wbq2zuGteh2u57TaWuND10muBMK9ZRnec1VkoAjlZgkm0QjE
        pURebgCV+AnyBCgW/2JNMqQcqDs9
X-Google-Smtp-Source: AA+uWPwZUfv7dZujgN3BVnlOq2pXr/Mk1RIurg9oUKdSubQlkupXcds+pCa5s83jJxIUKbnXiiAgxA==
X-Received: by 2002:adf:f64c:: with SMTP id x12-v6mr10951425wrp.97.1534184678749;
        Mon, 13 Aug 2018 11:24:38 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id l72-v6sm34586767wma.17.2018.08.13.11.24.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 11:24:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
References: <20180811043218.31456-1-newren@gmail.com>
        <87mutts3sz.fsf@evledraar.gmail.com>
        <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
        <20180811173406.GA9119@sigill.intra.peff.net>
Date:   Mon, 13 Aug 2018 11:24:37 -0700
In-Reply-To: <20180811173406.GA9119@sigill.intra.peff.net> (Jeff King's
        message of "Sat, 11 Aug 2018 13:34:06 -0400")
Message-ID: <xmqqr2j25dlm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The rule in Git has always been that your very first include must
> always be "git-compat-util.h" or an equivalent header that includes it
> first (like "cache.h"). This is mentioned in CodingGuidelines.

Glad to see that you already have written the above so I don't have
to ;-)

As things are slowly moving out of the so-far kitchen-sink "cache.h"
into more specific subsystem headers (like object-store.h), we may
actually want to tighten the "header that includes it first" part a
bit in the future, so that 'git grep cache.h' would give us a more
explicit and a better picture of what really depends on knowing what
the lowest level plumbing API are built around.

> So I think the better test is a two-line .c file with:
>
>   #include "git-compat-util.h"
>   #include $header_to_check

But until that tightening happens, I do not actually mind the
two-line .c file started with inclusion of cache.h instead of
git-compat-util.h.  That would limit the scope of this series
further.

> I wonder if there's an easy way to check. I guess adding '-Dint=foo' to
> the command line, and then putting '#undef int' at the top of
> git-compat-util would catch just about any code the compiler sees that
> doesn't have git-compat-util included. :)

;-).
