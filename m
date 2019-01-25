Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E8991F453
	for <e@80x24.org>; Fri, 25 Jan 2019 13:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbfAYNy3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 08:54:29 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39088 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726108AbfAYNy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 08:54:29 -0500
Received: by mail-qt1-f193.google.com with SMTP id u47so10706244qtj.6
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 05:54:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tUp3PK3Jow0pnW7u5HGSsmyAOLbXP3TP124PmGVc0uY=;
        b=uA6ZGInvl+ykAF+lFoNymfnoA9TimKAzYDosTPn1mhldn5hLfYrVnhY6Nz5OGPoI61
         4SGmFUkkn6EhjmpR2mrT1aPNwnZmmJrNTE7yMZxuqPy+hkgCnCwBWHe2Whq67fIqYRcr
         ZdSzu+NE+qoK8OteX0KBPn0/EYotK59DMFNMdQHyUa517ZR/yybD/tAfz65hnmSOcZ57
         0z41Qc5VkB/TI019RFMfm8o11C2ofc+2VdiKOGNXrEQIim5tHRQ1WxPzm4cUHQiVpfMD
         lbm4ElgYa7/Vb6UITJt2OsbOozLcybNJMeBv9S9n4wj5xqIKwTowOlfRImOmcaMW8RQZ
         yrrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tUp3PK3Jow0pnW7u5HGSsmyAOLbXP3TP124PmGVc0uY=;
        b=clwNJl9stbRzFuW6HfMspWxPq2bwQqa+deMNgnjmxUm2Uxxu1v6aDFqfInhO4QLqqx
         rYJbMGin+LT0qn7sEKDSimqNqJ5k1+TmBvLYDAnijOhtQ91ShI0WB9EJYXfTKIFuWrmV
         XhEVZ9bLV+QvO6K8Ec21NWB+iX35va+yyuRYGJSfKJpQ2H34skcYkkEsHFdKvNtyDtQq
         CkjOUuBekz+BAbVJpReiICtleN28jaiaaVIky7vATVpaVOznin7epDCgPuZMEjJfz3yM
         WXQaemNcsYlfj3N1LdDQWit1QFvP65PSp4ZMjl4GNg8nK1I9S2AMvt/AKecsa4+66UZD
         nl+w==
X-Gm-Message-State: AJcUukfxFXjWHstoTBcbCKfZqQEQQtPyICys+lq8bCUk/hp4wmkQRvsZ
        MEoW8MSDQgoaOG8hNviyJxk=
X-Google-Smtp-Source: ALg8bN4nhh7hKyNkTAEz57CPwUYC9JwOvDgEFb7NEUygBuikX8egGl0j8UGwjgglY4Fvdmo5WLUMNw==
X-Received: by 2002:aed:2539:: with SMTP id v54mr10939927qtc.211.1548424468307;
        Fri, 25 Jan 2019 05:54:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:a010:321f:4bbb:82c4? ([2001:4898:8010:2:8944:321f:4bbb:82c4])
        by smtp.gmail.com with ESMTPSA id j138sm41832662qke.65.2019.01.25.05.54.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 05:54:27 -0800 (PST)
Subject: Re: [PATCH 0/6] Create commit-graph file format v2
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net, avarab@gmail.com
References: <pull.112.git.gitgitgadget@gmail.com>
 <xmqqzhrpfwvk.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <82be29f0-9b68-4bd6-4d5f-c6cfa1a0ccc6@gmail.com>
Date:   Fri, 25 Jan 2019 08:54:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <xmqqzhrpfwvk.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 6:39 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> This series is based on ab/commit-graph-write-progress and bc/sha-256.
> 
> Thanks.
> 
> It seems that the base (i.e. merge between these two topics) you
> used may have used a version of either topic (most likely the
> latter) slightly older than what I have, as patches 1 and 2 seem to
> lack the local variable "hashsz" in the context, near the beginning
> of commit_graph_write().  I wiggled the patches in, but it has too
> heavy conflict merging to 'pu', so it may have to wait until the
> other topics stabilize a bit further.

Sorry that the merge was painful. I would have waited longer for
things to stabilize, but I'm expecting to go on paternity leave
soon. Didn't want to get the idea out there before I disappear
for a while.

When things stabilize, I may have time to do a rebase and work
out the details myself. Otherwise, everyone has my blessing to
take work I've started and move it forward themselves.

Thanks,
-Stolee
