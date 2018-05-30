Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC951F51C
	for <e@80x24.org>; Wed, 30 May 2018 09:26:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968793AbeE3J0C (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 05:26:02 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:51907 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968758AbeE3JZ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 05:25:59 -0400
Received: by mail-wm0-f68.google.com with SMTP id r15-v6so18894369wmc.1
        for <git@vger.kernel.org>; Wed, 30 May 2018 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=T9cJmn/1wzP/bJ8WYco2AmEBTIcotVtoOhndQISOCCo=;
        b=ro3nBP56P4gK4781zOxyuhWNVIBb8Y5/7rL9dZUbDFJw+fROJp68rtFvzv3zMbHsWs
         fqiRaT7Oy4m3j4NtoYQn1hAcCvZkfg0srVeh66e+I1yX0AGfcOPvFYllb9h2ljWTR54L
         +riocr+tC1qQ4iW4MMVEg+kcgVDFlFr18WhsbM6mcBpkcuiS/u0LLrMMGZYq2/nBWF/S
         dPJFkJ+yMt8Yc5ZSbUz7l+gZo7TrMnnYT54t2Y9n5JzVvv9YL1Zc0Ykp+HTf3M6c1Y3Z
         wLfq7pe1LRZbmLMcWSBfQThm6YBIFHDrdyDApudyHRaEOl2JNzS2Q01QoNJM2M36LU9+
         46xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=T9cJmn/1wzP/bJ8WYco2AmEBTIcotVtoOhndQISOCCo=;
        b=nr1c5e6cvrYVDrN8KHEsZAgkerfr6Aj/kLXWkohUy5tAYOABjpWCmxSraNqwKGxlMl
         B0wOK+HIZpfYd61AFYTuSM/KpN+m5DbxLMi2ViMfHVjExiSP9XFwg8MffX7FCO6CLxcz
         f3vLfIdlt/Vka9/oVV5NuZSgkcOHGI6G/tXarJe8VTme8+9N1edRhYZ9g1milgw3t6Uk
         twyWxRMjoRnJNWqrwLizjC/IiNg7bL7yLaO/Yy5PVzy8McFWAnNsDUN6cJjP9vqpTiqy
         kSL5jAgwCwFqAO5t0f/nD2zR2UTJ/7xHK1/neWjQ8E1FCdeHRsFvgXBaG5zkppQxcGf3
         f4jQ==
X-Gm-Message-State: ALKqPwdjPftyPCoDu53GCK5EWTEpUrgIHdkQ5xsBhdPYrkL86yxV29KS
        +O9HBoJi34zi3MxEsyGdYRs=
X-Google-Smtp-Source: ADUXVKL+cJzcC7B4RuoG2M46X7YzG+KSuX+12Ai363LxdxA6/rCXMvJWwPmwzqe0y5Wbn+8r4812cA==
X-Received: by 2002:a50:9818:: with SMTP id g24-v6mr2585740edb.31.1527672358723;
        Wed, 30 May 2018 02:25:58 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id t1-v6sm18662209edq.84.2018.05.30.02.25.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 May 2018 02:25:58 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/5] format-patch: automate cover letter range-diff
References: <20180530080325.37520-1-sunshine@sunshineco.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20180530080325.37520-1-sunshine@sunshineco.com>
Date:   Wed, 30 May 2018 11:25:57 +0200
Message-ID: <878t81fqai.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, May 30 2018, Eric Sunshine wrote:

> * The final name for the 'tbdiff' replacement has not yet been nailed
>   down. The name git-branch-diff is moribund[2]; Dscho favors merging
>   the functionality into git-branch as a new --diff option[3]; others
>   prefer a standalone command named git-range-diff or
>   git-series-diff[4] or similar.

FWIW Dscho in an IRC conversation on May 25th seems to have settled on
calling it "git range-diff <args>". He just hasn't gotten around to
submitting a new version.
