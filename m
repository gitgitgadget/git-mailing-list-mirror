Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BB9AD1F404
	for <e@80x24.org>; Wed, 21 Feb 2018 18:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752133AbeBUSou (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Feb 2018 13:44:50 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33907 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751610AbeBUSot (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Feb 2018 13:44:49 -0500
Received: by mail-wr0-f194.google.com with SMTP id m5so7336481wrg.1
        for <git@vger.kernel.org>; Wed, 21 Feb 2018 10:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=RPWqKsdD35CpQbFXTfmNJ0+QtllgVQqDRdZ6Ay2vjSg=;
        b=jvY3RPtYubHPOvfnHIc81FOTOmKsSvsVa3aQuwQfIfk3zTOfQ1QzwixyNa7dl2I2gt
         vgfMmlwyKPNIoslb4QXJX90LuggZBFXf9re6LC6kP7iEyhIMLDpTvR5Yn5walOV4zUC8
         QsvFgzgwXdhrVF1wSWCyo6o+eaAWHcyQr05oXjmtPkWVOCHOg0qVV73OMstp9erS2W1/
         ZPqGDgVACPGcPQ7bgugp1iarbAvcJ4mS842KZppZDRioG0t8aCs2gervPVtirgYv0eHg
         /2QVj//yMi2x49Xo2SVNQMIjZL72NSIqKvQFrDcoXniEc5tRbvHGems4Kbq42Dw3ESmy
         H/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=RPWqKsdD35CpQbFXTfmNJ0+QtllgVQqDRdZ6Ay2vjSg=;
        b=lqVhG8iXSGVE9dh6svyUqZ7mOJ/XeTJy/az9dX6meA46ae7dEpFM+uJzAFuB4UQ+Nq
         Bvl4NPQ6kUes3LJaxnDAju0WMemdOlUl30U0KUG8USKywj/DoZczqaKPO0h9/1aADvCu
         SZdwub8QTajhh9puxbjCaD9ppG/EN6+6l29McoFvYOa08+Ss6IXmqP/UOoxPFgAKfN+v
         +iRrz4bKDu8Mig5s3bmVLLHfvUWZViyWSip9iBEfvIUtef9vIFv0hJEbKXB0oL6wPky2
         KHXlBjDz9a6cwVVOHckSvFiokfolrnrgYvDQiUapQHG7dvZoSSfNTyPLXvQ8d3UVBsEF
         tBCA==
X-Gm-Message-State: APf1xPB465h9u8w3Paoflwi80Js6sWCQfxVxAdtVgCl+f/f08CXWl28V
        kTvNHPlJJ1znCV/G/KAtCNuHBin9
X-Google-Smtp-Source: AH8x226i79pW9Lozxn3VsTix5gFVBOibDt/sU96LBLoHjszJNhG4QOnQ7rNP209J4WVcQH74lDlAIg==
X-Received: by 10.28.249.18 with SMTP id x18mr3004908wmh.49.1519238688042;
        Wed, 21 Feb 2018 10:44:48 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id s125sm8253854wmf.4.2018.02.21.10.44.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Feb 2018 10:44:47 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] submodule: indicate that 'submodule.recurse' doesn't apply to clone
References: <20180220202922.220568-1-bmwill@google.com>
Date:   Wed, 21 Feb 2018 10:44:46 -0800
In-Reply-To: <20180220202922.220568-1-bmwill@google.com> (Brandon Williams's
        message of "Tue, 20 Feb 2018 12:29:22 -0800")
Message-ID: <xmqqlgfmyyg1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> Update the documentation for the 'submodule.recurse' config to identify
> that the clone command does not respect it.
>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  Documentation/config.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Thanks.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index f57e9cf10..59ff29d7a 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3210,7 +3210,8 @@ submodule.active::
>  
>  submodule.recurse::
>  	Specifies if commands recurse into submodules by default. This
> -	applies to all commands that have a `--recurse-submodules` option.
> +	applies to all commands that have a `--recurse-submodules` option,
> +	except `clone`.
>  	Defaults to false.
>  
>  submodule.fetchJobs::
