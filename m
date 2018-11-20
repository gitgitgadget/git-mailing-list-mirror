Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F211A1F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbeKTXvC (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:51:02 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54988 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeKTXvC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:51:02 -0500
Received: by mail-wm1-f68.google.com with SMTP id r63-v6so2112109wma.4
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XV31Q/5ap/4yVBb7uUABuCQRk95xJd9yJCUWPBTe6H8=;
        b=CwF6+a9SW5zYsCisfi71sPtO0/Yh5wsF5rmpLXEm5gNawEiijCHbtSScD4n5zeal21
         J06maRPUmplE/Ma4xkhM5nQpt/LH9c+I801AjoiSpnwV1ffF0Lrx/WtIjO2f0lSr2ovu
         yy9OSHb2XRL69/jTfzQyMr7rAz+cRa/yvxElFo0buVj/+SqdYnHuUbdc1R8QyinH30mw
         v1/ppns3dHJaP/sN30T7FbN9qFMMhtVhpvBhY8DDSdOpv9i2pF2Jkwy3qGuT+meWD80i
         zgPj6eUMtznAuwXjLs7+H2fg6ZYyuFIND/loCYKPogbPIuRf412VNUmg4rST5EZ53xPx
         VDhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XV31Q/5ap/4yVBb7uUABuCQRk95xJd9yJCUWPBTe6H8=;
        b=RlTSqPeFuZt10f6zhTiV6sfFX3ULBA/LHR4vrsbYQlBliPTbtZOvIGol5jzeqj/Uyl
         uW8Vuie5G9wlzug527SPt7W3673iyoiZoDPqjPfej3bJYvPrT+QdDwZdwqL4ZYUdxowK
         mz0C/O9XomPIM6wnKWQYFGSZ9ysn+iV8Jh4nXgYn36dPFitdyus8o9wOaHXkpquVnPs6
         ufDONvP7Ckfcn0z2S0isaJoahAFspokgG3oF6uf5WKHwD+Nu3hP6YnxE0XlJ0UBy+2db
         MvRYS8wP/+WePtiqtkDWRvlublQGrfWnjionwg0Ft26mG7LaRIKj+LqM29eX5CSvkJXr
         eyRw==
X-Gm-Message-State: AA+aEWYrYQeh6Qwf8+INipoktmVr8CKFxLxvF151H8ifxPqaKqdFwQtv
        BvuP0RYbjeaD0oQtRd0Ecbg=
X-Google-Smtp-Source: AFSGD/XcZ5qNUryoFvKk2FcuqxZOSHsKcK04vi26msc1fosjt2Rtbelc8oPEQwacjR51tXbmgm778A==
X-Received: by 2002:a1c:e88:: with SMTP id 130-v6mr2315859wmo.13.1542720114107;
        Tue, 20 Nov 2018 05:21:54 -0800 (PST)
Received: from szeder.dev (x4db92154.dyn.telefonica.de. [77.185.33.84])
        by smtp.gmail.com with ESMTPSA id t5sm25508332wmd.15.2018.11.20.05.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:21:53 -0800 (PST)
Date:   Tue, 20 Nov 2018 14:21:51 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        pclouds@gmail.com, Ben Peart <benpeart@microsoft.com>,
        jonathantanmy@google.com
Subject: Re: [PATCH 1/5] eoie: default to not writing EOIE section
Message-ID: <20181120132151.GA30222@szeder.dev>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com>
 <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com>
 <20181120061147.GB144753@google.com>
 <efa1d7fb-1da3-c093-1cb1-873a2e1c445c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <efa1d7fb-1da3-c093-1cb1-873a2e1c445c@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 20, 2018 at 08:06:16AM -0500, Ben Peart wrote:
> >diff --git a/read-cache.c b/read-cache.c
> >index 4ca81286c0..1e9c772603 100644
> >--- a/read-cache.c
> >+++ b/read-cache.c
> >@@ -2689,6 +2689,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
> >  		rollback_lock_file(lockfile);
> >  }
> >+static int record_eoie(void)
> >+{
> >+	int val;
> 
> I believe you are going to want to initialize val to 0 here as it is on the
> stack so is not guaranteed to be zero.

The git_config_get_bool() call below will initialize it anyway.

> >+
> >+	if (!git_config_get_bool("index.recordendofindexentries", &val))
> >+		return val;
> >+	return 0;
> >+}
