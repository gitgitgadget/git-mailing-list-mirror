Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBEF1F6AC
	for <e@80x24.org>; Mon,  9 Jul 2018 20:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933036AbeGIUgT (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Jul 2018 16:36:19 -0400
Received: from mail-yb0-f170.google.com ([209.85.213.170]:40071 "EHLO
        mail-yb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932947AbeGIUgS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Jul 2018 16:36:18 -0400
Received: by mail-yb0-f170.google.com with SMTP id y11-v6so7719264ybm.7
        for <git@vger.kernel.org>; Mon, 09 Jul 2018 13:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oMP4VdE7B3gTdKMF+2rlvL7DCjNhfjoF0+LK6AcLTHs=;
        b=PZ1bSOHxSNhCE5PTaE6543ijZXTSDsa1PPsiafhbV5rCCMdZEphGpNrlGiFLiaiaTo
         uNmANP25M/hw3248BGsLgQr4XSBTGQIdOIq/3Bq5Ctqhkip7ITTC7lYeosAvX0Bbdisr
         UM5vjInH4DHSJSDyaAIchVnfagvNLkmKg/mkkEAgXHLHu3/y8hNZWXoJxMRDf3SxWDh+
         rOrMA1PsKXbuncWLHNY9imzPv4s9aSlXoyoG9C6bl/uGguaPxetSDkA+AaCGRTRp4fqv
         WIezhJgvLQPhVPk3LDlxVvwqum8NKQUX+CBNo+EJLtjrOFJMcy0YByJNVByCfp5XwfSs
         AbKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oMP4VdE7B3gTdKMF+2rlvL7DCjNhfjoF0+LK6AcLTHs=;
        b=fLGPTKndbNjqJTELZB0o4F5aGQ8X+puN1B1CyOvygMgxnEgWAapond5/3ayClCTm+i
         OvYtNqj/KbD022ZvecQt+pnGwciViUxw+3JacYsaaE/h8ZKs8qS90MIc66fAdLsiHUjY
         kh2CoY6XxAOCirhwAjKlTxqFKqiNCBtOyPNLtDKiiSo++SWXBuFFLRwTxd8JFvbCHnRu
         w/1r92VNgLz0RmJT3s7vLGqR7aYvtvkmTQ1IrN5CBZ25cHOFgbl9zejr6nzPKBxG/LrN
         8hrBU9iEcoLE2/FFHHMDBwjS05zcp55THTFsDUZldgY60Eb2hdasw//vWwlsXdcEShrC
         p7Mw==
X-Gm-Message-State: APt69E2iHYtoME/8Or1Ch14MnidxnuHvQQi9u4zjcviAyOljbqdcbnoW
        MEhydoDswg4FUjMybxy/cBEA2xmEB+U=
X-Google-Smtp-Source: AAOMgpdD3AYPOZPhLB9a+xHV/PlwD4L5CyttGDHOtPi8wIUo9/mWS0nO32AkiWp+P5EiHCcCUrry7w==
X-Received: by 2002:a25:b582:: with SMTP id q2-v6mr11285205ybj.482.1531168577011;
        Mon, 09 Jul 2018 13:36:17 -0700 (PDT)
Received: from localhost ([107.217.158.181])
        by smtp.gmail.com with ESMTPSA id o204-v6sm3842580ywd.16.2018.07.09.13.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 13:36:15 -0700 (PDT)
Date:   Mon, 9 Jul 2018 15:36:14 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v4] grep.c: teach 'git grep --only-matching'
Message-ID: <20180709203614.GA83328@syl.attlocal.net>
References: <20180705143401.GA87330@syl.attlocal.net>
 <17fb488dad653d6378af122c91805294e1a1e93a.1531168412.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17fb488dad653d6378af122c91805294e1a1e93a.1531168412.git.me@ttaylorr.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 09, 2018 at 03:33:47PM -0500, Taylor Blau wrote:
> [ ... ]
> ---
>  Documentation/git-grep.txt |  7 +++++-
>  builtin/grep.c             |  6 +++++
>  grep.c                     | 51 ++++++++++++++++++++++++++------------
>  grep.h                     |  1 +
>  t/t7810-grep.sh            | 15 +++++++++++
>  5 files changed, 63 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 0de3493b80..a3049af1a3 100644
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
> @@ -201,6 +201,11 @@ providing this option will cause it to die.
>  	Output \0 instead of the character that normally follows a
>  	file name.
>
> +-o::
> +--only-matching::
> +	Print only the matched (non-empty) parts of a matching line, with each such
> +	part on a separate output line.

OK, it seems as if the consensus is (1) take the description as-is from
GNU grep, and (2) don't change the existing behavior of "git grep -o
'^'".

This patch does both of those things, and can be queued as 2/2 in this
series.

Thanks, everybody :-).

> --
> 2.18.0

Thanks,
Taylor
