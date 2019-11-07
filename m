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
	by dcvr.yhbt.net (Postfix) with ESMTP id CDA111F454
	for <e@80x24.org>; Thu,  7 Nov 2019 10:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387638AbfKGKvN (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 05:51:13 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41792 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727528AbfKGKvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 05:51:13 -0500
Received: by mail-pl1-f194.google.com with SMTP id d29so1123807plj.8
        for <git@vger.kernel.org>; Thu, 07 Nov 2019 02:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FYJfgfFzwlkAWF0fdJpUixmMdokCDGQHYwTv8mlyzBc=;
        b=goY7O4vMeh4b2gJvyZxypnSEoRGSbDQ1XiMbKAwyB6ojFHLDL6lTB1N8WAYMZUnwI7
         5WjrymlvHMl/m7abZ2/D/CE3xJ9cD69zS3nExCfPoRlh2O4w3TQIOUbiY9wuO28Vp1eP
         AHN95mCdsoDwlS8N0zYdXqo/prS8wFXiijTE2QojjYl/y1T8dTFbZ720exJ/UYaJA/iv
         mjHFnzKLy/vl1FP6SZCBtrjj44gCm0lnDZvtpNTrDKqXlfNOukslLDns25u79sihO5A+
         s28zTEVrpS67lXvHKtTYlKziBx79ZBY/dCg4lsBodpd4PuNQ0fExb1bESf9nt3de4wBw
         8QMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FYJfgfFzwlkAWF0fdJpUixmMdokCDGQHYwTv8mlyzBc=;
        b=eXZCBF0QK7jVti4TlYj5Jo8FsKxEKqDDYx01YAqhFxDTdzgi38SlKJcBfMyDpwferh
         xPpuXmrXIOWkTZymBZL9uVdWMhVZUF0G0g0m0CrpB2yx0IdrEDDnW16auHFOlV+CAqKp
         9Qx2n3RBxItZdpjdVjLbEkmByyrv/e1bArWnXrQfFwh31eJzbHR4VTiMIgpcCd2HoIJV
         2IvbWnZPFb879WjY/aUdLMCAxUSoiJK7XBIalnjvsFLzUBwRNza6q0rrrTIUIIPzk75T
         Ntml5ZI6KjshPBvU5Vi7Re/SbwQDFhjyXg3rt00wdZOLG7Bxih7lDh7uO6/Fh+0YChlI
         UfrA==
X-Gm-Message-State: APjAAAXJdWfhWU2fHBCsJhTuyWgXI4iKnRmr094mQC5GFK059C5JNt4T
        wdDQIRw2ZuZhcOLhW8/s2VwApI1V
X-Google-Smtp-Source: APXvYqxrwupekBKejNI2STyocEwNLvubjmXHrbP2C/+tTcAZ1bKlshsyjz4FeOSUcWPs1BKpp6zyxA==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr3086760plb.328.1573123872311;
        Thu, 07 Nov 2019 02:51:12 -0800 (PST)
Received: from localhost ([2402:800:6375:16b7:502d:9b82:436:143a])
        by smtp.gmail.com with ESMTPSA id z25sm2148482pfa.88.2019.11.07.02.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2019 02:51:11 -0800 (PST)
Date:   Thu, 7 Nov 2019 17:51:09 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v4 3/8] t3900: demonstrate git-rebase problem with multi
 encoding
Message-ID: <20191107105109.GD8096@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <cover.1573094789.git.congdanhqx@gmail.com>
 <ca869cef57bcf620a7b5d0519d362dcd9a27eae6.1573094789.git.congdanhqx@gmail.com>
 <20191107060233.GB6431@sigill.intra.peff.net>
 <20191107064854.GB8096@danh.dev>
 <20191107080218.GA11245@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191107080218.GA11245@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-11-07 03:02:18 -0500, Jeff King wrote:
> >                 git config i18n.commitencoding ISO-2022-JP &&
> >                 echo ISO-2022-JP >>F &&
> >                 git commit -a -F "$TEST_DIRECTORY/t3900/ISO-2022-JP.txt" &&
> 
> ...you still can't just run this manually because of other lines like
> this one.

Except we can with a little effort:

    export TEST_DIRECTORY=..

> It's also weirdly unlike all of the other tests, which creates confusion
> for people reading the code. IMHO the tradeoff isn't worth it.

Hm, I think it's the test_commit_autosquash_flag is the one that is weird
in this file. Most of other sets of tests (line 89-176) use the same quote.

test_commit_autosquash_flag is the inconsistent one,
for the most part, it doesn't employ the funny quote,
but it uses the funny one in the `git cat-file` line.

-- 
Danh
