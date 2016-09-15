Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4294B2070F
	for <e@80x24.org>; Thu, 15 Sep 2016 18:48:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752666AbcIOSsy (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 14:48:54 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35441 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751098AbcIOSsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 14:48:52 -0400
Received: by mail-wm0-f68.google.com with SMTP id 133so4870321wmq.2
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 11:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=59Nz13qkzWFPa4FmiCNc4jZffhdx11lBopo766vPU4E=;
        b=S2OJgMMz4IGgXFP3/JepLdOhF4tG3sh4oKlzTEOEzYtASoxnkV8uWrd5CA/ZjxmYm/
         obEamnNg3EkRTuA3qflLtJmo8IVhJkjuIoNQiyFVAfcT6iTzeSWdkPFrm0OQPdTO3LXb
         ZLdVEtnxkosz6wNhRInphV66IILM+c8JNjR27uvSTNDZ2SaBKuFTAvD+MqRNx+0ZqHv9
         67r5Zdv9Fu10wVZGiuevgGHcX06ajphhm3LVmlZ13mECXW9PTnajsgmQntY/am/z8b5k
         L5rsaj7E6AJjONHCpofc+AtBbMjXzSoVKbS0FD0H6YyKILEDon2hVV/kHrJJsI6edAXz
         mdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=59Nz13qkzWFPa4FmiCNc4jZffhdx11lBopo766vPU4E=;
        b=M3VFcJo3L1jhu25ZGd/u5ZqQLSsbnLaEKrX6AeQKDpNHxS0AWY1nCLyPAdW0gIeMau
         WdAH1tQgItW66jRKMiyZvpNfVS4qUhkt397HL5PJTy7mFjTkbz8Xt/wg6J0raD3RNzsa
         SPtWD8EfbwUxpTwipiWBDiFYErnXjN0cQKuZtmqXIzFbp+Het8MV7tsuBmHDfqIwoVOq
         2ehitsCW3NnPJspGZ3M0qPiHhcA6Sx03/1zV6VjcMXFPeHagtd2Vy33qwAUPyQzLVmY6
         lxDuJDbN5IQqlcNtv5NaNCBph0JQiDU2e2qpiTlipqOSVqBrzpC8pUKhSXpCPkzJarCE
         sQag==
X-Gm-Message-State: AE9vXwPP3l7Eo79MxaTBHQXGybBXcdGisRbwhiBG88Lu0HAgDt/+mF9MEXzw7lMegMDvGA==
X-Received: by 10.194.98.205 with SMTP id ek13mr6082089wjb.158.1473965331103;
        Thu, 15 Sep 2016 11:48:51 -0700 (PDT)
Received: from localhost ([2a02:c7f:c42b:f900:5e51:4fff:fee9:57af])
        by smtp.gmail.com with ESMTPSA id w129sm3675743wmd.9.2016.09.15.11.48.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Sep 2016 11:48:49 -0700 (PDT)
Date:   Thu, 15 Sep 2016 19:49:06 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jan Keromnes <janx@linux.com>,
        Ingo =?iso-8859-1?Q?Br=FCckl?= <ib@wupperonline.de>,
        Edward Thomson <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 3/4] read-cache: introduce chmod_index_entry
Message-ID: <20160915184906.GE8254@hank>
References: <20160912210818.26282-1-t.gummerer@gmail.com>
 <20160914210747.15485-1-t.gummerer@gmail.com>
 <20160914210747.15485-4-t.gummerer@gmail.com>
 <xmqqbmzqqhm7.fsf@gitster.mtv.corp.google.com>
 <xmqqsht2ozwx.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsht2ozwx.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/14, Junio C Hamano wrote:
> I've queued this trivial SQUASH??? on top, which I think should be
> squashed into 3/4.

Yeah, I missed this.  The SQUASH??? definitely makes sense, would be
great if you could just squash that in.

> Thanks.

Thanks the reviews and helping me getting the series in a good shape!

> 
> 
>  read-cache.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/read-cache.c b/read-cache.c
> index 2445e30..c2b2e97 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -779,7 +779,7 @@ int chmod_index_entry(struct index_state *istate, struct cache_entry *ce,
>  	default:
>  		return -2;
>  	}
> -	cache_tree_invalidate_path(&the_index, ce->name);
> +	cache_tree_invalidate_path(istate, ce->name);
>  	ce->ce_flags |= CE_UPDATE_IN_BASE;
>  	istate->cache_changed |= CE_ENTRY_CHANGED;
>  
> -- 
> 2.10.0-458-g8cce42d
> 

-- 
Thomas
