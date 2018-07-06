Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 480A01F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 20:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933936AbeGFUVO (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 16:21:14 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54457 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932328AbeGFUVN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 16:21:13 -0400
Received: by mail-wm0-f66.google.com with SMTP id i139-v6so15821417wmf.4
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 13:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=BjaMtAJH+Rynkd2374YIBZIqde1tFekXiLZPDLqNwD4=;
        b=Sc+iX02XmG2W5o+8iXkJxjlWsxM62PexjwPI3Zr2jMQgbM9iN1A5Rh+JcsT9F0Wozg
         x7AB0bD1Xq33z2lMUOCc+TdUYiYbc5yPYZB8o2074HzQM4Zym2Pmb0kkiNHlPISqwn+2
         mE9O0xnbGve6PmNkNCXj7HI1XfFA3xzbk2mLdpCGPm7gDT29G22Pve8SF7JjYmIe8mxF
         A+f156MCgCIkYJeUh8tCU5XtxkQLyMbPbS/RXHWjtLdNAmGJbHDYvJkeZeQn9DylfwoU
         X9vO96WikgWZzECKIPCFRRrcnQQp9l49S1N1Y6AtXxMzhKlH57seAAc+DhGTbocUq11p
         XgHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=BjaMtAJH+Rynkd2374YIBZIqde1tFekXiLZPDLqNwD4=;
        b=IWoaH3mEwu/smUPl0T+2b8LLSzueNdlYQripMc7Ag42ZdI2yf2sbods+14ve6PbcVH
         MTvLp8XsG+ImVvIXReMwsSwT8j7QiEMdS7ZckU61tc1l2768kEZaOjNW1HFuQbTPQFWi
         dQ0bsV0Qlx5Bj4xjXZsS3TjEWhJlB4PRrkf2W/iP0/OpXKW3OA8lkbjzYrnujSXF46AF
         0CjHTfdG/21JmxBOdNbdx/Z1JiDu7eP+4/wKcHtE3z/jpgLYT8hVvz3aEwRko3KOkwz/
         tF6U2cFq0wToPHPi4lTs1ttXhFFSRFiORgVpr4qVEVYJqB0XIA3NvnAYRTx0wMi/HvRW
         6YcQ==
X-Gm-Message-State: APt69E0MJXVpX8FJfy+cnkNi0Hgdm3uz95bIfltfl8MNG7VN4jeH3weA
        y3YJdObAyJnHf7KZyizo7Xg=
X-Google-Smtp-Source: AAOMgpc24M+QPtbSYOTwb/fTIRkt6IJFd5n8S1mSt7lAxu9RBd9iWP1zsZK41S+XkOx6HCrLTyrLEw==
X-Received: by 2002:a1c:928c:: with SMTP id u134-v6mr6979151wmd.106.1530908472196;
        Fri, 06 Jul 2018 13:21:12 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id x10-v6sm9010041wrn.25.2018.07.06.13.21.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 13:21:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     git@vger.kernel.org, Ben Toews <mastahyeti@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 5/8] t/t7510: check the validation of the new config gpg.format
References: <cover.1530616446.git.henning.schild@siemens.com>
        <cover.1530616446.git.henning.schild@siemens.com>
        <9fd9d0d2ee3ae549baf8e9a710dfffbc118e66f7.1530616446.git.henning.schild@siemens.com>
Date:   Fri, 06 Jul 2018 13:21:10 -0700
In-Reply-To: <9fd9d0d2ee3ae549baf8e9a710dfffbc118e66f7.1530616446.git.henning.schild@siemens.com>
        (Henning Schild's message of "Tue, 3 Jul 2018 14:38:17 +0200")
Message-ID: <xmqqfu0wjetl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Henning Schild <henning.schild@siemens.com> writes:

> Valid values are already covered by all tests that use GPG, now also
> test what happens if we go for an invalid one.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> ---
>  t/t7510-signed-commit.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
> index 6e2015ed9..cb523513f 100755
> --- a/t/t7510-signed-commit.sh
> +++ b/t/t7510-signed-commit.sh
> @@ -227,4 +227,14 @@ test_expect_success GPG 'log.showsignature behaves like --show-signature' '
>  	grep "gpg: Good signature" actual
>  '
>  
> +test_expect_success GPG 'check gpg config for malformed values' '
> +	mv .git/config .git/config.old &&
> +	test_when_finished "mv .git/config.old .git/config" &&

Hmmmmm.  

Is the damage caused by throwing a bad value at gpg.format designed
to be so severe that "test_when_finished test_unconfig ..." cannot
recover from?  This test script is not about how "git config" is
implemented and works, so it would be a good idea for it to be even
oblivious to the fact that .git/config is the file being mucked with
when we do "git config".

I have a suspicion that you can just use test_config (which would
arrange "test_when_finished test_unconfig ..." for free).

> +	git config gpg.format malformed &&
> +	test_expect_code 128 git commit -S --amend -m "fail" 2>result &&

Is this 128 something we document and have users rely on?  Or should
we rather say

	test_must_fail git commit ...

here instead?

> +	test_i18ngrep "malformed value for gpg.format: malformed" result &&
> +	test_i18ngrep "fatal: .*\.git/config" result &&
> +	test_i18ngrep "fatal: .*line 2" result
> +'
> +
>  test_done
