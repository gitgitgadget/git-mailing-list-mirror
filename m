Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9ADB1F453
	for <e@80x24.org>; Sat, 29 Sep 2018 05:45:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727420AbeI2MM2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Sep 2018 08:12:28 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37251 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727407AbeI2MM2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Sep 2018 08:12:28 -0400
Received: by mail-lf1-f66.google.com with SMTP id a82-v6so6490313lfa.4
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j4iktVRtuI3pgDfRvIVbrAMyJnIuaXRN0IBBtsaUDJg=;
        b=ujLUiPaGM8H/76Uera6V2GT6vm7gpvpwNEvNdxCw+9/53lZe/035VN5EVreK4yeLPV
         Z+amnmkQkleYBCf40/KhRFWhr+nE10P9uORfVLxcfkADAlXbna/SmFJ2DLcSuHHBwbmS
         dzjWjvLKlYPUaXL+ZrHkZcH8HdG/iF2DB5SoLYdTv5bl6Dqld59FTUTFhXD5H2phAzKW
         RPxTf1wX+TeCDa75JbRAgX4Nd2FzPyaZ6Z07PyK9LEH3ASUgob5VZje5TLML2H9BM3b6
         JMcwYikGKdMSZ0SSnEWhgiimkoKvaX1iyzYavVge1dCLcxo7BkHZvZ3pLI9JOz8X+uF5
         qtXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j4iktVRtuI3pgDfRvIVbrAMyJnIuaXRN0IBBtsaUDJg=;
        b=rYCx7nytNt/fhpbAlIBtlak6FOgDdwkS3Uz7zS80T0B0MKzp3ARJIzbuGeqy1DKyjL
         mHQ+fKR1hJUP1TXWwqWkRhGMmu6TaZ1t5IGlUMsfd3HxthApyF3VNlS4V26mFcfRxqru
         BNVVuRFHJslfcJ8KRnM7tqtDg744nsH3ZHXzDqVK9y/rXKZtlhX8Sm6eQLNL91nbRx+v
         um0LD6h+mazwl/ZvTXLuObAZlTf3CFM+A7eBqBHRXXlBmBL10r0W51FtptGsdzqNDUmH
         qb1o9uh88aY/If3cUt3nIQr6aIvk1Bd4XR2V00MKSu0APZZDveeFN1OLLs6pu12iC/TV
         PjJg==
X-Gm-Message-State: ABuFfogZY/vkWJgza5DXPqHhEboD3SX8pGeEZCZs+u4hOqZWs4Y5X+x+
        ofl64xl74uZ4Zgui4jt4Bfc=
X-Google-Smtp-Source: ACcGV61wR8IvBWOnyHzm7c4/B036PGmiSHt7p41sK7WcVnSeQKq8hu5OpD9W90+cbYf09Q07OvJBrw==
X-Received: by 2002:a19:5f43:: with SMTP id a3-v6mr737125lfj.105.1538199923013;
        Fri, 28 Sep 2018 22:45:23 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id u17-v6sm1365339lje.39.2018.09.28.22.45.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 22:45:22 -0700 (PDT)
Date:   Sat, 29 Sep 2018 07:45:20 +0200
From:   Duy Nguyen <pclouds@gmail.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Ben Peart <benpeart@microsoft.com>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v6 3/7] eoie: add End of Index Entry (EOIE) extension
Message-ID: <20180929054520.GA21901@duynguyen.home>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20180926195442.1380-1-benpeart@microsoft.com>
 <20180926195442.1380-4-benpeart@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926195442.1380-4-benpeart@microsoft.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 26, 2018 at 03:54:38PM -0400, Ben Peart wrote:
> +
> +#define EOIE_SIZE (4 + GIT_SHA1_RAWSZ) /* <4-byte offset> + <20-byte hash> */
> +#define EOIE_SIZE_WITH_HEADER (4 + 4 + EOIE_SIZE) /* <4-byte signature> + <4-byte length> + EOIE_SIZE */

If you make these variables instead of macros, you can use
the_hash_algo, which makes this code sha256-friendlier and probably
can explain less, e.g. ...

> +
> +static size_t read_eoie_extension(const char *mmap, size_t mmap_size)
> +{
> +	/*
> +	 * The end of index entries (EOIE) extension is guaranteed to be last
> +	 * so that it can be found by scanning backwards from the EOF.
> +	 *
> +	 * "EOIE"
> +	 * <4-byte length>
> +	 * <4-byte offset>
> +	 * <20-byte hash>
> +	 */

	uint32_t EOIE_SIZE = 4 + the_hash_algo->rawsz;
	uint32_t EOIE_SIZE_WITH_HEADER = 4 + 4 + EOIE_SIZE;

> +	const char *index, *eoie;
> +	uint32_t extsize;
> +	size_t offset, src_offset;
> +	unsigned char hash[GIT_MAX_RAWSZ];
> +	git_hash_ctx c;
--
Duy
