Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717021F406
	for <e@80x24.org>; Wed,  3 Jan 2018 20:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751134AbeACUkD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Jan 2018 15:40:03 -0500
Received: from mail-yw0-f169.google.com ([209.85.161.169]:44663 "EHLO
        mail-yw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750831AbeACUkC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Jan 2018 15:40:02 -0500
Received: by mail-yw0-f169.google.com with SMTP id m129so1005990ywb.11
        for <git@vger.kernel.org>; Wed, 03 Jan 2018 12:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=O6tZiRRh+ydBbNpl9KKt1OM6oT91vUNW9gmJTjtrl+8=;
        b=bDd2TSRZZKHSGQgx53JLR3hBMMxoH1JH8BDN76fkHjA4QxFZ95ogUdW2YpbnELNtAS
         V7/zGIJjVJK2Fo+Q10BxKbErCyyoO/+QTWD8HGuJWmDi1R6aquR5fOEi3JicQRmiq6/C
         yFH9nhQgON957/Zp10JKyYnqaIsffQH97Ez/u7G+IAX7UJ6k3eYuQJNQb1YHPATB/Jad
         CPiPqiHgJ54SGoPEz27CCsaVyU/Z88JVaOit61wAB9vadFmWO9o6qk7ipxhl2a2kfJqx
         a/+h4mCPx4KQzrmT0+++NuT/Zcl40R2fk19VbhntenXuWqSRDowfeoHP4l291i4emE+o
         MEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O6tZiRRh+ydBbNpl9KKt1OM6oT91vUNW9gmJTjtrl+8=;
        b=kNu7QxWKxuq/mEHqhECp9SOgwKKVWapOJHxvkErYivmJLTc/KN3nQjElWKZYiWt82U
         +c1X/uHMN4cRSWYCYbIb4Z073w0jKN7W6MdmFCR2ZXkJG0v6RimJ8qQi9/k8NHYcdE0L
         PoL5ymxvcMz7dkGHl1mji8/JEW9t22arg9KpBIH2QHk9FaY2tEUeTVWf3MMtYTroNDiO
         Ep98P9PNJRfLrUw4hWUs0w7UgEV+FjYbJcQultmmfoIT1U/qiHGQnx/0rlqrO8m1Qqt7
         TkwM6p6aSBUCv9zaLaM4bIJ0XpLISfPNQybVFA3gbstcC2VZlzVCNqcwah+9QBw34oUl
         Lkkw==
X-Gm-Message-State: AKGB3mIkKTMKh/RFyVNnPDXG15luTJHHzxBUyxcaVHvDrV2kiif0imHW
        wW3r0WKwQaknU6MJDQaNJ7aQiw==
X-Google-Smtp-Source: ACJfBoseCEwEoa4NdAa/XO1B+Aiw0cCN3e/L2S9cg6YJPKj6rk/lau+KUaP67vIrVb73SCKpVhZu4w==
X-Received: by 10.129.137.68 with SMTP id z65mr2410205ywf.176.1515012001307;
        Wed, 03 Jan 2018 12:40:01 -0800 (PST)
Received: from google.com ([2620:0:100e:422:9072:375d:b2f1:696e])
        by smtp.gmail.com with ESMTPSA id v192sm731491ywa.2.2018.01.03.12.39.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 Jan 2018 12:39:58 -0800 (PST)
Date:   Wed, 3 Jan 2018 12:39:56 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 04/26] upload-pack: convert to a builtin
Message-ID: <20180103203956.GA44365@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
 <20180103001828.205012-5-bmwill@google.com>
 <CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kb2=uU0_K8wr27gNdNX-T+P+7gVdgc5EBdYc3zBobsR8w@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/03, Stefan Beller wrote:
> On Tue, Jan 2, 2018 at 4:18 PM, Brandon Williams <bmwill@google.com> wrote:
> > In order to allow for code sharing with the server-side of fetch in
> > protocol-v2 convert upload-pack to be a builtin.
> 
> What is the security aspect of this patch?
> 
> By making upload-pack builtin, it gains additional abilities,
> such as answers to '-h' or '--help' (which would start a pager).
> Is there an easy way to sooth my concerns? (best put into the
> commit message)

receive-pack is already a builtin, so theres that.

> 
> Thanks,
> Stefan
> 

-- 
Brandon Williams
