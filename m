Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7CF9C1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 22:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751075AbeBGWGm (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 17:06:42 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36692 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750736AbeBGWGl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 17:06:41 -0500
Received: by mail-pg0-f48.google.com with SMTP id x25so853708pge.3
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 14:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFcNTssSmmOrnnmbTifNbBc0Ero+yDO9Zm/TzVren/Y=;
        b=l1MA5oiqpRnXAgWg9+XRjT4z6vXzuqDH0SmP8oPKChmVVURKNepP8J6vs6nhELYMUe
         zxQ37FcYqZqECPIgMa9GxAMvr6i9kvYrIhPpWC+MCC58L+CDL6Z9twn+TQldRuy9LPmR
         DYHxhojVqo+ZM0/eTHiPQVt+fZWcyKsVCAHUY1rVq5LAidubZJxTFXgO+SK+/zBSaUBL
         uT80J8/x8Pkqml3yXYVzxgmV2rbNVLGoUPIwDtMC9PZCeCdkagWNpBcPqiLlJvcDja7R
         FTEq+8r1riRvABZo98IuQrKzTNGhwv/nuKcJl/JP+DYyD+gdGRP8u2PMGBvDghxaU3HO
         zFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFcNTssSmmOrnnmbTifNbBc0Ero+yDO9Zm/TzVren/Y=;
        b=S4bORLb/BODGpWRpRlrQAcjcjqus4kLndhAcDK07cXLuMD4J18FmPH7SAvZZKoY5Oo
         LrJ8gozD39ze+GtjOLg4e1qpUaksKb9JzRezDr0PZewE+dwwNCXxkLATQ0A/ts38wlV/
         AtqutaYfTeWcTt84WosHhE7HcvOL7rC7gu5MNh7/SLVvmq0S+Q4hctiYpgWiSsaYKMKb
         VfCMuUcCIiOoFM5lRyw2oPusQ8GtmKz6tywjdRoQDF0gZXGktRHFOfAdfLqoXb8dxN2S
         DwMPKmLB2Eqhm+BlB4Y7Y9sUrQdXBWPTrQbv2NYz/rzCiSdwKbBeYaLFXAB7R6hwiscn
         BTUg==
X-Gm-Message-State: APf1xPDudTyvHfvEEGkrFeJ20AgSN8QYOhYOsdpQag0O/+v+592vO/5d
        lLj8b5jsBQ99GUVhvEOv+ftKdqrR1LI=
X-Google-Smtp-Source: AH8x225EQtQff4fI9yxxktel06A3ZRz800jegZ9D9y7yWoo0u6NFwhFDd0gYgVK+WzCFZGds24E1cg==
X-Received: by 10.101.97.165 with SMTP id i5mr6069416pgv.55.1518041200633;
        Wed, 07 Feb 2018 14:06:40 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id k7sm4767551pgo.31.2018.02.07.14.06.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Feb 2018 14:06:39 -0800 (PST)
Date:   Wed, 7 Feb 2018 14:06:38 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 025/194] object-store: allow prepare_alt_odb to handle
 arbitrary repositories
Message-Id: <20180207140638.a4ff04513e10e1fc3f2d7c9c@google.com>
In-Reply-To: <20180205235735.216710-5-sbeller@google.com>
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235735.216710-1-sbeller@google.com>
        <20180205235735.216710-5-sbeller@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon,  5 Feb 2018 15:54:46 -0800
Stefan Beller <sbeller@google.com> wrote:

> +	/*
> +	 * Path to the alternate object database, relative to the
> +	 * current working directory.
> +	 */
>  	char path[FLEX_ARRAY];

I would prefer this to be commented:

  Path to the alternative object store. If this is a relative path, it
  is relative to the current working directory.

to show that it is not necessarily relative, but the current version is
fine too.

> +		/*
> +		 * Paths in alt are relative to the cwd. We ignore environment
> +		 * settings like this for all repositories except for
> +		 * the_repository, so we don't have to worry about transforming
> +		 * the path to be relative to another repository.
> +		 */
> +		link_alt_odb_entries(r, alt, PATH_SEP, NULL, 0);

I find the comment confusing - it makes more sense for the reason for us
not worrying about transforming the path is that the paths as stored in
struct alternate_object_database are relative to the CWD, not that we
ignore environment variables for certain repositories.

I think it's best to remove this comment, and instead add a comment to
read_info_alternates() before its call to link_alt_odb_entries(),
explaining that paths in the alternates file are relative to
"info/alternates", not to the CWD (since that is the exceptional case).

All the patches prior to this look good. Thanks especially for the
consistent naming convention of the patch titles.
