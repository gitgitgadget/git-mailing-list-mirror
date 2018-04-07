Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36D0D1F404
	for <e@80x24.org>; Sat,  7 Apr 2018 22:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeDGW7I (ORCPT <rfc822;e@80x24.org>);
        Sat, 7 Apr 2018 18:59:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:39951 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752080AbeDGW7H (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Apr 2018 18:59:07 -0400
Received: by mail-lf0-f66.google.com with SMTP id e5-v6so5139685lfb.7
        for <git@vger.kernel.org>; Sat, 07 Apr 2018 15:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=/AX6WQbs7q6wOLjp3fOuoBNvkSR8zslpZONlj5RVS/g=;
        b=BhL2RYIotdcjTmpjDKUAmhVM9GATvoG0p9XThr0nrxzaZyTpVziiqIcj5jfhZDLJfM
         NF3H9cveNwDNgVc2hQwbRazZRgSAzCQYkGrqeiPTA9aIEQHwbHQByjW0JaGcgkGCqBLP
         K0cZYhTplHtGKcUzYi92z4zgTWYRJCk88WUdGj+kVPvWY1uP46J/Qi8Z9ghTt9RwVMBf
         plpkA6n1/QgxCblHdBUF1ADE+kpwamdW8aUl9WpDd8l/JgjWcZcJYvwfc04PstUWqZu4
         dw8532l9VMW3VscQGlCb3GJHO4x3JCYTfCHEgd1TtTS34kLQ2OdDXCcU/rcm32nXUnhj
         pTKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=/AX6WQbs7q6wOLjp3fOuoBNvkSR8zslpZONlj5RVS/g=;
        b=ZkSZYzG3LDVPbvwUTFClWh91iSO1C1CyUR8FJL/wTdLn70LAx6qsKzjzthv8ZuPUBX
         YeQor9Z1ztt+0GwLgogjFbmi+AdZUqSvKJNoaSNr2sO1RQmdhm5+bPAJYeUyAPu9ktc9
         ixWkJkpljhdPKCB0qHTNFVNm7fzZpryZSmW72KFh77a5FnkD649BOHpESCo8xjbd6Wez
         HopB7Hwf1tUG8NIEEBm3D2qtYIgMHBqkfUf6a8fb7RZVSdIuC1LZ1mkn1RbYoOlzOVbS
         EGEZv4AHHjJQYtfiriQRF0x6cPISP3h3fnpg4KLUXCMMV3mDEjfxFzs+uPkAcbWuJ4F+
         8uyw==
X-Gm-Message-State: AElRT7FvurrYNpszd0BYB/tSoG5zyg8q07TPADuZxDPMmL1TVc0LEhfm
        phw7ML28tIgdguc5g6MLx2M=
X-Google-Smtp-Source: AIpwx49TzYQQY5IGe6xSgkPYEdbwDDsbP2UNnToU9UkNshcuSOcUsCjmotQG5xoTo7ToAPHhZ0JWMg==
X-Received: by 10.46.16.1 with SMTP id j1mr20160364lje.102.1523141945953;
        Sat, 07 Apr 2018 15:59:05 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (aga121.neoplus.adsl.tpnet.pl. [83.25.156.121])
        by smtp.gmail.com with ESMTPSA id d4-v6sm2729570lfg.65.2018.04.07.15.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 07 Apr 2018 15:59:04 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        szeder.dev@gmail.com, ramsay@ramsayjones.plus.com,
        git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v7 02/14] csum-file: refactor finalize_hashfile() method
References: <20180314192736.70602-1-dstolee@microsoft.com>
        <20180402203427.170177-1-dstolee@microsoft.com>
        <20180402203427.170177-3-dstolee@microsoft.com>
Date:   Sun, 08 Apr 2018 00:59:01 +0200
In-Reply-To: <20180402203427.170177-3-dstolee@microsoft.com> (Derrick Stolee's
        message of "Mon, 2 Apr 2018 16:34:15 -0400")
Message-ID: <86lgdyei8a.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> If we want to use a hashfile on the temporary file for a lockfile, then
> we need finalize_hashfile() to fully write the trailing hash but also keep
> the file descriptor open.
>
> Do this by adding a new CSUM_HASH_IN_STREAM flag along with a functional
> change that checks this flag before writing the checksum to the stream.
> This differs from previous behavior since it would be written if either
> CSUM_CLOSE or CSUM_FSYNC is provided.

I'm sorry, but I don't understand from this description what this flag
does and what it is meant to do.

> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---

[...]
> diff --git a/csum-file.h b/csum-file.h
> index 9ba87f0a6c..c5a2e335e7 100644
> --- a/csum-file.h
> +++ b/csum-file.h
> @@ -27,8 +27,9 @@ extern void hashfile_checkpoint(struct hashfile *, stru=
ct hashfile_checkpoint *)
>  extern int hashfile_truncate(struct hashfile *, struct hashfile_checkpoi=
nt *);
>=20=20
>  /* finalize_hashfile flags */
> -#define CSUM_CLOSE	1
> -#define CSUM_FSYNC	2
> +#define CSUM_CLOSE		1
> +#define CSUM_FSYNC		2
> +#define CSUM_HASH_IN_STREAM	4

Especially that it is not commented / described here, and the name is
unsufficiently descriptive for me.

[...]
> diff --git a/csum-file.c b/csum-file.c
> index e6c95a6915..53ce37f7ca 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -61,11 +61,11 @@ int finalize_hashfile(struct hashfile *f, unsigned ch=
ar *result, unsigned int fl
>  	the_hash_algo->final_fn(f->buffer, &f->ctx);
>  	if (result)
>  		hashcpy(result, f->buffer);
> -	if (flags & (CSUM_CLOSE | CSUM_FSYNC)) {
> -		/* write checksum and close fd */
> +	if (flags & CSUM_HASH_IN_STREAM)
>  		flush(f, f->buffer, the_hash_algo->rawsz);

Wouldn't CSUM_FLUSH be a better name for this flag?

> -		if (flags & CSUM_FSYNC)
> -			fsync_or_die(f->fd, f->name);
> +	if (flags & CSUM_FSYNC)
> +		fsync_or_die(f->fd, f->name);
> +	if (flags & CSUM_CLOSE) {
>  		if (close(f->fd))
>  			die_errno("%s: sha1 file error on close", f->name);
>  		fd =3D 0;

--
Jakub Nar=C4=99bski
