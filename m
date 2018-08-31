Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61A5D1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 17:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbeHaV2P (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 17:28:15 -0400
Received: from mail-qt0-f177.google.com ([209.85.216.177]:39597 "EHLO
        mail-qt0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727258AbeHaV2P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 17:28:15 -0400
Received: by mail-qt0-f177.google.com with SMTP id o15-v6so15333943qtk.6
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 10:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=ebE5bEMv1Dqk1DjmKt/9DmqdYX4JK/oDfT97iezHy+c=;
        b=Ve1rtdZH3iWkGTm43wcHp7un94HcAp2Myhl55h5msyB4hgmnwNCya2Wyz58wYvJsNd
         UlfLGZlNXPLKpmpNtXnAHtMMcX2OH26oomIxGBTn9PQrJersnuZhx+eg6XFTglkyCu8R
         hD7xZ4oBySsF0dZnOvnJZpD7KPaCpthXkyewo+MKQE6lOFv6tqVkooO/p1qXePpHRoFd
         ujqNEvWNv9FpWBk/0LI/iaHgmgX38ONc+rk0y9fUQCPq+XpnFbPoFZmnfZt9a6PLTe1A
         0wQtnn2lNjtuxKTbm+oAMhpn1I6uG+RnOmSvob4bUtsEV3UdXu7mCF4qwRG5n49TVUzN
         9e7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=ebE5bEMv1Dqk1DjmKt/9DmqdYX4JK/oDfT97iezHy+c=;
        b=X05YfWQa76r1TCqpKZax8Bj/u6sPQtkKf81JyB6MvKbubTW95W07OjR/lSEfpzn6Ni
         rBOB6kNWhHKfEDvK94eWOLuW58MMlNPIvdHNg4RQyb9Vs71/aa5fou2p+GovgSMgcW0+
         mj18WbDstlKH1GHB2TbizzvAbuyX1zDS1VIbLPzCA3RmohK8UYEYfj+ScapELc+tfCB7
         3Ordpwf76bTYLkepszIiGoprgmAeX5fHw1nr0kc4a2djOqNZ1IyXjuWFTvKie4tbwVEo
         GmTPH4VWuHMdvzJFy+0q8dpS+as1nlHmN55FeIhqKih0zUhRUzvlBWoqRAMnO6AOA4Vy
         tHpg==
X-Gm-Message-State: APzg51DOpnIRHrvxjwn355MXkpkuVmQwk1ekDbpqYXDVc9vsShgKUjix
        Pm/XLSwY/ZJWTUT2GVP/1Cc=
X-Google-Smtp-Source: ANB0VdbRt72l1/pzaf5/g5zgVAORLxyE3+D0bhw1Fq6jY0XMV+mnCMfiQjlu1sXf72ox1L0ncLq+dg==
X-Received: by 2002:aed:244c:: with SMTP id s12-v6mr17464625qtc.160.1535735985965;
        Fri, 31 Aug 2018 10:19:45 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id y47-v6sm7009021qtk.27.2018.08.31.10.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:19:45 -0700 (PDT)
Subject: Re: [PATCH 1/8] trace2: create new combined trace facility
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     jeffhost@microsoft.com, Junio C Hamano <gitster@pobox.com>
References: <pull.29.git.gitgitgadget@gmail.com>
 <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e2e07731-6a13-d511-f568-5f81311f4904@gmail.com>
Date:   Fri, 31 Aug 2018 13:19:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <82885700379efe6d6a83629cac4d943b99b393bf.1535734192.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/31/2018 12:49 PM, Jeff Hostetler via GitGitGadget wrote:
> +	if (tr2key_trace_want(&tr2key_event)) {
> +		struct tr2tls_thread_ctx *ctx = tr2tls_get_self();
> +		if (ctx->nr_open_regions <= tr2env_event_depth_wanted) {

This should also compare to TR2_MAX_REGION_NESTING to avoid memory 
bounds issues. It may even be worth sending a message that the depth 
went beyond the limits.

Thanks,

-Stolee

