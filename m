Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67C411F62D
	for <e@80x24.org>; Mon,  9 Jul 2018 02:38:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754371AbeGICih (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Jul 2018 22:38:37 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45415 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754356AbeGICig (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Jul 2018 22:38:36 -0400
Received: by mail-ed1-f66.google.com with SMTP id g15-v6so12671450edr.12
        for <git@vger.kernel.org>; Sun, 08 Jul 2018 19:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Uphqg689USNCaWRur1FmgRqbyrFRKMjWikVpMAXY9Tk=;
        b=GXb3CWHtRp/HQM5bU05+lR3ra0QKP1S6s+bKTFifB1aFvn9s8lD993g6eYuTvbIdK4
         M46UN8y8hmEa/LF2amhO/9Ow6dOS7eW5C4YoblLdZ67qOn8Bjz98/2zgH8OBfF8oCHr/
         ngNaELwn1v/5JL5MbfnFcnR1idbDUyB6quV5Xek1/m9Btu1Wqw6GCGfx121pRh/Rd8ru
         wm20p3Y4qdBuvNoNoltE84RmXGmPbfdvFGZCqjKbH/qrPmNE7lrHGFKXf4SKQHVFDBkc
         FAB4ndA1R+5kNZTPXSBvb6oTMV75ML5JTer1LU+/MxwXc9iBqo+aDKTw7QLOIlwH40j8
         0F1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Uphqg689USNCaWRur1FmgRqbyrFRKMjWikVpMAXY9Tk=;
        b=kwygEx0o6nDT+jJ+1cdRizTkHEhpaPCV44KzaFWZc6nZl/Er+luOIClQY/zodWolrB
         APtff/ZA2hFwxsEFASkxbodBRhGU+Ih1TfpoDNYjhysr9MEYX7DIRiYqT9m7ydXRN0Gl
         4zYmXr/I+BD30KET214KcP4JvZSB6qZzK61umtgOoEXgam5JnydfxNF+2+4m/0fKqkIb
         gM5/kjhDccbE/vMEFxUp8CIH//uyU6jL2Wx09Cd6bnBNjx3lmf6ZoM5k3lzDZJoQtim1
         y+VbfewrU8YznomFPXjMQxjxghAeN1vbrCYBDqzWTn9tdCJxfz8lO36gr9H/hMTaA93/
         viqw==
X-Gm-Message-State: APt69E0ZB5gAocgNRqBaL2x8PG8996rMEiKKQLCzX063latbJip1Mz1s
        PpGWdGA7i0T1GnBQR3m/1zjQ2KuRRVapIUH4WDE=
X-Google-Smtp-Source: AAOMgpcuKm7CiRF5Tbne8vEac3SkrM3+ZWFzhigqdWTCdbrrZwJMr2O7cJ1UEEHlOI+ospV7YpkLtatY9QOaJC3u1dU=
X-Received: by 2002:a50:8b25:: with SMTP id l34-v6mr83595edl.265.1531103915047;
 Sun, 08 Jul 2018 19:38:35 -0700 (PDT)
MIME-Version: 1.0
References: <20180708233638.520172-1-sandals@crustytoothpaste.net> <20180708233638.520172-2-sandals@crustytoothpaste.net>
In-Reply-To: <20180708233638.520172-2-sandals@crustytoothpaste.net>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 8 Jul 2018 19:38:21 -0700
Message-ID: <CA+P7+xq900ikNR3uBEo28rjrTh5iYJm-R8jcAjhq-7G2jh3iVA@mail.gmail.com>
Subject: Re: [PATCH 01/17] cache: update object ID functions for the_hash_algo
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git mailing list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 8, 2018 at 4:39 PM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>  static inline int oidcmp(const struct object_id *oid1, const struct object_id *oid2)
>  {
> -       return hashcmp(oid1->hash, oid2->hash);
> +       return memcmp(oid1->hash, oid2->hash, the_hash_algo->rawsz);
>  }
>

Just curious, what's the reasoning for not using the hashcmp anymore?

Thanks,
Jake
