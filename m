Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 08B541F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeB0Wm3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:42:29 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:54592 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751754AbeB0Wm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:42:28 -0500
Received: by mail-wm0-f41.google.com with SMTP id z81so1495618wmb.4
        for <git@vger.kernel.org>; Tue, 27 Feb 2018 14:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7I5xuO4yeke+ojScKrPZFHh/DB76vylahGS8FdmeY5M=;
        b=PMTP3JT0J9010E6HOxv/t4lkz9eAHHo3cBahEhTKz1BGkBbJcy2TL0ceVdTeLaSqTx
         /EuTvk9vcXdKjcBr91WI8uQIt9/FAOGZsP1tI8+zoCHw34eQ7E+rOChMhLC9CrFlqk3R
         TROZhuR4gfRe+O89/CfjhFnJXlD/DxJ9zcFP7+AiE+Z6MgHQvjLiOpWmx5Jo+CT2WLPn
         SJtZjByFGP4vhO/B6ElsI4q3yhVI+YAdJ1q3Fwopcm1wkL0BOLZmmQAkwNOGTP1gYEs2
         pVKKHN45om7z1OAA1pKBNpFfB0L/j/XNdS5KHeX5HmiirrFpoZfd5oiXZMKySF+A6/6d
         Nnjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7I5xuO4yeke+ojScKrPZFHh/DB76vylahGS8FdmeY5M=;
        b=PVBXxTl+az9CGJy4qqvnnNIG6zBmAVZcdB/f90LLVxYAaqlhSVDlgSlwr/Mmg8UWBo
         M//u2eT0kHmVRWv2OsSU5Dc++AaS9Jm8sI6u17qY6XPN08ZxbRCHquC3qlXBBilsrepQ
         x+CYvY3n6t5XW0GFybHA0vu8gUbVSWS8hLMsFPyylbtgIs6qP4zSHEK5ESE/4hZhzNDP
         Bp6JfDoql+eg7A9Lz+kDQm4LWODtez4MrgIbSAdYd70K+UOztJQLyoHKXbr2cGUat3PN
         srLj0T0RV7xPARhekiirBmihJxdb33lz8WUwcRxGLtAuhVFUWb25zremzKGnWnSE0Mlc
         dADw==
X-Gm-Message-State: APf1xPAyUd7M3Ef1TeKbQ5/PDYx03mBfudd/Boa56N2sA3kEQ+jPVMX4
        BkmojvVKDoOXf3sel92bu7M=
X-Google-Smtp-Source: AG47ELsbMe9GbP7AVngeiwavUnSFvEYaN+52VRIFjRGFaVicrV5IqykqCblvjWwQTt8urGBdlWeXkg==
X-Received: by 10.28.198.199 with SMTP id w190mr11420391wmf.62.1519771346615;
        Tue, 27 Feb 2018 14:42:26 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id h50sm295617wrf.65.2018.02.27.14.42.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Feb 2018 14:42:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood@talktalk.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 4/9] t3701: don't hard code sha1 hash values
References: <20180213104408.9887-1-phillip.wood@talktalk.net>
        <20180227110404.16816-1-phillip.wood@talktalk.net>
        <20180227110404.16816-5-phillip.wood@talktalk.net>
Date:   Tue, 27 Feb 2018 14:42:25 -0800
In-Reply-To: <20180227110404.16816-5-phillip.wood@talktalk.net> (Phillip
        Wood's message of "Tue, 27 Feb 2018 11:03:59 +0000")
Message-ID: <xmqqinainjfy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood@talktalk.net> writes:

>  t/t3701-add-interactive.sh | 30 ++++++++++++++++++++----------
>  1 file changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index bdd1f292a9..46d655038f 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -10,6 +10,16 @@ then
>  	test_done
>  fi
>  
> +diff_cmp () {
> +	for x
> +	do
> +		sed  -e '/^index/s/[0-9a-f]*[1-9a-f][0-9a-f]*\.\./1234567../' \
> +		     -e '/^index/s/\.\.[0-9a-f]*[1-9a-f][0-9a-f]*/..9abcdef/' \
> +		     "$x" >"$x.filtered"

Interesting ;-)  You require .. and on the left hand side you want
to see a run of hexdec with at least one non-zero hexdigit, which is
filtered to fixed-length 1234567; right hand side is the same deal.

Which sounds like a reasonable way to future-proof the comparison.

If 7 zeros are expected in the result, and the actual output had 8
zeros, the filter does not touch either so they compare differently,
which is somewhat unfortunate.  Perhaps something like

	/^index/s/^00*\.\./0000000../
	/^index/s/\([^0-9a-f]\)00*\.\./\10000000../
	/^index/s/\.\.00*$/..0000000/
	/^index/s/\.\.00*\([^0-9a-f]\)/..0000000\1/

after the above two patterns help?
