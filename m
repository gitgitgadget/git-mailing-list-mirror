Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 060AF202A0
	for <e@80x24.org>; Tue, 24 Oct 2017 01:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751278AbdJXBSH (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Oct 2017 21:18:07 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:47101 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbdJXBSG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Oct 2017 21:18:06 -0400
Received: by mail-it0-f51.google.com with SMTP id f187so8134276itb.1
        for <git@vger.kernel.org>; Mon, 23 Oct 2017 18:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t7EBn4JHIntA/aIPb2jaACBXdX0LDg+DRyQyAfCVZfc=;
        b=V7OYhGtTo+kxH40jLBuKEb2qI+ajezruyfcWgJI/DyQqgwOR7nj8W/8USUA3tmMrte
         R1NbG4M7MjzUmf5mnQxCc5948jFKn02iZ5cmZ5iEgQqN6JS0BcOji3qgscZv7RGIOZJj
         iK0sEoD9bLacCp5VyTXURU63DUNVEHPdOBWKhbSsxdNmBwHM+GFt3dPwj57wE1C/zQma
         zayJSskl/GUTHGMzwQHWbC7oxb7JVlkjNM69+IaRFW8TtvD7IGYHL/6xtkvoAeLVTBLY
         Hn7Jniy9HfVh5Sk1fiv82ffj+WeQIs/jFSWeEj8SLeAkuuL4aTCfsQw6D2j7kOhl4VNZ
         +7eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t7EBn4JHIntA/aIPb2jaACBXdX0LDg+DRyQyAfCVZfc=;
        b=bHqU3xnGSYn/IsdBTbA4PVkURI+XlEXpqDJQqT5m1LtQVYRaoDVxKTzjo4ZWe9oTV4
         /h08VnCDHUVl2hauZeS1nm3lTphroc3/b2oajp3L3boxcC8KNMXdbsU8obOtzdmyMvU2
         6QGsHaCKT5xQ7fv+E3MMD4Yih9VSRZLpoAgEh3ee82OpJTUtQ1ofa17sXonJN2QWqeTg
         HHhK68Jcpz7ca7WbYwdOBcLb8sv5tsxUjlZ0oIU1qumHkqEOmyRb5wZB1VmtMyBhi+JP
         P+vPcvjtGJmwiwbFXQ5nh5XfoEO2ou0EvTlieXRVSUoGVxE6PMoClGq71Lju94hGjx42
         7VNQ==
X-Gm-Message-State: AMCzsaVl7Ooy2gZRjYgZVUCACtHO/LvD1Jy7kowc2foflawGlEMHZDBr
        blJCU5Dz5mhpINaT/yy0lwA=
X-Google-Smtp-Source: ABhQp+T3DpbIW6rU/IVGQHab/wW9XAuE+giB78W8XXwuEYwuYM4BbofqAGs01ege+M3U6Pnq5YdAUg==
X-Received: by 10.36.73.99 with SMTP id z96mr11780450ita.36.1508807886036;
        Mon, 23 Oct 2017 18:18:06 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id l65sm160329itb.6.2017.10.23.18.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Oct 2017 18:18:05 -0700 (PDT)
Date:   Mon, 23 Oct 2017 18:18:03 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Kevin Daudt <me@ikke.info>, git@vger.kernel.org,
        Rafael =?iso-8859-1?Q?Ascens=E3o?= <rafa.almas@gmail.com>,
        Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] column: show auto columns when pager is active
Message-ID: <20171024011803.tgigclx2swfg744r@aiede.mtv.corp.google.com>
References: <20171011172310.2932-1-me@ikke.info>
 <20171016183511.12528-1-me@ikke.info>
 <20171023215246.r3xevx5jey5pyuuz@aiede.mtv.corp.google.com>
 <xmqqy3o19wp5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy3o19wp5.fsf@gitster.mtv.corp.google.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:

> Subject: column: do not include pager.c
>
> Everything this file needs from the pager API (e.g. term_columns(),
> pager_in_use()) is already declared in the header file it includes.
>
> Noticed-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  column.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

> --- a/column.c
> +++ b/column.c
> @@ -5,7 +5,6 @@
>  #include "parse-options.h"
>  #include "run-command.h"
>  #include "utf8.h"
> -#include "pager.c"
>  
>  #define XY2LINEAR(d, x, y) (COL_LAYOUT((d)->colopts) == COL_COLUMN ? \
>  			    (x) * (d)->rows + (y) : \
