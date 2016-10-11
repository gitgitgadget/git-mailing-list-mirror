Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BFC91F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 18:24:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753925AbcJKSXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 14:23:54 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36315 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753916AbcJKSXx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 14:23:53 -0400
Received: by mail-pf0-f169.google.com with SMTP id e6so5769312pfk.3
        for <git@vger.kernel.org>; Tue, 11 Oct 2016 11:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z6edd0N2Q3ZcWJOmJoGI/eZ5wSVbQuQiNw+EVIHashQ=;
        b=ogkj+9eT72MLOvGSgGgWwLGZykSt4DRgYMdSdnr5gjeiZQ1cSmvgbQ0i3f0z12sifV
         bb45bbR8I+M44JhLoTg1DaDYA/Qzwrga1RNT4KKsTXHu9AAFHQScIvPCQQc5Mfz3wCR1
         dZ0PP2JoAxTCf9uI+y0YGIyfrCZzDnqExd2kW/GBrmQksPKjzYgEihphCTqklQo0/9yc
         CvpRYBJb8rTlJuFJQ8EnoPNwmmpfw80TQC6t3NbAtMi043An10OD3GHFBgMBZRgN6Nqi
         G2c2jpcCom7b3VFk78SndQxCH4u8456MLv0kr4bXEQoDRB7zdnQLNZGOptJgyhoRAk++
         LFKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z6edd0N2Q3ZcWJOmJoGI/eZ5wSVbQuQiNw+EVIHashQ=;
        b=d5IlkPhRTFOglj4u26pIzhZGEnzI4bRQGgz/T0VciVllF78Y4Cd0blvyde/HsZIqO5
         vFXwSxf+hu+xS7sFZw3/Ul1wIoxpRuvwNIlbIQk26YixDI5va/5Yc3tdjbT6LAdTMWDd
         9ggEk5zO3xKUImgBJHrYJyb5zHNohmRkWh/j8lNoqvxIPRY95OZ/PcH9LhQhGHfUxWUk
         pbOMb/W7csM950gcSsD7OT7ysy1szNd3sLrA4R5Rumig1hkKBhFDtagUwhp9iCD9oeFN
         xF61hrN7uWqtymAezGS4lFUHsHEwJfgMd2Y1iBsgMn0dgZMzwQzQj1IHuAHnNeBRDrER
         sHiQ==
X-Gm-Message-State: AA6/9Rl0p5mE+tbE67886idh/tkABkzMglR/cywCv1t29sdEtOlRI6079ZptpvU5o9h2MIi5
X-Received: by 10.99.109.196 with SMTP id i187mr2692750pgc.164.1476206887427;
        Tue, 11 Oct 2016 10:28:07 -0700 (PDT)
Received: from google.com ([2620:0:1000:5e00:19ef:1eb0:a061:def1])
        by smtp.gmail.com with ESMTPSA id id6sm5693502pad.28.2016.10.11.10.28.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Oct 2016 10:28:06 -0700 (PDT)
Date:   Tue, 11 Oct 2016 10:28:05 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     gitster@pobox.com, git@vger.kernel.org, pclouds@gmail.com
Subject: Re: [PATCH 17/28] attr: expose validity check for attribute names
Message-ID: <20161011172805.GB9085@google.com>
References: <20161011002115.23312-1-sbeller@google.com>
 <20161011002115.23312-18-sbeller@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161011002115.23312-18-sbeller@google.com>
User-Agent: Mutt/1.7.0 (2016-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Stefan Beller wrote:
> From: Junio C Hamano <gitster@pobox.com>
> -static int invalid_attr_name(const char *name, int namelen)
> +int attr_name_valid(const char *name, size_t namelen)
>  {
>  	/*
>  	 * Attribute name cannot begin with '-' and must consist of
>  	 * characters from [-A-Za-z0-9_.].
>  	 */
>  	if (namelen <= 0 || *name == '-')
> -		return -1;
> +		return 0;
>  	while (namelen--) {
>  		char ch = *name++;
>  		if (! (ch == '-' || ch == '.' || ch == '_' ||
>  		       ('0' <= ch && ch <= '9') ||
>  		       ('a' <= ch && ch <= 'z') ||
>  		       ('A' <= ch && ch <= 'Z')) )
> -			return -1;
> +			return 0;
>  	}
> -	return 0;
> +	return -1;
> +}

Whats the reason behind returning -1 for a valid attr name vs 1?

-- 
Brandon Williams
