Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BDDDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Jun 2022 14:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiF0OS4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jun 2022 10:18:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235267AbiF0OSy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jun 2022 10:18:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D0D101C2
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:18:54 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id be10so13014219oib.7
        for <git@vger.kernel.org>; Mon, 27 Jun 2022 07:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=huEAySgT534MUneqc0gvQjWHtgauO7gXlp8WLpWKaJs=;
        b=KMQ8hBK8nFwK+88IclTUWKi4l87nhASbhjZtbkAzgC+7h8gyYUYVmYyIqM8FzERfcs
         k3xvMOE72yMhFwN/GvXAbDmNRo8PlOGhQ2M2iN/OawdzqaJgLRK2KcDCt6weQy+DZfOf
         2dvwShhvGuXVB53Ym/N8fc4Zw+jW8vfIQUzKqiuQ1NfmdmBGzkiq0fSv3ZheAvjz77kH
         NxAQJo1nO4Cejt2/FPpYbqujngZGh7imm4cnX6geq/Jh+FLhzno/6dc77QJpxJ1MSi+J
         TUMYQc/iWtlWQbW4WLHdYmp73Hts0V9sA+BgOiVj5dCMKeAZSklW+5ypJjLCpbnLlVzr
         ClDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=huEAySgT534MUneqc0gvQjWHtgauO7gXlp8WLpWKaJs=;
        b=vUQDNz2vRDZCo59knA8jqUD5W/tQRBtVPQ6K+APk96DeZa0bIaJmj6wsMFpri9VdCX
         YHeCse5u5E+7ubNgqvLhjDAX2ongEX+UGNDv9DjobdA2IzQZ4eO2+oXvgpiDMoQ+VhuQ
         RR9KF8nqnfdq3D8lRjFEWDNKbaMw/rhoEmkcQDY0D4SHgmgdhASEAV+EoSUPH0VFV8mN
         Ii2y8YE0lA10DOkpZQFcEZTnh8lT130GNaxBPkuMpNXy31hDqb3EFHOhnU29j/Ty30NB
         V82H86cRxx5b+uPfQKRNAtomRHxny7AGBrzyzHK1PkvGFAwz/QnCUEx/Gh/4r/FBofJ3
         YDHg==
X-Gm-Message-State: AJIora8j7IiG6oaYsG8YVybKn19vb5Snca9sFgBSZkf9oL70hV9e44sl
        MoiYosHeW33DfDpBnA/qPTy5
X-Google-Smtp-Source: AGRyM1slk0/enc1zOTQBOU8jElHvF9HzfMR/e0MCCXh5qWaFhvdjH+SL5bM62B4h3h5mNIksECG1jQ==
X-Received: by 2002:a05:6808:99c:b0:335:6be3:b519 with SMTP id a28-20020a056808099c00b003356be3b519mr3787206oic.81.1656339533004;
        Mon, 27 Jun 2022 07:18:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:714a:b337:6fac:e704? ([2600:1700:e72:80a0:714a:b337:6fac:e704])
        by smtp.gmail.com with ESMTPSA id kv9-20020a056870fb8900b000f39f0816bbsm6982249oab.40.2022.06.27.07.18.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 07:18:52 -0700 (PDT)
Message-ID: <b2c947c6-b33b-066e-a578-65f769ef4f75@github.com>
Date:   Mon, 27 Jun 2022 10:18:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/6] Documentation/technical: describe bitmap lookup
 table extension
Content-Language: en-US
To:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
References: <pull.1266.git.1655728395.gitgitgadget@gmail.com>
 <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <4d11be66cfa2cd667df56ab9260903a37900bd4c.1656249017.git.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <4d11be66cfa2cd667df56ab9260903a37900bd4c.1656249017.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/26/2022 9:10 AM, Abhradeep Chakraborty via GitGitGadget wrote:
> From: Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
> 
> When reading bitmap file, git loads each and every bitmap one by one
> even if all the bitmaps are not required. A "bitmap lookup table"
> extension to the bitmap format can reduce the overhead of loading
> bitmaps which stores a list of bitmapped commit id pos (in the midx
> or pack, along with their offset and xor offset. This way git can
> load only the neccesary bitmaps without loading the previous bitmaps.

s/neccesary/necessary/

> +			** {empty}
> +			BITMAP_OPT_LOOKUP_TABLE (0x10): :::
> +			If present, the end of the bitmap file contains a table
> +			containing a list of `N` <commit pos, offset, xor offset>

(Note that "commit pos" and "xor offset" here don't have underscores, but
your discussion below does use "xor_offset" with underscores.)

> +			triplets. The format and meaning of the table is described
> +			below.
> ++
> +NOTE: This xor_offset is different from the bitmap's xor_offset.
> +Bitmap's xor_offset is relative i.e. it tells how many bitmaps we have
> +to go back from the current bitmap. Lookup table's xor_offset tells the
> +position of the triplet in the list whose bitmap the current commit's
> +bitmap have to xor with.

I found this difficult to parse. Here is an attempt at a rewording. Please
let me know if I misunderstood something when reading your version:

  NOTE: The xor_offset stored in the BITMAP_OPT_LOOKUP_TABLE is different
  from the xor_offset used in the bitmap data table. The xor_offset in this
  table indicates the row number within this table of the commit whose
  bitmap is used for the XOR computation with the current commit's stored
  bitmap to create the proper logical reachability bitmap.

This does make me think that "xor_offset" should really be "xor_row" or
something like that.

>  		4-byte entry count (network byte order)
>  
>  			The total count of entries (bitmapped commits) in this bitmap index.
> @@ -205,3 +218,31 @@ Note that this hashing scheme is tied to the BITMAP_OPT_HASH_CACHE flag.
>  If implementations want to choose a different hashing scheme, they are
>  free to do so, but MUST allocate a new header flag (because comparing
>  hashes made under two different schemes would be pointless).
> +
> +Commit lookup table
> +-------------------
> +
> +If the BITMAP_OPT_LOOKUP_TABLE flag is set, the last `N * (4 + 8 + 4)`
> +(preceding the name-hash cache and trailing hash) of the `.bitmap` file
> +contains a lookup table specifying the information needed to get the
> +desired bitmap from the entries without parsing previous unnecessary
> +bitmaps.
> +
> +For a `.bitmap` containing `nr_entries` reachability bitmaps, the table
> +contains a list of `nr_entries` <commit pos, offset, xor offset> triplets.
> +The content of i'th triplet is -
> +
> +	* {empty}
> +	commit pos (4 byte integer, network byte order): ::
> +	It stores the object position of the commit (in the midx or pack index)
> +	to which the i'th bitmap in the bitmap entries belongs.

Ok, we are saving some space here, but relying on looking into the pack-index
or multi-pack-index to get the actual commit OID.

Since this is sorted by the order that stores the bitmaps, binary search will
no longer work on this list (unless we enforce that on the rest of the bitmap
file). I am going to expect that you parse this table into a hashmap in order
to allow fast commit lookups. I'll keep an eye out for that implementation.

> +	* {empty}
> +	offset (8 byte integer, network byte order): ::
> +	The offset from which that commit's bitmap can be read.
> +
> +	* {empty}
> +	xor offset (4 byte integer, network byte order): ::
> +	It holds the position of the triplet with whose bitmap the
> +	current bitmap need to xor. If the current triplet's bitmap
> +	do not have any xor bitmap, it defaults to 0xffffffff.

This last sentence seems backward. Perhaps:

  If the value is 0xffffffff, then the current bitmap has no xor bitmap.

Thanks,
-Stolee
