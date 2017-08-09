Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B939A208B5
	for <e@80x24.org>; Wed,  9 Aug 2017 18:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbdHISi2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:38:28 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35644 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752207AbdHISiZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:38:25 -0400
Received: by mail-pg0-f44.google.com with SMTP id v189so31372875pgd.2
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 11:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pwrUWdiZrNZQoZdR2XG3P16sflbL8Z9stVLQPjK1Tus=;
        b=v7aIy4K1YmZqpxhCFV2BE4JIvMdBcTdLSjRoQBKWA5627qfyvjM3WkOUV5DhujsQdr
         qsD2Ga3p4Nqd91BF4/5j+dRe8mKRdtinGtx7ExRBK/pqqUEZk1L6Ku6xwg2EG73xhbR6
         AnkhQCjumVPJoxNcAWi2IpwpmSJUVNLdj0cg15vxj+z2jTh/Z3qEH+MSiE2lUV3fa2BZ
         FITOd5t9u+JNX4i3s+dTpkZRognvz8c4u5NpTD7VZDbKiJSsxXZZ53GSMIBjvEkIGwDL
         v9Tw25ewG1encz6Q5hj+hKTZf0brXv9++DyAvVEQ6uOfoeu4ev13jSuQOoI3E4q2SrSU
         csPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pwrUWdiZrNZQoZdR2XG3P16sflbL8Z9stVLQPjK1Tus=;
        b=SDcPqdhXL2SiAr73ZmPk891Ic0Jzfh1nLyrEmskDqc7FsCw/A1rHqllD4di3odMkoi
         LISMtM96KpeKsz2fBRcyzcjd5vuwZdIiEMgEcxNHVSDt3LtVBWFr7+J0WIEr2eg6EdZS
         g9EJoCte/AC3cX1vQi/QX/t96GkDdRaLgOmXVzs1AwxAu4FWEhuKlS7fVnjFOhXi6kBy
         ULiHfvrykKMz6xuc80mM3p/5kjhHA0PQJ+qouUcBPL2M6WMUyQnplcw59b0D0x9ZUaFg
         VuauqJrurFRmVhJQj/FBFa5sf8eeWPjoyoesb1tCAHsDAj8l49l/flr54CjPUXTNajhE
         sm8Q==
X-Gm-Message-State: AHYfb5g3PLTpttiRPDya7CtwCjWSH/3oFxjRwmQF5NMe6CuUoPW2xm8t
        qkX1o/PiLpF7Fbfssg04eA==
X-Received: by 10.98.159.12 with SMTP id g12mr9240313pfe.279.1502303904976;
        Wed, 09 Aug 2017 11:38:24 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:2958:5ad1:cb09:f54c])
        by smtp.gmail.com with ESMTPSA id t29sm8953938pfl.4.2017.08.09.11.38.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Aug 2017 11:38:24 -0700 (PDT)
Date:   Wed, 9 Aug 2017 11:38:20 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] interpret-trailers: add an option to show only
 existing trailers
Message-ID: <20170809113820.50cfb247@twelve2.svl.corp.google.com>
In-Reply-To: <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
        <20170809122439.fscozhyvxcx2oq2n@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Aug 2017 08:24:40 -0400
Jeff King <peff@peff.net> wrote:

> diff --git a/t/t7513-interpret-trailers.sh b/t/t7513-interpret-trailers.sh
> index e5b0718ef6..525fd53e5b 100755
> --- a/t/t7513-interpret-trailers.sh
> +++ b/t/t7513-interpret-trailers.sh
> @@ -1312,4 +1312,19 @@ test_expect_success 'only-trailers omits non-trailer in middle of block' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'only existing' '
> +	cat >expected <<-\EOF &&
> +		existing: existing-value
> +	EOF
> +	git interpret-trailers \
> +		--only-trailers --only-existing >actual <<-\EOF &&
> +		my subject
> +
> +		my body
> +
> +		existing: existing-value
> +	EOF
> +	test_cmp expected actual

Would it be worth asserting that the "sign" trailer is configured here
and would normally appear? Maybe through a grep on the output of "git
config".

> +'
> +
>  test_done
> diff --git a/trailer.c b/trailer.c
> index a4ff99f98a..88f6efe523 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -991,9 +991,10 @@ void process_trailers(const char *file, struct process_trailer_options *opts,
>  	trailer_end = process_input_file(opts->only_trailers ? NULL : outfile,
>  					 sb.buf, &head);
>  
> -	process_command_line_args(&arg_head, trailers);
> -
> -	process_trailers_lists(&head, &arg_head);
> +	if (!opts->only_existing) {
> +		process_command_line_args(&arg_head, trailers);
> +		process_trailers_lists(&head, &arg_head);
> +	}

This is a bit confusing, but it is correct, since
process_command_line_args() processes both configured trailers and
command-line trailers.

Having said that, it might be worth declaring LIST_HEAD(arg_head) inside
the if block now.
