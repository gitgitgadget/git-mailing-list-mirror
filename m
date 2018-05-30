Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B698C1F42D
	for <e@80x24.org>; Wed, 30 May 2018 12:35:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeE3Mfh (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 May 2018 08:35:37 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:37206 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751656AbeE3Mfg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 May 2018 08:35:36 -0400
Received: by mail-wr0-f193.google.com with SMTP id i12-v6so29392973wrc.4
        for <git@vger.kernel.org>; Wed, 30 May 2018 05:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z3CiUPyG2qacKrqpoYrpJp2S7lmny0Qy7kTpbGT7va8=;
        b=reoGrkBhuLugTuuvV5cpOib/41wfRREPIDpGepAVhO6a+1EMRGq+lTL89JNcaRpUBE
         yWFHcw+7W30zNxeRq9q5bWt1lrpJiKafyew5CNPvCYwlhMi8NQdVrWXDLA292UZn3IXK
         Daspm55LeoGi+U6wjuq9eMmnsFFkWw9mtUC8kKwMnvQTEoc/Hip4V/RkRmjJyzamaY2Q
         wU2kwhV1MM6BIUANLHS2gHQj0yd1wmZh2buzD9jDloPFXwsKbiohYJWa5kJMtWnwzndE
         kgfJddQz3tPyyhyJ28t11da3XNeaAPeSQ5c9Cg40kCzcXmOaY102tYU5RQCUcOjdf/E4
         iD8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z3CiUPyG2qacKrqpoYrpJp2S7lmny0Qy7kTpbGT7va8=;
        b=SNpr3DQCW5dYsV4ypQMjha0Qb+gCQB9iC7uacVi9h4k3oGB+NQ1M2aoXFvd3+tyJvx
         JW9PYlG1SkzQcy7FqfSg1vInAvnjCIO/Xx5Bsqv0jg9vb3cUp/Uxo8HtMNaqM9ZD/hPH
         rgTWlj0CJz7opnN55c/eJgzs9uxUgBxY7N5tPeAiXNQndT1Xm175LCTGotKK2dbU8Ebf
         dUpUCkCsM4U9cqpqXxWNbCZjYvH8XuLLHiAK++FIW1JYNZytLqcI9rFOGvDpKj+oIf9B
         lcinZpBSDui5clvNrw8dvJJRSBnfyiD3GS6m28ZAerOAlcBePta66CuWAm4jjH81qTXB
         9fSA==
X-Gm-Message-State: ALKqPwcUjIu8ZiSWHi/0s0UUV/Q0v7VkDF54pOq2KN6ogYe7saiHNl/F
        +4IRks/iK+XeHKgMgAxn4+mwSw==
X-Google-Smtp-Source: ADUXVKL23xm58Et1S+EahBEj8Bxf6LhL3RSHD6JLvYvc+oT4bbrRO4xws7EVD7L8XJbvJJs3o4KqFQ==
X-Received: by 2002:adf:c444:: with SMTP id a4-v6mr2123596wrg.20.1527683735408;
        Wed, 30 May 2018 05:35:35 -0700 (PDT)
Received: from localhost.localdomain (x590c60bd.dyn.telefonica.de. [89.12.96.189])
        by smtp.gmail.com with ESMTPSA id n11-v6sm32077029wrh.10.2018.05.30.05.35.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 May 2018 05:35:34 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jnareb@gmail.com" <jnareb@gmail.com>,
        "stolee@gmail.com" <stolee@gmail.com>,
        "avarab@gmail.com" <avarab@gmail.com>,
        "marten.agren@gmail.com" <marten.agren@gmail.com>,
        "peff@peff.net" <peff@peff.net>
Subject: Re: [PATCH v3 16/20] commit-graph: verify contents match checksum
Date:   Wed, 30 May 2018 14:35:29 +0200
Message-Id: <20180530123529.32090-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.17.1.1124.gac09da1361
In-Reply-To: <20180524162504.158394-17-dstolee@microsoft.com>
References: <20180511211504.79877-1-dstolee@microsoft.com> <20180524162504.158394-1-dstolee@microsoft.com> <20180524162504.158394-17-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/commit-graph.c b/commit-graph.c
> index d2b291aca2..a33600c584 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -841,6 +841,7 @@ void write_commit_graph(const char *obj_dir,
>  	oids.nr =3D 0;
>  }
> =20
> +#define VERIFY_COMMIT_GRAPH_ERROR_HASH 2
>  static int verify_commit_graph_error;
> =20
>  static void graph_report(const char *fmt, ...)
> @@ -860,7 +861,9 @@ static void graph_report(const char *fmt, ...)
>  int verify_commit_graph(struct commit_graph *g)
>  {
>  	uint32_t i, cur_fanout_pos =3D 0;
> -	struct object_id prev_oid, cur_oid;
> +	struct object_id prev_oid, cur_oid, checksum;
> +	struct hashfile *f;
> +	int devnull;
> =20
>  	if (!g) {
>  		graph_report("no commit-graph file loaded");
> @@ -879,6 +882,15 @@ int verify_commit_graph(struct commit_graph *g)
>  	if (verify_commit_graph_error)
>  		return verify_commit_graph_error;
> =20
> +	devnull =3D open("/dev/null", O_WRONLY);
> +	f =3D hashfd(devnull, NULL);
> +	hashwrite(f, g->data, g->data_len - g->hash_len);
> +	finalize_hashfile(f, checksum.hash, CSUM_CLOSE);
> +	if (hashcmp(checksum.hash, g->data + g->data_len - g->hash_len)) {
> +		graph_report(_("the commit-graph file has incorrect checksum and is likely corrupt"));

This error message is translated ...

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 240aef6add..2680a2ebff 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh

> @@ -388,4 +389,9 @@ test_expect_success 'detect incorrect parent for octopu=
> s merge' '
>  		"invalid parent"
>  '
> =20
> +test_expect_success 'detect invalid checksum hash' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
> +		"incorrect checksum"

... but here in 'corrupt_graph_and_verify' you look for "incorrect
checksum" with plain 'grep' (as opposed to 'test_i18ngrep', which
won't find that string in a GETTEXT_POISON build, and ultimately
causes the test to fail.

