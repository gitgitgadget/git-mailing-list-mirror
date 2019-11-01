Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6554B1F454
	for <e@80x24.org>; Fri,  1 Nov 2019 01:33:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727580AbfKABdL (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Oct 2019 21:33:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39534 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKABdL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Oct 2019 21:33:11 -0400
Received: by mail-pg1-f193.google.com with SMTP id p12so5368137pgn.6
        for <git@vger.kernel.org>; Thu, 31 Oct 2019 18:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yS/WZziyFFiIngS1jogggMkrHBnF9J2udAjUuac6/0g=;
        b=FL9+LmdaCErhbEFBmGb2ZBXLXU22cD1/Zf4x9EdYdRahwisE/Z7A+gGAneALJ3C6CL
         BGC2xMmx9mjHHdAwqY5sFVbb8kVlNFE3Wap5fN3YIiGRUJLjAdWw5dJRglGSJ5mhRyq2
         vUEb61PmiYi/qUI5gw8K+/dUKT6zlCaG7tVlsnEX6dHmqhR1znsOMFsNZpqfgJ8HFSSq
         8pII1tdGvnaL5LhCMK2Tgne7guPbq30Dk5eTsxgNrie1gULvTBWLvx81GlgcYIuyWA6k
         IJDnYdEqcpBJ8FD+EfXJ4PTqNnWum4ZQUh0A6oHg4Arh7qDI4xRNnJXp5OsXNcx1F/ZH
         /C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yS/WZziyFFiIngS1jogggMkrHBnF9J2udAjUuac6/0g=;
        b=arrzSqA1lGZZ87N7hpY8Iu+D+ZiuOr4MvEbmCIgCPs7cist0nPi4cS2qbCs83NL1TF
         Q+kF2xbimK9Awj3A/U+UA87KOG+zn3Ieh77h45ISGSysgbbmQRS/uZP9GSUbg33CRpbC
         uPGtHnJ16AVt9Q0f3qip8LCrhhIkckEkOm3JrGGmJ13Enr+zvzba/y1nlZa6BVCdKrKy
         o1aOZDG0BFce+tsiO/x5RuTrQJ+SMkn0/PXuMbQgVTzzMNEbFda7VuSVEFiNsmUD1pZF
         H9W/tfoo770kyYaAhyLPR0eJUaX6gMTlX8wvc0YLbSz9/vjfmb9z/mgRb+DpS/dLBsP8
         fjVQ==
X-Gm-Message-State: APjAAAU5N6Z9Z8YM1Iqnts3Bip2bczAXO6/eofzvWOgpKMXqwnasMu4h
        5QDeI1ETLv/IURlGeK8cCjIwzUFG
X-Google-Smtp-Source: APXvYqwFA3Z1jTYXGMIuASkJUWB/bDEOeMn5/8DbBDC/mNXzPotUlGbHqxuenSMZWv+sHwQGJmFoUA==
X-Received: by 2002:a63:7247:: with SMTP id c7mr10222082pgn.311.1572571990813;
        Thu, 31 Oct 2019 18:33:10 -0700 (PDT)
Received: from localhost ([2402:800:6374:2d45:2809:9830:be60:8e46])
        by smtp.gmail.com with ESMTPSA id q26sm4188491pgk.60.2019.10.31.18.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 18:33:09 -0700 (PDT)
Date:   Fri, 1 Nov 2019 08:33:07 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t0028: eliminate non-standard usage of printf
Message-ID: <20191101013307.GD30350@danh.dev>
References: <20191031092618.29073-1-congdanhqx@gmail.com>
 <20191031092618.29073-2-congdanhqx@gmail.com>
 <20191031174118.GA2133@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191031174118.GA2133@sigill.intra.peff.net>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-10-31 13:41:18 -0400, Jeff King wrote:
> So I think your patch is the right thing to do (hex escapes in shell
> printf are definitely not portable), but we might want to note something
> like:
> 
>   This wasn't caught by most people running the tests, even though
>   common shells like dash don't handle hex escapes, because their
>   systems don't trigger the NO_UTF16_BOM prereq. But systems with musl
>   libc do; when combined with dash, the test fails.

Make sense. I will take this note in the reroll.

-- 
Danh
