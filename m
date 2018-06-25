Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C4B01F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964911AbeFYSWf (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:22:35 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36680 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964880AbeFYSWe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:22:34 -0400
Received: by mail-pf0-f193.google.com with SMTP id u16-v6so3060198pfh.3
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=X2VfwomBB4clXRHn7PQVBRoZ2/yzty+Hfg5i3B1m4Gs=;
        b=MjIHVJpl/swE6KnzhgYLHfVltyk9fi7GEhJeozDkGeCTU8A/pwZPuztcxenEhOAzLK
         hhBYI5GmtRpTk/yAcsN0laLxvLkmTrEDQBs5LjvcgcI0Roc2DMZFn+dL4D5AeJD0rQYh
         Tm9kadT63gHz1V4OunfA4Zv+yLtuNLx1M/h0zpPxA3RYWA57X39kWiwKLm2I+9wG9f2p
         fPTdN32LPzQVDUR3A7/g5s7KFKPafCWKVDPYpjuQn5Jy6tOa0+XrNHQjzFwFBObDtcaq
         6x2HQ+LmzFpA314+Vo43Mn8VTBDI+oMq7Q6q/KqMxWwoPznItRVVL50Dbp7Yv+ll9mX7
         ihtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=X2VfwomBB4clXRHn7PQVBRoZ2/yzty+Hfg5i3B1m4Gs=;
        b=NA27TLH1tET2x1XfGY8cGzKW6Fh4O6uP9PbEVAih50lR6wp+N0Ul3MGraZCTuOa/Ut
         T0zlR9S2e3cH6sMj21YpFe1tl3v1y6YDPJ6rJT2+QHggnqEoiycOgRPK03ozipje5jf1
         XB09Hwf/Ud51UK/94IGPwKIoz6po0SiHsb0rQ9I3ebMbudjpdw/YHeqSF/vwSJX+m94x
         cGVcrO5gTuO+9VdychJi+JiXEPl7ZuGZvMVo2gnNxOB1fz8ypkTBVlbqoRrV13Hz46wC
         vFV1hovfeR/hvRXc1R2fG8DyA+o8MAcP98zpwqjsiZNc/L9uK9u8JHTkXM99ATESoaFB
         v4HQ==
X-Gm-Message-State: APt69E3yrq9gyVjQV4Q74ruCACnd8RydbBzbsHmDpdjarWAGQgYpj7KI
        Z1gWkiG0f7XmIjMgR98Xzp+uPPnMx3Y=
X-Google-Smtp-Source: ADUXVKLt4gSHe867OOFektxLVW4P+bzXILJbALm189ahaDDXDY+ijdFn6cc75m3ePIatskb/g6SGyw==
X-Received: by 2002:a65:602c:: with SMTP id p12-v6mr11602097pgu.209.1529950953915;
        Mon, 25 Jun 2018 11:22:33 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id q207-v6sm24405939pgq.11.2018.06.25.11.22.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Jun 2018 11:22:32 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:22:31 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [PATCH 0/2] Object store refactoring: make bitmap_git not global
Message-ID: <20180625182231.GD19910@google.com>
References: <cover.1528397984.git.jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1528397984.git.jonathantanmy@google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/07, Jonathan Tan wrote:
> This is a continuation of the object store refactoring effort.
> 
> We cannot truly free an object store without ensuring that any generated
> bitmaps are first freed, so here are patches to drastically reduce the
> lifetime of any bitmaps generated. As a bonus, the API is also improved,
> and global state reduced.

I've reviewed this series and haven't found any issues.

Reviewed-by: Brandon Williams <bmwill@google.com>

-- 
Brandon Williams
