Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8890A1F51C
	for <e@80x24.org>; Mon, 28 May 2018 09:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933843AbeE1JZ0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 May 2018 05:25:26 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34445 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933834AbeE1JZV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 May 2018 05:25:21 -0400
Received: by mail-wr0-f193.google.com with SMTP id j1-v6so19161402wrm.1
        for <git@vger.kernel.org>; Mon, 28 May 2018 02:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=b7U4zM9O3JSSwJ1oT6BMOMnggFwG7G3cHieiD/YpGUY=;
        b=oykGF4XuKCLkorXtXOm4twVYhWx21/dMI3WmEuWMG2r3KPT0eRbECsYAN/doVT1jdQ
         PBlhPEeHYJluZJCVbKIOd8CHN7aIhUY+kpqb9ADBPi68hfGsbGL+OdYoHY2qLl1qGoqS
         +sIugFeIhkxXUpKeL05Pb0ymCxB7Qb6rzh0EgkP+9x5UDi3ePHQywuQgwXrccCyAnXGa
         e/9T45XeMao14a4dJ0dlAEMWKQMRNXwPl8qpUFw0v9YDlXIKlU+PGy2s4CUJJBaBZ9On
         OA544bOsW4eKCuj12H8HOsvvcxI80ZxFRO5jRRdF0V6z0buVcCII8BF3jmRbFTwhXGD1
         370A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=b7U4zM9O3JSSwJ1oT6BMOMnggFwG7G3cHieiD/YpGUY=;
        b=j3rh0GOrBIHgSaLevnp82gMVW52Fss5xDoDmm+mycALkXcO2GgQZzyhybEqbxSoToE
         rY9uWuPGdgkH+vRN2P4tbQhGeaxr1n4yx8dP+fIbh58EsPlZpZqwJI2n7faEEoaj33Ys
         9hex7TkNawP4bbextnE0psKRRNdOHR0n3KJ7hgD5O66I7YCTY9OgFCzkAg7zD81XqWp+
         VNKXAiylbUfYhUdt/UerRkg7YSuFlTFdh/YTgSSeNmAvLknH2MhLqiewicLR1XUNaXyh
         ll5bQWzo1cNsEg4isOhbXkYSoCCS2Gqk1EfTLabCqDwulveZ5UY7RKa8OAhCPVbSn5GU
         aplQ==
X-Gm-Message-State: ALKqPwcT8b2MhtpK+zHKskdyX6Pkp3SQQuc9cbgRY7yI+HX4yFPnKhCO
        A+P4MaT9KVUWmXv6PezDd2E=
X-Google-Smtp-Source: AB8JxZqqO6SN8zG3F6DGrNws8+E6gBaTB6MCI29UV5t72XI7j7QC98QQz33oeHN30V+Raz9HYIFHlw==
X-Received: by 2002:adf:b310:: with SMTP id j16-v6mr9201835wrd.207.1527499519379;
        Mon, 28 May 2018 02:25:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u89-v6sm13826796wma.4.2018.05.28.02.25.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 May 2018 02:25:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH 2/3] usage: prefix all lines in `vreportf()`, not just the first
References: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
        <cover.1527279322.git.martin.agren@gmail.com>
        <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
Date:   Mon, 28 May 2018 18:25:18 +0900
In-Reply-To: <ef5b4e28e00ad0c95dbe625d2e7305957f9fe5ba.1527279322.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 25 May 2018 23:00:54
 +0200")
Message-ID: <xmqqin78jfnl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> diff --git a/t/t1011-read-tree-sparse-checkout.sh b/t/t1011-read-tree-sparse-checkout.sh
> index 0c6f48f302..31b0702e6c 100755
> --- a/t/t1011-read-tree-sparse-checkout.sh
> +++ b/t/t1011-read-tree-sparse-checkout.sh
> @@ -243,9 +243,9 @@ test_expect_success 'print errors when failed to update worktree' '
>  	test_must_fail git checkout top 2>actual &&
>  	cat >expected <<\EOF &&
>  error: The following untracked working tree files would be overwritten by checkout:
> -	sub/added
> -	sub/addedtoo
> -Please move or remove them before you switch branches.
> +error: 	sub/added
> +error: 	sub/addedtoo
> +error: Please move or remove them before you switch branches.
>  Aborting
>  EOF

This shows the typical effect of this series, which (I subjectively
think) gives us a more pleasant end-user experience.

> diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
> index 4ee009da66..80d35087b7 100755
> --- a/t/t1506-rev-parse-diagnosis.sh
> +++ b/t/t1506-rev-parse-diagnosis.sh
> @@ -11,7 +11,7 @@ test_did_you_mean ()
>  	sq="'" &&
>  	cat >expected <<-EOF &&
>  	fatal: Path '$2$3' $4, but not ${5:-$sq$3$sq}.
> -	Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
> +	fatal: Did you mean '$1:$2$3'${2:+ aka $sq$1:./$3$sq}?
>  	EOF

And this, too.

> diff --git a/usage.c b/usage.c
> index 80f9c1d14b..6a5669922f 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -34,7 +34,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	prefix_suffix_lines(stderr, prefix, msg, "");
>  }

