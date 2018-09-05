Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBC151F404
	for <e@80x24.org>; Wed,  5 Sep 2018 19:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727741AbeIEXdi (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 19:33:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51744 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727618AbeIEXdi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 19:33:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so9052452wma.1
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 12:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:newsgroups:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MqSDW9dodEyGcJX2FNRJEDUhq9J+saLs2BpsN06Wuog=;
        b=YFEGoMtnSopK4m7Trh29SvSRtl58YZ5Df26iPhm09wkAqDDzUTlNJpN6nQKF0OB9oD
         LKXG5H/+KCE/1QfI8EFqb5gSA4FO/N51/heoU7C9I5pS/p0A6ifQ6rY/3IG4dXkF+7RF
         iARA6nTRSSxuomV2tLcjfs8BAG17/ujb7w42ukjNj3gJ8zKf69nGntFw3D7g/0zJkVo5
         BH0iT47OcnESbBr9B0n+S2eI9aZ9B3NjfdmFqaFXUFjTBdX0IeI+4zghxQ9+wpMW5c9T
         7+XRzeUWj6c2vUJAwRKrwBlRfW/29BrT4pSUafHa6tSMJRB1hA+XWTdLD7w55xCqURQM
         8OrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:newsgroups:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=MqSDW9dodEyGcJX2FNRJEDUhq9J+saLs2BpsN06Wuog=;
        b=srSpqaMnapk8iX5drRZkGBbkqTB++tKe8EdeCLKFAAS1jnvSGIZPZL1e6fbD6ARLd9
         fGkm084tj5bsV8rk5Gld8Y1TZch+rUg3CyDuC3AYX1NZbP4xkF1omueJjE7lFEJMyBRL
         EuK1WvEjUvGIef+ikrz7P2/f5fQUrEoozuGo1lLLPtxdO3GmvThAF1yYIbxTCh7y2ZdD
         iDXlgoQhiGkpdfsUSBUO/JlGR93q4zhLrebe6xZMh1M7DYiA1LmLUUgMd6ruFd0x6VE8
         gOFfqiNcs3Xw7AvRn/wYWOyFmyNcE4jEZusmrQj6QTNBFDcLKRY1kRLPFUNjOnF8junF
         8z0Q==
X-Gm-Message-State: APzg51CSZNdgucLPm15JHwyZqfRbv0z3bLBT+I387cNyIq01zNRmbOze
        AbBZmsd9VXeaq/EVYmHYRYE=
X-Google-Smtp-Source: ANB0Vda5dXX6+51DbYd8E1Km2o+bAZ1lnVShGYAT3JmKmJ+pCktKhlT5LORqeMWr9Geks9QouIl+Tw==
X-Received: by 2002:a1c:1252:: with SMTP id 79-v6mr1094589wms.70.1536174127378;
        Wed, 05 Sep 2018 12:02:07 -0700 (PDT)
Received: from ?IPv6:2a02:8109:8a00:3914:ddab:fe80:1813:f455? ([2a02:8109:8a00:3914:ddab:fe80:1813:f455])
        by smtp.gmail.com with ESMTPSA id w4-v6sm4312116wro.24.2018.09.05.12.02.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 12:02:06 -0700 (PDT)
Subject: Re: [PATCH 0/9] Offer to run CI/PR builds in Visual Studio Team
 Services
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Newsgroups: gmane.comp.version-control.git
References: <pull.31.git.gitgitgadget@gmail.com>
From:   Sebastian Schuberth <sschuberth@gmail.com>
Message-ID: <25914342-ff35-90b2-860e-6aff5c109f14@gmail.com>
Date:   Wed, 5 Sep 2018 21:01:36 +0200
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
MIME-Version: 1.0
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2018 11:10 PM, Johannes Schindelin via GitGitGadget wrote:

> The one sad part about this is the Windows support. Travis lacks it, and we
> work around that by using Visual Studio Team Services (VSTS) indirectly: one
> phase in Travis would trigger a build, wait for its log, and then paste that
> log.

I'm sorry if this has been discussed before, but as this recap doesn't 
mention it: Has AppVeyor been considered as an option? It seems to be 
the defacto standard for Windows CI for projects on GitHub.

-- 
Sebastian Schuberth
