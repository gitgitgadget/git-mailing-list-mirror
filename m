Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71E441F453
	for <e@80x24.org>; Fri, 18 Jan 2019 21:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729502AbfARVCH (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 16:02:07 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51878 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729474AbfARVCH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 16:02:07 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so5768298wmj.1
        for <git@vger.kernel.org>; Fri, 18 Jan 2019 13:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=JVB5HSHIhsh7LZ0j18OaSi6ON/da2u5Pio0nZpxHW+A=;
        b=HzQP0/8ye3EWkzohyI4siA9/n6lNt/MAQb9CINqKxtH4lhAC+C8G2CODhNmeh8loa+
         vlHSwqFCgG7CPsQM2X3dsqaaP4ERPjg7JcWExdFGtdoORszfKV8cZazMIlIfd+NrqCuq
         8RTUOgwf0mXknUz5jt5cWzMOkTTZ7t3pi4xm2R+4G8/q5vHouHqvF0otNaU973YHz/sU
         nZpnRFI0JRnZ8iYsAvYpjOUFxRopUedW5fuSXzKLpmtdy+G/GhSOJfarX5biLm6WyRT6
         t84WBUftJl25ZLQC25kqLGNWDN8TduLXN5nKzoqFHA7THa18M1ttyeIyDlh8EJqeeiEn
         Imdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=JVB5HSHIhsh7LZ0j18OaSi6ON/da2u5Pio0nZpxHW+A=;
        b=azMfvHlU5Vmdlu8GtzqtQZZAqG+TIt+3cP0qBfGA/VPsjlrLHNEIITvcohiHvuRkte
         8Krjsu9Gt0r+vyMHstg/mA+JQydIfXmecDt/lyQtgziDRF5HFxWoOG1QgYR73ilz7F6c
         xEQ/KkNoJxBig5qp30QcN+qARJWZMqcYaUhbhTO9U5uKl/u3uUQuP9AvK1AIhxRWJwyd
         fOYZAkLC8WdWU+W5XFN8J38+QLQY9eX1zR3VfGqTtgGflMlHqSTAUzykhUcqAy7qJvwb
         pMqf5Cqltwgqnx0vf7EOlS+eyBMPp+C6Nx488tivO8Ln1+OVYc3a3rkxMx4eYklk70ij
         2M8w==
X-Gm-Message-State: AJcUukd1tpB5x+6w3sX5ilqz8SuUaLyrNh6WqlZWuw1r7a07WoI+67bZ
        rFU711/qWbtIwWoBCYrp1Ho=
X-Google-Smtp-Source: ALg8bN5lrLAlYd01iYXbawZxmUcdTVBvErUTDNrrKECZgtNpGnWqDVgH9KX8mgrXQo+GjWoB0RP+Vg==
X-Received: by 2002:a1c:a913:: with SMTP id s19mr16122225wme.4.1547845324140;
        Fri, 18 Jan 2019 13:02:04 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c13sm94984657wrb.38.2019.01.18.13.02.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 18 Jan 2019 13:02:03 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Richardson <brandon1024.br@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit-tree: add missing --gpg-sign flag
References: <20190118010918.43705-1-brandon1024.br@gmail.com>
Date:   Fri, 18 Jan 2019 13:02:02 -0800
In-Reply-To: <20190118010918.43705-1-brandon1024.br@gmail.com> (Brandon
        Richardson's message of "Thu, 17 Jan 2019 21:09:18 -0400")
Message-ID: <xmqqy37hiss5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Richardson <brandon1024.br@gmail.com> writes:

> -		if (skip_prefix(arg, "-S", &sign_commit))
> +		if(!strcmp(arg, "--gpg-sign")) {

Style.  "if (!strcmp(arg, "--gpg-sign")) {"

> +		    skip_prefix(arg, "--gpg-sign", &sign_commit);
> +		    continue;

Technically, skipping the prefix S of string S will make us point at
an empty substring at the end.  So from that point of view,
skip_prefix(arg, "--gpg-sign", &sign_commit) is not incorrect
per-se, but it is highly misleading.  We have already determined
that the user gave us "--gpg-sign" option without anything after it,
so we want to summon the "use the default key" behaviour by giving
an empty string to sign_commit.

An explicit assignment

	sign_commit = "";

would be a lot more readable and make the intent a lot more clear.

> +		}
> +
> +		if (skip_prefix(arg, "-S", &sign_commit) ||
> +			skip_prefix(arg, "--gpg-sign=", &sign_commit))

This side is OK.  "-S" gives us an empty string, but "-Skeyid" gives
us "keyid" in sign_commit.

>  			continue;
>  
>  		if (!strcmp(arg, "--no-gpg-sign")) {
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 86d3f93fa..efc136eaf 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -51,7 +51,9 @@ test_expect_success GPG 'create signed commits' '
>  	# commit.gpgsign is still on but this must not be signed
>  	git tag ninth-unsigned $(echo 9 | git commit-tree HEAD^{tree}) &&
>  	# explicit -S of course must sign.
> -	git tag tenth-signed $(echo 9 | git commit-tree -S HEAD^{tree})
> +	git tag tenth-signed $(echo 10 | git commit-tree -S HEAD^{tree})
> +	# --gpg-sign must sign.
> +	git tag eleventh-signed $(echo 11 | git commit-tree --gpg-sign HEAD^{tree})
>  '
>  
>  test_expect_success GPG 'verify and show signatures' '
