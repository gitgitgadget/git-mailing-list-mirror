Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A780A1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 09:44:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbeJVSCc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 14:02:32 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39576 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728412AbeJVSCc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 14:02:32 -0400
Received: by mail-ed1-f65.google.com with SMTP id e5-v6so2547058eds.6
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 02:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gNi7C4KET/x2A4jFml3gRQCW1dPak7KwkIbO5a935/k=;
        b=VJbmTIP9y3V+UBJOFmqYnRFI/WucO8L8QqOTiFQo24zfpgYVe45kzKO2dUaMAcrU9c
         T5juJZRTWENLmejznGFmQBVuU2teyWLAYPxYdnbHTS3OSrfmdvoaoVRb2Kk8bTCj01o8
         j8mWNO3tbDf6iEHXlBELjRvey/t5UXoFg0U4uLZKJtbpkiq+yn8q44xre4fADuLWZMIu
         +hqiCx/RMXahjYTYgZ0F7U+R3PlOszvDRMuC2TQ+ktjqdcY/SpNWxu3zUgvzmXoG7COA
         lv3hj8yDHqs7W9BbhK4Mql4DehIuHQn70NAhJ3IqlptSDlvRB1z34sYuHldsfoOwvZAB
         xjog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gNi7C4KET/x2A4jFml3gRQCW1dPak7KwkIbO5a935/k=;
        b=CfWWrx2kU0zm0pSdGPlDmTrzJZWtP7zdq+zYu6oE1bCAsiqyHWMlqssSWxoefFdGbl
         XPVDlwQro/RoDTkGTl/neFYwAS/5utxj8iA2MywzGKNWT8t4zhu60ZCWCJgNvObfuAXY
         6pXtulSIekOSIT7SrhqstZcbn8zl8Emv0cI49AUA6ysidQRWYR9OvQD0rYN1a2s+sS+Z
         aepdQUHcg88l78KwYGXG9xJ4yGJ9JKo9psCd2jskXRRpQfgBAkVdjSIkrO4+16YaLXEX
         +/DdHAE2IKT27YJ3akAVCcCElnyjxAdKEa799CgZZzSwVng3KO0kkm3DjX7w6wBTWTXq
         Mfdw==
X-Gm-Message-State: ABuFfogx6OOZgX/vMQon0D4zCm7Lnn7zH1Y4YACh+lk4JnhCctxqakj9
        M21EWmuJpb4pU5vvPaOfBJ0=
X-Google-Smtp-Source: ACcGV61jtCRklEPyTVvb6hrIyyXNgFI957zSW2+W6mlh1TefpmpvNmHCnq0qjvdQtlEVYjhWpLIcZg==
X-Received: by 2002:a17:906:7c45:: with SMTP id g5-v6mr2067584ejp.77.1540201483565;
        Mon, 22 Oct 2018 02:44:43 -0700 (PDT)
Received: from szeder.dev (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id w37-v6sm706283edc.2.2018.10.22.02.44.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Oct 2018 02:44:42 -0700 (PDT)
Date:   Mon, 22 Oct 2018 11:44:40 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 10/12] Add a base implementation of SHA-256 support
Message-ID: <20181022094440.GD30222@szeder.dev>
References: <20181022024342.489564-1-sandals@crustytoothpaste.net>
 <20181022024342.489564-11-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181022024342.489564-11-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 22, 2018 at 02:43:40AM +0000, brian m. carlson wrote:

> diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> new file mode 100644
> index 0000000000..683bc6e39b
> --- /dev/null
> +++ b/sha256/block/sha256.c
> @@ -0,0 +1,186 @@
> +#include "git-compat-util.h"
> +#include "./sha256.h"
> +
> +#define BLKSIZE blk_SHA256_BLKSIZE

[...]

> +#define Ch(x,y,z)       (z ^ (x & (y ^ z)))
> +#define Maj(x,y,z)      (((x | y) & z) | (x & y))
> +#define S(x, n)         ror((x),(n))
> +#define R(x, n)         ((x)>>(n))
> +#define Sigma0(x)       (S(x, 2) ^ S(x, 13) ^ S(x, 22))
> +#define Sigma1(x)       (S(x, 6) ^ S(x, 11) ^ S(x, 25))
> +#define Gamma0(x)       (S(x, 7) ^ S(x, 18) ^ R(x, 3))
> +#define Gamma1(x)       (S(x, 17) ^ S(x, 19) ^ R(x, 10))

[...]

> +#define RND(a,b,c,d,e,f,g,h,i,ki)                    \
> +	t0 = h + Sigma1(e) + Ch(e, f, g) + ki + W[i];   \
> +	t1 = Sigma0(a) + Maj(a, b, c);                  \
> +	d += t0;                                        \
> +	h  = t0 + t1;

[...]

> +#undef RND
> +#undef Ch
> +#undef Maj
> +#undef S
> +#undef R
> +#undef Sigma0
> +#undef Sigma1
> +#undef Gamma0
> +#undef Gamma1

To protect us from potential "macro redefinition" errors, these
#undefs should come before the #defines above.  Note also that BLKSIZE
is not #undef-ed.

