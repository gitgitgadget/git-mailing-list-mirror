Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0B00D1F406
	for <e@80x24.org>; Wed, 16 May 2018 21:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeEPVmy (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 May 2018 17:42:54 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:39709 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbeEPVmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 May 2018 17:42:54 -0400
Received: by mail-pg0-f66.google.com with SMTP id e1-v6so850955pga.6
        for <git@vger.kernel.org>; Wed, 16 May 2018 14:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gCE7yLyyXvVKISUUzPQLuHKsb9eixQezdvYrVnH+rKQ=;
        b=oPSVI0wVuQUeaidcZ0F1skjK74iCGvKE+Xq4a27S08V9Qaa15iqiCuFKum8L1RlWpK
         ZESIVHwlAuISKwY6rwleoVWKLAqbY9p3gREtVM7d77oZKgDb3U7uOCH5/LdvvtZEz48B
         sP8e759AznH0btCIwi+wsv3nvFwb08AT8K2pn1UuRoxeJo/WV4ejqbxzehHK7RtcvA77
         FzVL72Ms1XH2EuhrlNljONahuqkSAqdYYFb3nX72hrP3kpaEH3bfBCEsvcKU4b27nxsb
         dE7Ht5LXXtHHLrXo2mIMdZoWz71rKTRXQShEfs+rrxeR6QLCHkff/pI8DVVN6Uez66pr
         vd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gCE7yLyyXvVKISUUzPQLuHKsb9eixQezdvYrVnH+rKQ=;
        b=X4iSyMblFYJONSXvYSLn1YibFq3hNRjJ7e3J3ltbzkU4CFa7T0oY11mwo5k9jYf4A/
         nqck9AJCSJihMf/ThHksLQ+YACTOTLvZlrtvhxO/nBcmLgbYLPYykMt6RdqyYvTsjOy/
         v6jUX4kOs4ucdQk846ZHodqX18TlRRsACTj0cz1fPLinFmaCj5eWzPfb4jmV1WtYU9gM
         35MFthv+kkvouAB37FNImFTabLJ3m9KNVoWscwjyLSuv7a5v77+kjvQPoyQ5SS0wXxc6
         y8cOFbN7ROWgDrGloVkJO/LFz2tE5NkUdPRXI8EqrqPCGb/lN3IyCRrhVDyEoD37y3pp
         bxQw==
X-Gm-Message-State: ALKqPwf4fXWQ4FBlT7JIzn5j8P0DwxVxDi15bPx+uMnA1oNUA+bnepNQ
        718cQRptz7bJheG7EuowE8LKKA==
X-Google-Smtp-Source: AB8JxZrjAhF3e8TNemlIwdrxb1SHhZ59nF8bTTj0Ie2oCH2V2FmKM+9bzy2y9nOMBN+WLj4lpvgV0g==
X-Received: by 2002:a62:4544:: with SMTP id s65-v6mr2647986pfa.150.1526506973162;
        Wed, 16 May 2018 14:42:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id 4-v6sm6693346pfn.38.2018.05.16.14.42.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 May 2018 14:42:52 -0700 (PDT)
Date:   Wed, 16 May 2018 14:42:51 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] refspec.h: reinstate 'extern' to fix sparse warning
Message-ID: <20180516214251.GA60301@google.com>
References: <29f60a43-9c95-512a-ef85-558906a08ed0@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <29f60a43-9c95-512a-ef85-558906a08ed0@ramsayjones.plus.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/16, Ramsay Jones wrote:
> 
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
> 
> Hi Brandon,
> 
> If you need to re-roll your 'bw/refspec-api' branch, could you please
> squash this, or the equivalent change before the 'struct refname' to
> 'struct refname_item' name change, into the relevant patch. (which
> would be patch #1, commit 8999381ed).
> 
> This patch was built on top of 'pu', but as I said above, patch #1
> is where the original 'extern' keyword was dropped. (see first hunk
> of the diff to 'remote.h').

Of course I'll do that, I'm planning on sending out a v2 by the end of
the day and I'll incorporate that.

Though now I'm confused, I thought we were going towards eliminating
using the extern keyword? ...of course I guess it means something
_slightly_ different when using with a variable vs a function :)

> 
> Thanks!
> 
> ATB,
> Ramsay Jones
> 
>  refspec.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/refspec.h b/refspec.h
> index 374f8ea63..7e1ff94ac 100644
> --- a/refspec.h
> +++ b/refspec.h
> @@ -2,7 +2,7 @@
>  #define REFSPEC_H
>  
>  #define TAG_REFSPEC "refs/tags/*:refs/tags/*"
> -const struct refspec_item *tag_refspec;
> +extern const struct refspec_item *tag_refspec;
>  
>  struct refspec_item {
>  	unsigned force : 1;
> -- 
> 2.17.0

-- 
Brandon Williams
