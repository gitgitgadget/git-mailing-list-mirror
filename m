Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB46B1F462
	for <e@80x24.org>; Tue, 30 Jul 2019 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728837AbfG3VkF (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jul 2019 17:40:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40867 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728834AbfG3VkF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jul 2019 17:40:05 -0400
Received: by mail-wm1-f65.google.com with SMTP id v19so57959861wmj.5
        for <git@vger.kernel.org>; Tue, 30 Jul 2019 14:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ivhehsP3BBaaP5YII07JZrMCYScVY59r3BRTwL3AY5E=;
        b=GtLSgrjThsFECHapSn83XQjpCvkZl3k1LG9adAT1E7NoFdcJQI6pz+a2LHw8IUEHnf
         T7mzJNONDDNaGJYVNrtM3dd91JHIKanK87JxPY4onT3e9jksepQ+pvRTNtzWp1sK92yK
         2h7GUjYQycz6oruumws33eHc9kVWDQGvogZtQ4aOT0xLGGD9zYWLUs0tAyXc5t3a9OeQ
         +VEZbiJAJkHH/YuJfqYAUNZnFQQdMW4E/843wvHsyuN8R3doRJFdrTRJbNgcK7YiFyxD
         DytXBjkXg9TdlhnQKnVCLcL4dfwCYFxTF7fBW+2Hi1nN3/LbLDXcgbWxB/XdY6Es8qGG
         90jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ivhehsP3BBaaP5YII07JZrMCYScVY59r3BRTwL3AY5E=;
        b=OC63VyneW9CCBmbKnsGIn/stFwWMyH46VJvF0bZZ1/ZRG0WXsIHp4Rwvk5GAsic/FM
         0QRUJfIDWeRdhYJWKv196xL0e+/Q2mCdI5ugSwSH6cM+zJQFHW/VJIyIWuWpwf4ZsELK
         f6SM7Mk7jlLLNVH1d+LeA6rgddUGxtBbivjFmLJnfjMgNROj1VE6HpVMWlfe1qWVWVQq
         d9zT3JwKLUD2nKPjpPiPMTuNoO98VszAghdP1/piAoO/ibXkyND3im6PWEcc8a/5+pS/
         kTzWC3Qbc7xJ9zj+NQ6gbr9HT6gwgpkYCTiDLaioYMsvvCsRNDJ3L+JmxbCw18Vn2Q/S
         iQPQ==
X-Gm-Message-State: APjAAAWNCGnjwFhobX+CBuNNKt1wTITM7Szq9J7nWjsfqB2w6DphhRCa
        V4l0NGBeN0fyMq8OGSapWtI=
X-Google-Smtp-Source: APXvYqygjg3hSong8Q9GRVgIBoJvrbPVU3vPCHRN3Ggq4c2mBeIL4Bo9kd1GrVzw/WZ0Uucx2fZg9Q==
X-Received: by 2002:a1c:be05:: with SMTP id o5mr108189643wmf.52.1564522803348;
        Tue, 30 Jul 2019 14:40:03 -0700 (PDT)
Received: from szeder.dev (x4dbe512f.dyn.telefonica.de. [77.190.81.47])
        by smtp.gmail.com with ESMTPSA id v124sm69518154wmf.23.2019.07.30.14.40.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Jul 2019 14:40:02 -0700 (PDT)
Date:   Tue, 30 Jul 2019 23:40:00 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] t5510-fetch: fix negated 'test_i18ngrep' invocation
Message-ID: <20190730214000.GT20404@szeder.dev>
References: <a4fe71618410bdb188b6850a61ec65e7b4da5897.1560889525.git.gitgitgadget@gmail.com>
 <20190730212915.3509-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190730212915.3509-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 30, 2019 at 11:29:15PM +0200, SZEDER Gábor wrote:
> The test '--no-show-forced-updates' in 't5510-fetch.sh' added in
> cdbd70c437 (fetch: add --[no-]show-forced-updates argument,
> 2019-06-18) runs '! test_i18ngrep ...'.  This is wrong, because when
> running the test with GIT_TEST_GETTEXT_POISON=true, then
> 'test_i18ngrep' is basically a noop and always returns with success,
> the leading ! turns that into a failure, which then fails the test.
> 
> Use 'test_i18ngrep ! ...' instead.
> 
> This went unnoticed by our GETTEXT_POISON CI builds, because those
> builds don't run this test case: in those builds we don't install
> Apache, and this test comes after 't5510' sources 'lib-httpd.sh',
> which, consequently, skips all the remaining tests, including this
> one.

Hrm...  It looks like there is nothing httpd-specific in this test
case, at all, so we could run it even if a webserver is not available.
Moving this test case earlier in the script seems to confirm it, as it
still succeeds.

However, I'm not really familiar with this
'--[no-]show-forced-updates' option, and this is not the time to get
up to speed, so I would let Derrick to decide and follow up...

