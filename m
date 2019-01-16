Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611091F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 11:24:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732752AbfAPLYV (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 06:24:21 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:33928 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730420AbfAPLYU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 06:24:20 -0500
Received: by mail-wr1-f44.google.com with SMTP id j2so6530904wrw.1
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 03:24:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=WbAzIPApcCXjTqINSORrz4qIKfhbstK+37boPh+BBN4=;
        b=SfpHnfJhaNBJZLi4f/UVQsbJEWueH1Ih5qH2FNRyBEp6/gKGCmUsrIE3iciZzaCtNO
         R3bt6PVEMx1zWB7+bBYvjsoYeghYwQBHXEISIyFAiv4+Hwxf1M1Zp83rPpdARC0qy72e
         Bhr342pldJ2VKzZtkaj+u3aVAAYlnr1FEuOt/DGCJWnVEWiHoQD0ZiceAmmE71nBAOY8
         9HjGYx3ViIE9OS2EXZC3Y+7YsfxVOnRP6WHROje0SGP1QHB5vqM/9geO7+cA97Gyf5s5
         KgPlkDLlE0XmgrsGPl1dV5rP8AON6Cg3Iig3YcEINxuArGr0a88jyGmtzs8WixR+Xtzd
         UuIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=WbAzIPApcCXjTqINSORrz4qIKfhbstK+37boPh+BBN4=;
        b=KdMUFp3HtCW+mQIaBI0A59JPyItkDcps08zEgE21S8jSSLWjG7Dwcxtdqaq8zIguW7
         g4SwyegP9yIbu9DNSSFC+Bg2SL64225XXl3MlbVj6n+jA56Zu2O0+QxbAYt8Tgkontix
         i56Mj4iaMJdECCRVQ2uZmOTv41f7VXWOF6GUlVk4grR/iZxrmrswCUgVgFIyEFvJ5YdX
         2UAAus0e1uRM+yvkQh+FhpY4LI1AZo0QB4nLjKz5DtjONUtdP4S3zPA3bD6Bpb+aF1/X
         5R8N1sfqnW4WjpAPB+6pBhcnr6Tp5juFRRKzb9WJGqv+GqLsP9WDPsAuu4NfurHbk4h8
         ZygQ==
X-Gm-Message-State: AJcUukf3cZp1gjjmi7dxFZdcU1q0IKahfaiQ+dljnHpkDqCBnlvpV9Zk
        hADCMhjgSaDmkLhpYfzeCus=
X-Google-Smtp-Source: ALg8bN7Cf3qlTuyLIqbtgPLp8B5rPD4DP3S891hepvLFzl8kM5HhMMZv3EdlMpijDoYcSWEZbaSEHA==
X-Received: by 2002:adf:8c09:: with SMTP id z9mr7135811wra.301.1547637858880;
        Wed, 16 Jan 2019 03:24:18 -0800 (PST)
Received: from evledraar (i40217.upc-i.chello.nl. [62.195.40.217])
        by smtp.gmail.com with ESMTPSA id f2sm92150991wre.34.2019.01.16.03.24.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 03:24:17 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, szeder.dev@gmail.com,
        zhiyou.jx@alibaba-inc.com
Subject: Re: [PATCH/RFC v1 1/1] test-lint: sed -E (or -a, -l) are not portable
References: <20190110115704.GL4673@szeder.dev> <20190115203038.10574-1-tboegi@web.de>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190115203038.10574-1-tboegi@web.de>
Date:   Wed, 16 Jan 2019 12:24:17 +0100
Message-ID: <87pnsw4zha.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 15 2019, tboegi@web.de wrote:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> From `man sed` (on a Mac OS X box):
> The -E, -a and -i options are non-standard FreeBSD extensions and may not=
 be available
> on other operating systems.
>
> From `man sed` on a Linux box:
> REGULAR EXPRESSIONS
>        POSIX.2 BREs should be supported, but they aren't completely becau=
se of
>        performance problems.  The \n sequence in a regular expression mat=
ches
>        the newline character,  and  similarly  for \a, \t, and other sequ=
ences.
>        The -E option switches to using extended regular expressions inste=
ad;
>        the -E option has been supported for years by GNU sed, and is now
>        included in POSIX.
>
> Well, there are still a lot of systems out there, which don't support it.
>
> Beside that, see IEEE Std 1003.1TM-2017
> http://pubs.opengroup.org/onlinepubs/9699919799/
> does not mention -E either.
>
> To be on the safe side, don't allow it.
>
> Reported-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> I am somewhat unsure if we should disable all options except -e -f -n
> instead ?
> /\bsed\s+-[^efn]/ and err 'Not portable option with sed. Only -n -e -f ar=
e portable';
>
> That would cause a false positive in t9001 here:
> "--cc-cmd=3D./cccmd-sed --suppress-cc=3Dself"
>
> which could either be fixed by an anchor:
> /^\s*sed\s+-[^efn]/
>
> Or by allowing '--' like this:
> /\bsed\s+-[^-efn]/
>
> Any thoughts, please ?
>
> t/check-non-portable-shell.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
> index b45bdac688..96b6afdeb8 100755
> --- a/t/check-non-portable-shell.pl
> +++ b/t/check-non-portable-shell.pl
> @@ -35,7 +35,7 @@ sub err {
>  		chomp;
>  	}
>
> -	/\bsed\s+-i/ and err 'sed -i is not portable';
> +	/\bsed\s+-[Eail]/ and err 'Not portable option with sed. Only -e -f -n =
are portable';
>  	/\becho\s+-[neE]/ and err 'echo with option is not portable (use printf=
)';
>  	/^\s*declare\s+/ and err 'arrays/declare not portable';
>  	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';

I'd just go for your /\bsed\s+-[^-efn]/ suggestion. Just a note if we do
go for the whitelist: According to GNU sed's manpage -E is also known as
-r, so /\bsed\s+-[Erail]/ would be better.
