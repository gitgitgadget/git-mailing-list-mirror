Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A4BE1F404
	for <e@80x24.org>; Tue, 28 Aug 2018 21:35:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeH2B3D (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Aug 2018 21:29:03 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34666 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727167AbeH2B3D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Aug 2018 21:29:03 -0400
Received: by mail-wm0-f65.google.com with SMTP id m199-v6so2887801wma.1
        for <git@vger.kernel.org>; Tue, 28 Aug 2018 14:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Co6yBPAXftKORreqqzRgJdwdAE5GANCXCaWpg+u3ENg=;
        b=HAqxKCnvBYtbzuvSOJ6+yYkWhHp1GeXIawzIEvCMjbBJdkUbluNXcNi6+PPVkdcZZ9
         nqLW0e9Fxcs2QrFiaM6b0SmvQ47TrpftYo0nXQhxvygE0irF5X15pvhldxvOWkHtMMM9
         hEZ5/MNTAIlnbRUi5q8L1MICzkIhnxYNHt/cZQa5njRh/2YMEsxZei+c2XvN4Uucvu7X
         /+Yeqrt0rq1PKdDs3YBodiZWmSk8SqV8L+9dfeJtElL+u91aL9oEtdjEvS4Sruo6aERa
         wR/goECzw7WpTHHF8B59Fh3TnwgGcfKG0A4hv7g0HkZdDsomBneh8NTKtEqQLKhiFlVG
         hAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Co6yBPAXftKORreqqzRgJdwdAE5GANCXCaWpg+u3ENg=;
        b=RJqmA0xeByXyKDkOFMteEWZ87ceqzgxx3squaJq0NTjNIPpxR7rJbKGzSTn9v1XUdn
         SE1k9Wl6o4iRB48DoWddxKB+eIWNY3QPS93P/nr2lhZA7Or/QfYZF/4+2UJnl63Hp18q
         Y38LmDJd1ugcc+Z1gCNi5wcbrsLB837QS7qM6kUV6NMn25uJhVDPSnkxhOlm44jcNYWg
         +sxyRL2SqM2I6pIZB4Y0SuB7NKJziGXIwVoK0lw3EOPrRNRSl2qwYP5AreMkumg/w2au
         vP2DFCIg6MxbYfkWi5PYSGcqH5N9IOYjAT8Nm19hX/Yzz4oIyh5h9MQvWlB4ra0eG3bG
         Jfmg==
X-Gm-Message-State: APzg51AJbamSRRGi+Q6rxye6PaxsqBMNmNvPKFLLVdrwqG13bq6Zf3rE
        +GpKH8YYCOm8ZNnDuXSP/Q8=
X-Google-Smtp-Source: ANB0VdZTJSu6Eo9/WZge5rkMS1GkfUmGknERxj2AV30hl9mU6gpWiN5nnz1u9E7ohTJ8d8ODHhtblA==
X-Received: by 2002:a1c:f703:: with SMTP id v3-v6mr2374396wmh.48.1535492128693;
        Tue, 28 Aug 2018 14:35:28 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j44-v6sm4294721wre.40.2018.08.28.14.35.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 28 Aug 2018 14:35:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tim Schumacher <timschumi@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc: Don't echo sed command for manpage-base-url.xsl
References: <20180828212104.2515-1-timschumi@gmx.de>
Date:   Tue, 28 Aug 2018 14:35:27 -0700
In-Reply-To: <20180828212104.2515-1-timschumi@gmx.de> (Tim Schumacher's
        message of "Tue, 28 Aug 2018 23:21:04 +0200")
Message-ID: <xmqqsh2ydvj4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tim Schumacher <timschumi@gmx.de> writes:

> Previously, the sed command for generating manpage-base-url.xsl
> was printed to the console when being run.
>
> For the purpose of silencing it, define a $(QUIET) variable which
> contains an '@' if verbose mode isn't enabled and which is empty
> otherwise. This just silences the command invocation without doing
> anything else.
>
> Signed-off-by: Tim Schumacher <timschumi@gmx.de>
> ---

I am not sure if this is a good change.  All these QUIET_$TOOL hide
details of running the $TOOL to produce the final output of the step,
but they still do report what they are creating via which $TOOL.

Shouldn't the step to create manpage-base-url.xsl be the same?  The
detail of creating it (i.e. token @@MAN_BASE_URL@@ is replaced with
the actual value) may want to be squelched, but shouldn't we still
be reporting that we are creating manpage-base-url.xsl file?

>  Documentation/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/Makefile b/Documentation/Makefile
> index a42dcfc74..45454e9b5 100644
> --- a/Documentation/Makefile
> +++ b/Documentation/Makefile
> @@ -217,6 +217,7 @@ endif
>  
>  ifneq ($(findstring $(MAKEFLAGS),s),s)
>  ifndef V
> +	QUIET		= @
>  	QUIET_ASCIIDOC	= @echo '   ' ASCIIDOC $@;
>  	QUIET_XMLTO	= @echo '   ' XMLTO $@;
>  	QUIET_DB2TEXI	= @echo '   ' DB2TEXI $@;
> @@ -344,7 +345,7 @@ $(OBSOLETE_HTML): %.html : %.txto asciidoc.conf
>  	mv $@+ $@
>  
>  manpage-base-url.xsl: manpage-base-url.xsl.in
> -	sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
> +	$(QUIET)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
>  
>  %.1 %.5 %.7 : %.xml manpage-base-url.xsl
>  	$(QUIET_XMLTO)$(RM) $@ && \
