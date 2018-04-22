Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E2F51F424
	for <e@80x24.org>; Sun, 22 Apr 2018 23:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753595AbeDVX2S (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Apr 2018 19:28:18 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44664 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeDVX2R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Apr 2018 19:28:17 -0400
Received: by mail-wr0-f196.google.com with SMTP id o15-v6so36270746wro.11
        for <git@vger.kernel.org>; Sun, 22 Apr 2018 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=JzJIYvZkCEy3KsTRla6357JbaahV4LBXS2brLGgUGIo=;
        b=QDQ6iPihPVKmalQzjFrx/AmACIjtjNihAGo5MTNVCQy+Vkced3tsjynm0wStNM8pEH
         2VSDLPdF+J9m6U8iVqrQedvFjjHoSP4g3EBaTHs6kJUxZABhUvu8Ghb7JiacGbnk9YvY
         UN+sBRqJ7DoWnFa/KzGFHUocqDbCkA1gjBaV2pB9ntMcaDMx/Z8BIvsYF5dXCJxJtwni
         /p/vcD1I5Cva7pwjALRfpz2hNEM0+dKA3CWClZ2a17VNbjAo2o59S6rSMN1HAbYRAmLo
         jRomjI9UihQmH8ph7UeNDHo15eLYgqAWldLkZur7fZXfsNenJgtUkkr6pfQbbd2ifNou
         5jtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=JzJIYvZkCEy3KsTRla6357JbaahV4LBXS2brLGgUGIo=;
        b=QiPH732geeu3wh/PkqIPBoU5TPL9frzoRmDqoCVnFaw+2Lqo+Tys7gY3sMKd44Ybml
         h7EoA4GoREeCurGrvIASdbNPkbHHkywJcB81vskoMIuOfXm4UMNPF0EGzXP548Ze141q
         vyJ49/eLVh9Vvphz03f/xtz2Y31n6GkLwA6CEfUwD4aenhCXzfFw82BjHDZnERjjdAhy
         dt+rEzXn2lDgjYkAhXEIqGmC7VAD/bgDhMQriCMyRiuEn82FPl0M3W5LB1HpBqB4jCR3
         gKotZAkSKdu7MpZFRg7iUbHrSFSOyzeWDVhtyBW82qlZRPZkjyIXKYt0E7IdUgVokgyK
         O7+A==
X-Gm-Message-State: ALQs6tCRJeQlsmK7zrleLkLmxip9nK8/QVpRHr+DCu9AOE2Bczlzg8OD
        pcTmOMfQMh7oMs6ZKINk6is=
X-Google-Smtp-Source: AIpwx4/+IAtbzXckN6b5ExYYMO+5dXrsBBgPiu8fLPhQOf1amBiIGTmpFKEjOcwtHDBS1pQa35N4ag==
X-Received: by 10.28.131.21 with SMTP id f21mr8554576wmd.78.1524439696045;
        Sun, 22 Apr 2018 16:28:16 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c14sm7350070wmi.28.2018.04.22.16.28.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 22 Apr 2018 16:28:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, l.s.r@web.de, martin.agren@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v2 0/6] Teach '--column-number' to 'git-grep(1)'
References: <20180421034530.GB24606@syl.local>
        <cover.1524429778.git.me@ttaylorr.com>
Date:   Mon, 23 Apr 2018 08:28:14 +0900
In-Reply-To: <cover.1524429778.git.me@ttaylorr.com> (Taylor Blau's message of
        "Sun, 22 Apr 2018 13:47:20 -0700")
Message-ID: <xmqqsh7makj5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>   * Removed '-m' as an alias for '--column-number', per René's
>     suggestion [1].
>
>   * Fix some incorrect spelling of 'columnnumber'.
>
>   * Change casing of 'color.grep.linenumber' to 'color.grep.lineNumber'
>     to be consistent with 'color.grep.columnNumber'. This is an
>     unrelated change, and one which I am happy to drop from this series.
>     It was suggested by Martin in [2].

All sounds like good updates.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 0cf654824d..7349c7fadc 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -106,7 +106,7 @@ do
>  			echo ${HC}file:5:foo mmap bar_mmap
>  			echo ${HC}file:14:foo_mmap bar mmap baz
>  		} >expected &&
> -		git -c grep.linenumber=false grep -m -w -e mmap $H >actual &&
> +		git grep --column-number -w -e mmap $H >actual &&
>  		test_cmp expected actual
>  	'
>
> @@ -117,7 +117,7 @@ do
>  			echo ${HC}file:4:5:foo mmap bar_mmap
>  			echo ${HC}file:5:14:foo_mmap bar mmap baz
>  		} >expected &&
> -		git -c grep.linenumber=false grep -n -m -w -e mmap $H >actual &&
> +		git grep -n --column-number -w -e mmap $H >actual &&
>  		test_cmp expected actual
>  	'

It seems that these two used to be "even when it is configured not
to show linenumber, with -n it is shown and without -n it is not,
when the new --column-number feature forces the command to show the
"filename plus colon plus location info plus coon" header.  I'm
guessing that the reason why these got changed this round is because
the old way was found too defensive (perhaps nobody sets
grep.linenumber in .git/config in the tests that come before these)?

