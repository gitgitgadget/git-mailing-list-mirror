Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E3211F453
	for <e@80x24.org>; Tue, 29 Jan 2019 23:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728208AbfA2XB3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 18:01:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44196 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727488AbfA2XB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 18:01:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id z5so23935090wrt.11
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=be5qmgS0FxyI05Ay7lfHiarQ9vTS4hS4oFatxyAuk7g=;
        b=eDmryJOfBwaDfTWfvGbN9TtzVvzY+FsRxBWrUQw40Lg3V2kZuT2gf3+FuTjOUNt7rP
         ETbCNsdy8KhhtV52ZHRxAuzD9Ipz13mahfv3qzjkw50OO2lapwutdXfh8fXWaFkIeIXK
         1TDQATIkt9YrC+9FdsWkK2QBOGrcwEiHAQMIQiD7RpN+BKZSBvo9zvZweHk6cqPXYcXu
         EbVOpg1qiBLQzi/fXaFPFUua5xgMQFoXxbVswOZGMmITyy8ittNcL1yA1/9At214/0fD
         hcAq6ZlvXVdbJfB0unqtTqYCElQlj2PhP0DtOXiwHFUUP5RgZMeJ8S4EwYqvFf7fJRHX
         zewg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=be5qmgS0FxyI05Ay7lfHiarQ9vTS4hS4oFatxyAuk7g=;
        b=iwiz2HZXAEYraMqC0hVNchfM41uOG7JLIFYHEvB5gZjV8N2mI8uCdYjPSbYwVZgG7N
         GH/AALzzwp2USEshVu1KcXfwPQTXjWgVSc8aIzg7xmMyZfZwxCU9OGabkrZMCddPDiFI
         i+CH4BmMFajOE9BzoTBCArgCDbKujOJNA+/yeYk7pk3r5NcfcX6srN8EpAn74pcKIsI1
         dqYI114ttQEF8Xsvd4LIixXMZAnLZd0AKI/uo+YmU87lgvS/u9M2c5avjgH1Sd6yFMo6
         CsDTVfTD5HnAfBnbdm6w4l1lpRWODBBjnWy1j1PvE1LcqfpmDkrYrU1Rk4EH1JOv3Tws
         uvlw==
X-Gm-Message-State: AJcUukc03sZ5Y++weth3NaXF6fQN/olW9zs1JQnausFGwI2yHoPNDCgE
        K9F8sXgzS8YxWgy7goIEEu/iemQc
X-Google-Smtp-Source: ALg8bN7whpAxuyY6F4IBtZZdfEHA1iCaWjF4F5MAWjiGhd3lMY0i2bMRyQ4xIk4Bz2bcbWQSX3KK/w==
X-Received: by 2002:a5d:664a:: with SMTP id f10mr27334785wrw.311.1548802886923;
        Tue, 29 Jan 2019 15:01:26 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s3sm154338wmj.23.2019.01.29.15.01.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Jan 2019 15:01:26 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH (Apple Git) 07/13] HTML documentation is not provided with Apple's git. Make the error message more on point.
References: <20190129193818.8645-1-jeremyhu@apple.com>
        <20190129193818.8645-8-jeremyhu@apple.com>
Date:   Tue, 29 Jan 2019 15:01:26 -0800
In-Reply-To: <20190129193818.8645-8-jeremyhu@apple.com> (Jeremy Huddleston
        Sequoia's message of "Tue, 29 Jan 2019 11:38:13 -0800")
Message-ID: <xmqqsgxb5ard.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeremy Huddleston Sequoia <jeremyhu@apple.com> writes:

> Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
> ---
>  builtin/help.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index 7739a5c155..e001b6157c 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -383,7 +383,7 @@ static void get_html_page_path(struct strbuf *page_path, const char *page)
>  	if (!strstr(html_path, "://")) {
>  		if (stat(mkpath("%s/git.html", html_path), &st)
>  		    || !S_ISREG(st.st_mode))
> -			die("'%s': not a documentation directory.", html_path);
> +			die("HTML documentation is not provided by this distribution of git.");

Mentioning HTML in the message may be a good idea, but I feel that
"distribution of git" is not something we should say in the source
for those who are building from the source.  Distributors are free
to munge before they generate their binary distribution, of course
;-).

>  	}
>  
>  	strbuf_init(page_path, 0);
