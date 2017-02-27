Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E95A11F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751485AbdB0Rtx (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 12:49:53 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34436 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdB0Rtu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 12:49:50 -0500
Received: by mail-lf0-f67.google.com with SMTP id a198so4078796lfb.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 09:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Unegw2S+ES7f7ay7y8X/m0+AZiaT8rvsVIyD8EYUB4I=;
        b=BTEqb92xce7V3GjXBdTvKpjb5QJmxDuZbJ1lkjIKZaMMJjCqZWWkANo6EhS40BkwtQ
         Lgcr1eX5cFDts3qklnX/RMY3n1q+kFEOiQyNW4+xchQ0FT4nd8HTtcwKlVC5wQ5DhEXz
         tT20s1MZt2CsKr5q1Bs59rqnZ2W/IVLJzIVpYvEESmYMTYXRIPX+LMWRMeyovPS0gjAv
         zdfM3pWZVFmFMA/kKFZEH0edsVbmTppnjWljl/LKpiSxc4G5Y+jJd6gFwqkLPIiUa110
         dqkdE9a03lzDSCixGxJpumxWbfan0Iehi+YrUsFKmeAqUU1sA3PLVxlB/QeADmO00ioD
         jCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=Unegw2S+ES7f7ay7y8X/m0+AZiaT8rvsVIyD8EYUB4I=;
        b=FB7/OBK7W9UK1nFPh2IWKZpzu3nzrMMsxZWkDvnEjUIwiM5r/bfGK/DYIRh7DiMiy3
         MYCbz6qctu0FawIpF68e0rzukl9Qy+8ftF6x3hz2BZxckC94+SfHQ2Fw62QXFh+h8rga
         bBSS2Lv9SmYoRGsoUFELROPhIxcZw4WW/wGrByOXjNbYRCjOVV/7fZ/esdqPDfTvTG8R
         /UOOO6LmFprU/KsbFWkweXlHhV5646Zad64oWM1gp9HzQHSzVFoFrYpBUHoC5NykCctm
         ftwTUj2f9sYLjBpW1oAGc57tVu99yYwXre4H+9Pwyr+jgZIP5pan9hxZB90wKNSMPvFu
         jb4g==
X-Gm-Message-State: AMke39nLDL0Nv8I7dWPk9iQ2bKd3sQktdOJklX2/HpCVHi0MwzrdWgiWSCfvrm1IBg+N2Q==
X-Received: by 10.46.84.73 with SMTP id y9mr4831193ljd.6.1488217710839;
        Mon, 27 Feb 2017 09:48:30 -0800 (PST)
Received: from [192.168.1.26] (deg240.neoplus.adsl.tpnet.pl. [83.23.110.240])
        by smtp.googlemail.com with ESMTPSA id p11sm4082110lfd.20.2017.02.27.09.48.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Feb 2017 09:48:30 -0800 (PST)
Subject: Re: [PATCH] gitweb tests: Skip tests when we don't have Time::HiRes
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
References: <20170227123720.8493-1-avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Message-ID: <4b34e3a0-3da7-d821-2a7f-9a420ac1d3f6@gmail.com>
Date:   Mon, 27 Feb 2017 18:48:21 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20170227123720.8493-1-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 27.02.2017 o 13:37, Ævar Arnfjörð Bjarmason pisze:
> Change the gitweb tests to skip when we can't load the Time::HiRes
> module.

Could you tell us in the commit message why this module is needed?
Is it because gitweb loads it unconditionally, or does that at least
in the default configuration, or is it used in tests, or...?

[I see it is somewhat addressed below]

> 
> This module has bee in perl core since v5.8, which is the oldest

s/bee/been/

> version we support, however CentOS (and perhaps some other
> distributions) carve it into its own non-core-perl package that's not
> installed along with /usr/bin/perl by default. Without this we'll hard
> fail the gitweb tests when trying to load the module.

I see that it because gitweb.perl as the following at line 20:

	use Time::HiRes qw(gettimeofday tv_interval);

> 
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Good catch (if a strange one...).

> ---
>  t/gitweb-lib.sh | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
> index d5dab5a94f..116c3890e6 100644
> --- a/t/gitweb-lib.sh
> +++ b/t/gitweb-lib.sh
> @@ -114,4 +114,9 @@ perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
>  	test_done
>  }
>  
> +perl -mTime::HiRes -e 0  >/dev/null 2>&1 || {
> +	skip_all='skipping gitweb tests, Time::HiRes module unusable'

Is "unusable" a good description, instead of "not found"?

> +	test_done
> +}
> +
>  gitweb_init
> 

