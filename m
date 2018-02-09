Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 167541F404
	for <e@80x24.org>; Fri,  9 Feb 2018 18:59:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbeBIS7O (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 13:59:14 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:39062 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752426AbeBIS7N (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 13:59:13 -0500
Received: by mail-wr0-f196.google.com with SMTP id f6so9247347wra.6
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 10:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ySq1AJJuyb55Anebr4aTntP/XLZ4UvxesgMc/jgqCAw=;
        b=V8ip/OERpLs6wGbUyHHO1r0vbGo8Jfho3hGepNWY/quXNVx90aYJZb1RYKwvQzbmqY
         3snn589pfty3uILMlzVmIBAsZJMfQh2VfvJ2OjQfqu/YfEH5Q3bPMzMvGUevR5vJtG5X
         hg8fseNVyf4qQOcCKmFMAgAzQcGGn00V0rMDy7utGDwKnSkgbQZqPZ427SzeKRGTlDqt
         M7V/XXjCYzWgDdHGlj8o61mLARag6LBU8/uiHCFo1jsHy/9Lkk21m/Lzr5ESbsO+C+UN
         +VimLS2xAh8ny3QI7aupISNSrt522OhbIayQmZV1drkXWalZqN4RsSunaIBT9/bVh6xm
         wbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ySq1AJJuyb55Anebr4aTntP/XLZ4UvxesgMc/jgqCAw=;
        b=Zzn/yIt+z6u2LFBIsS0pY24MrefykGRf4NFktnfUcLyv5Z0RN2N4DNdNPjjTd6ZALu
         okCoJMm5gNI8d9ZEgCY7uVYZPF/st9MGaQIHZlyNjnW4XAWJbB4+HD12vqNdMK23N9S/
         wSANmg5mh0KCbfMHmcXxY7RvRiAFxcoJdhq0hMgnyV7hhk6K1v3tDMXgJX+v+8qSOBBv
         gCFQ9opCxRGgxi1O2aU+hWGaQwj6ojrlh5p34pS65/ivA1GOcPDHQrVpjungQf2cxrOH
         mSL4w9x000msXxA8Fwtp4/itjwgEClbZlLq//5lwqDVJ/c6MHZWopc5mY/iVFBiWs3/4
         PoYw==
X-Gm-Message-State: APf1xPCd0oQUDdS6heBf06bnTDCD/xLXdQIcSIo6a+8vvmqKsIA1lglK
        wLGR0VeVjwJhtMKOiusT+zgON5FA
X-Google-Smtp-Source: AH8x226yf6Qqwdvr1PmUDpvpRJy8wPTe2E+GPRrls/2zjbJKHg3F2vsxUiwnOaPAOr3E1o3uikVlLg==
X-Received: by 10.223.195.141 with SMTP id p13mr3216505wrf.19.1518202752266;
        Fri, 09 Feb 2018 10:59:12 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x127sm2473453wmb.36.2018.02.09.10.59.11
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 10:59:11 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 04/42] git-completion.bash: introduce __gitcomp_builtin
References: <20180131110547.20577-1-pclouds@gmail.com>
        <20180209110221.27224-1-pclouds@gmail.com>
        <20180209110221.27224-5-pclouds@gmail.com>
Date:   Fri, 09 Feb 2018 10:59:10 -0800
In-Reply-To: <20180209110221.27224-5-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 9 Feb 2018 18:01:43 +0700")
Message-ID: <xmqq1shuxa4h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> +# This function is equivalent to
> +#
> +#    __gitcomp "$(git xxx --git-completion-helper) ..."
> +#
> +# except that the output is cached. Accept 1-3 arguments:
> +# 1: the git command to execute, this is also the cache key
> +# 2: extra options to be added on top (e.g. negative forms)
> +# 3: options to be excluded

The options="${options/ $i / }" substitution in a loop is cute.  The
third argument to this helper is an IFS separated list of regular
expressions to match options that we do not want to see in the
completion, so 

	__gitcomp_builtin foo '' '--a[^ ]*'

presumably would exclude all options whose names begin with 'a' ;-).

> +	if [ -z "$options" ]; then
> +		# leading and trailing spaces are significant to make
> +		# option removal work correctly.
> +		options=" $(__git ${cmd/_/ } --git-completion-helper) $incl "
> +		for i in $excl; do
> +			options="${options/ $i / }"
> +		done
> +		eval "$var=\"$options\""
> +	fi
> +
> +	__gitcomp "$options"
> +}
> +
>  # Variation of __gitcomp_nl () that appends to the existing list of
>  # completion candidates, COMPREPLY.
>  __gitcomp_nl_append ()
