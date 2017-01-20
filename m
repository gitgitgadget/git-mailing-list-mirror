Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D5920756
	for <e@80x24.org>; Fri, 20 Jan 2017 22:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752643AbdATWzQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 17:55:16 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33909 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752373AbdATWzP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 17:55:15 -0500
Received: by mail-wm0-f65.google.com with SMTP id c85so10073103wmi.1
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 14:55:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=0uifJP5+DK+BTBUdf5gfnkZ4QmZerlChfEEhCD78LM4=;
        b=OyQhd1mTGnyHbfuHkoXF/O0lV3fMFSHYOqUlTLTE/qwadhG+xRvTVYSo61YZKfgDsX
         e+vaWFg85CdKHiIN6v4i5VUHTOUcfo6sCptC00PWzO282M+TYzUiHLCvsrQfwRXerMch
         HYC5apbBZGqwaZ8YRLXA5xnCN+ckqqM4JRu5BFDsNDl86pryWF1SnulsyTtmPJAR9Rkm
         Ew6qV2en0C0twV08UFwiARX3ZrdbWVjuFX9/23N2dr5zrMdLdDMxtKD1TVOU98QIYT56
         ITdA2ezJiUSIjLShoUwRi+o+i8hJBH7SiV2QDma3/qmvpd9zGS3I8edILmQL4nYnqN1Z
         4VwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=0uifJP5+DK+BTBUdf5gfnkZ4QmZerlChfEEhCD78LM4=;
        b=ba9tSfSel+hD6W/zk3OslXpaJcNVCBa+DHHhgt8X4TKXvfc1fvwx28U1zsncAOuKMU
         pLakpen70w5ks/GMBJ8ABUovwv62nza76Fflofghj2+hq65Y856o0J2LSPOIMKcHf+7d
         FVFuvDXgFapT36br5X29XT3bydBxBQGl5ENfrskHRFmDG3gEyyaF+udDQ2lVFB4EoqgE
         iBYA/ffUDXGnZ2EcixqDXeKWR5NqIfbtQVMKEgr4Lu7u688gIJdzTqSqqErJpybZHp+f
         di7e4nnQKWp/ZEJZEjTg1Lw10kI1EmtjnLKhU9t6gC9SttfqzQEbb/UuI8kK53Dkk/Tu
         JjdQ==
X-Gm-Message-State: AIkVDXKmMF9AQoUEnzp9/o/QzHnpXuIUMokniqP2NqzwNJ5CDN1FkP4/WK6Youpv58/e8w==
X-Received: by 10.223.167.71 with SMTP id e7mr8983878wrd.154.1484952913676;
        Fri, 20 Jan 2017 14:55:13 -0800 (PST)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id u47sm1751191wrb.15.2017.01.20.14.55.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 14:55:13 -0800 (PST)
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
To:     Junio C Hamano <gitster@pobox.com>,
        Vladimir Panteleev <git@thecybershadow.net>
References: <20170120155015.4360-1-git@thecybershadow.net>
 <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Message-ID: <3b1d2717-dd7f-2add-b935-3ace6063b258@gmail.com>
Date:   Fri, 20 Jan 2017 22:55:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-20 19:03, Junio C Hamano wrote:
> and viewed in the wider context, I notice that quiet is not honored
> in the added code.  I think that is easily fixable by replacing this
> hunk with something like:

--quiet will still work correctly with the current patch, because 
show_ref already checks quiet. Granted, the original --verify code used 
show_one and not show_ref; however, I don't see a meaningful difference 
between calling show_ref and show_one for HEAD, other than a bit of 
overhead, so adding a new function may not be worthwhile. I will still 
add tests for this; however, in light of this, would you still like me 
to perform the change you requested?

-- 
Best regards,
  Vladimir
