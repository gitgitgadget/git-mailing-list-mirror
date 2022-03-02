Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E93C433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 20:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243234AbiCBUUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 15:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234257AbiCBUUn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 15:20:43 -0500
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A599C9A2D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 12:19:59 -0800 (PST)
Received: by mail-ot1-x331.google.com with SMTP id a7-20020a9d5c87000000b005ad1467cb59so2680733oti.5
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 12:19:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zzBRQcoqvdJcBysARyHD9AHqLQbIhAVlOBXkk9grmZg=;
        b=c0OdVNextRHWo+ie58YBraoNRDOvKmsF8B6A+9YFqN1APLdfDQlBFbRpENfUXrhz+4
         9Hc6JFGLu3v6Bw0h8o2vA6CZlYBtV7iz9FtJqlvh1T1iHRjwy5huIlviiyv665p2sKtJ
         zA6IPH9+P6xR0P2VAh7V5znzgC425/dGul1YoPTIbmk32IbKTIfwXTuwC4RiKkX1DvD+
         MiSE2wKpP/mteiYT2jDNHMzFLVTLN49bLtHyqYm4r3fFY5+WkQHIrPyuhbkYiXS5Vvnk
         kVj/cioTldBTjRPggEqBqFaEJcCjaSA0NGiLnzlO8mTbFFY2MxkWsrxisGx8FU3NaL5K
         ZkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zzBRQcoqvdJcBysARyHD9AHqLQbIhAVlOBXkk9grmZg=;
        b=7zsnbkQQqyy/le7Pxhc7htUhYAlEqq6N+f/tPxEaI65jTM/qZLm09EFLi1vraQ6a0k
         s6mBC5MYzkcbT+AzrALfOiUmEH6J/YTYpgt8306zT5j6XIm7qp/bGlxKGpfaZ1f8vxG4
         y42HEHx/F3bbm5ZefMNvQ/b6mx210cZptY/nnv/mwDRYD5PUTNDbPdO2qNIYPSbv7dbl
         6UPeWr8maXaEacpP1gAdR/qPKb+HlsKwTtCClW8dEj25DV+TMgkDilLpoJr+6Wcilv6A
         iID6fo0JLsZiqu10rVGUTY4V6ieSge+W2y1PJhWATfZfP8FoM2e7KIijUvXVQm6Dl23h
         Cpzw==
X-Gm-Message-State: AOAM532UJCU/TCbFjP7kFXbjzsRYEQH9nz72AN0yOL48nMFJZfnj+yXu
        SI3BxIwV9hzhvxXqGEjWBw/33uBzpika
X-Google-Smtp-Source: ABdhPJxnjx5sL4EVYF17RLopnkmCLtEAlfwkQybmvuUW9vOytH6ZAXBNWD4mP+OzD6LfuP/daabcXw==
X-Received: by 2002:a05:6830:2783:b0:5ac:e99f:70fe with SMTP id x3-20020a056830278300b005ace99f70femr16981751otu.122.1646252398980;
        Wed, 02 Mar 2022 12:19:58 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bl16-20020a056808309000b002d43b28a8bdsm10706427oib.14.2022.03.02.12.19.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 12:19:58 -0800 (PST)
Message-ID: <245e34c3-ba85-2bb3-d17a-e48ee5b142bd@github.com>
Date:   Wed, 2 Mar 2022 15:19:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH v2 09/17] reachable: add options to
 add_unseen_recent_objects_to_traversal
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     tytso@mit.edu, gitster@pobox.com, larsxschneider@gmail.com
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1646182671.git.me@ttaylorr.com>
 <6f0e84273f78797c728058521969e73f8817b49c.1646182671.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <6f0e84273f78797c728058521969e73f8817b49c.1646182671.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/1/2022 7:58 PM, Taylor Blau wrote:

> diff --git a/reachable.h b/reachable.h
> index 5df932ad8f..b776761baa 100644
> --- a/reachable.h
> +++ b/reachable.h
> @@ -1,11 +1,18 @@
>  #ifndef REACHEABLE_H
>  #define REACHEABLE_H
>  
> +#include "object.h"
> +

Nit: just realized this include could be replaced by a struct
declaration:

>  struct progress;
>  struct rev_info;

Like these. 'struct object;' should be enough for the typedef.
>  
> +typedef void report_recent_object_fn(const struct object *, struct packed_git *,
> +				     off_t, time_t);
> +
>  int add_unseen_recent_objects_to_traversal(struct rev_info *revs,
> -					   timestamp_t timestamp);
> +					   timestamp_t timestamp,
> +					   report_recent_object_fn cb,
> +					   int ignore_in_core_kept_packs);

Thanks,
-Stolee
