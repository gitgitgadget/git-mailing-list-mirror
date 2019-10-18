Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C04B71F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfJRWyN (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:54:13 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41630 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbfJRWyN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:54:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id q7so4719552pfh.8
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=2k3ZAV1SL+UgMgJZkBrlYlE17xAy8PiibQ8LpZKqvbc=;
        b=qZwLKYCXr/iw2JeG8DTp1tnSLLGSv+s8xbu/YomrnVQQ9a649PZqY1Xce1KU0Y2k7Q
         gpe60BcpvjloIus1pupR/x+oGTWvS7l32Jkt4UzZYqQ4eVT31fVJTZQTGRYSLT8pwRbv
         BVAeZln7ce0mynClC1ZjYxlVv7W/O6l7NaGVIkSwQjpwT0v5bGXzErpARf/8f7KeyhRJ
         2LMHKM3YaQDn6G11T2VgULYhe4tThzbO6WqyMmKPGhiqDkyCuMv5weEArPHaghBNONy3
         aNcnhO7DwKElYwiB/VU8UWQ74RtETL59dTsQhi1BvWFPs10GEhN+GvWAKS9doCuMe4np
         SHtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=2k3ZAV1SL+UgMgJZkBrlYlE17xAy8PiibQ8LpZKqvbc=;
        b=M32MWi5xhQt8Ctp3ex5dvv+MPg3GjIgWp05v17Vdi4WZYDAyAesWnYWRXTssX9hqRf
         g9ooNcaaM925dcPT7VepfHqeNrROMhj+8kfvgVHa1QuY3+bidju860DMf9Q0/r12TjAo
         tpI1ReISs+aqOfKsb+sCVzlNvta1WEd94UWFaxv7IBNX4qyeNmgdq2Lfs2ntnOXXLSX0
         /RWecILlVGry9ivg9ixp3aQxKU6/Qv7bnJLym6R9nfXBrTOZ1sQ7zb3jd6sLDfyxBGqa
         N+Pv3DqvWjjH9vSuYEVP78NGwcPH1tcFxKD/RZYAHA9ungT2ZMtKdEWlJ4bdfTqQRqJ2
         xSmA==
X-Gm-Message-State: APjAAAX3AIp7Iac9JOo2akv+bocyJh1PSDXn0nqXMKODQG2+9tA1QuD0
        zwL6cDwaR+aJHzbe4UG3jJ3/nA==
X-Google-Smtp-Source: APXvYqxVRLa68DT8Fh82Srld516Ky2alSKUa+BaYtW2X6K1O7CjbCD4OfvsfwFUtw5qvkiUfcznS/A==
X-Received: by 2002:aa7:9e8d:: with SMTP id p13mr9144843pfq.171.1571439252468;
        Fri, 18 Oct 2019 15:54:12 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id i37sm6741836pje.23.2019.10.18.15.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:54:11 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:54:07 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v6 1/2] documentation: add tutorial for first contribution
Message-ID: <20191018225407.GB9323@google.com>
References: <20190517190359.21676-1-emilyshaffer@google.com>
 <20190517190701.49722-2-emilyshaffer@google.com>
 <20191018164027.GI29845@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191018164027.GI29845@szeder.dev>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 18, 2019 at 06:40:27PM +0200, SZEDER Gábor wrote:
> 
> Just leaving a quick note here: an entry about the new command should
> be added to 'command-list.txt' as well, so it will be included in the
> list of available commands in 'git help -a' or even in 'git help'
> and in completion, if the command is marked with the necessary
> attributes.
>  

Yeah, I agree - I didn't know about this until fairly recently, and I
want to highlight it!

I have at least one other change I want to send for this document in the
coming week, so I'll try and make a change for this too. Thanks for the
callout, SZEDER.

 - Emily
