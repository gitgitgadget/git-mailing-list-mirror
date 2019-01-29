Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AB481F453
	for <e@80x24.org>; Tue, 29 Jan 2019 18:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728627AbfA2SKg (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 13:10:36 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44704 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726846AbfA2SKf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 13:10:35 -0500
Received: by mail-qt1-f196.google.com with SMTP id n32so23240672qte.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 10:10:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OaTmv4bJu8kPn45BsxfoXSBNQstwBZH+SO1YT6DQix8=;
        b=lALfCaFeFHhU+03XcHoaNfYTrQH+Kg1VALCOl5T9uUk0yY1JHzT90DNQZ9WRexb47t
         RyraFcYfrk5PiJqZIEcPywcGjhdNAMPyn9lQOOa/YUersBo1o5LNhoqovgJeNRYbTk1v
         wbaBvWSjIaMkmUA3x7l9S0rsEpC/1MkR8z4WaixhDRLDZNj8Je+bh8HUYyRLk2nZbRe4
         vWSEw8DjldLAer45XEEaRxUeBw0fSzXw/iPSMMD/2K6k6YHxS73KbqQTmYdn8KNMdIlL
         Ao8XSyqnfNvpJklIBwt4Gic75DCL0Ga9AAFZ74jU38pQZkjX9jHWDVdzZBwsU87U7biU
         ELCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OaTmv4bJu8kPn45BsxfoXSBNQstwBZH+SO1YT6DQix8=;
        b=s2XNwBBYe7Qn15jb9S90WKBC2ur5asBPx0oF+d4X42mfwROv7qG7+tJ29sB5LFX/4G
         Ez3B5qNxsL0k39TnOAIxHHqJzqz8zuOUojOzf6Zvlba6eQ4hr9nMdHEu1npSXWBo/9YK
         BLThQlpBRlbrqxbk8i9ooYJYdRSd8LWTg5HPfb7qX7V8/9IJcrQupP7T9wBWMqMu+6Y8
         9YQTurtxcA50eGZrSIwumzKZNjICc/m6PFRH33no2ApCuCqR3LUpZ10NSm8O/nZ8+1SC
         7tV/zpbClsolE/nicQG47TX8OdNKEFB63X51sknNs7U0sUIjtfAAJqJMXdii7n7xZx/6
         mr8A==
X-Gm-Message-State: AJcUukdILLc5SSzJS+9RpqUij2depKbNV9TTujIDF8kuhm1mok+VNITw
        aJh0GKJ8LpjJMbVNsVW3PAk=
X-Google-Smtp-Source: ALg8bN52nr0zAeGk/mH2fJ8rggGSSE38HMEIH0aQq4P5mPkWwhrO9qCzFVnKXg41iST5WQn7LqZsVQ==
X-Received: by 2002:ac8:2d9d:: with SMTP id p29mr25814531qta.238.1548785434346;
        Tue, 29 Jan 2019 10:10:34 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:788a:444c:e16b:27e? ([2001:4898:8010:2:61be:444c:e16b:27e])
        by smtp.gmail.com with ESMTPSA id q54sm90034495qtb.64.2019.01.29.10.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 10:10:33 -0800 (PST)
Subject: Re: [PATCH 1/1] Makefile: add prove and coverage-prove targets
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>
References: <pull.114.git.gitgitgadget@gmail.com>
 <294187c6968eff952e78bcea808c66fbedbf1f90.1548773766.git.gitgitgadget@gmail.com>
 <20190129155827.GC13764@szeder.dev> <20190129173409.GD13764@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <95d30af1-1940-b4db-99e8-2ccca5210bbd@gmail.com>
Date:   Tue, 29 Jan 2019 13:10:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190129173409.GD13764@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/29/2019 12:34 PM, SZEDER Gábor wrote:
> On Tue, Jan 29, 2019 at 04:58:27PM +0100, SZEDER Gábor wrote:
> And in the related email discussion [1]:
> 
>   But even though the docs claim it [-j<N>] should be possible,
>   I've been getting "random" test failures when compiled with coverage
>   support, that went away with -j1.  So the tests still run with -j1, as
>   with the first version of the series.
> 
> So it doesn't seem to be that bad after all, because it's not
> "completely breaks" but "random test failures".  Still far from ideal,
> but the original coverage patch is just about 3 weeks short of a
> decade old, so maybe things have improved since then, and it'd be
> worth a try to leave GIT_PROVE_OPTS as is and see what happens.

It would certainly be nice if the build time could be reduced through
parallel test runs. I've kicked off a build using GIT_PROVE_OPTS="-j12"
to see what happens.

Thanks!
-Stolee
