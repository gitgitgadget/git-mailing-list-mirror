Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 46F621F454
	for <e@80x24.org>; Tue,  5 Nov 2019 18:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390747AbfKES6t (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 13:58:49 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34822 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390514AbfKES6t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 13:58:49 -0500
Received: by mail-pl1-f196.google.com with SMTP id x6so9943239pln.2
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 10:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GUiNfgtVRB10cF5gKeYk/liZWnn7GInRCNQbit/0Qvw=;
        b=VjN+BtYXIBSqbUVOr4krTv3E2nNPjsBTifTRyrxkG+mKaB7Mw7z8dhnhtECkX58LgX
         x96eU5d2Z1wu3/OZED3c0keKZWZbe1XIYB7R5JTOScLH6U/B2L36OwRVKDazLeKSMv2V
         YYJazLHwiPhX3HDVRa9zoWCsr+1SY+Z/f9o200ulvVMlYJvHA9b+d7TgYQz0jkZrKrBt
         kZr5zCSytSwOQ5+Hjk3mqXG95YMEfGhFO6d/0Fjn1rY9ljGb8xHVJiON1OGXcm9Cd782
         uerHPvR/W3FyW8Y+a4R9YlWLt/RGX3NAaFNxkmhHFTzN/XKB+iZN77qFOcL1bsP4yPx7
         P5IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GUiNfgtVRB10cF5gKeYk/liZWnn7GInRCNQbit/0Qvw=;
        b=BA/urLDdGeYkJL2xNLI4sGXpvdz9riMFAE78RwwQJkYC4JwOV4ls4xMa/ileDspNZr
         vsJB7aDWI8azfsMoydW/Ep4muahkGBTkkUGBVac1w6MDSGtYxjdsko4Ro0Hvtw/ItjBl
         Ofiv0IyrItJeUEAVTamDRmK6YWWq49d5/3hULqqCyrQr7TQ00WXz6Fmr/16v+LB705GY
         MVHnOwYFxwisg5kLmRCPzhiDQlHdtmpfNp1SbjusVbHjIYHrD5FRsNgYTf7tsRZtqp0F
         qP6nfY7P85drtuLaq2WKtyDlNSjf66zwnrPCb+ZXIfTMbEqh+X8qRF9oVy1bss9tHYiU
         FN2A==
X-Gm-Message-State: APjAAAWUjS4W0ZDF3yZl77jg4fRVgjMxi83vjOjg96jzmTSgoExNEOQL
        aMxuuHwiBKRIg6YZCK3f5Mj4I59C
X-Google-Smtp-Source: APXvYqxe83TrNd6AnobVApKm1Ok5McVTDmGc8UaReLLkmv4wGNISgHJTlKa15N/xD+Gtb35Mk4kKYw==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr35980827plp.166.1572980327984;
        Tue, 05 Nov 2019 10:58:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id u65sm21731864pfb.35.2019.11.05.10.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 10:58:47 -0800 (PST)
Date:   Tue, 5 Nov 2019 10:58:45 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] fetch: remove fetch_if_missing=0
Message-ID: <20191105185845.GA94320@google.com>
References: <20191101220537.GA249573@google.com>
 <20191105185322.205317-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105185322.205317-1-jonathantanmy@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan wrote:

> I think it's less error-prone if we always have a "git" command on its
> own on a line, to avoid losing its error code. When piped into another
> invocation, or when command-substituted into an argument (e.g. "echo
> $(git hash-object foo)"), we lose its error code.

Sure, but assignment is a special case:

	if myvar=$(false)
	then
		echo yes
	else
		echo no
	fi

prints "no".

See "Don't use command substitution in a way that discards git's exit
code" in t/README for more details.

Thanks,
Jonathan
