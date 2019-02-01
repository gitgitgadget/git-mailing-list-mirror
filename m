Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640F51F453
	for <e@80x24.org>; Fri,  1 Feb 2019 18:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfBASxa (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Feb 2019 13:53:30 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43192 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728681AbfBASxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Feb 2019 13:53:30 -0500
Received: by mail-wr1-f65.google.com with SMTP id b4so1289990wrq.10
        for <git@vger.kernel.org>; Fri, 01 Feb 2019 10:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=VWjFiA142uTby09pehvYkt/LemCsYsVJP/9kN3K5t9Y=;
        b=d1K73XUEWC+oWNOsLSs6NYmKwPZDbaKKRgQHAJX9+1xGRmmRF0OaJGsGKyJLykrx6w
         E+6CfO2zqjcLsAtAev70bvoliNLfFlx4L6zDReR+Q7Lqt0ihTGrzdIw2ERrE8ir/JYT6
         X0XdHUS2hZgdkM3Ilux3Gv/4uoxfJLpX9WMULJ2pojWIHxS+v+qh/L+VulHTc3sM7p/C
         BHqSisbJsJJn6xO5MEmt/oSPEQrXOku8iG7HmAWtHJdO06J7Thi2LUISHD7bOX3gYHq9
         b6yVJD8sRA4GO/fNphnpu33ciK/bULiegI/NPCAc3Ufi7OLKzMFxODRyIf2GxLUCueyu
         bmyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=VWjFiA142uTby09pehvYkt/LemCsYsVJP/9kN3K5t9Y=;
        b=WdiZzih7KXuP6DhOHbaKrmAf6qTACrtsasp6dX81dFzaTNYI0YYvQSF71Ote1uBAU1
         lPTUQUS5GQSoSoqxdxOSoz0O9YR6V4NyEI2rLFtVYpnqw8VvbB1GWljA7SHssmebL/lk
         +cXRd7Q+XnkNbMQuwQaV5t4cGKQE1dU/AiDcqroaTZQt9DMslm8nUzJ0D3eahfQEC8B8
         h0j955a850wrwFygI0lLRxCqPsh8dkU6dffw6IJwvSE8YcrlyPqkKELJHM6ilZIsanOD
         Eazu8zwD7zm5H5bdNtpbyO9Wdx2JRo3E8lAXVbXVOMVhJSe2JxuKTed0f1laWHrr6aZI
         wjSw==
X-Gm-Message-State: AJcUukce+huJAjIey27wPuWNtmMDrjQ4PdggDi3jKyxlOf9swTfya8aF
        0Df4optkQ+h0lNpTmOxMunw=
X-Google-Smtp-Source: ALg8bN5ZPwzShl9nDf38+J7hfq26GovXv+7LrrqAu0HQMo0Zg8fB2J3SHV7HF8E2b4RxIBF1qdb4+w==
X-Received: by 2002:adf:bb44:: with SMTP id x4mr41465793wrg.24.1549047208463;
        Fri, 01 Feb 2019 10:53:28 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id e27sm9032713wra.67.2019.02.01.10.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 10:53:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sebastian Staudt <koraktor@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v4 2/2] t6120: test for describe with a bare repository
References: <20190201135512.68220-1-koraktor@gmail.com>
        <20190201135512.68220-2-koraktor@gmail.com>
Date:   Fri, 01 Feb 2019 10:53:27 -0800
In-Reply-To: <20190201135512.68220-2-koraktor@gmail.com> (Sebastian Staudt's
        message of "Fri, 1 Feb 2019 14:55:12 +0100")
Message-ID: <xmqq7eejz6fs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sebastian Staudt <koraktor@gmail.com> writes:

> This ensures that nothing breaks the basic functionality of describe for
> bare repositories. Please note that --broken and --dirty need a working
> tree.
>
> Signed-off-by: Sebastian Staudt <koraktor@gmail.com>
> ---
>  t/t6120-describe.sh | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index 7cfed77c52..ea2c3dbe1c 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -418,4 +418,9 @@ test_expect_success 'describe complains about missing object' '
>  	test_must_fail git describe $ZERO_OID
>  '
>  
> +test_expect_success 'describe works from outside repo using --git-dir' ' 
> +  git clone --bare "$TRASH_DIRECTORY" "$TRASH_DIRECTORY/bare" &&
> +  git --git-dir "$TRASH_DIRECTORY/bare" describe
> +'

OK, it demonstrates that the command exits with status 0.  Do we
want to validate its output, too?
