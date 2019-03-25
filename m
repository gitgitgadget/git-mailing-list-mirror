Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DA6C20248
	for <e@80x24.org>; Mon, 25 Mar 2019 19:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729473AbfCYTrQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Mar 2019 15:47:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43225 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728912AbfCYTrP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Mar 2019 15:47:15 -0400
Received: by mail-wr1-f67.google.com with SMTP id k17so3675082wrx.10
        for <git@vger.kernel.org>; Mon, 25 Mar 2019 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=YSRZQgBbPdD+GXkdTzEkyc+oVSDtxrwVJhrHZgMX+QA=;
        b=pemWpS2MmeUY0uuEGuSUvx+FHctYyATi5oUtQuehTKRuR+wonvCh2o0lu5m8b+in4M
         Ci0L1wH/3kNvgH7Nt+rlOTv0mTvIMGoFS4SkF5n/CPIVFUzOJe2eiWZI8diIyDQOqUxH
         A38Uq3ziCvv0G3rrnM8Kz56x4C7IcCO/HMoYMWFqN4wrad6WDjULIx0Biu8jsdUIo6Hf
         hLc1y514UwNZ1YOhG83Kqb6fRjtq4ELL/xsscqH3h34V+pMfb7san4wNtouyELBzh+oj
         h/37oxoTi7Pmzd9cqU3/lPHRe8tCgcokw7JUIddaNHNz4zil07vseItC/wCkaie5VzLb
         nY6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=YSRZQgBbPdD+GXkdTzEkyc+oVSDtxrwVJhrHZgMX+QA=;
        b=JcxQDa2+SA5Y6NmHIpWep89dd6wrQcz77x+Cy2zPWdb4BeQPifDVDZFa4CTvgPBy5B
         c/t5f65ejLY0EPdpPOe9SVFjrs5suo98UhO+N3GwO04O2HqItKhSXoG/zcruQqD7qbJX
         beFwvMAoYmDj01tsNjvptnAnFWQJc5T3NycU/Oh0+BUl2AnywXVbmFX5D5Y+bXQhxv5Z
         h6tS9sJhPvy1ASRIw/8QK9lpXrZN+sk4W2tOIsXQ5YwLwc17jdf530PtgFC2g1GTiuGj
         kIH51XkXm+AAFs1b2AMYJqIRu+EpYui31YAMeBqShAtdx5xerNZl+0FvYtquM/aWzynH
         P5+g==
X-Gm-Message-State: APjAAAW9w/oVb+2SkIqUWgrMWkyZk8B5J2wG59kj1wUYFEP/B0jBS2Mm
        4lZ5sqg3Gbkjvg+xDkuVB2cYakOT5nw=
X-Google-Smtp-Source: APXvYqyz00PE2QZOVWBgZsSB7xjwMdH7pmjjfFV7VRLHZL67irYEmyqwykT655vJyrJYFGzR+vd3IA==
X-Received: by 2002:adf:e288:: with SMTP id v8mr16148416wri.7.1553543233578;
        Mon, 25 Mar 2019 12:47:13 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id c10sm22741250wrt.65.2019.03.25.12.47.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Mar 2019 12:47:12 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 8/8] tests: disallow the use of abbreviated options (by default)
References: <pull.167.git.gitgitgadget@gmail.com> <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <04c36b1de9f22d7e0c64bb118eb424c1f64bd223.1553537656.git.gitgitgadget@gmail.com>
Date:   Mon, 25 Mar 2019 20:47:12 +0100
Message-ID: <87sgvabutb.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 25 2019, Johannes Schindelin via GitGitGadget wrote:

> +# Disallow the use of abbreviated options in the test suite by default
> +test -n "$GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS" || {
> +	GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=true
> +	export GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS
> +}
> +

Just using the if test ...\nthen\nfi long-form would be consistent with
our usual style & the rest of this file.
