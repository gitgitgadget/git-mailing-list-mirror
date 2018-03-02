Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 499371F404
	for <e@80x24.org>; Fri,  2 Mar 2018 03:59:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164043AbeCBD7P (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 22:59:15 -0500
Received: from mail-pl0-f65.google.com ([209.85.160.65]:42142 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163935AbeCBD7O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 22:59:14 -0500
Received: by mail-pl0-f65.google.com with SMTP id 93-v6so4934522plc.9
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 19:59:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iRUvhfFarjYbJSP/wzn/eyzMc8v7eSkaTzYAYMh+SRg=;
        b=NKK0J6Rskbf9lQEnBVXrrdCma5DxLdPT6zBgH5Z9MFih8eG3RZhbg0lLDBszsPsL3m
         NzonMf/Ab1pczG5AD985vNd32Lcy5nEa2lWjMN51q7hadqG+CuLCKe1V49n1/xAxnTSS
         1KTLtN2rHeBFjk3IaGkA72ezyic7d6QjpR76iwXkjqdY95e0mepZsn3BJRpuDSVQKlhu
         6Lazw0c6TF40mS4SqHrD8+trlKuV+EMCkKmI6fVCvgxAssGbWkJ7e34JkDI/u5K6Pfl9
         po+49Yd71LAuYvvVEGkgTqhG/wHXdZXMoh5gjg4tTitJQe13Vnjye20ZWm+fOdHpsff1
         0a0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iRUvhfFarjYbJSP/wzn/eyzMc8v7eSkaTzYAYMh+SRg=;
        b=E5wb6rkXuCBaHSA/eooFmI2MjiJA+R7ZViKqxD4NlXf4icvLR8wpepRYnnj0gXTsfl
         EoHXhylwuAVwmQzrTM5ZMCsdh40KdvXOQGLwU3vuUsOLE5EKjeSETavVPKJQZMJ5yYOn
         cnnV3Zu9xrWs0zBFt6tJDEPc40kx18UqAKSEVUWUUVxG0pheaZpBoc6HhYEPXEO3xA6S
         rAF7PJZstuwAT7XYouqlyZ5N1cLgsB4AfKTg1/yj0ll7qz2pO52mlWDnAdRKbIVOdrW6
         FgOZ2lpaYusAXbDBP7I/D3KB4cSoEVo3Yi2cOJZk5M0YLtJFtqIYZXMGvlI3/mJOrXDW
         wOjg==
X-Gm-Message-State: APf1xPBIuAC9eF1/yM1ZUtZgnDR6AuTusDdNYK5dYF8wiR4I0+yllZTG
        EGRVVqtPEUL91XO7RnyELKU=
X-Google-Smtp-Source: AG47ELuvmVA5EaDq3paL1KedK0DH6p8FaoqLf0mDAzQdL7WrtKi4b0yIiNstQVnCt7xZhuSFAmo6TQ==
X-Received: by 2002:a17:902:6b82:: with SMTP id p2-v6mr3641367plk.326.1519963153490;
        Thu, 01 Mar 2018 19:59:13 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id f82sm12644893pfd.175.2018.03.01.19.59.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Mar 2018 19:59:12 -0800 (PST)
Date:   Thu, 1 Mar 2018 19:59:04 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        ungureanupaulsebastian@gmail.com,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH 1/2] ref-filter: mark a file-local symbol as static
Message-ID: <20180302035904.GA238112@aiede.svl.corp.google.com>
References: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d28d866-535c-6d37-4cb9-5decedab3acb@ramsayjones.plus.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Ramsay Jones wrote:

> Commit fcfba37337 ('ref-filter: make "--contains <id>" less chatty if
> <id> is invalid', 2018-02-23) added the add_str_to_commit_list()
> function, which causes sparse to issue a "... not declared. Should it
> be static?" warning for that symbol.

Thanks for catching it!

> In order to suppress the warning, mark that function as static.

Isn't this closer to

	Indeed, the function is only used in this one compilation
	unit. Mark it static.

?  In other words, sparse's warning is accurate, and this is not about
trying to quiet a false positive but about addressing a true positive.

> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>  ref-filter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Jonathan
