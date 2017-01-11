Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 855811FEB3
	for <e@80x24.org>; Wed, 11 Jan 2017 09:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932290AbdAKJsr (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 04:48:47 -0500
Received: from mail-wj0-f194.google.com ([209.85.210.194]:33127 "EHLO
        mail-wj0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751808AbdAKJsq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 04:48:46 -0500
Received: by mail-wj0-f194.google.com with SMTP id kp2so90040436wjc.0
        for <git@vger.kernel.org>; Wed, 11 Jan 2017 01:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cRbL8/2Q6N0rlHgcDe6aXkJQ+9wHFADWE/Yiwr70qUg=;
        b=ECCAkW+3rvSJoEzspCRX7Elwy1wI5m6LQBdVMUZfN9RPCFcvlEmtTg7M5FHow7Zbl8
         uLUtCKxFk/X8jJZpMoLl2qov2zbweIcV3P81el3tWShHGZeUFTxLcjerB6JJMIjj37mM
         86eOezlxqcOdlIExvYVhX6eMPCR11Gbwis5vwp35KaIfAGf4bCKI1K2ieAmvJ48gmrzV
         LkyG55dm5IZOv7YWFvC6wpRWcFcOgWcxEdyt0rKU7PbXZJ3P1JH4n2r417f+FO3zNQ/G
         t7Y7CgrT6oHNnOlzrK1wq3uZWYbWempxzi+bVhzcUuJ8XkCeh2jt2NvyzX6Kvb24eWFr
         8Z2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=cRbL8/2Q6N0rlHgcDe6aXkJQ+9wHFADWE/Yiwr70qUg=;
        b=JHwhLhKlbkC0LmZh63tgJ0RBqa2hpKBliQh2NMX9KA+Ismis69QurZMj78dVf0tIuB
         raY1gpMazh/CJcKerLUqKWTgwVNax6tJFTbd7Us6CJqhsgVj0o0RbkOO3X5xeZC94yyU
         oxihmuFLjkeKZ3LJO85hAhnn446AYsJReCzUAIy68ygMnGgzP6VFaBSk6L+Y10xLlome
         FeXZXJgJCZ3LhmJVh8anISZNrSdYlxEZ/S4rmT9f789HZoM7JMmng7LN3FyVuUULWu9R
         GR8c19MnE3ekWbmRe4WoTQq0lPMElbLPJijZ9DYi2tsyDb6KRQWk4eLxvJDUlvP7hDov
         rAYg==
X-Gm-Message-State: AIkVDXI52L/yIfl6RShzUdLi/UOa9WImYNTtRjyBVGKQbJsOpuhAz483IAFCwzphMbGkAg==
X-Received: by 10.194.108.10 with SMTP id hg10mr5281549wjb.58.1484128124637;
        Wed, 11 Jan 2017 01:48:44 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5866.dip0.t-ipconnect.de. [93.219.88.102])
        by smtp.gmail.com with ESMTPSA id f76sm8099807wmd.15.2017.01.11.01.48.43
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 Jan 2017 01:48:44 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1] convert: add "status=delayed" to filter process protocol
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170108201415.GA3569@tb-raspi>
Date:   Wed, 11 Jan 2017 10:48:43 +0100
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Taylor Blau <ttaylorr@github.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <8267E408-85B2-457E-8B14-5C476343378A@gmail.com>
References: <20170108191736.47359-1-larsxschneider@gmail.com> <20170108201415.GA3569@tb-raspi>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 08 Jan 2017, at 21:14, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On Sun, Jan 08, 2017 at 08:17:36PM +0100, larsxschneider@gmail.com =
wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> Some `clean` / `smudge` filters might require a significant amount of
>> time to process a single blob. During this process the Git checkout
>> operation is blocked and Git needs to wait until the filter is done =
to
>> continue with the checkout.
>>=20
>> Teach the filter process protocol (introduced in edcc858) to accept =
the
>> status "delayed" as response to a filter request. Upon this response =
Git
>> continues with the checkout operation and asks the filter to process =
the
>> blob again after all other blobs have been processed.
>>=20
>> Git has a multiple code paths that checkout a blob. Support delayed
>> checkouts only in `clone` (in unpack-trees.c) and `checkout` =
operations.
>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>>=20
>=20
> Some feeling tells me that it may be better to leave =
convert_to_working_tree() as it is.
> And change convert_to_working_tree_internal as suggested:
>=20
> int convert_to_working_tree(const char *path, const char *src, size_t =
len, struct strbuf *dst)
> {
> -	return convert_to_working_tree_internal(path, src, len, dst, 0);
> +	return convert_to_working_tree_internal(path, src, len, dst, =
NULL, 0);
> }

If I do this then I would have no way to communicate to the caller that =
the
processing is delayed. Consequently the caller would not know that an =
additional
call is necessary to fetch the result.

Thanks,
Lars=
