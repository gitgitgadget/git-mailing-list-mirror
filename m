Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C7C1F87F
	for <e@80x24.org>; Mon, 19 Nov 2018 18:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730019AbeKTFQE (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 00:16:04 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36681 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729682AbeKTFQD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 00:16:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id y6-v6so7430955plt.3
        for <git@vger.kernel.org>; Mon, 19 Nov 2018 10:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1VGU1/bEvr8m6R/IcVZPGz2ILQc6VsQLsodXE8DCvF4=;
        b=uH5GMzQCfN0/kMZCzu35laa4414D9F07xzSdZvDqrohRU0TyKLKPZehyu912f2egve
         hFjaa7tHGGKf/Hus0WcRFWPlYAKRdD7IFv7qVeEYX5Xqv9G0BBAJiQ9QeVeBe8z9vmc+
         r/V107xkj5w2HgmYkeERFn0ZHHDOQLohcVu02+m1M6N+ZfNG2Al9QuwbpUPydHFtMuZy
         2AyIxoqfwu/DWvbA/9kGUbv65Asrk1LFS0SBtGuthX+DkfuEqRXlGbxF6Hyy/s09/Hrc
         njyhQM5XDLq4z1ZKHU0iPlALnT8rPSkVL1n7UP17tVfgwICG/y7aDrQ89ofTl8nhDamP
         SdWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1VGU1/bEvr8m6R/IcVZPGz2ILQc6VsQLsodXE8DCvF4=;
        b=aLdc51iU5hs6/OmtVTXt7rA9TsFQkkowaJlRpS9woulE+Th6UC76ucsvNGTngJPfb6
         fmNI7ODtwkBPjTvs2VdpAQRZkx/0rQ4WyR2+bD/vagw27stciVXWp/TEq2PqL7fzM6xy
         e5I/8tvKPHrP1lPGPaxq52xD0aC+Pva3+R5Plit8SrfFE7uhyqEieYQNAPzI0Ol5WybB
         tFEfPsa3+iXuWagtGfFTWm5yLGdVOyRnPRzUDNXXaUO22MmN4d6dtMPHYJQIOUtm9fRJ
         ut4Lv3lFIcVGOW5YVf7OFFoiHP6+cyXBF66FP/fYREP5FaYY04bBoMDffUrNKv6VUxut
         75fQ==
X-Gm-Message-State: AGRZ1gLgiypcr2Mua3NZvPUA49xcBovBpX1hQUvrIl868aAtl2lzYMHt
        SS1DnancNWVUZJnGXnzJcPHDLjsr
X-Google-Smtp-Source: AJdET5eUA2RzZzAIvdAGv+1xF7QZHTCpN8tEZxt2e6TZDwE7aQfryKn/42lcS7ty1PcxPa+eQZFwNA==
X-Received: by 2002:a17:902:7088:: with SMTP id z8-v6mr22557589plk.329.1542653472011;
        Mon, 19 Nov 2018 10:51:12 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id m10-v6sm90261939pfg.180.2018.11.19.10.51.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 19 Nov 2018 10:51:11 -0800 (PST)
Date:   Mon, 19 Nov 2018 10:51:09 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] tests: add a special setup where rebase.useBuiltin is
 off (Re: Git Test Coverage Report (v2.20.0-rc0))
Message-ID: <20181119185109.GA47930@google.com>
References: <9e293b1b-1845-1772-409b-031c0bf4d17b@gmail.com>
 <871s7g29zy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <871s7g29zy.fsf@evledraar.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> On Mon, Nov 19 2018, Derrick Stolee wrote:

>> [...]
>> builtin/rebase.c
>> 62c23938fa 55) return env;
>> [...]
>> Ævar Arnfjörð Bjarmason 62c23938f: tests: add a special setup
>> where rebase.useBuiltin is off
>
> This one would be covered with
> GIT_TEST_REBASE_USE_BUILTIN=false. Obviously trivial, but I wonder if
> the rest of the coverage would look different when passed through the various GIT_TEST_* options.

I wonder if we can do better for this kind of thing.

When I do routine development, I am not running tests with any
non-default flags.  So why should tests run with non-default flags
count toward coverage?  Is there a way to make the default test
settings dip their feet into some non-default configurations, without
running the full battery of tests and slowing tests down accordingly?
E.g. is there some kind of smoke test that rebase with
useBuiltin=false works at all that could run, even if I am not running
the full battery of rebase tests?

That's a bit of a non sequitor for this example, which is actual code
to handle GIT_TEST_REBASE_USE_BUILTIN, though.  For it, I wonder why
we need rebase.c to understand the envvar --- couldn't test-lib.sh
take care of setting rebase.useBuiltin to false when it's set?

Thanks,
Jonathan
