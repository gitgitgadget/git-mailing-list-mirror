Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED3951F516
	for <e@80x24.org>; Thu, 28 Jun 2018 22:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966835AbeF1W2O (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Jun 2018 18:28:14 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:39332 "EHLO
        mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966801AbeF1W2N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jun 2018 18:28:13 -0400
Received: by mail-wm0-f46.google.com with SMTP id p11-v6so115084wmc.4
        for <git@vger.kernel.org>; Thu, 28 Jun 2018 15:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=enbCXaivaRiweUqrFhWislpiftQ/yqB1jUXvRk13jv4=;
        b=ta3LZZgwJ6NNstLwWwG/SW8+tLlQS3zocRf9Fj1S6rktwyt9uDDKC/L9K/uxvlCHXx
         W4OFQOcTP/5GLdTkqDBah7xSwKb2khjOXNplMev5bi5oED1pIZol5GlZYZdNZ5CZDcZm
         wresXnP4DoFd5aGyOwC6xLzsKK/CU5fc+oPAIV5zW1tOMnQEVHn9uIYmiVwpipQu9Rq1
         Gz55CwCwkma1i80x5JiU42y3FXoXPidmBpogc79VSCgp9JRWMISotL1V6ph+EScnyZWl
         f89mWdnfGZLdZkNFVg+0A0R0aIGxq6cQGa0bRyxouizWYfDzGK4h7PLl1cw30nhgWyP7
         KGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=enbCXaivaRiweUqrFhWislpiftQ/yqB1jUXvRk13jv4=;
        b=D73ZPU5u4n4oTYES5EQPuIoSf/keR3JHtrtQcVIB5WIMnj03GASuj9mV/Ue8tCplKT
         hdQjc9FHnxSlP3E5AkOKWgRJczOBPrU366y7LTOZalmRT+hk59c/aHZ5GePWyGXLPFLw
         wEVhIXWHEqGzHp7TJTQOxhWFynIbfEvtBEH+mfHF0110OrFseZXkxLKa4VtCeeOhFMXH
         ikbou3KRJfTEnoePkFroRTszeoGnMGmMeTLVCnuvVw0i5DXD/PeqC4iiM4kmgbbAu0jb
         l6w2y/j20R5HuGJSv8zJF4uI7+rsNCKkY/x9B0S5SwUtRJ6lkg9TVHcNmx4VKacoClM6
         f2vg==
X-Gm-Message-State: APt69E0aT5E+CvPPc2ZgU5PpIW0wSfq2Hp94Q4D/6YvC8d1Og3hql6+7
        d05dWxMxeZ3OWs6SEMHel2c=
X-Google-Smtp-Source: AAOMgpdToFp98SEUXIC+qGLwbyEBD07VPDuci2Uu6cn0eJMD8BgUuaRxDVfWkaombVNTRkGxlqPLtA==
X-Received: by 2002:a1c:1ed7:: with SMTP id e206-v6mr9326049wme.67.1530224892292;
        Thu, 28 Jun 2018 15:28:12 -0700 (PDT)
Received: from localhost.localdomain (x4db1165b.dyn.telefonica.de. [77.177.22.91])
        by smtp.gmail.com with ESMTPSA id v9-v6sm2701420wrn.97.2018.06.28.15.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 28 Jun 2018 15:28:11 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Jameson Miller <jamill@microsoft.com>
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "peartben@gmail.com" <peartben@gmail.com>,
        "peff@peff.net" <peff@peff.net>,
        "sbeller@google.com" <sbeller@google.com>
Subject: Re: [PATCH v5 3/8] block alloc: add lifecycle APIs for cache_entry structs
Date:   Fri, 29 Jun 2018 00:28:00 +0200
Message-Id: <20180628222800.10570-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.18.0.273.g57f1ecce9c
In-Reply-To: <20180628135932.225288-4-jamill@microsoft.com>
References: <20180620201557.77155-1-jamill@microsoft.com> <20180628135932.225288-1-jamill@microsoft.com> <20180628135932.225288-4-jamill@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> diff --git a/read-cache.c b/read-cache.c
> index 9624ce1784..116fd51680 100644
> --- a/read-cache.c
> +++ b/read-cache.c

> +struct cache_entry *make_transient_cache_entry(unsigned int mode, const struct object_id *oid,
> +					       const char *path, int stage)
> +{
> +	struct cache_entry *ce;
> +	int len;
> +
> +	if (!verify_path(path, mode)) {
> +		error("Invalid path '%s'", path);
> +		return NULL;
> +	}
> +
> +	len = strlen(path);
> +	ce = make_empty_transient_cache_entry(len);
> +
> +	hashcpy(ce->oid.hash, oid->hash);

Please use oidcpy() here, too.

