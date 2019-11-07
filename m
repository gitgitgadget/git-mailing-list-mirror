Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16BD01F454
	for <e@80x24.org>; Thu,  7 Nov 2019 01:32:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbfKGBcu (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 20:32:50 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42719 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732757AbfKGBct (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 20:32:49 -0500
Received: by mail-pg1-f195.google.com with SMTP id q17so618745pgt.9
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 17:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Gxcn/7vs/okuupMY6WHCEiaCTOYDkU82bpuuULL0SAU=;
        b=dm6B5SJFtmuFX1d9nj2EXLUWPLq4K76hCsEQg65EhniVKZoeYffd/VZqyMGS11OfPk
         BIZd6VnfOMFHnaKt4mTpN/6oVkFCzvrTd8VeKnqu2W80cWSo5HKZsH8r/ovp00Kid74Z
         NudJrPVqu4Vw6D7JbszaodXiYBUm7804M5sQRheTjSLF1XYcTTRO+fndo7KmgAVSyv7t
         5CZdA6GlT40TsAAhaK7/ELHaPqNuckgOg6DovUIiLMOVvyZ4nN4RpsrCwPAp/l2+VeRt
         M9JFoqIIWx7nKf/u6O2bp/p2ybiw9PQ6ACiV+MnIQ1IIuGI6mXlrDa9yyo1P0uc75z36
         Mv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Gxcn/7vs/okuupMY6WHCEiaCTOYDkU82bpuuULL0SAU=;
        b=N0c69uPmAeiOCfC9Ym1HB/MekqBoSB8kWSD2WzWzkIqNxVHWY22o2rZum5qG6jodUa
         5II0nHJgL/64zsUXGMbDHz+NjsdRt3oQOervEId1Y8v9+kcaX6mbplU392SaVfSni/to
         UJV1im6Xixj9iLeJVb3M+9LBffQDMQfstnM97dQSYh4rxWdlbaTkhHxlrUVsp2otJNti
         j9j2QzrRcIq7+q9nqCQUFivXK1XUacoip0PkGxVMvP4uuoCpsSuYvKGQvnAaJoufnAvm
         7eawG96aWC4Dsttb7I39nGxFj+0I67aG4KHQn9nuVCwhSW9w/ko7DEGQWJi9jJfI1LDf
         rTag==
X-Gm-Message-State: APjAAAXdoB4DatrTfcAqU9ro89i75IDfz/YGtABDfVJFNLMURk7Ijak/
        o6Hry6wCJdvWVtSNnGhfPH9VulmDK8c=
X-Google-Smtp-Source: APXvYqx8QOzUZdoTCHpor4XzQQQozr06EbTgjoeSNrT0FwdqOKv9HbWpZzRakwLMxGGqLrosNSCigw==
X-Received: by 2002:a17:90a:f013:: with SMTP id bt19mr1376409pjb.16.1573090368861;
        Wed, 06 Nov 2019 17:32:48 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id m4sm201510pjs.8.2019.11.06.17.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2019 17:32:48 -0800 (PST)
Date:   Wed, 6 Nov 2019 17:32:43 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 17/20] trace: move doc to trace.h
Message-ID: <20191107013243.GH229589@google.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
 <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
 <9b02b44cc868d8bbdcfd99d26256c2876fc0b03c.1573034387.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b02b44cc868d8bbdcfd99d26256c2876fc0b03c.1573034387.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 06, 2019 at 09:59:44AM +0000, Heba Waly via GitGitGadget wrote:
> From: Heba Waly <heba.waly@gmail.com>
> 
> Move the documentation from Documentation/technical/api-trace.txt
> to trace.h as it's easier for the developers to find the usage
> information beside the code instead of looking for it in another doc file.
> 
> Documentation/technical/api-trace.txt is removed because the
> information it has is now redundant and it'll be hard to keep it up to
> date and synchronized with the documentation in the header file.
> 
> Signed-off-by: Heba Waly <heba.waly@gmail.com>
Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
