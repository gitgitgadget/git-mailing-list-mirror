Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E3D1F61D
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 16:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C/+N61QT"
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F387B3860
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:53:56 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-27d8e2ac2b1so600917a91.2
        for <git@vger.kernel.org>; Mon, 16 Oct 2023 09:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697475236; x=1698080036; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nIRSPAQzOHJjj3vb19r9HAqzrbRORqkv/+q8Z2znRIs=;
        b=C/+N61QTJV9B5AuL9eWLfFjCyfJ3UiznY/22uNbVLbEOFVgXNvXLNeq3klXlzPJQ2W
         mUaG/sGBZM1yz1Pfbq83KHZomQzL1eDud89lToEsjrFVsubJJWmZR9If8lA6a+uJjmNj
         ZHJSO0tlrvcw5xspMimtMxhgq2Uz0pDKVywqxqRqG591Ubc/bclNJOK7Jtrq56iXF6hQ
         6dMyyhR/aTFcG+X4/9mOi7FYLhgyw0UFU52AhNcpZ8cOt20XSLpKrfYO/ZAdnlL0vbQK
         Mb/xm2kEF2t3Y7/sN7yf5+3nXUUwK2n2jV+EhCmLOC3VNJYsF5o8myZH6HUvAs0n7xpw
         c9Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697475236; x=1698080036;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nIRSPAQzOHJjj3vb19r9HAqzrbRORqkv/+q8Z2znRIs=;
        b=EZcEVAo4nUW5fu7RXuSRL9sd0fKA8F6bvrXq39ihQNoDKJkkZvQirUIdK1/BWEKi83
         nwDR/n5h2RU6TxKukqna1R83Rtasa4Us3IY+bbMUV5Nn5NnwL3PvpMJaqK4oq81phH9l
         wKq7WcMbswelxZEmyABes7ANdQ/PZvFAndGSsfLIusE4Gcypkk/baG22j1UzHAi0wkMU
         68uN0rnPLeDEsN7ERmdJfPZrIwCTkyVev9YcK7qdYhJi5wP+BDeEs2BEusEDhEV2aX22
         TW4FTC0Soq72iCXR6aMm6eMTNAxT2EY0Nxno1/1hd1w/35+te5BZXr0OrpbCwPNKA7YO
         tsmA==
X-Gm-Message-State: AOJu0Yx9n//5pxC7vxKM0az4rbwXFH5SE1t7X+nWCtpmNOtpEkoysF9q
	ryY9L8pYaOylQ5+hgj/ifmKK+705Ixg=
X-Google-Smtp-Source: AGHT+IFONk3ynooJPi5AvRXFbq9DSYh9nQRoiQ1xKJ6v7RpaO8Fbs2S8n6XEsETk0gTx5n1S4Z9dlg==
X-Received: by 2002:a17:90a:6e01:b0:27d:2ad2:4d9b with SMTP id b1-20020a17090a6e0100b0027d2ad24d9bmr8113481pjk.46.1697475236183;
        Mon, 16 Oct 2023 09:53:56 -0700 (PDT)
Received: from localhost (120.153.125.34.bc.googleusercontent.com. [34.125.153.120])
        by smtp.gmail.com with ESMTPSA id e7-20020a17090a804700b00263b9e75aecsm4859231pjw.41.2023.10.16.09.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 09:53:55 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Dorcas AnonoLitunya <anonolitunya@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org
Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
In-Reply-To: <20231016152113.135970-1-anonolitunya@gmail.com> (Dorcas
	AnonoLitunya's message of "Mon, 16 Oct 2023 18:21:00 +0300")
References: <20231016152113.135970-1-anonolitunya@gmail.com>
Date: Mon, 16 Oct 2023 09:53:55 -0700
Message-ID: <xmqq1qdumrto.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dorcas AnonoLitunya <anonolitunya@gmail.com> writes:

> Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions

Let's try if we can pack a bit more information.  For example

Subject: [PATCH] t7601: use "test_path_is_file" etc. instead of "test -f"

would clarify what kind of modernization is done by this patch.

> The test script is currently using the command format 'test -f' to
> check for existence or absence of files.

"is currently using" -> "uses".

> Replace it with new helper functions following the format
> 'test_path_is_file'.

I am not sure what role "the format" plays in this picture.
test_path_is_file is not new---it has been around for quite a while.

> Consequently, the patch also replaces the inverse command '! test -f' or
> 'test ! -f' with new helper function following the format
> 'test_path_is_missing'

A bit more on this later.

> This adjustment using helper functions makes the code more readable and
> easier to understand.

Looking good.  If I were writing this, I'll make the whole thing
more like this, though:

    t7601: use "test_path_is_file" etc. instead of "test -f"

    Some tests in t7601 use "test -f" and "test ! -f" to see if a
    path exists or is missing.  Use test_path_is_file and
    test_path_is_missing helper functions to clarify these tests a
    bit better.  This especially matters for the "missing" case,
    because "test ! -f F" will be happy if "F" exists as a
    directory, but the intent of the test is that "F" should not
    exist, even as a directory.


> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> index bd238d89b0..e08767df66 100755
> --- a/t/t7601-merge-pull-config.sh
> +++ b/t/t7601-merge-pull-config.sh
> @@ -349,13 +349,13 @@ test_expect_success 'Cannot rebase with multiple heads' '
>  
>  test_expect_success 'merge c1 with c2' '
>  	git reset --hard c1 &&
> -	test -f c0.c &&
> -	test -f c1.c &&
> -	test ! -f c2.c &&
> -	test ! -f c3.c &&
> +	test_path_is_file c0.c &&
> +	test_path_is_file c1.c &&
> +	test_path_is_missing c2.c &&
> +	test_path_is_missing c3.c &&

The original says "We are happy if c2.c is not a file", so it would
have been happy if by some mistake "git reset" created a directory
there.  But the _intent_ of the test is that we do not have anything
at c2.c, and the updated code expresses it better.
