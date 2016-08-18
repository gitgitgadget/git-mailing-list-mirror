Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9021C1F859
	for <e@80x24.org>; Thu, 18 Aug 2016 07:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752937AbcHRHPt (ORCPT <rfc822;e@80x24.org>);
	Thu, 18 Aug 2016 03:15:49 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:35752 "EHLO
	mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbcHRHPs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2016 03:15:48 -0400
Received: by mail-ua0-f194.google.com with SMTP id 109so2104566uat.2
        for <git@vger.kernel.org>; Thu, 18 Aug 2016 00:15:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Yg9116IP7XaB0tTnbfwd8hJHotlDvxElWlEdtJv9iE=;
        b=GQEttYR+XSgL28quM4tLcvX1DxRZ4gp1OnL6MV2ATITFYunaaLAybcyT0trXmCby1G
         14Mg41JUCsBwIsD9gbDaAZA17KzRD8RsXFnBbVEr2nnues+jZ/PnzTwsYcQc9GlySrou
         vFzaH18LuNlsA6T92vpsxvgtCg0UT0duam5NnBBJmeEk8PwRGqX8XLMxMbmwe8ZjkRCc
         tEqLI5r+Kz+f+tsPninJ0G1SA02tZH1qwiOcJuBiKxpQbQaJcEzUG0VfaZ4IvBs/T7Yo
         UpPhp/Ju9wFmrnf9uWX/h228S4NQPtx7fg4Cc9v08ll/IZG0LpzIpMBEjY+gJYLo9Lu8
         P0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Yg9116IP7XaB0tTnbfwd8hJHotlDvxElWlEdtJv9iE=;
        b=UCvGRuyaQPczSJB/adICUDVvOwYK7/vJtF9rTh2zP1tZLOebM0ZUILvXWMvT2noZeo
         yiTX10TvgV+Y1hiJlbGMnS2qIARvz+rtWfCfgoDqlghA3aMjrirAiMeCYYLc5PnFWGwX
         1049YyHGNXC7uq4byzhf2el/74bSsW8/2ps+doNcEriZbK6G3DeojRSOVbXbcZvNmrFF
         g5ePiqCHRRTFTJ19sFDdyhOPi9gl647mREVv9GssknJRw6ApPF95GRs7WTPVtJKqjBe4
         Yxm7Jt2hlMq+cc879ywUMFmPwNXEGQHawojRXO2K9piL9PaA4zKPZIAqYcFGNOtqbUzn
         PldQ==
X-Gm-Message-State: AEkoouvRQP2FRGEAbXsZhldthckbbAIDHV2e5nrC8RRILr+Kvkb6D8jTapymKGzNkWYXTA==
X-Received: by 10.31.125.67 with SMTP id y64mr290917vkc.55.1471503630080;
        Thu, 18 Aug 2016 00:00:30 -0700 (PDT)
Received: from gmail.com ([2800:370:4a:fb70::5])
        by smtp.gmail.com with ESMTPSA id j20sm116639vkd.16.2016.08.18.00.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Aug 2016 00:00:28 -0700 (PDT)
Date:	Thu, 18 Aug 2016 00:00:23 -0700
From:	David Aguilar <davvid@gmail.com>
To:	Jacob Keller <jacob.e.keller@intel.com>
Cc:	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <stefanbeller@gmail.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v7 6/7] submodule: refactor show_submodule_summary with
 helper function
Message-ID: <20160818070023.GA30666@gmail.com>
References: <20160818005131.31600-1-jacob.e.keller@intel.com>
 <20160818005131.31600-7-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160818005131.31600-7-jacob.e.keller@intel.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 17, 2016 at 05:51:30PM -0700, Jacob Keller wrote:
> [snip]
> @@ -333,31 +326,23 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
>  	strbuf_release(&sb);
>  }
>  
> -void show_submodule_summary(FILE *f, const char *path,
> +/* Helper function to display the submodule header line prior to the full
> + * summary output. If it can locate the submodule objects directory it will
> + * attempt to lookup both the left and right commits and put them into the
> + * left and right pointers.
> + */
> +static void show_submodule_header(FILE *f, const char *path,
>  		const char *line_prefix,
>  		unsigned char one[20], unsigned char two[20],
>  		unsigned dirty_submodule, const char *meta,
> -		const char *del, const char *add, const char *reset)
> +		const char *reset,
> +		struct commit **left, struct commit **right)


Note the pre-existing unsigned char[20]s in the signature above...


> [snip]
> @@ -381,14 +401,39 @@ void show_submodule_summary(FILE *f, const char *path,
>  		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
>  	fwrite(sb.buf, sb.len, 1, f);
>  
> -	if (!message) /* only NULL if we succeeded in setting up the walk */
> -		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
> +	strbuf_release(&sb);
> +}
> +
> +void show_submodule_summary(FILE *f, const char *path,
> +		const char *line_prefix,
> +		unsigned char one[20], unsigned char two[20],
> +		unsigned dirty_submodule, const char *meta,
> +		const char *del, const char *add, const char *reset)


... and here too.

There's an ongoing effort to replace unsigned char sha1[20]
with struct object_id.  It might make sense to pass "one" and
"two" as "unsigned char*" instead of hard-coding the SHA1-length
here.  Alternatively, we could pass in the struct object_id*
instead.

The [20] in the show_submodule_header() function above is
pre-existing and not added by this patch, but that function's
signature is touched by this patch so it might make sense to
tidy that up while we're in here, possibly as a separate patch.
-- 
David
