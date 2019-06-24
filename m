Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95B2B1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 13:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbfFXNaP (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 09:30:15 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39155 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728926AbfFXNaP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 09:30:15 -0400
Received: by mail-qk1-f194.google.com with SMTP id i125so9700979qkd.6
        for <git@vger.kernel.org>; Mon, 24 Jun 2019 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dhnZFaWtCLkgAhw8tKVzTytqbf5vauIqf4eTAEFbwFE=;
        b=eQmqgAgx0tLFbbSLOsPuy6EBU/OMgdRKlU+rpTnthu6cVBXnZGOQw9BtGy/att0yx7
         3uHRLH1S7A9CONiuA7r0kx3uq1p1wgE9XdIoZfZznvpOx0DzmjF/7qhNcEIYmtGkCBoc
         u2yoKG3OP7KyrvTNX93lYbzo9IOKxok9WgK663BgDsgi5xkFc6mo8y2cY7WOWUcEhgRL
         bdEFIfhQG4dam02Qx6ZeuwGzzAFgifgTJW8fwRaVSvGXY9H2AOk2G3f+xJL7059ot7c7
         7meG0xplnt2GySI3hNUQJFQGJDlhg/eSSokYPUjpRY007MpM+6p460G6/5qneiYsgmfo
         MPuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dhnZFaWtCLkgAhw8tKVzTytqbf5vauIqf4eTAEFbwFE=;
        b=EEg/jqc5Zquan3H5A8mHRXvqLfN+FPkwR3tslfsLTcojFuc0i+rw6lGcY+jaary8Kq
         fPcQDCGbQrDRB3fWk4UxvVECbkJSqvRHAeRvPmf7cnVaxxhv71lVL0qgn5QAcoet7ZjU
         Id61Nu0XicVWhfYOcgMiU0CXcmLve1w0Kwz4P723VCn+R+CPI9OyZhxjYpLhI2o1L0/R
         lROB9HD7mHh/U8iYny43pf/9e0V9PF+m0H13TfF/2r1xTH6fjR9xwpwOoehgOBuh2Gmp
         lmxBN46ZVDQz7mfm5tX5Kv+4MXNaVy9WJn045mK18dW3Z+NDq/wqgusurk1ImtVb6uPj
         7u4Q==
X-Gm-Message-State: APjAAAWGJcJrgy2Cyy5Tikvf5fRpj9BZ8BpYK3itou7MHXqz7NxmoGI4
        dYPmeZyaR+j2r1hPWTy7trYN/ZC/
X-Google-Smtp-Source: APXvYqzT6eWIQ4+w3eS5z3/ud8sI5RfyyNYwmrMUrxo9u5wBdd8Fun4zqeFDpYsuANzkXTBM0mpsOg==
X-Received: by 2002:ae9:ef4a:: with SMTP id d71mr17444532qkg.392.1561383014518;
        Mon, 24 Jun 2019 06:30:14 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:bd0b:1518:483a:73eb? ([2001:4898:a800:1010:6e41:1518:483a:73eb])
        by smtp.gmail.com with ESMTPSA id k38sm5704443qtk.10.2019.06.24.06.30.13
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Jun 2019 06:30:14 -0700 (PDT)
Subject: Re: [PATCH 2/6] tree-walk.c: remove the_repo from
 fill_tree_descriptor()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20190624095533.22162-1-pclouds@gmail.com>
 <20190624095533.22162-3-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a2d91c63-86ca-90e7-0087-09df269d3865@gmail.com>
Date:   Mon, 24 Jun 2019 09:30:14 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190624095533.22162-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/24/2019 5:55 AM, Nguyễn Thái Ngọc Duy wrote:
> While at there, clean up the_repo usage in builtin/merge-tree.c a tiny
> bit.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  builtin/merge-tree.c | 22 +++++++++++++---------
>  builtin/rebase.c     |  4 ++--
>  builtin/reset.c      |  4 ++--
>  notes.c              |  2 +-
>  sequencer.c          |  2 +-
>  tree-diff.c          |  4 ++--
>  tree-walk.c          |  6 ++++--
>  tree-walk.h          |  4 +++-
>  unpack-trees.c       |  2 +-
>  9 files changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 34ca0258b1..97b54caeb9 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
> @@ -205,6 +205,7 @@ static void resolve(const struct traverse_info *info, struct name_entry *ours, s
>  static void unresolved_directory(const struct traverse_info *info,
>  				 struct name_entry n[3])
>  {
> +	struct repository *r = the_repository;

I like this trick to make the change below minimal:
> +	buf0 = fill_tree_descriptor(r, t + 0, ENTRY_OID(n + 0));
> +	buf1 = fill_tree_descriptor(r, t + 1, ENTRY_OID(n + 1));
> +	buf2 = fill_tree_descriptor(r, t + 2, ENTRY_OID(n + 2));

I wonder if _every_ conversion should include this trick,
so when we move to change that method we simply move the definition
from the method block to the prototype. (No need to adjust what you've
done already, just an idea for future conversions.)

Thanks,
-Stolee
