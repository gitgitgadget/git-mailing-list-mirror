Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DAD77207F8
	for <e@80x24.org>; Wed,  3 May 2017 19:47:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932195AbdECTrN (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 May 2017 15:47:13 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36479 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932125AbdECTrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2017 15:47:12 -0400
Received: by mail-pg0-f52.google.com with SMTP id t7so83312079pgt.3
        for <git@vger.kernel.org>; Wed, 03 May 2017 12:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=T204H3JF2ATp+1S9x/2bRRhXhfZkqoyJndob5UGJo5g=;
        b=lej5zPgjulJzDDMuDShdFuubxmk61OBP48dxyU+2Ni9pl8zuQf2z/S1vJQtqiSdJ8+
         ANBfHxom5dhh0gt2u4RiNhC0omBFOoOwSTjsjZOcTAqOrIhQeWs/RYWsmpxQAN1IZCLS
         8LYvrE7vVjn8N6esVWubEZd67+XN8uijC8/8f8D7GVEMqQysL+BUfj4fLOZCPQmYNKCP
         z/G/Q50c3sHsNC0CdIpiv8DvjQcsEYEb1JPhKewIAyKF1sIMr5z2w0xim9Fdou/KVMSP
         ySG+/8bw2eHzW1CmPtV5ZbzgiHmMFQb+GOrsr2c2Q++jCV5QQGg6v7D0of0s6MfnwYZz
         7gyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=T204H3JF2ATp+1S9x/2bRRhXhfZkqoyJndob5UGJo5g=;
        b=VwExYIJaZTnQHEduQ9h3RAlY2JkzvX8aU8Gj+0iFtn2/C59vXLzizyVHBVGkIqHP7f
         7BL93rcbveEtC3zjnnapkH3f8T5+hqc4L+I/uqzYM3QB3O/qSN4shZ6Y6hrcx8DYDVCY
         TOFvPHtZhoHGtAeMHwQXHlQ8/Sbo7ZBxRWRrnK64dnd1qgSiHJ+kUR9vl9EtT5KLWXwT
         rgT8i6bMY0qll/6YP1wEEbdTQE0q8yyXK0LUvnY3T5frokL4mS6zlXEa3IEXQCKuvqKi
         /8qK2PPqBOFIE07HUO6zK8sNeff8d9/MWcX9Ek+3moeFzZWHk/MehrDnH1Ne56vxeryG
         liJg==
X-Gm-Message-State: AN3rC/5XACks22k7m2ImvAgmXtq5Gi/ELXmIHX2ZakdD50VUWDgGWhfR
        fi1u9atIhQOO5A==
X-Received: by 10.98.141.16 with SMTP id z16mr6852812pfd.91.1493840831415;
        Wed, 03 May 2017 12:47:11 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:8ce6:bd0b:35b6:826c])
        by smtp.gmail.com with ESMTPSA id f27sm4466577pga.41.2017.05.03.12.47.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 03 May 2017 12:47:10 -0700 (PDT)
Date:   Wed, 3 May 2017 12:47:08 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] config.mak.uname: set NO_REGEX=NeedsStartEnd on AIX
Message-ID: <20170503194708.GE28740@aiede.svl.corp.google.com>
References: <20170503135430.7785-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170503135430.7785-1-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:

> Set the NO_REGEX=NeedsStartEnd Makefile flag by default on AIX.
>
> Since commit 2f8952250a ("regex: add regexec_buf() that can work on a
> non NUL-terminated string", 2016-09-21) git has errored out at
> compile-time if the regular expression library doesn't support
> REG_STARTEND.
>
> While looking through Google search results for the use of NO_REGEX I
> found a Chef recipe that set this on AIX[1], looking through the
> documentation for the latest version of AIX (7.2, released October
> 2015) shows that its regexec() doesn't have REG_STARTEND.
>
> 1. https://github.com/chef/omnibus-software/commit/e247e36761#diff-3df898345d670979b74acc0bf71d8c47
> 2. https://www.ibm.com/support/knowledgecenter/ssw_aix_72/com.ibm.aix.basetrf2/regexec.htm
>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)

Thanks.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Is there e.g. a build farm where we can check for this kind of thing
more systematically on supported platforms?
