Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E7FB1F404
	for <e@80x24.org>; Sat, 24 Feb 2018 00:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeBXAyL (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 19:54:11 -0500
Received: from mail-pl0-f67.google.com ([209.85.160.67]:43262 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbeBXAyK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 19:54:10 -0500
Received: by mail-pl0-f67.google.com with SMTP id f23so5853813plr.10
        for <git@vger.kernel.org>; Fri, 23 Feb 2018 16:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y557OY1YLBGAateR0MBOMGcJru2NhEgwoRtpwx4Spbo=;
        b=S1o4ucpA1F7dIjgPllME0lzUYWJIJuoLgFpHG5qQhIy1C7JE4zkJJpayUXD1aihpRu
         rOLZ4QcgOsHMu+GcNi8+OMSne139+8/xfD5WFcFLwoVqeR0XoRWAM/vORAWd5JN1TvK7
         s0qGCsAr4Slh/VzL2Qw/L1r6fCmQjRVHj+M0k424QZ+NTL94fXctoN8NVXEeUx1orDIB
         sX40KUc3GsXeY7bLWzxfM076N6bmc5j31tIF5dBWYelyot3suv6svRkac//NoxryLuRh
         MtI78yW4nAWhwGaI+yaP1qrJXeuW09AEMjNzYm5SoBW9La0VT9LyXV835QovsgP2Q0lj
         ru8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y557OY1YLBGAateR0MBOMGcJru2NhEgwoRtpwx4Spbo=;
        b=MwT92Z5AjjWhCeCAUQvhu9dwXMSgA0DgUW9/iBnjuevtKkUo7Kw/cyxCTKLjjqpUUj
         QvCEX/1waw/Vm+uoctvMeBU9y2KXsgGYyIMMHXqWugd5K8C59R3LPaCkxpvanF0bxY12
         yBfny6G2nryNdyejzq/30VfhyWXq1eb7U8r0glUB9uXL0BMLqDmKsi3FTaoTf25PucBb
         suiU8b7QAkkuaQGwjw8JJ3Z94BFAJ/ygtE7eoBmYKIBKO0goDTlqQhTi1HIkdig9mqc6
         7bnTllkHSgDXOMk6Zor2Gx0mca6NuhKYKi3JAhVDhbNVRHDvB0TC6RSsWJMoFc2ros3b
         UzTw==
X-Gm-Message-State: APf1xPBS18E14cPbVB/+awdeCsIgSMjE1dOkdugF7iacuUEf7fjSUAAY
        v+PXM2LC2CcjAL80ZVuwh0g4Gm1xAgc=
X-Google-Smtp-Source: AH8x225Q7El0Huhdj4ClPSWGbgnNXE6PssP7DMF2f8wRvtvIfliP4Q1ejarBP4iB0ACG884b7Sbz1w==
X-Received: by 2002:a17:902:6184:: with SMTP id u4-v6mr3305365plj.390.1519433650135;
        Fri, 23 Feb 2018 16:54:10 -0800 (PST)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id n81sm8078761pfk.152.2018.02.23.16.54.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 23 Feb 2018 16:54:08 -0800 (PST)
Date:   Fri, 23 Feb 2018 16:54:07 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        gitster@pobox.com, jrnieder@gmail.com, stolee@gmail.com,
        git@jeffhostetler.com, pclouds@gmail.com
Subject: Re: [PATCH v3 21/35] fetch-pack: perform a fetch using v2
Message-Id: <20180223165407.2d2f4343b2497172523f9f66@google.com>
In-Reply-To: <20180207011312.189834-22-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com>
        <20180207011312.189834-1-bmwill@google.com>
        <20180207011312.189834-22-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  6 Feb 2018 17:12:58 -0800
Brandon Williams <bmwill@google.com> wrote:

> +	while ((oid = get_rev())) {
> +		packet_buf_write(req_buf, "have %s\n", oid_to_hex(oid));
> +		if (++haves_added >= INITIAL_FLUSH)
> +			break;
> +	};

Unnecessary semicolon after closing brace.

> +			/* Filter 'ref' by 'sought' and those that aren't local */
> +			if (everything_local(args, &ref, sought, nr_sought))
> +				state = FETCH_DONE;
> +			else
> +				state = FETCH_SEND_REQUEST;
> +			break;

I haven't looked at this patch in detail, but I found a bug that can be
reproduced if you patch the following onto this patch:

    --- a/t/t5702-protocol-v2.sh
    +++ b/t/t5702-protocol-v2.sh
    @@ -124,6 +124,7 @@ test_expect_success 'clone with file:// using protocol v2' '
     
     test_expect_success 'fetch with file:// using protocol v2' '
            test_commit -C file_parent two &&
    +       git -C file_parent tag -d one &&
     
            GIT_TRACE_PACKET=1 git -C file_child -c protocol.version=2 \
                    fetch origin 2>log &&
    @@ -133,7 +134,8 @@ test_expect_success 'fetch with file:// using protocol v2' '
            test_cmp expect actual &&
     
            # Server responded using protocol v2
    -       grep "fetch< version 2" log
    +       grep "fetch< version 2" log &&
    +       grep "have " log
     '

Merely including the second hunk (the one with 'grep "have "') does not
make the test fail, but including both the first and second hunks does.
That is, fetch v2 emits "have" only for remote refs that point to
objects we already have, not for local refs.

Everything still appears to work, except that packfiles are usually much
larger than they need to be.

I did some digging in the code and found out that the equivalent of
find_common() (which calls `for_each_ref(rev_list_insert_ref_oid,
NULL)`) was not called in v2. In v1, find_common() is called immediately
after everything_local(), but there is no equivalent in v2. (I quoted
the invocation of everything_local() in v2 above.)
