Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D754A20756
	for <e@80x24.org>; Sat, 21 Jan 2017 00:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbdAUAZk (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 19:25:40 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:37285 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbdAUAZj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 19:25:39 -0500
Received: by mail-wm0-f43.google.com with SMTP id c206so68826837wme.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 16:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=rBxjnLpEKaaedkj+JDFEz5Ebe/rtxTRR0KVz1GX9fhI=;
        b=eBHAR0Oib8a7IiPNEuvaWd3JOPXJ1kYHpgo2qVxv0EqDIcmDh9kFewRQJ+vWMrwfB6
         lNSWr/uBAZD26bzhCluFT7nN9RGy54UzcHg2cMkHNZgTGStcocB+B530kQy8dRVPA0FS
         czJ25Lthae3lE5F/wBi0Xld3HHQUxnH3qX5ba61Sn2SVyueCu/2TDxPlCma7xRvvgRtc
         OHB8x7XzNJfNzWCwYjgpaaFSCGbNf1OjCfd9iI+cNa/ArwNt0J7GZW/aVbYp+AN3TCpq
         lNULy4dsbBMtDnq4OK9IESNj2ZW5Sd/oLdWmU3125q59w0fptXgjDcqPYIgTeWwiktrM
         4eFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=rBxjnLpEKaaedkj+JDFEz5Ebe/rtxTRR0KVz1GX9fhI=;
        b=SZc73YwR8ua/+FV3x/SWgzlcgGVutvOvWrBFiUnv8SEPDg+xIJSKDXM/OSNZMl4Ndy
         KOmU/cUSV5uFLeFmN87PGG+AlRq8FoTBARPAKFgRwQ7FIHLuAaSp/+wBBzS0AtCm8dsF
         OXUmdtUjjjRQDLsWDZPMTfepU8VcbI/oySTAI6rybD8hblaxS0JU8JUmS4RV6jK9dT2b
         XbcTAVpcZhnbrFQi6lPeFK2tcGfiEPMYVW9wohRwgwIgldWTkadq9Pyfwaa3a8xak0qb
         z7H6YDYfO1vgvhepPQVKcRzLGEZ08yxf9hZ9PcEUevveeWdY4pJXkZt2T7aRqr4s+gNz
         AYnA==
X-Gm-Message-State: AIkVDXId39nCEiDZuY1XnRtJL/p4MTe3pSt0+hHOr2Lh5wZV4U6YL+jCsHVNdl+W4ZAS/g==
X-Received: by 10.223.143.45 with SMTP id p42mr13534216wrb.120.1484958338081;
        Fri, 20 Jan 2017 16:25:38 -0800 (PST)
Received: from home.thecybershadow.net ([89.28.117.31])
        by smtp.gmail.com with ESMTPSA id z67sm1991612wrb.49.2017.01.20.16.25.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Jan 2017 16:25:37 -0800 (PST)
Subject: Re: [PATCH] show-ref: Allow --head to work with --verify
To:     Junio C Hamano <gitster@pobox.com>
References: <20170120155015.4360-1-git@thecybershadow.net>
 <xmqqa8aly2o4.fsf@gitster.mtv.corp.google.com>
 <3b1d2717-dd7f-2add-b935-3ace6063b258@gmail.com>
 <xmqqshoduxnj.fsf@gitster.mtv.corp.google.com>
 <xmqqo9z1ux7r.fsf@gitster.mtv.corp.google.com>
Cc:     git@vger.kernel.org
From:   Vladimir Panteleev <thecybershadow@gmail.com>
Message-ID: <daef1407-6f08-147d-e23b-bb69bb8fd1ed@gmail.com>
Date:   Sat, 21 Jan 2017 00:25:36 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.6.0
MIME-Version: 1.0
In-Reply-To: <xmqqo9z1ux7r.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-01-20 23:29, Junio C Hamano wrote:
> By the way, I have no strong preference between "read-ref, check
> quiet and show-one" and "show-ref", so if you make --verify to
> consistently call "show_ref()" for both refs/heads/master and HEAD,
> that is also perfectly fine.

This sounds like a good idea, as it will also allow -d and some other 
options to work with --verify (whatever use case there might be for 
that). Will resubmit with that.

> I just do not want to see the same feature/codepath to call two
> different implementations that happens to do the same thing today.

Understood and agreed.

-- 
Best regards,
  Vladimir
