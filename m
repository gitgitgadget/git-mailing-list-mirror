Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69CFA203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 20:54:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932672AbdGXUyc (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 16:54:32 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:33615 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932668AbdGXUya (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 16:54:30 -0400
Received: by mail-pg0-f48.google.com with SMTP id g14so13097389pgu.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2017 13:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WcMiz8BG0QXxCZZ2k5lhY0IAl+7OMKb4lJh6ZSgzUak=;
        b=NSShlyiXY+rTzcTDsVLrLpUFPdTWGSPS0Sie8hOGy1fuwVRZ5mJYEGmy7IGQVx5Ir5
         6iztWz5G01uLef7ORW070Xm09hzWMoWLrgmx8kbv2I6DNBjA/pLZcHI4fEmNMt3dYxMC
         cS2/bsQEtLSD+Zc+Esg2D0fFisXj4N9cjwSx0svHZ2P03ZTsMZKv9xR2AGdtQNgMwJeZ
         Zq3xUHq+ILazFtxnj/pMOzz0sENx37U9fdDWzEKA60h4DolrJkQHCkvB7V+8aG4L1UyI
         vBKfpgAPljLIR1Uj++B/ssSn/52LPCTwAGgj8F9gMfJLQEaipgYYJ0j7tLuVk3PX6Jbk
         s51A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WcMiz8BG0QXxCZZ2k5lhY0IAl+7OMKb4lJh6ZSgzUak=;
        b=JiOIYq1lbvmj3uLC3DHl6urslqyHJh110KwY5OaD0/iYveN/W/aRVObPO2Amqahgxe
         3icercJl/byOTisyjBPLLuIvRBZ3vhdHdkvslF3AXoM7vDhfdoi8uZ3CuAkzZNmYsBt2
         dm5rtIh5e/XXy58HVM9/xtGK5MsCEtIaUXhPPJubV8WrTFEfewqvdT6o99ESaxVgazIv
         0Hq4fVuiwjvPJt14LpP8kycDMB/bjcbAOcB3b5K/enojk8TqcCbp4b4SDpvJXMkQzdIN
         JfM6OxqOR2tDasPRvGXBSovmCu+2JHbxHscTYhyM4cdK7Z3SArwluCmHLusdsxGbL73d
         f9PA==
X-Gm-Message-State: AIVw112YShvxEHGXeTIpqieIapvykd5kvbYWEd8A9/8IT4A8SIB9cmRS
        +A4kxpFPmjPu70jB
X-Received: by 10.84.209.132 with SMTP id y4mr13813348plh.460.1500929669717;
        Mon, 24 Jul 2017 13:54:29 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c4bc:947:66f8:1cfe])
        by smtp.gmail.com with ESMTPSA id s9sm25680200pfe.67.2017.07.24.13.54.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Jul 2017 13:54:28 -0700 (PDT)
Date:   Mon, 24 Jul 2017 13:54:27 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Prathamesh Chavan <pc44800@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, christian.couder@gmail.com
Subject: Re: [GSoC][PATCH 03/13] submodule: port set_name_rev() from shell to
 C
Message-ID: <20170724205427.GA92874@google.com>
References: <20170724203454.13947-1-pc44800@gmail.com>
 <20170724203454.13947-4-pc44800@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170724203454.13947-4-pc44800@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/25, Prathamesh Chavan wrote:
> +static int print_name_rev(int argc, const char **argv, const char *prefix)
> +{
> +	char *namerev;
> +	if (argc != 3)
> +		die("print-name-rev only accepts two arguments: <path> <sha1>");
> +
> +	namerev = get_name_rev(argv[1], argv[2]);
> +	if (namerev && namerev[0])
> +		printf(" (%s)", namerev);
> +	printf("\n");
> +

'namerev' needs to be freed at the end of this function.

> +	return 0;
> +}
> +

-- 
Brandon Williams
