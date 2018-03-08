Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B12A71F404
	for <e@80x24.org>; Thu,  8 Mar 2018 23:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751187AbeCHXdd (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 18:33:33 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:43421 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751173AbeCHXdb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 18:33:31 -0500
Received: by mail-wr0-f194.google.com with SMTP id a63so3729976wrc.10
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 15:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=IsclHQPtuQQQle0+/VEopjCFFNs9wsOjNiI+mVqu2ng=;
        b=M4nxkNEvqzKeU4bwKc/+YS91prkP/9VxmI3e6UUOf5akC4f3gXTaYHfBQdWjR8VZdo
         kwQJxXiOdM92YTbYvYtdC11T8Vb/PDmTjqzraoHXHOelnslIIL52Yi3kt7yxb6AKpijQ
         VYY75JKfNoYC13kmFyjtViaF8k3NiUTet1VgJvvt/kHBS9bmoDFFdMlpOSsLc63Xg4o1
         qESwoOr4PeAyflZobRgg/IXyWFurvSdLVeZjMM25U4O6QsXq27AcwP3mMFyzALHl7zmI
         SHdytdOUBHf95OnsADbqyWhGFgRJKly4Tq0fu0K1TXh4JlGl99CboLPKeY8ucBOvIJsH
         bhsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=IsclHQPtuQQQle0+/VEopjCFFNs9wsOjNiI+mVqu2ng=;
        b=rMdWDU3yhGd6NFGORHKZRGsNppC5ACkv6gEW5TL0HThFZvYcAi55m2yB4Z6CkzNR/E
         uJFs4G3Bdy7rfFzXrZJWvWR0Yl/IQZWKIdkCkqw6PV/dPTMw5dKbF4Ysn7hbuLGzk3nP
         u3ZhRT8uQ05r/fPP836B3fi8nSGac6K+7XDP5cpRgRuSB0XAu0uO+tsDI2G4oS9FqkiR
         ULC/Z3VdmxzyBQSsS0q3Q148g+dS9jgA0Mvri4kEXr/e1hi4ytS2PmbMwN9ZYHugNSDV
         fxboI6j7S7Gx1st1HOEMOUzK9Jq2BgJp8LluHTYBh2UBOd/lkeiL1R9CNS3t42d59hrn
         xcHw==
X-Gm-Message-State: APf1xPDrHbc1DM8pIroH5zBKP1PjspCzl979kImh9/R1lvq6DB0w81V0
        ovstADd6JiN6pKB88nCuP/I=
X-Google-Smtp-Source: AG47ELsWu3P3ABDolkmRBMo8d1yq6nXWxE+XSHK1j7OUXA8z61XgHcUbTKSQk1NVaOQ6Mb9w13iBrw==
X-Received: by 10.223.192.76 with SMTP id c12mr23090631wrf.177.1520552009292;
        Thu, 08 Mar 2018 15:33:29 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id u127sm10081wmd.30.2018.03.08.15.33.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 08 Mar 2018 15:33:28 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1.1 1/2] t9400-git-cvsserver-server: don't rely on the output of 'test_cmp'
References: <CAPig+cRSDbFZ_C9opu3pr=m7HwFkeuoxUD_8Yqbd4XxX-W0cHg@mail.gmail.com>
        <20180308224458.5730-1-szeder.dev@gmail.com>
Date:   Thu, 08 Mar 2018 15:33:28 -0800
In-Reply-To: <20180308224458.5730-1-szeder.dev@gmail.com> ("SZEDER
 =?utf-8?Q?G=C3=A1bor=22's?=
        message of "Thu, 8 Mar 2018 23:44:58 +0100")
Message-ID: <xmqqzi3i6t2v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> diff --git a/t/t9400-git-cvsserver-server.sh b/t/t9400-git-cvsserver-server.sh
> index c30660d606..5ff3789199 100755
> --- a/t/t9400-git-cvsserver-server.sh
> +++ b/t/t9400-git-cvsserver-server.sh
> @@ -449,10 +449,9 @@ test_expect_success 'cvs update (-p)' '
>      GIT_CONFIG="$git_config" cvs update &&
>      rm -f failures &&
>      for i in merge no-lf empty really-empty; do
> -        GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out
> -	test_cmp $i.out ../$i >>failures 2>&1
> -    done &&
> -    test -z "$(cat failures)"
> +	GIT_CONFIG="$git_config" cvs update -p "$i" >$i.out &&
> +	test_cmp $i.out ../$i || return 1
> +    done
>  '

This makes "rm -f failures &&" unnecessary, no?
