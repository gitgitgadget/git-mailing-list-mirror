Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AA201F404
	for <e@80x24.org>; Mon,  9 Apr 2018 13:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbeDINvs (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Apr 2018 09:51:48 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:39816 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeDINvr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Apr 2018 09:51:47 -0400
Received: by mail-pl0-f67.google.com with SMTP id e7-v6so3177777plt.6
        for <git@vger.kernel.org>; Mon, 09 Apr 2018 06:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=VhUb5UfRi5PgB1quasqSDnJX310BGGzJtY1iyIke1aY=;
        b=sKR3TnsLsEaa7VNRABprCo46lRp0+pv+/+zI8s/wOqev4Zx5poKdC4nScV+pjnvmd3
         PM6ZRKB3kOT/ZPElTqJB1riFOYYhZ7pA+nmKTayBCCFMqYnXqFIQLEMJe+xtn5/4bnKV
         iS2x0gjUk+BIYTADen24UbRyOIzRKU9K9u9ykshMiSviDpgiK4ELTyumsxEvrlbihzmH
         ERlnWrx3EZInXAfPY2lvu17a6WXChZbXBlC4n6C0pSwXn4giB1Md4CCmSYszeSvci/ek
         8KwWn/917aMavpguMdewnCVMQiTNDKM9jaRmhgfb332h0qWzTYeiu6F6yrh0Q5PibTMu
         bokA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=VhUb5UfRi5PgB1quasqSDnJX310BGGzJtY1iyIke1aY=;
        b=kumAsCBLGfI/mD77Opi2T1JIjJSsoCS3mWdsNt9CqQVlD+u8mKuUaQqUN/ZJdGA29b
         AB7okrfr48hmvZkKjPt6d8+1JrbBBWzaBxy6g6GJH7nAhnUgfSyot/Y/qPuQbp+roxwU
         MeyLBppAbEUE4tU6b1N99Yor+X7l/TLSZxfF12ffqypgVV+5tROT3ayhgVJdJ0XuC068
         mSGfExAPMrGB0KDGC2ZiJ1thHNsDaZDHwcwT8BQidDq077p7plZ/+q17tMsfLuEHG+cM
         DKZ6ptDMd9dHkccMzxEsJyOK7M1L7LZclwgEiVmE7IHFVN8mpYuL7Vs5DzIXeFn4Wpib
         x85A==
X-Gm-Message-State: AElRT7HMU9amJku0Gnkwk+QTUBNf9Djrw6wDs/loL+MOFw5p7LndkC45
        NTkqw7fGNNwGUhZGlhrKGIM=
X-Google-Smtp-Source: AIpwx480661K4t4H5fo/fiunf4EiIiIdv7OCVcBgINJoEs6qi8s6lRmw8Ib/nOeWJfpytt4KXx5Hng==
X-Received: by 2002:a17:902:3381:: with SMTP id b1-v6mr38909877plc.214.1523281906140;
        Mon, 09 Apr 2018 06:51:46 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id e73sm1750582pfj.186.2018.04.09.06.51.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Apr 2018 06:51:45 -0700 (PDT)
Subject: Re: [PATCH 02/19] replace-object: move replace_object to object store
To:     Stefan Beller <sbeller@google.com>, jonathantanmy@google.com
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
References: <20180406232136.253950-1-sbeller@google.com>
 <20180406232136.253950-3-sbeller@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <9cf5ca7b-4837-8626-f4f6-f580fd33128b@gmail.com>
Date:   Mon, 9 Apr 2018 09:51:39 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406232136.253950-3-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/6/2018 7:21 PM, Stefan Beller wrote:
> Refs belong to particular repositories, so the replacements defined by
> them should belong to a particular repository as well.
>
> Move the definition of a single object replacement to a new header
> "replace-object.h". While at it replace the hardcoded 20 by GIT_MAX_RAWSZ.
>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   object-store.h   | 14 ++++++++++++++
>   replace-object.c | 40 ++++++++++++++++++----------------------
>   replace-object.h |  9 +++++++++
>   3 files changed, 41 insertions(+), 22 deletions(-)
>   create mode 100644 replace-object.h

Throughout this commit, there appears to be an extra space inserted 
before 'the_repository'. Some are more obvious than others (such as a 
'free( the_repository->...)' but others are after the indentation.

> diff --git a/object-store.h b/object-store.h
> index fef33f345f..da639b3184 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -93,6 +93,20 @@ struct raw_object_store {
>   	struct alternate_object_database *alt_odb_list;
>   	struct alternate_object_database **alt_odb_tail;
>   
> +	/*
> +	 * Objects that should be substituted by other objects
> +	 * (see git-replace(1)).
> +	 */
> +	struct replace_objects {
> +		/*
> +		 * An array of replacements.  The array is kept sorted by the original
> +		 * sha1.
> +		 */
> +		struct replace_object **items;
> +
> +		int alloc, nr;
> +	} replacements;
> +
>   	/*
>   	 * private data
>   	 *
> diff --git a/replace-object.c b/replace-object.c
> index 3e49965d05..a7eb31026e 100644
> --- a/replace-object.c
> +++ b/replace-object.c
> @@ -1,19 +1,11 @@
>   #include "cache.h"
> +#include "replace-object.h"
> +#include "object-store.h"
>   #include "sha1-lookup.h"
>   #include "refs.h"
> +#include "repository.h"
>   #include "commit.h"
>   
> -/*
> - * An array of replacements.  The array is kept sorted by the original
> - * sha1.
> - */
> -static struct replace_object {
> -	unsigned char original[20];
> -	unsigned char replacement[20];
> -} **replace_object;
> -
> -static int replace_object_alloc, replace_object_nr;
> -
>   static const unsigned char *replace_sha1_access(size_t index, void *table)
>   {
>   	struct replace_object **replace = table;
> @@ -22,7 +14,8 @@ static const unsigned char *replace_sha1_access(size_t index, void *table)
>   
>   static int replace_object_pos(const unsigned char *sha1)
>   {
> -	return sha1_pos(sha1, replace_object, replace_object_nr,
> +	return sha1_pos(sha1,  the_repository->objects->replacements.items,
> +			 the_repository->objects->replacements.nr,
>   			replace_sha1_access);
>   }
>   
> @@ -35,18 +28,21 @@ static int register_replace_object(struct replace_object *replace,
>   		if (ignore_dups)
>   			free(replace);
>   		else {
> -			free(replace_object[pos]);
> -			replace_object[pos] = replace;
> +			free( the_repository->objects->replacements.items[pos]);
> +			 the_repository->objects->replacements.items[pos] = replace;
>   		}
>   		return 1;
>   	}
>   	pos = -pos - 1;
> -	ALLOC_GROW(replace_object, replace_object_nr + 1, replace_object_alloc);
> -	replace_object_nr++;
> -	if (pos < replace_object_nr)
> -		MOVE_ARRAY(replace_object + pos + 1, replace_object + pos,
> -			   replace_object_nr - pos - 1);
> -	replace_object[pos] = replace;
> +	ALLOC_GROW( the_repository->objects->replacements.items,
> +		    the_repository->objects->replacements.nr + 1,
> +		    the_repository->objects->replacements.alloc);
> +	 the_repository->objects->replacements.nr++;
> +	if (pos <  the_repository->objects->replacements.nr)
> +		MOVE_ARRAY( the_repository->objects->replacements.items + pos + 1,
> +			    the_repository->objects->replacements.items + pos,
> +			    the_repository->objects->replacements.nr - pos - 1);
> +	 the_repository->objects->replacements.items[pos] = replace;
>   	return 0;
>   }
>   
> @@ -84,7 +80,7 @@ static void prepare_replace_object(void)
>   
>   	for_each_replace_ref(register_replace_ref, NULL);
>   	replace_object_prepared = 1;
> -	if (!replace_object_nr)
> +	if (!the_repository->objects->replacements.nr)
>   		check_replace_refs = 0;
>   }
>   
> @@ -113,7 +109,7 @@ const unsigned char *do_lookup_replace_object(const unsigned char *sha1)
>   
>   		pos = replace_object_pos(cur);
>   		if (0 <= pos)
> -			cur = replace_object[pos]->replacement;
> +			cur = the_repository->objects->replacements.items[pos]->replacement;
>   	} while (0 <= pos);
>   
>   	return cur;
> diff --git a/replace-object.h b/replace-object.h
> new file mode 100644
> index 0000000000..50731ec9c2
> --- /dev/null
> +++ b/replace-object.h
> @@ -0,0 +1,9 @@
> +#ifndef REPLACE_OBJECT_H
> +#define REPLACE_OBJECT_H
> +
> +struct replace_object {
> +	unsigned char original[GIT_MAX_RAWSZ];
> +	unsigned char replacement[GIT_MAX_RAWSZ];
> +};
> +
> +#endif /* REPLACE_OBJECT_H */

