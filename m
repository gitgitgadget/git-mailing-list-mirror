Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACCDD1F404
	for <e@80x24.org>; Wed, 11 Apr 2018 20:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755711AbeDKU65 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 16:58:57 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:40163 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752311AbeDKU6z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 16:58:55 -0400
Received: by mail-lf0-f68.google.com with SMTP id e5-v6so4596743lfb.7
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 13:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=zVkcKnoWnpJSFEkPn8pIxel0EOB6U8xS3RxwJ+OYx0M=;
        b=U0yyJ/MqrQ57IA1SEN1AINarEy2+bzqCVrZUn6HtIzfrQcob8I9O8CrkCP/6KcuzFL
         sNWAORSUpp5oCh2WFSqIAunnPm+Hvcv/qqi1BJtDhMN6o9RH784u+5Y0uGjLHxoIVftQ
         /vh6sHx95NVLb++7umWUtr4irJdC6nJmsOPd8EzIJyqGRyJhsVfKGOgeVRLciegvzW5k
         Z1UeCGBfoGZiAFaSpAO0ebWAX1KUBIARD7FxEOgSLLeKSaq3XiNSZJtlIdQeIQYm03H0
         ufW5NqiZM6xukObS0KCNNDu0gPCfJEVIvrS17C0waPFzJRxlZY7B7PyqYE4+TsgJ3zf1
         SJNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=zVkcKnoWnpJSFEkPn8pIxel0EOB6U8xS3RxwJ+OYx0M=;
        b=LLmPvxgGPcBgsZ975HfTLLqR+upXa+zz8BQHpmH/j3elhDroqrLr0SKU9fJZwdhXC5
         RvYvdkgb4oygc0mXyRb1Fgnp0OV+l3ZZ3/tEid7fXvAejooyuOpK2C5nGDrP7DK15xZM
         CkW71quCFfdWGY9XOsCnCfl+i4oxsNI96tYgu0iwAmRYDtLghV3H12N6+gEAANgXup5N
         Y8xVuKw1MyUrq8+ZjmjTOTqjC8dbg3txm5Em5OwMXf0tgXWYuP/5EhxsVfPzxEffY8qM
         kc40/xDhO8aUpngRgcY8TJYhHFJpq/1/QODFDnKiArhCTHvQ4qewyHTf9j1AX3N+eu8m
         3rAg==
X-Gm-Message-State: ALQs6tAu+ULOXUOX8AqrmJxkza4TQOVmPQlniRRBf8yTmuRI1gYxsTTR
        00hWuwMyVyZcHlmK2V1Yq2w=
X-Google-Smtp-Source: AIpwx48qmCWtsWrNY5YuYdONGR8y6Hf6GOSSIBRAJGcS25NV3z4booLub7UQP2ya3cLc8Y8Lhjm/zA==
X-Received: by 10.46.91.143 with SMTP id m15mr3836406lje.75.1523480333903;
        Wed, 11 Apr 2018 13:58:53 -0700 (PDT)
Received: from Laptop-Acer-Aspire-F15 (abrk101.neoplus.adsl.tpnet.pl. [83.8.104.101])
        by smtp.gmail.com with ESMTPSA id y70-v6sm408144lfk.24.2018.04.11.13.58.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 13:58:52 -0700 (PDT)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, sbeller@google.com,
        szeder.dev@gmail.com, git@jeffhostetler.com, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v8 03/14] commit-graph: add format document
References: <20180402203427.170177-1-dstolee@microsoft.com>
        <20180410125608.39443-1-dstolee@microsoft.com>
        <20180410125608.39443-4-dstolee@microsoft.com>
Date:   Wed, 11 Apr 2018 22:58:49 +0200
In-Reply-To: <20180410125608.39443-4-dstolee@microsoft.com> (Derrick Stolee's
        message of "Tue, 10 Apr 2018 08:55:57 -0400")
Message-ID: <86zi294fzq.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> +CHUNK DATA:
> +
> +  OID Fanout (ID: {'O', 'I', 'D', 'F'}) (256 * 4 bytes)
> +      The ith entry, F[i], stores the number of OIDs with first
> +      byte at most i. Thus F[255] stores the total
> +      number of commits (N).
> +
> +  OID Lookup (ID: {'O', 'I', 'D', 'L'}) (N * H bytes)
> +      The OIDs for all commits in the graph, sorted in ascending order.
> +
> +  Commit Data (ID: {'C', 'G', 'E', 'T' }) (N * (H + 16) bytes)

I think it is a typo, and it should be CDAT, not CGET
(CDAT seem to me to stand for Commit DATa):

  +  Commit Data (ID: {'C', 'D', 'A', 'T' }) (N * (H + 16) bytes)

This is what you use in actual implementation, in PATCH v8 06/14

DS> +#define GRAPH_SIGNATURE 0x43475048 /* "CGPH" */
DS> +#define GRAPH_CHUNKID_OIDFANOUT 0x4f494446 /* "OIDF" */
DS> +#define GRAPH_CHUNKID_OIDLOOKUP 0x4f49444c /* "OIDL" */
DS> +#define GRAPH_CHUNKID_DATA 0x43444154 /* "CDAT" */
DS> +#define GRAPH_CHUNKID_LARGEEDGES 0x45444745 /* "EDGE" */

--=20
Jakub Nar=C4=99bski
