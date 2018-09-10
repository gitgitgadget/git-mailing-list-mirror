Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB1A21F404
	for <e@80x24.org>; Mon, 10 Sep 2018 14:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbeIJTM6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 15:12:58 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:45956 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728063AbeIJTM5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 15:12:57 -0400
Received: by mail-io0-f194.google.com with SMTP id e12-v6so729940iok.12
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 07:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=w0CiMu0Nyv3lj6SZcd6O8mOtT7IVuA7oICDQDTnOOO0=;
        b=SUm8xxAsrgvXcQ5VSs/jPwcRChXZkM5dL6a4tSWG2VDDcotd6+EbsvX79eroYX5Iq1
         neDvJar0Jw9gOpBZK8JOIAEAt1ILKzR7OarsJT4A/ftk/UXcEBR9OGO/7fqrI72nuGHC
         7G8D888UQdTxTSE9WoCvX1UQIeFgF949BsN80ETQXMstdTn1rV9c52y4gqcxfv97fuyU
         hxmEOiJqOefIOHhvxmbXEdcOYijhOSOylHOEK+z1HiXdvATUrLPBLXWcJWDEBiY2jT+m
         mzV4+n1mRIN6gTDdgIS5TpSWW+pNoNbSKaQF4Ygv0hZ/RBtgoxYb3emrFY498gvBCowf
         9IOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w0CiMu0Nyv3lj6SZcd6O8mOtT7IVuA7oICDQDTnOOO0=;
        b=uMSdcv3MU881eUdYmMWfXwBoNKLELNdlYzKu5nTiLf9YykWLVg3ttVozgeolPtYQYd
         7w53pm3LnCIA2VrnKZhjPzxhxlqrDMxjy5TS5Sgss9GWQeITVsqmuHNuAg+ooXa6Vjdf
         OaJVj8+yx1M/LqnUYZpuFeLAnmC90UALf0LU+IworsOp3yDxJV0bQMWbGtu5zcBxVMdq
         PnfWRonhbIxLpTTR+b57+/9fWfiMc248OKhWabsb9DCpLZjS89CJxKaiCcoNND8woV7e
         Xcq+8dYYyYnD8uOMT0ZVXee9XuUGb+oCMnvKpHA41pQEkYp/6cUJJ1Q5Tc35XsZPTKBz
         X/PA==
X-Gm-Message-State: APzg51DfGG6nhZ0C8D8QazPbGtqRvTifQrrvuK3yIcIm+8uCHxWOGxlv
        8Ih2f3WGpHY/YXIqUuwS81B7RoqReJgX6g==
X-Google-Smtp-Source: ANB0VdYxqIpErmC4vWJ5LVG3iMLmF9fZ51uMuZwnTobMMnyIiJ6NqptHIcJtn0n56a4G7XcEPbmZ8w==
X-Received: by 2002:a6b:e514:: with SMTP id y20-v6mr17827951ioc.93.1536589116974;
        Mon, 10 Sep 2018 07:18:36 -0700 (PDT)
Received: from localhost ([206.121.37.170])
        by smtp.gmail.com with ESMTPSA id d12-v6sm6008736itf.25.2018.09.10.07.18.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 07:18:35 -0700 (PDT)
From:   Taylor Blau <me@ttaylorr.com>
X-Google-Original-From: Taylor Blau <ttaylorr@github.com>
Date:   Mon, 10 Sep 2018 10:18:34 -0400
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t3701-add-interactive: tighten the check of trace output
Message-ID: <20180910141834.GJ86006@syl>
References: <20180910140714.19617-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180910140714.19617-1-szeder.dev@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Tighten this 'grep' pattern to only match trace lines that show the
> executed commands.

Looks good, and I think that this is the only such occurrence in t3701
that needs this treatment.

Signed-off-by: Taylor Blau <me@ttaylorr.com>

