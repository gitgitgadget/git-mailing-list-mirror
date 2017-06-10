Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BAD3F1F8CF
	for <e@80x24.org>; Sat, 10 Jun 2017 01:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751644AbdFJB3A (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 21:29:00 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33584 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbdFJB27 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 21:28:59 -0400
Received: by mail-pf0-f196.google.com with SMTP id w12so133962pfk.0
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 18:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=uMt7rUtZO6kg8GN48yijlO5qiwsM99aEM3wZKZLtGOc=;
        b=J9m5Pgtf/Ll8miMY/gxzIwgJ4D1tMQNhzB0r6Tz8ET/5NZ7UzGMhGqzqRjCF/PRet6
         qZJZXZYfK3DhDFHQyRencqbfhNcFxHDmvdQawXwdtrCcV2GXJItfOjOaFoYcucrCouR9
         Egvyck1mK5uRv6o4K7zfHWUJMa0GuY+hE5S9c3zt9v5Y42GyXqIriFbyF94qfUBHHPPH
         SFld6VlAXC3UDBcx8QrY+8OBmL7OymkzQ3qkEwP/Pd5W7vT6rSpUkaSBpMguQJXwV5lk
         IlFR3CXp9gfyhUOFqWL2NoyiJII5lpRMgt7CjyspTwp3FT9p7J9anMIoUscyBzZXgenc
         ShnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=uMt7rUtZO6kg8GN48yijlO5qiwsM99aEM3wZKZLtGOc=;
        b=gZ3I1jGDRiVw5H2dp2W3oGKTmh6cgLcvLv2pRTGAPAYCsjYOMuijdUpm9ddPUV73dI
         uuLvqgTrJHeYoyMTJTwC/bMQsgFD4u18jLpN5HbcoNQKceDM1kHAdRFr33gOwjeZ8Rt4
         MIvlnXaNtrojeL2b6boRsP9bNNLI5yAO891S9hW+VytJibGewl0flMmt1L6SxwR7s5cE
         XfaVbJuXuHoFfCsapMk+3ZcVy3skIotd0W6JSATXUhin8chlwi04yGqelhG8/FC1BC6x
         Sd0SZWjO5gXHoaN5M1JzOH0bgpTgSf1ESJqPE74DoQdlyoLeJPJSZ5QXJWLvkhP75s/Z
         bHSA==
X-Gm-Message-State: AODbwcBbZXTcm+zSPeJsruPXovdUDb3Yg8YRyzbyJEzLS/7WGA2Stjts
        7Y6kou6YckZSbA==
X-Received: by 10.98.67.138 with SMTP id l10mr45145884pfi.73.1497058138634;
        Fri, 09 Jun 2017 18:28:58 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id j6sm7685215pgc.1.2017.06.09.18.28.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 18:28:56 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/9] t1308: relax the test verifying that empty alias values are disallowed
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
        <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
Date:   Sat, 10 Jun 2017 10:28:55 +0900
In-Reply-To: <3325827e66b1a9e693f81e8aa4cae44f41dfdc25.1496851544.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Wed, 7 Jun 2017 18:06:47 +0200
        (CEST)")
Message-ID: <xmqqefus636w.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> We are about to change the way aliases are expanded, to use the early
> config machinery.
>
> This machinery reports errors in a slightly different manner than the
> cached config machinery.
>
> Let's not get hung up by the precise wording of the message mentioning
> the lin number. It is really sufficient to verify that all the relevant

s/lin/&e/;

> information is given to the user.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t1308-config-set.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> index ff50960ccae..69a0aa56d6d 100755
> --- a/t/t1308-config-set.sh
> +++ b/t/t1308-config-set.sh
> @@ -215,7 +215,9 @@ test_expect_success 'check line errors for malformed values' '
>  		br
>  	EOF
>  	test_expect_code 128 git br 2>result &&
> -	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
> +	test_i18ngrep "missing value for .alias\.br" result &&
> +	test_i18ngrep "fatal: .*\.git/config" result &&
> +	test_i18ngrep "fatal: .*line 2" result
>  '
>  
>  test_expect_success 'error on modifying repo config without repo' '
