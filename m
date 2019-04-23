Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3817C1F5CB
	for <e@80x24.org>; Tue, 23 Apr 2019 01:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfDWBYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 21:24:55 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39412 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbfDWBYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 21:24:54 -0400
Received: by mail-wm1-f68.google.com with SMTP id n25so16498221wmk.4
        for <git@vger.kernel.org>; Mon, 22 Apr 2019 18:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=U9ItXLB+ewi1/JR1fvldzM89g5LNpEVp/5cyPY4eVO0=;
        b=bzWffVKVmpEe4IGyFWor0FTe+yDZU3TYzQdfHTtvnc8fO17cJBj3i2AuvxTL1/S5rd
         UxTwUvTHAAMB75YKThsuVx/If2X3uZ7/4+ojESrfB1hvIRiGrEJZ+zXZN5fWZs/Swsqv
         Fmt/UmJYvDQoEBQa8DzKz1YYYWFe/avE5C5WoEJ6ijCCItN7mtYvEHOn0i5i9pknUeku
         5Ua3jY/1AOS4frU7s4G5NlVVWDfJ66ycJLKhQjfF4tdYLqSCTxZsD3HAkXppihlL3NxH
         sHriUpU5GjR62l7fpd9cbRK+ceV+tg6vXfkVvP0rHzgMcm9y9mTm0gB4YSc2iYs28xwQ
         VQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=U9ItXLB+ewi1/JR1fvldzM89g5LNpEVp/5cyPY4eVO0=;
        b=h5Mz473/zMOlXls1YAtMI1Q/YDEo3I7fJ7zxiCaWuyUS02ha7BcK5Zd4LPl9xvMlaI
         BpUHzQBfDbrnI7iyWf5nsf4S8MyKHvt1s0J9d2NjGzR4soMNVMUrJOAfkll+pLFUS66W
         pUeNQubVuo+juWOUrsAfVK3WMZ+s1hnpfaHHvtYt3lmMGPFlTiJrsxiixxWn0An4cRMA
         Y+BLiBDizhnblR7YYsKIdy2M58BSr3+4qpbknOg87oTPlPdcfwasCnNQuabSu2NfR4d8
         DkTEY6chrQqp9rkfcBZwNhUcBnakoC37nId/dpJGyw5DsbcsiAliVNVnhIDlQmSSdSY5
         Ii/g==
X-Gm-Message-State: APjAAAW2UJPxTmPnuqWD5s7Up8otfVbz4EV/nVp1u2Kk28J6fvynD0Xp
        Guk17yhMg6bnyMBdhXDWmCefanqNraU=
X-Google-Smtp-Source: APXvYqz0tvle3KYzlyJkY5mtp024LhA1q7xWVdv8UB9JRYci1UwFpV8B1QiGYBqmTGVX7O3cgRxLXA==
X-Received: by 2002:a7b:c347:: with SMTP id l7mr201161wmj.70.1555982692606;
        Mon, 22 Apr 2019 18:24:52 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id z17sm3627544wrm.33.2019.04.22.18.24.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 22 Apr 2019 18:24:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH] doc/ls-files: put nested list for "-t" option into block
References: <20190422151541.GA1633@sigill.intra.peff.net>
Date:   Tue, 23 Apr 2019 10:24:51 +0900
In-Reply-To: <20190422151541.GA1633@sigill.intra.peff.net> (Jeff King's
        message of "Mon, 22 Apr 2019 11:15:41 -0400")
Message-ID: <xmqqzhoh5x98.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We could fix it by adding a "+" before the sub-list to connect it to the
> rest of the "-t" text. But using a pair of "--" to delimit the block is
> perhaps more readable, and may have better compatibility with
> asciidoctor, as in 39a869b2f2 (Documentation/rev-list-options: wrap
> --date=<format> block with "--", 2019-03-30).

OK, thanks.

> Junio: I happened to notice this while hunting for "ls-files" options
>        that could make your makefile de-dup patch unnecessary (but
>        didn't find anything).

Yup, I was looking at builtin/ls-files.c before sending the Makefile
patch, too ;-)

>  Documentation/git-ls-files.txt | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 5298f1bc30..8461c0e83e 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -118,6 +118,7 @@ OPTIONS
>  	linkgit:git-status[1] `--short` or linkgit:git-diff[1]
>  	`--name-status` for more user-friendly alternatives.
>  +
> +--
>  This option identifies the file status with the following tags (followed by
>  a space) at the start of each line:
>  
> @@ -128,6 +129,7 @@ a space) at the start of each line:
>  	C::	modified/changed
>  	K::	to be killed
>  	?::	other
> +--
>  
>  -v::
>  	Similar to `-t`, but use lowercase letters for files
