Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25FC61F454
	for <e@80x24.org>; Thu,  7 Nov 2019 06:49:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfKGGs7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 01:48:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33071 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725763AbfKGGs7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 01:48:59 -0500
Received: by mail-pl1-f194.google.com with SMTP id ay6so778757plb.0
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 22:48:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZZAIgMDI+BryG7oiYKz6rGyYgFBOkcx0CLHzHDVRRpQ=;
        b=BQTwnglHO93LSkAk19y57eziOyIQm/wBXo5NtB88gO70+FPpcPMTTXpCEImCcAJ+JS
         MP4vyj04ITT31145dR+uUQRhEJXmCL1VLeWoZtTw4Vx1YA3lXw/S4/sNSViXHgFwsOX0
         hH8JAY0P7YtQuSxyOTFujCAunTxHY3TzwDjizHoDD1wsSL7K86D4sc9jdfrGmM8FF7UY
         UrUpywe+ogo/tIq9H/zcGsnhs3hB4xooHGbwi1RwDHzLAiBtq+FOkc0C9ZtfPLDMa3V7
         eqUsqjSKavPrdSE1TsHP8WJKInrnFfhQ6p1KzKfjXLBq2tZBEGhFiHbkz10CLCnXgVL9
         W5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZZAIgMDI+BryG7oiYKz6rGyYgFBOkcx0CLHzHDVRRpQ=;
        b=ai4IyEL3lYP9OLoyd3GDRMxhAklrabyNYGlzX6xahzF1ifZogmciD4btxgbJJz9BQI
         ht7fKkWp06eLSpmG0KhO4W1SfUYRp/kbBg2239QzeeYmFWss9ybm9YpexR5DoNJQgWHE
         bmMs04RdwHzoIg5ZPZVXtb7sy0VvGb8veZSFQ8vnpJVm1m0vi62oeeGX6loNGwdxEUSR
         dWQrJsuqQt0IjBNMS7WC0e+d5SIym9EI2+80hYIkRcmfPM5b8j63G9dw2zB9psMPO1Ad
         lKaEpoCieNbO1GFqzdMs7L2T/1DJbFVKq08vb3cQcfjmfgbroAzcgOv5SWHLQVJJk+Za
         9iRQ==
X-Gm-Message-State: APjAAAWDNEBdRdaCKNjKMM+f0bnLO+GNwwizRdV/MGgyY3UljrrM4yDb
        EFQMi9I241p9pB2+4OWSdG4=
X-Google-Smtp-Source: APXvYqzf20ZiwxVo7Q+H65q0CojVhkZFsksoZk04l0HP53unicrEIHzZsh5hd0d/yUaa/GVlnTiGug==
X-Received: by 2002:a17:902:ba91:: with SMTP id k17mr2078268pls.100.1573109337299;
        Wed, 06 Nov 2019 22:48:57 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id x20sm1418299pfa.186.2019.11.06.22.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 22:48:56 -0800 (PST)
Date:   Thu, 7 Nov 2019 13:48:54 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi
 encoding
Message-ID: <20191107064854.GB8096@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
 <20191107060233.GB6431@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107060233.GB6431@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-07 01:02:33 -0500, Jeff King wrote:
> On Thu, Nov 07, 2019 at 09:56:14AM +0700, Doan Tran Cong Danh wrote:
> 
> > +test_commit_autosquash_multi_encoding () {
> > +	flag=$1
> > +	old=$2
> > +	new=$3
> > +	msg=$4
> > +	test_expect_failure "commit --$flag into $old from $new" '
> > +		git checkout -b '$flag-$old-$new' C0 &&
> 
> These single quotes are funny; they close the test-snippet string, so
> these variables are outside of any quoting (and thus subject to
> whitespace splitting).

Yes, those quotes are funny, and I'm also aware that
they will be subjected to whitespace spliting.
But those quotes were intentional, they're there in order to have
better log with:

    ./t3900-i18n-commit.sh -v

With those funny quotes, we will see this (verbose) log:

    expecting success of 3900.38 'commit --fixup into ISO-2022-JP from UTF-8':
                git checkout -b fixup-ISO-2022-JP-UTF-8 C0 &&
                git config i18n.commitencoding ISO-2022-JP &&
                echo ISO-2022-JP >>F &&
                git commit -a -F "$TEST_DIRECTORY/t3900/ISO-2022-JP.txt" &&
                test_tick &&
                echo intermediate stuff >>G &&
                git add G &&
                git commit -a -m "intermediate commit" &&
                test_tick &&
                git config i18n.commitencoding UTF-8 &&
                echo UTF-8-fixup >>F &&
                git commit -a --fixup HEAD^ &&
                git rebase --autosquash -i HEAD^^^ &&
                git rev-list HEAD >actual &&
                test_line_count = 3 actual &&
                iconv -f ISO-2022-JP -t utf-8 "$TEST_DIRECTORY/t3900/ISO-2022-JP.txt" >expect &&
                git cat-file commit HEAD^ >raw &&
                (sed "1,/^$/d" raw | iconv -f UTF-8 -t utf-8) >actual &&
                test_cmp expect actual

I think it's easier to manual run the test step with this log.

-- 
Danh
