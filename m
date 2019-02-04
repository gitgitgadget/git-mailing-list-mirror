Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1878D1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfBDUEZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 15:04:25 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38760 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfBDUEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 15:04:25 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so1293550wml.3
        for <git@vger.kernel.org>; Mon, 04 Feb 2019 12:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=i5JG8tIfRXONVJ8/JgUK8YZ9qRkr2sS2YRIiN2FIvgQ=;
        b=h+ljem0mYg0zlNqknEe8gEWYqIKoeepK9NJGn7BwH/bHUTVMmOZ8jvgLSm2y1UFq1k
         4szO/pOV5ElDK8v/zdOV18jfSOtMZmDNgbuAN55oNYCLRkQu6SJdAgE1sPfTq+T3+zMm
         34rGlcEMWBB3sdagjhAdG1A1W2uun0Fhor4bQxxR0Jo6OmtpzCAiSdNJWQY4CLPwPSGj
         x9Askm155wphDJR533Um/IsMGwCyd52SmO+EBREwasJm2dZpOIGX9nsHoz+yDmd7O/fk
         zLi0RQgy3IRpZTVClHbvdfo6FGCG7Or4gADNg+G2dNJ8SVC5led+mcaos2c+WC1UBYao
         C2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=i5JG8tIfRXONVJ8/JgUK8YZ9qRkr2sS2YRIiN2FIvgQ=;
        b=YdWBVJvisOSJdpxImJUWMt6V+/OrtTNOyV6sbm+7f4vSe7f/CtpMQ9ATZ3lJu6SnbX
         CljwOzvgVtSAHcv356pUos+QqHtU9B0FipvwMZeBOEcM1nHeC27knWLutgocbxtUKjj0
         0yjv1M3lcDbOqbMbxz0JusjVq+AUdql5slHlTq9wAZyC1h1uBasj2Oa/+DFdHmT1gFhR
         B/i9GvGoQNbSWCw7kofoetWIj5pCwc3tFY8/NlinlYd0mEvZCLMuy8p32YzDs9eNIfVz
         KIHlXBsM7Bp17DGIGYEYAEGLm+/UvrcJFE/1sd6nBsN9AdI4C1YdrH3FMw3poQdifrIR
         H9sQ==
X-Gm-Message-State: AHQUAuaxRUcqFwLXWp6fncrjhmVVw980Vsj/g4m45dB2NeHcXLXOp5su
        0I4TsucYjZjmAivIvJhFfFg=
X-Google-Smtp-Source: AHgI3IbGRcoI5jhGBImhp/76V5E7ELHP8+nzRF1d4sz8YTTK5BMgxD6ZTZaDj8clNXxXjCDCueTDpg==
X-Received: by 2002:a1c:a401:: with SMTP id n1mr814732wme.101.1549310662783;
        Mon, 04 Feb 2019 12:04:22 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id i184sm7931862wmd.26.2019.02.04.12.04.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 04 Feb 2019 12:04:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC/PATCH] core.abbrev doc: document and test the abbreviation length
References: <20160926043442.3pz7ccawdcsn2kzb@sigill.intra.peff.net>
        <20190204161217.20047-1-avarab@gmail.com>
Date:   Mon, 04 Feb 2019 12:04:21 -0800
In-Reply-To: <20190204161217.20047-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 4 Feb 2019 17:12:17 +0100")
Message-ID: <xmqq36p3uxq2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

> @@ -773,6 +773,14 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
>  					return 1;
>  				continue;
>  			}
> +			if (opt_with_value(arg, "--abbrev-len", &arg)) {
> +				unsigned long v;
> +				if (!git_parse_ulong(arg, &v))
> +					return 1;
> +				int len = abbrev_length_for_object_count(v);
> +				printf("%d\n", len);
> +				continue;
> +			}

Instead of exposing this pretty-much "test-only" feature as a new
option to t/helper/test-tool, I think it is OK, if not even better,
to have it in rev-parse proper like this patch does.

I however have a mildly strong suspition that people would expect
"rev-parse --abbrev-len=<num>" to be a synonym of "--short=<num>"

As this is pretty-much a test-only option, perhaps going longer but
more descriptive would make sense?  

	git rev-parse --compute-abbrev-length-for <object-count>

may be an overkill, but something along those lines.

Oh by the way, the code has decl-after-stmt, and perhaps len needs
to be of type "const int" ;-)

