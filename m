Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB16A1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753987AbeFVQvV (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 12:51:21 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:42316 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751377AbeFVQvU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 12:51:20 -0400
Received: by mail-pl0-f68.google.com with SMTP id w17-v6so3749545pll.9
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 09:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9WaSSPQAwtYwGjmZP2chFl7ZO9ZXkWy0D9JMLQn8P5A=;
        b=hoULxR2VPT6WmjNHs/iu/PkK5a0fk/0TgQtuUGDBlUj8M3tYlzLAO74P3ZDbCWd0GA
         /mo2oXESbnAhLZMw7wL/Yaiy/V1U0izWpk5d5qrAv5xBORSnr2L29oMu86QoZZboehAw
         6JhsF4QeEWcEvyr7H+yZe1FwYhE/ncimCcgnGmgkWjuABmAR2thUSCZ1lLEf1PsxbNHt
         Lql1Sz0XyZK2HS56PWOIytlV4IylpugbVMmY83si2HXykPaEku/kx/cxyGPhwkfIODgD
         H5Shwu10VcgouxJQWT3u2tFmORftLDisp8hCIQaB07JRPxuBAbqWOWtCLZrJi4xAgvoT
         YjVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9WaSSPQAwtYwGjmZP2chFl7ZO9ZXkWy0D9JMLQn8P5A=;
        b=BXCotK+IHwWwpJtxEh+z6q9rs5VchOtPefE63vfESdTg4RYOhrWLjgmv6vGl9oseLc
         2wvlG6kDKSdJSakHKYrTeyuXMEO2D78Bt4mbSQI3kPjfe44hMMJ4QouxXXFx+mSI9ef7
         4+wGkDeBoayUnKvSrZOdJ/wNv0/WJ2n/w5bm9nlpHeXuSc871JAB4Ad2EVXl0isuyVMu
         GvakZ/G7nWHZ07BhK55BOUzbAyX2jNzzBH8E47dXY3FTqlC8Z70UM7NUOSYHjn8sPfh2
         h+3w2583wIwrzJcwC0Z87H1eA8cXx8QOR8GIYSjzShN9arHZ4jsZ3+dmbqeUboJ50ns3
         jjnA==
X-Gm-Message-State: APt69E3j3Ss5zGGgskUSCiSucWCicvxXMCpGeZTEXOgfMkYn3BojMJR2
        ptxmaAeCi92oO/2pOX/5KhMIJg==
X-Google-Smtp-Source: ADUXVKKhwqZ5+cVXzQxQ/TFx8x9IgTLqlJfvM0o15VoBgC70YnFSM2cQfRZ5obTIqlP02bTcZhcfwQ==
X-Received: by 2002:a17:902:246a:: with SMTP id m39-v6mr2493939plg.141.1529686279434;
        Fri, 22 Jun 2018 09:51:19 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id u2-v6sm16242309pfk.3.2018.06.22.09.51.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jun 2018 09:51:18 -0700 (PDT)
Date:   Fri, 22 Jun 2018 09:51:17 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Antonio Ospite <ao2@ao2.it>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/7] submodule-config: add helper to get 'update-clone'
 config from .gitmodules
Message-ID: <20180622165117.GB244185@google.com>
References: <20180622162656.19338-1-ao2@ao2.it>
 <20180622162656.19338-4-ao2@ao2.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180622162656.19338-4-ao2@ao2.it>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/22, Antonio Ospite wrote:
> Add a helper function to make it clearer that retrieving 'update-clone'
> configuration from the .gitmodules file is a special case supported
> solely for backward compatibility purposes.
> 
> This change removes one direct use of 'config_from_gitmodules' for
> options not strictly related to submodules: "submodule.fetchobjs" does

s/fetchobjs/fetchjobs


-- 
Brandon Williams
