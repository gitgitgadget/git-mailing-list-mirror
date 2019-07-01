Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 072441F461
	for <e@80x24.org>; Mon,  1 Jul 2019 15:36:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbfGAPge (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 11:36:34 -0400
Received: from mail-yw1-f52.google.com ([209.85.161.52]:41097 "EHLO
        mail-yw1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAPgd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Jul 2019 11:36:33 -0400
Received: by mail-yw1-f52.google.com with SMTP id y185so113156ywy.8
        for <git@vger.kernel.org>; Mon, 01 Jul 2019 08:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+WyLaBK4vPitC195O3aTG+Ckp7sRNU3Gdc6kt2PWC/k=;
        b=rAMUEn5nBOI37eevwKqEXgriKUeV+VHkepVLf3ZPVLWWOXMurjlQO+t2WtNrFKFs9H
         mlXu0OR/0otvWdC1HAIvx3s/JYJMdpoG8YvrWjPgdumwSs7ZZogKw4MqCibqXQYGirIR
         KrKVx4e3ocimDWwlhQj1uWDjCUrtjAhaEeMjZ7roleToffdKNZZcGJeDJ1qU7cW6jvqE
         9MJFHZADN6yUdsIRIcLex9CA50U5LH64uCKm601HTgeWuc9UrsbXnJin9BAdVr8XN5Pf
         FDeSt6imlT3XKJcoZu9hrMR/8jAnBPvGqxBYJyx8zyeWA0DURinlZydn1i5yDLFk2i1q
         MPrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+WyLaBK4vPitC195O3aTG+Ckp7sRNU3Gdc6kt2PWC/k=;
        b=qtjbobDTRn2bfHO3rBriOL7SxC2rijcmPykQ0PIFUKttJodsHq5Qwd+Xa2ot7buAx+
         20n9ixA4d3753cfNxfkr9YFRHKQNMPShKlMHkhoeqjT3xzj6pImmH4VhNVcDqwwk4laz
         IB3CBtvAnUTVnKCpveuxydbWadZmDdDf+gsbXvJdOc0ivzMFn5X884X0tcErQNrB3uDF
         1vQBUoV3cwoQzGXaBnKMZQzMbioMruImiyrtqO4C5z+bwmIkN0ewpXdwTUPrMqw9GSvP
         boRaicJhF5nv9o+PVVJUIXr0J8Q6znHv54SwZ8C5QPg+ZcgEneAGUGoTYQpe492uE1Kj
         xMGA==
X-Gm-Message-State: APjAAAWKYFtlmz8q2NwJU25IN1+S0ZKXMbU2N2wKroBzVYGEfKwQN1cu
        LwFUC6sl69puZsD66tkKWqNGqPok/7+yjA==
X-Google-Smtp-Source: APXvYqzWh6wUVnTtVLoqYovOFZ200iPnwmcfy/bIeO4V1+CPqH3geREICl8oYoSWcqcUT/nZIer3YA==
X-Received: by 2002:a81:2914:: with SMTP id p20mr14875056ywp.69.1561995392936;
        Mon, 01 Jul 2019 08:36:32 -0700 (PDT)
Received: from localhost ([2600:1700:6e90:7930:6841:343f:64f7:7ef1])
        by smtp.gmail.com with ESMTPSA id a82sm2591109ywh.42.2019.07.01.08.36.32
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 01 Jul 2019 08:36:32 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 1 Jul 2019 10:36:31 -0500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2019, #07; Fri, 28)
Message-ID: <20190701153631.GA45707@TaylorsMBP5815.attlocal.net>
References: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzhm173sp.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 28, 2019 at 03:17:42PM -0700, Junio C Hamano wrote:
> * jk/check-connected-with-alternates (2019-06-28) 1 commit
>  - check_connected: assume alternate ref tips are valid
>
>  The tips of refs from the alternate object store can be used as
>  starting point for reachability computation now.
>
>  Will merge to 'next'.

Ah, I didn't see that you had queued this one as well. We also have this
patch in our fork. It has been in our fork a little longer than the
ref-filter patches, but this one has also been running without issue.

Thanks,
Taylor
