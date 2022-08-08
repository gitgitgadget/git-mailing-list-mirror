Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61CDDC25B07
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 11:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242602AbiHHLa4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 07:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233907AbiHHLam (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 07:30:42 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 913281113
        for <git@vger.kernel.org>; Mon,  8 Aug 2022 04:30:41 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id w10so8314381plq.0
        for <git@vger.kernel.org>; Mon, 08 Aug 2022 04:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:in-reply-to:content-transfer-encoding;
        bh=Sy9ZxTerQ8MEJ6GeJkIZOzO4Z7HGFw+3kNKcZcKfsO4=;
        b=Yy4M9jRenGie2EgcDoLss3g71uZpcDjachdvrSo6DR9HIP3VZ70RE/Wk8jgtpkAq4t
         eszK8aAcRZyxTuvCxGqhxRnuU+wKfYF9Sgyojg46C9qRAMziNWoZ60oOXKdOhFWRqrDq
         JDMsgckovHqobPACEpJZwZMOubGov4caSDo8YI6A5EBSPAnzhHmxQqnx2PmS506Lxi2M
         6wnKoIMIFg56z65EBEtzkYKtPy2HSfp+yib9C+HF2qdWx+bcSOx7Y5LxxB8LhMleqG0V
         ax+EXQu2IqhjLkcjzY8/asBuek5R/+lYCHZo6zXHD6JGUVd6LeiAR3CWG2x184uXsKr0
         HQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:in-reply-to
         :content-transfer-encoding;
        bh=Sy9ZxTerQ8MEJ6GeJkIZOzO4Z7HGFw+3kNKcZcKfsO4=;
        b=JDXBMz92pSt8ERFVw0kHpXRRPUtoZVWyIPTEa3xeyfkJQl3uN6C9ORiAZbKvYwDrdJ
         PNU1Xb9gD56KGfGaMKHozBkJhD55jsn+vnBYmmNV3admpVzPJSK09cIDf+av2sadaEkv
         L/FjJiKSkHw2ZqayhbA7j5vcB8e3bfhwWHJHpMjbg3xY1b+Nx6L0s2qtTZmcvgwGNNcV
         dj0EFAUoIAvHoRUaLmDiySOlMCGlU4sMwtu++lfCMIRPBWtk5+Vd307kimK3ILE1Qx24
         VLeuqml5K6gpJve0DF8dhaeBXGR7xEojaqLh/Q1fP/vke4EQM6OEUhKvtQr4YRfRd2xn
         2wlA==
X-Gm-Message-State: ACgBeo2vpryHypbbUi5xGN+ZPpJ+3Ok9aUcveW4IJ1bh4jn47cAuqyBY
        BL2FIhRR26F5rweQFoHrSc5Acdt9dnA=
X-Google-Smtp-Source: AA6agR4/s2RuRQVQdFIq8hnEPyq9ZBCzrDtFQxuPEYEZRuCimgXMfWpbo1POj0hFTTTASJS9B1NWnA==
X-Received: by 2002:a17:903:11c7:b0:170:a74e:3803 with SMTP id q7-20020a17090311c700b00170a74e3803mr4429764plh.156.1659958240850;
        Mon, 08 Aug 2022 04:30:40 -0700 (PDT)
Received: from [127.0.0.1] ([45.138.210.17])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b0016dc44459a8sm8707855plg.12.2022.08.08.04.30.37
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 04:30:40 -0700 (PDT)
Message-ID: <f71b813e-10c4-b6b5-5b09-85fa7b50a360@gmail.com>
Date:   Mon, 8 Aug 2022 19:30:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: [GSoC] Week 7 and week 8 status update
Content-Language: en-US
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
In-Reply-To: <CAJyCBOSrhxbCcDX5oWBuNEWOxQu2Rmk+T+paORLzoLF=iaBH1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Git community,

Here is Shaoxuan Yuan.

I'm writing to share my latest progress [1] from GSoC week 7 and week 8.

You can read it when you are free, and generously give me some
advice if possible!

---
Summary

In the past two weeks, besides keeping the work on `git-mv`, I was
also working on the sparse-index integration with `git-rm`. I shipped
one iteration of `git-mv` series and two iterations of `git-rm`
series. At the time of writing, `git-mv` is v2 and `git-rm` is also v2.

[1] https://ffyuanda.github.io/blog/GSoC-week-7-8/

-- 
Thanks,
Shaoxuan

