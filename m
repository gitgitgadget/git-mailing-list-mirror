Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B33D01F453
	for <e@80x24.org>; Tue, 22 Jan 2019 20:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbfAVUNw (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 15:13:52 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38372 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfAVUNw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 15:13:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so28892647wrw.5
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 12:13:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=UrDEz4DzqnMcw9VHCeYpPFSdEu84yU4qyRRHHreUvLM=;
        b=oPrDWpNO/v5PsIa/V85R9QQQkDnnGYbpfg6JTfJ4bRb/lDi0XqtTAh6OWTtjSreBoz
         sO64D5M8cuZIaY4VrC0AvfmJBf0MECPeCotSehm8Q663/FHTlSJW8dffqejig0fYdGBe
         /NNB2syNHTRmYicsVZTQN29TA/J36B5J0O7Ek3oPUV7Ul5j5MWC+o4Eh5Tn+Tk50g9vd
         SNx1fJ6vw/cBKNsY3fMauBxQgPRoZiA/OMMUjIrwL8173AI+pADUuP3QC3hTaqTQi+H8
         TBCcrBmLjtKyyXtSC59b6I5OuhwHCdljiTx8TvkImIDddHnVEaGE64UySDzGx8REdABa
         Ra+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=UrDEz4DzqnMcw9VHCeYpPFSdEu84yU4qyRRHHreUvLM=;
        b=GFicxTJt6liZ+oBQOIbLPT7DGKb9h9EejnzDSCXwGh1A5hef+3psjbhTFSOTEfOcCW
         6LBfLFGatATQQAc+0ln15xFquqlpspZ3V8httrsq4FAgTGi91ckKAmv9glribcb9yngp
         l+F76iWPCoWovxGpO51qw2ZZla7pbm+GAcm3zPwm40JhUpqfLtNH8+gsfKHBQSSoEe34
         G30cZZTOOQVDCYTObANxSK7rRU0IouFilY1Gri780M0VmTtucLja1Hiy2jnt4UUUga6j
         BzG+rZppVGGR8eNsoOpeDmFwdZgWzZtenzWRYZPbGBoqNQlj/npYO1IuRANRLotexZmA
         TYhg==
X-Gm-Message-State: AJcUukdZIW997dXbav5WXW13/iy0hqOs4WgsfBBNF+qmj82fZlgIBiWQ
        4KdL42QAse9OqihncubvK2g=
X-Google-Smtp-Source: ALg8bN4mslSSRvUGla37wsALmUwxQTZ+tSmstqiqjvenzmvRk8mko3sJ739iB+wZDOeANp/wuQ18qg==
X-Received: by 2002:adf:9d4c:: with SMTP id o12mr32447093wre.94.1548188029736;
        Tue, 22 Jan 2019 12:13:49 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 198sm98048501wmt.36.2019.01.22.12.13.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 12:13:49 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, adrigibal@gmail.com
Subject: Re: [PATCH v2 1/1] Support working-tree-encoding "UTF-16LE-BOM"
References: <CADN+U_PUfnYWb-wW6drRANv-ZaYBEk3gWHc7oJtxohA5Vc3NEg@mail.gmail.com>
        <20190120164327.3234-1-tboegi@web.de>
Date:   Tue, 22 Jan 2019 12:13:48 -0800
In-Reply-To: <20190120164327.3234-1-tboegi@web.de> (tboegi's message of "Sun,
        20 Jan 2019 17:43:27 +0100")
Message-ID: <xmqqk1iwfo1v.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> The unicode standard itself defines 3 possible ways how to encode UTF-16.
> a) UTF-16, without BOM, big endian:
> b) UTF-16, with BOM, little endian:
> c) UTF-16, with BOM, big endian:

Is it OK to interpret "possible" as "allowed" above?

> iconv (and libiconv) can generate UTF-16, UTF-16LE or UTF-16BE:
>
> d) UTF-16
> $ printf 'git' | iconv -f UTF-8 -t UTF-16 | od -c
> 0000000  376 377  \0   g  \0   i  \0   t

So among three, encoder can only do "big endian with BOM" (c).

Lack of (a) "big endian without BOM" in the encoder is not a problem
in practice, as you can ask UTF-16BE to produce the stream, tell the
decoder that you have UTF-16 and the lack of the BOM would make the
decoder take it as (a).

But lack of (b) "little endian with BOM" is a problem.

So the proposal is to invent UTF-16-[BL]E-BOM that prepends BOM in
front of UTF-16-[BL]E output to allow those who want (b).

Which makes sense, I guess.  I do find it a bit ugly in the sense
that it is something iconv should learn to do, as the issue is
shared with all applications that want to use libiconv and convert
into UTF-16.

Do you add UTF-16-BE-BOM for consistency?  It would be identical to
telling iconv to encode to UTF-16, if I understood your problem
description correctly.

> diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
> index b8392fc330..4a88ab8be7 100644
> --- a/Documentation/gitattributes.txt
> +++ b/Documentation/gitattributes.txt
> @@ -343,13 +343,13 @@ automatic line ending conversion based on your platform.
>  ------------------------
>
>  Use the following attributes if your '*.ps1' files are UTF-16 little
> -endian encoded without BOM and you want Git to use Windows line endings
> +endian encoded with BOM and you want Git to use Windows line endings
>  in the working directory. Please note, it is highly recommended to
>  explicitly define the line endings with `eol` if the `working-tree-encoding`
>  attribute is used to avoid ambiguity.
>
>  ------------------------
> -*.ps1		text working-tree-encoding=UTF-16LE eol=CRLF
> +*.ps1		text working-tree-encoding=UTF-16LE-BOM eol=CRLF
>  ------------------------

This change is robbing from those who do want a file without BOM to
give to those who do want a file with BOM.  Are the latter class of
people the majority of the intended readers (read: Windows folks)?

I wonder if the following, instead of the above hunk, would work better:

 endian encoded without BOM and you want Git to use Windows line endings
-in the working directory. Please note, it is highly recommended to
+in the working directory (use `UTF-16-LE-BOM` instead of `UTF-16LE` if
+you want UTF-16 little endian with BOM).
+Please note, it is highly recommended to
 explicitly define the line endings with `eol` if the `working-tree-encoding`

> @@ -540,10 +546,30 @@ char *reencode_string_len(const char *in, size_t insz,
>  {
>  	iconv_t conv;
>  	char *out;
> +	const char *bom_str = NULL;
> +	size_t bom_len = 0;
>
>  	if (!in_encoding)
>  		return NULL;
>
> +	/* UTF-16LE-BOM is the same as UTF-16 for reading */
> +	if (same_utf_encoding("UTF-16LE-BOM", in_encoding))
> +		in_encoding = "UTF-16";
> +
> +	/*
> +	 * For writing, UTF-16 iconv typically creates "UTF-16BE-BOM"
> +	 * Some users under Windows want the little endian version
> +	 */
> +	if (same_utf_encoding("UTF-16LE-BOM", out_encoding)) {
> +		bom_str = utf16_le_bom;
> +		bom_len = sizeof(utf16_le_bom);
> +		out_encoding = "UTF-16LE";
> +	} else if (same_utf_encoding("UTF-16BE-BOM", out_encoding)) {
> +		bom_str = utf16_be_bom;
> +		bom_len = sizeof(utf16_be_bom);
> +		out_encoding = "UTF-16BE";

OK, you do allow BE-BOM and the code does not rely on the fact that
iconv happens to produce it with "UTF-16", because the library is
free to switch between the three possible output (a)-(c) and we do
not want to get affected by such a switch.  Makes sense.

