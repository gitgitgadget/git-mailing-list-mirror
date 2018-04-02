Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0B71F404
	for <e@80x24.org>; Mon,  2 Apr 2018 23:47:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754665AbeDBXrq (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 19:47:46 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:41131 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754584AbeDBXrp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 19:47:45 -0400
Received: by mail-pl0-f52.google.com with SMTP id bj1-v6so3860867plb.8
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 16:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z+GF5/7sJlMVRX6HrIeNZJjhu3vZnuX0SyBvJ7+uHEc=;
        b=qmBBq4889HICjGzQAgUWFA1ayUEosRJAixrB04EnXgTMOJv/ey8I6K9Vl4ERXRpDy1
         /PNilRrMKslKB73JZybgaceIj0omgmCDGW0oceVaK8gj0nNS8oy1LUSyynY7bB+LOb21
         g5AXxAqysQhuKdkmS+Ab3/EmYX+qP15xYnhitosMC7XKEP6q6fbUG5/ivl4tCEjueVF4
         7tS+x4Jms824lHjcJXhL1CXQL9RjCRLEL8FWfVf3vik93tz8BoF01d27zKomBoR6ma0y
         0eu0IyUlV5Z43WQJslWmZtxTvMB7xwokN+jl8nThavEqo/xVrTCq4SIImSErswpcUMHk
         P+IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z+GF5/7sJlMVRX6HrIeNZJjhu3vZnuX0SyBvJ7+uHEc=;
        b=E+xRAuNDrt5l4l5fviP18kngi1RV94E9kW1FGDqZY9deR8NMJU8DIYn7zpoy4IYEZS
         N/04fjCAq6jBrjeF29zl89Q1tLOAK9rpJ444fv9om20E4yEOpb+mTSzVqajopvzxTL3W
         Zd1HGBGu0T3ldwKV4bED6rEIHujCQ2kvY97mLfF4XGGcqWgfje6EhKU2RR23HeLB0WXA
         3giUElAFvg2NwWZzf2REuVX+AvVkJjUtiq1oBDK8MOWHckhc/VK0lv2bp5Bw055bpL7q
         OOmvtlk08/BH8gUIHAAr76Rjc4yJhEsB/p+oldJvphRjf0C/Ze/WtNHZkC1EFzV3hjF1
         Xfsg==
X-Gm-Message-State: AElRT7H+n3jDYlFnBQzuPW5pgsRzyF+h8T+2JhFJKOWJc8WN0ko3qr8V
        cX9mIwNy8WyhyEdTTwodFtVLPw==
X-Google-Smtp-Source: AIpwx49ZFHQ1A20blryci+7fadupfxMpETopIMhi36sgPEAAlsZmfxNNGaajPARC6ZgeWNhsgo6WOA==
X-Received: by 2002:a17:902:85:: with SMTP id a5-v6mr11496214pla.99.1522712864881;
        Mon, 02 Apr 2018 16:47:44 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id p1sm2132977pgr.67.2018.04.02.16.47.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Apr 2018 16:47:43 -0700 (PDT)
Date:   Mon, 2 Apr 2018 16:47:42 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     jacob.keller@gmail.com, simon@ruderich.org, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/7] Moved code detection: ignore space on uniform
 indentation
Message-Id: <20180402164742.11d4c5507d6ee737c9935d73@google.com>
In-Reply-To: <20180402224854.86922-1-sbeller@google.com>
References: <20180402224854.86922-1-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  2 Apr 2018 15:48:47 -0700
Stefan Beller <sbeller@google.com> wrote:

> This is a re-attempt of [1], which allows the moved code detection to
> ignore blanks in various modes.
> 
> patches 1-5 are refactoring, patch 6 adds all existing white space options
> of regular diff to the move detection. (I am unsure about this patch,
> as I presume we want to keep the option space at a minimum if possible).

My preference is to not do this until a need has been demonstrated, but
this sounds like it could be useful one day. I'll review the patches
from the viewpoint that we do want this feature.

> The fun is in the last patch, which allows white space sensitive
> languages to trust the move detection, too. Each block that is marked as
> moved will have the same delta in {in-, de-}dentation.
> I would think this mode might be a reasonable default eventually.

This sounds like a good idea. "Trust" is probably too strong a word, but
I can see this being useful even in non-whitespace-sensitive languages
with nested blocks (like C).
