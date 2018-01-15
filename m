Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77E011F406
	for <e@80x24.org>; Mon, 15 Jan 2018 20:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750781AbeAOUkp (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Jan 2018 15:40:45 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:39150 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeAOUko (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jan 2018 15:40:44 -0500
Received: by mail-wm0-f65.google.com with SMTP id i11so4372035wmf.4
        for <git@vger.kernel.org>; Mon, 15 Jan 2018 12:40:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JOP+BSRQRykEHUygpoRttF58Fu7lhlRpkOI+ptVU8aU=;
        b=tPrMntJZYnoVMdkbomf7KBkLtoUjz4c77vxWwLjh+5Bcq8AWTv6SvtoaC9Ok4q7j94
         kFYFEXfdbVlcWMDYuOksjE5jJc6PdQlPxEXRy8c3Aq8vaw+oz29H1/S/opV2MofJybcI
         3B6ME3s2PljX/Vcdi6YYs1xUXcPZw8rImUxhwrQ/ie1SBRwSm5H8j70pYp2agZmZ4vr4
         EZPqQueKBf/+7brRIutHeAZTSdcZtZIM7brHPNu930BLhssEYgMAcoAOwuK2/Et+bjkj
         l6y41DuV+Y2MaMtUo7BzzB3I+V856szFMKET8+iBI9maa6kKLu5fEVsD6v20pgPEc2wW
         rOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JOP+BSRQRykEHUygpoRttF58Fu7lhlRpkOI+ptVU8aU=;
        b=hND1w6Cb8ITpwPBCbUS4dLZCYGSUYWZsURn/5JFO9nfWLddun8fMbHqcmllKlaf4/2
         0DwwjedWlIRvP9TsyJmRwrFX1iIFbLsMQRc02Rz8WtmnzDL1HCO3Pjd7kR3ohSWOphHD
         YH2P6OVh8TIDnYaIRWmdKW1+PtzF12+3n8Lt5ilbqKGFZo4RmKMWRG0OY4lrOlM515Lq
         3+16OL8EBk33/UcLo5B89iNphDWVJxz39fpn1Bv5rJYgkPTmsEDcD7gbQB+EXLYAmF5I
         PrABtB++46geeD1hqWJs0vs4yMAC8FfbAfzel4euQ3MlZOihFmw3i3m+csmwwjdjtSMl
         h3Gg==
X-Gm-Message-State: AKwxytdfss4Gz54+Kacir8ECWxk0w0/Z0xDDWQz9X3dRwcRRKoFDW2CZ
        XET20LH2QhC5A6lG0FmChks=
X-Google-Smtp-Source: ACJfBosZrjr60A6xk4baclrEPzIMx0Dd6vrB477CHjc8qHM7iQt/pXtFo2zvlTCbXHlCXoJ0uGOeUQ==
X-Received: by 10.28.70.196 with SMTP id t187mr8248295wma.129.1516048843625;
        Mon, 15 Jan 2018 12:40:43 -0800 (PST)
Received: from localhost (cpc73832-dals21-2-0-cust969.20-2.cable.virginm.net. [81.110.231.202])
        by smtp.gmail.com with ESMTPSA id o107sm596629wrc.63.2018.01.15.12.40.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jan 2018 12:40:42 -0800 (PST)
Date:   Mon, 15 Jan 2018 20:43:01 +0000
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     randall.s.becker@rogers.com
Cc:     git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH] Removed unnecessary void* from hashmap.h that caused
 compile warnings
Message-ID: <20180115204301.GL2641@hank>
References: <20180114180748.14584-1-randall.s.becker@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180114180748.14584-1-randall.s.becker@rogers.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your patch!  A few nitpicks below:

> Subject: [PATCH] Removed unnecessary void* from hashmap.h that caused compile warnings

From Documentation/SubmittingPatches:

    Describe your changes in imperative mood, e.g. "make xyzzy do frotz"
    instead of "[This patch] makes xyzzy do frotz" or "[I] changed xyzzy
    to do frotz", as if you are giving orders to the codebase to change
    its behavior.

I liked the subject Philip suggested in the other thread: "hashmap.h:
remove unnecessary void*", or maybe "hashmap.h: remove unnecessary
variable".

On 01/14, randall.s.becker@rogers.com wrote:
> From: "Randall S. Becker" <rsbecker@nexbridge.com>
> 
> * hashmap.h: Revised the while loop in the hashmap_enable_item_counting
> 	to remove unneeded void* item.

As above, this should be described in an imperative mood, and describe
why this is a good change and should be merged.  Maybe something along
the lines of the below?

    In 'hashmap_enable_item_counting()', item is assigned but never
    used.  This causes a warning on HP NonStop.  As the variable is
    never used, fix this by just removing it.

> Signed-off-by: Randall S. Becker <rsbecker@nexbridge.com>
> ---
>  hashmap.h | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hashmap.h b/hashmap.h
> index 7ce79f3..d375d9c 100644
> --- a/hashmap.h
> +++ b/hashmap.h
> @@ -400,7 +400,6 @@ static inline void hashmap_disable_item_counting(struct hashmap *map)
>   */
>  static inline void hashmap_enable_item_counting(struct hashmap *map)
>  {
> -	void *item;
>  	unsigned int n = 0;
>  	struct hashmap_iter iter;
>  
> @@ -408,7 +407,7 @@ static inline void hashmap_enable_item_counting(struct hashmap *map)
>  		return;
>  
>  	hashmap_iter_init(map, &iter);
> -	while ((item = hashmap_iter_next(&iter)))
> +	while (hashmap_iter_next(&iter))
>  		n++;
>  
>  	map->do_count_items = 1;
> -- 
> 2.8.5.23.g6fa7ec3
> 
