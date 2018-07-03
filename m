Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E521F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 19:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753013AbeGCTXk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 15:23:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:54554 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752105AbeGCTXj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 15:23:39 -0400
Received: by mail-wm0-f67.google.com with SMTP id i139-v6so3445565wmf.4
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 12:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=tv0UeiEXG47XYEuxfjm6/ZQUorEoHPKm/UAA0qVtCm4=;
        b=GBdUdeXkLZzNvZNeleRzitBRvNbKql0YrkVuEE0RYK+wAWhQ+Ypm/dikXXmprAcEtk
         8jNpDahX7gXvHf19JwuhCcQpKgeZQnDk8E0FdGbtMjuFNejr6OGHvr3iAS22OGA6lwWP
         TIsu+z+104gV8isDi8Ep+6QK+LuRqSvWb7HaLWqFeWO7BNHus8iyfLNf9ZEbG7z75y3y
         4wNVFnf8QWSlw4KRjBSNfV2MaG6hvfMub4WF3rs8ad6zqbipSkO3dvWIxIar4ZFQX9Xv
         icKRtCqEAs12Sd/K/n+Y1H+rir9/6LnQc88ulwocdHoEWg5m3xm7P+XSLk/TWNZk5W48
         QIwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=tv0UeiEXG47XYEuxfjm6/ZQUorEoHPKm/UAA0qVtCm4=;
        b=T74ZmISN9280RCT5Bv75HpZr6kqSaeDG5jmONzYlMBOsaBhMzeBw3Adr7mn7QmZpu6
         jc/+565iu5Lf4fYXsKhOiWLrMw9g3SbNLUj7uyvZFHEZHtTHSAmZCinYp/aCUttLOM5y
         hThR8lORLmiDRc7eFAsrrtXMI60lgVnNcw6t/amZzKj086jEtpn1q/BOKXvsMlvyosKz
         BMiYWZ3soMkWL9l62/g09sBwY1x15Axe/tZmQCQbhfBt/JTMwK9tb6PhM40DYqVS95R8
         xrwJhyb+3y0Bwcr5C06TmsKW2SPMrwuhQrq3HzIWs6EtV1lWaDyWBOj8FO7REevZ1tzr
         8Oyw==
X-Gm-Message-State: APt69E3gYojvWX3JDifAeu+edyJOpurldMIFUu3x0W+Ei1iNxqpBjmWi
        pDEg1YLwANMInQowE4c414wZkAxb
X-Google-Smtp-Source: AAOMgpdgILxQzKsyvP6QM61J2SvW7mwRPhdJ33YPf2hlLsVNyJnqtYmo7y/RzXtM/IH+xrrA+nzDbQ==
X-Received: by 2002:a1c:d8:: with SMTP id 207-v6mr10922870wma.99.1530645818116;
        Tue, 03 Jul 2018 12:23:38 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id t11-v6sm2602921wrg.23.2018.07.03.12.23.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 12:23:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Stefan Beller <sbeller@google.com>,
        Luke Diamand <luke@diamand.org>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 04/25] t: drop unnecessary terminating semicolon in subshell
References: <20180702002405.3042-1-sunshine@sunshineco.com>
        <20180702002405.3042-5-sunshine@sunshineco.com>
Date:   Tue, 03 Jul 2018 12:23:37 -0700
In-Reply-To: <20180702002405.3042-5-sunshine@sunshineco.com> (Eric Sunshine's
        message of "Sun, 1 Jul 2018 20:23:44 -0400")
Message-ID: <xmqqefgkqg1y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  t/t3102-ls-tree-wildcards.sh    | 2 +-
>  t/t4010-diff-pathspec.sh        | 4 ++--
>  t/t9400-git-cvsserver-server.sh | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t3102-ls-tree-wildcards.sh b/t/t3102-ls-tree-wildcards.sh
> index e804377f1c..1e16c6b8ea 100755
> --- a/t/t3102-ls-tree-wildcards.sh
> +++ b/t/t3102-ls-tree-wildcards.sh
> @@ -23,7 +23,7 @@ test_expect_success 'ls-tree outside prefix' '
>  	cat >expect <<-EOF &&
>  	100644 blob $EMPTY_BLOB	../a[a]/three
>  	EOF
> -	( cd aa && git ls-tree -r HEAD "../a[a]"; ) >actual &&
> +	( cd aa && git ls-tree -r HEAD "../a[a]" ) >actual &&
>  	test_cmp expect actual
>  '

Nice clean-up.  

I still find it irritating that ( ...; ) is merely unnecessary but
not incorrect, while lack of semicolon in { ...; } is a hard error
;-)
