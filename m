Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7FAE207D6
	for <e@80x24.org>; Thu, 27 Apr 2017 22:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423352AbdD0WMg (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 18:12:36 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34279 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1423349AbdD0WMe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 18:12:34 -0400
Received: by mail-pf0-f181.google.com with SMTP id e64so1798274pfd.1
        for <git@vger.kernel.org>; Thu, 27 Apr 2017 15:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=h2AJV0nDQrPOWDK+1akX7Nr5KEqbjdxJiyhEcnxohgc=;
        b=ezY3JEuJG5V3VqDnieQ5/yY6xU5ZLSSaokvzXGxyRKpN/jd03EIuWa9glexCya2a3A
         64ZvoDFk6PwTh5z3Ydm4qn5L2nDNdAQOw964WFdaCdgPWUQTRTckV7YGQX39EykPpZj3
         sruMe0OstCg7xIFWaiCovABir4cXDo5sL+2LN6MkZWMdT22ibjjl8dBk1A9NC6kXKWt7
         aFrjOGr0NVxquuWhjaNmvpbL1pKNnAfuO4l/XvZF04DoHK5RteMMU/YplHeOO+lubB++
         Nrs7TYw4XOQJ4TG/agaO4YJHTFQDF5MqrE4NcV/mDh16pOBhT0Ds/L8jIPz8cwphmbQd
         RSPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=h2AJV0nDQrPOWDK+1akX7Nr5KEqbjdxJiyhEcnxohgc=;
        b=AlJmjDCl+fRaoweHP20KVu6mkejNwhiJNy1gcLzzc5fak2KlXpeWOkmkjot6wwf1OX
         mrrmESFqfx52aZNrNVZgn/MI8+Ci9oPTHZ8RzZ3pClQXQGjb4Tglb8/eDSJuRFrYcZdl
         IRArKzLoz3czjWZwGPywFl97GayNQqk5huWNQwCJ+9J5pdMbQHuFtSS0Pt+Mj/3JSUrk
         qpVxMH+xwQHOWoJZXSWaCsWHg8GTt2N9Va3fNnlNWPlzs4gHlLLUSSV4j2tLhCWwsDl/
         PHj5V/Yaw1RWVHKJYVhHJe4hhHszkgDjNkblHW7u1Do77jjuGWwCXCi5F9XplUl4wCsi
         pTsw==
X-Gm-Message-State: AN3rC/5UeNZXeVwV/OCVPOYZAkV8m69gLt+rTfosexGbM2UZT68sSFq3
        eNNgnNGiB26LHN10wzFx/Q==
X-Received: by 10.84.212.1 with SMTP id d1mr10462395pli.109.1493331153914;
        Thu, 27 Apr 2017 15:12:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:6199:b109:ce03:97f2])
        by smtp.gmail.com with ESMTPSA id t18sm6520018pfg.31.2017.04.27.15.12.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Apr 2017 15:12:32 -0700 (PDT)
Date:   Thu, 27 Apr 2017 15:12:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 2/5] clone: add a --no-tags option to clone without
 tags
Message-ID: <20170427221231.GA146047@google.com>
References: <20170426231236.27219-1-avarab@gmail.com>
 <20170426231236.27219-3-avarab@gmail.com>
 <CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGZ79kbHuMpiavJ90kQLEL_AR0BEyArcZoEWAjPPhOFacN16YQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/27, Stefan Beller wrote:
> I like the option, though I dislike the implementation, specifically as you
> brought up e.g. "[PATCH] various: disallow --no-no-OPT for --no-opt options".
> 
> Can we have an option "--tags" instead, which is on by default
> and then you can negate it to --no-tags, without having to worry
> about the no-no case.

Yeah I agree that a "--tags" option would make the ui cleaner.

-- 
Brandon Williams
