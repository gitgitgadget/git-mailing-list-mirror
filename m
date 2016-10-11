Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E0E32098A
	for <e@80x24.org>; Tue, 11 Oct 2016 17:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754036AbcJKRGz (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 13:06:55 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35799 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753890AbcJKRGy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 13:06:54 -0400
Received: by mail-pa0-f46.google.com with SMTP id qn10so17908144pac.2
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 10:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5yqRQe7zyP6Vk+MRXB5kLxkid1TMWU3zl7GBxbXtmXo=;
        b=dtx/eBJ3TExx5vjCiXEfZdw/jtbHEJWAU3IER0rZKZMmS+5Yb2Vhkdlb0iV6sqtipj
         BJ9GcsDhEyXXJJGfbWFBYk62wR/JwqYAqAo+b51L9s56CTBo/pIlhcGFVcm1gqMbzUzA
         eCR0cEG78BDyNs/p30gL5YVogzVJJL312cHwHSWIniV/tMJ1q4R2bL6KBWR87DK6CYiV
         kWK7LHKVCx4HvJcP/uXvgwxiLrVRZKhg0T6JgvIOhs5vKXjvmG3mU6o58+KiGv98FTrF
         zG9x/TJl1DQ1S6NI2ggwLfoXcPaE3BhAtz1rDH9OzIjOR6CzBX20P/KkA1VQ6scg5Chh
         egEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5yqRQe7zyP6Vk+MRXB5kLxkid1TMWU3zl7GBxbXtmXo=;
        b=jalISWivfPsflzkiUjoas53fvwoKnPTfnSk6NaTioLKqyeEGbWCN+Ux84Mg5+HtXRP
         Vhf0vySuh7Z7mrkwpoea9hd9Dp5zgYVkk2ntPyNPxfKL1fEeQwG+Nw6GdMN6CE5A5vdD
         uw/DQ4JdSkk9d1bGhw3ESJoKaIcatzLXlg20QKe4cu8be1OC0JFfboyiJmTAyjRNLDyB
         LUpyKf/uz1Bo5rTn0fbvPI9zOP558mlqwmZBvw+vOip5ZAwv6zhz/lxo7re736BEyAyW
         8NzX3FkJWdaXgevC4/cjCpzvx53UUKDwA0Zmut1YazxFImuYvWU24DGVI7Q3OqHp8kZ3
         Biyg==
X-Gm-Message-State: AA6/9Rk02407L+ARhJSU2FyUuauUAYfqR0JLUtpIKz+RQdq3UteGgF4LFyA8AQdk5JnptDnr
X-Received: by 10.66.78.193 with SMTP id d1mr8567713pax.4.1476205176956;
        Tue, 11 Oct 2016 09:59:36 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id b128sm5575138pfg.45.2016.10.11.09.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 09:59:36 -0700 (PDT)
Date:   Tue, 11 Oct 2016 09:59:36 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 11/28] attr: (re)introduce git_check_attr() and struct
 git_attr_check
Message-ID: <20161011165936.GA9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-12-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161011002115.23312-12-sbeller@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Stefan Beller wrote:
> From: Junio C Hamano <gitster@pobox.com>
> 
> A common pattern to check N attributes for many paths is to
> 
>  (1) prepare an array A of N git_attr_check_elem items;
>  (2) call git_attr() to intern the N attribute names and fill A;

Does the word 'intern' here mean internalize?  It took me a few reads to
stop picturing college students running around an office :)

-- 
Brandon Williams
