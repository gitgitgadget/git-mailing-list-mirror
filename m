Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 044471F453
	for <e@80x24.org>; Sat,  3 Nov 2018 01:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbeKCKbZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 06:31:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43068 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeKCKbZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 06:31:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id y3-v6so3363797wrh.10
        for <git@vger.kernel.org>; Fri, 02 Nov 2018 18:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UZPJo1IODcGLr6uVU4fHgYtTqm2OlagxgjAkP+a1ZcA=;
        b=DPRGX9XwpVXR13v1S3/ZOXzDCzX/JiEBrmO2OBJ11LAma3n/RDX5ByRlkc+bsG3SL6
         1Juubn6BhhQ4EKQuqfE6luW8pSorDnoQq1XMNa+SgcJBWeL5DJY078vDcBXBooUTJm7B
         6psQNJdXzIGuGK3wwAqTA9lLTkkF/0FipQbNzDvmfZjaY1kE7bNGc+T+4oUWPGuZXznv
         pK10PoHF9hZiY/kmst/FzKycRvKgNZkaBzu342lZ98fG83k+k49XwEfwsrshoMxZpivu
         n2RIQDj5YMkF03/rt2e9trU23oxqiOl6UiFv9bMXnMX2T5WQtXPhWwLyWwkkOk10HdcV
         G/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UZPJo1IODcGLr6uVU4fHgYtTqm2OlagxgjAkP+a1ZcA=;
        b=Vc6tfTinoscx7u3SqvJxfZfDr/YOw8IC/moFNGF2blvIOZhrbpwZfcU6aEypmbZz9V
         UZ6eWNOlbC1fotTcvCOc8C0vxUXTxmqsD+i+/rTCJInU2b4I9BRrzNG74YZx3ee5vd0+
         WTqXOo9PzmgefXGMreTm67vlaAupiSoJfpVZXSCdIFQiUSrrlO8i6c4gYlj321MOtQMR
         8DBUQ9plfqnfMclk3Vs7dD3n7Nlyv9gKn1c7PbFGNh3pRJdpCwdJbsN4ZQf6XSsIn8Xt
         PnbdyVzwtZd1JP3AEf5DHeFr0FKPham9+iI1pIwKYH7bc857KOT2mReZQq3t2FHOlze+
         9u5Q==
X-Gm-Message-State: AGRZ1gJGMOlZxFlQPav2e5aCMwmNQXwP1P55UGmTHN7RsQQuUF0m+qYa
        qsIcLDP1eHjo75mTE2r4W6jAcMrxG4c=
X-Google-Smtp-Source: AJdET5c7j+YTDnibjORSvIvv6hiXd5s7k7i2q0hZhisi05+yjaC7zJsA4ep0woN74ede0LyNLQ2NwQ==
X-Received: by 2002:adf:a109:: with SMTP id o9-v6mr11760181wro.169.1541208114716;
        Fri, 02 Nov 2018 18:21:54 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id n67-v6sm18696792wmd.41.2018.11.02.18.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Nov 2018 18:21:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] diff: differentiate error handling in parse_color_moved_ws
References: <20181102212316.208433-1-sbeller@google.com>
Date:   Sat, 03 Nov 2018 10:21:53 +0900
In-Reply-To: <20181102212316.208433-1-sbeller@google.com> (Stefan Beller's
        message of "Fri, 2 Nov 2018 14:23:16 -0700")
Message-ID: <xmqqzhurlzv2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>  
> -static int parse_color_moved_ws(const char *arg)
> +static unsigned parse_color_moved_ws(const char *arg)
>  {
>  	int ret = 0;
>  	struct string_list l = STRING_LIST_INIT_DUP;
> @@ -312,15 +312,19 @@ static int parse_color_moved_ws(const char *arg)
>  			ret |= XDF_IGNORE_WHITESPACE;
>  		else if (!strcmp(sb.buf, "allow-indentation-change"))
>  			ret |= COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE;
> -		else
> +		else {
> +			ret |= COLOR_MOVED_WS_ERROR;
>  			error(_("ignoring unknown color-moved-ws mode '%s'"), sb.buf);
> +		}
> ...  
>  	} else if (skip_prefix(arg, "--color-moved-ws=", &arg)) {
> -		options->color_moved_ws_handling = parse_color_moved_ws(arg);
> +		unsigned cm = parse_color_moved_ws(arg);
> +		if (cm & COLOR_MOVED_WS_ERROR)
> +			die("bad --color-moved-ws argument: %s", arg);
> +		options->color_moved_ws_handling = cm;

Excellent.

Will queue.  Perhaps a test or two can follow to ensure a bad value
from config does not kill while a command line does?

Thanks.
