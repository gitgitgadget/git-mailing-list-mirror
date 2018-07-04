Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA9A1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 14:55:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDOzp (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 10:55:45 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:33157 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752635AbeGDOzn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 10:55:43 -0400
Received: by mail-oi0-f53.google.com with SMTP id c6-v6so11261318oiy.0
        for <git@vger.kernel.org>; Wed, 04 Jul 2018 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=57HwDxKrEB4j08H6aHb0tTINX9cN3PSzjVLuSZvax2A=;
        b=f1hCir+3vxyRoYi+pF4aAWOAC2uL23m00VA+v2xF//VZGPRCkMoaEzOOH/xOx2TQ75
         wPzedIi+DtDsgNOlbRl38RmbKKd6k3XU8AktLNaeh9hKWJ2RhCWLg4O3ARjdnUml9jnf
         V7RtmwtGYgrYr1NqREO5aASFqu/z+V6LQIIpttTVCn4AKV8WsUS60IUPfoqGaVKH4hbO
         na6aRzsqpbWUT7EyRCTCWSRgRnC6retJ/BhoHjxLZC40kF3U8DE1p1Co+g1HMY+CcBBo
         2Ahu9/8BG5dKOhAhnZUKYigNm6B3bgmL+08daVkKAe+HONlgQKVcgkUjQ8zLw75i/t1b
         as7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=57HwDxKrEB4j08H6aHb0tTINX9cN3PSzjVLuSZvax2A=;
        b=pB+H4zdI0fLPcxoxGffqEWwbHqsy59Yqk+1EtEbiiT2bqFivRrQf1C7FmwX8HUnPIY
         49p+4m/e/m44fSy1Pt6OY4t0UeDcKMX8B6SgyLWw6nnP+261agJZ7Olf8Z2jIKHIRsBm
         gTPjX8Fuw7dl/ZRpMveqO5UVLQU11u6Wch0mQjq955CU+RSrfRClyUta9YmD9CpurvJU
         GOxJC7IWhGHjW/vvVgW5xhAhSbLep7LJ+BXL+Vb5zwItV+FMQhsm6hT6rt037yVFL6Pv
         U0NP4OWQKm/Cnw2s4ro0sVIXZ5MafCiWEQlGRuj9X1uMfPkDN069ja/Xcys0/Iaq+uAb
         VcKg==
X-Gm-Message-State: APt69E1BYy4okWgKIOJUAajgPH4Ayl3yKg8yUhaG74XE4sYRjsIyfLXd
        yMl7vqdAoHda8qCBJaqkjo8cEFhNxIY=
X-Google-Smtp-Source: AAOMgpey+F/Y67Ci2UsKaQGTaKs6XWkKRkxlYoNDVh2jmuhpSjORf4UIdcUH04wJcj0shllBoLyXmw==
X-Received: by 2002:aca:4545:: with SMTP id s66-v6mr2727515oia.240.1530716142629;
        Wed, 04 Jul 2018 07:55:42 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id f14-v6sm2634872ote.53.2018.07.04.07.55.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Jul 2018 07:55:41 -0700 (PDT)
Date:   Wed, 4 Jul 2018 09:55:40 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2] grep.c: teach 'git grep --only-matching'
Message-ID: <20180704145540.GA51949@syl.attlocal.net>
References: <702e1d2a26704c7c932ee4b96f32bff4c45e485e.1530654455.git.me@ttaylorr.com>
 <bf53ea90c9114d0c4e3cc2b1df05464bfeb6e84f.1530716005.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bf53ea90c9114d0c4e3cc2b1df05464bfeb6e84f.1530716005.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 25, 2018 at 02:59:07PM -0500, Taylor Blau wrote:
> Teach 'git grep --only-matching', a new option to only print the
> matching part(s) of a line.
>
> [ ... ]
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 0de3493b80..078b4e3730 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -17,7 +17,7 @@ SYNOPSIS
>  	   [-l | --files-with-matches] [-L | --files-without-match]
>  	   [(-O | --open-files-in-pager) [<pager>]]
>  	   [-z | --null]
> -	   [-c | --count] [--all-match] [-q | --quiet]
> +	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
>  	   [--max-depth <depth>]
>  	   [--color[=<when>] | --no-color]
>  	   [--break] [--heading] [-p | --show-function]
> @@ -201,6 +201,10 @@ providing this option will cause it to die.
>  	Output \0 instead of the character that normally follows a
>  	file name.
>
> +-o::
> +--only-matching::
> +	Output only the matching part of the lines.

Junio,

My apologies that I sent the previous patch with incorrect indentation on this
line. Would you mind queueing this one instead?


Thanks,
Taylor
