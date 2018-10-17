Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 029B31F453
	for <e@80x24.org>; Wed, 17 Oct 2018 16:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJRAJL (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Oct 2018 20:09:11 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44240 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727016AbeJRAJL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Oct 2018 20:09:11 -0400
Received: by mail-ed1-f66.google.com with SMTP id z21-v6so25400879edb.11
        for <git@vger.kernel.org>; Wed, 17 Oct 2018 09:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V+BQ6Nv2m//JYMen3mnfz09e5OetS4w2GCYxdHphYWs=;
        b=DYDdej760CWvjaheI+Qo+2e4/FPz1PHg3ua2I1ADZe6nmMocgAGnvpLpEzvl9ivbuR
         hHFYRhqusLplWCauZsfJqibnYRWYeMRU4BLgKzlpmNHvdBREomG6owUfLm8Resxmgkqr
         v/rPwdUtFPGhE6PmJ4AWVDxRERuLwPxKZgFbwqnZZh5UZcQhgOV6JTuRi7Alq1arzfmj
         4edhiOZV1jCFTgrbqxt7gsEI1lCnzYxFyv4S8ZzTi590IaMsioFXtHqhwWo1Ouby9oeD
         OKNzSLxz8vYwtV5XV7t1eQqyK32r3XGuqQkVil4NiJbNIclvmwq8kY6xR9g4GzFFIdKx
         9fYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V+BQ6Nv2m//JYMen3mnfz09e5OetS4w2GCYxdHphYWs=;
        b=let5DJNmRU2eGBU8n+uvyhlRKVOX5UwNTIrirRpC+o4awiu9Oqyg4SICdUh8Qjy1h3
         kKbFvjkV/W6jeuYNBWwfhQ/OhiJyldgmRBLUHnu94a8YZN3IEFxof9KYu78wfY0AKsze
         eJejmp+xOAdmSm+l9Peg6YCfpPqvMomrf0q9vonmFhQ9uiq/LzyAZKUVh+7N1Ie2BIdC
         UDfcoUeNMhCBqO75GieBP5Alst+8mPrVd9VSg2hlK7fyJ7sF1u14Vk+mSKtrHK/UG+Lg
         wfpb2kibrfX3ymvWCL3Sn0DKlrTjo2lMHSYAw4WCJPuiZpu+vRYw23ahKvUR25eyuiHm
         esNQ==
X-Gm-Message-State: ABuFfojiG0FP6jpxKzoOn3eofIcb0d1ULXTOrls7vzmn07lt/q9W3HNl
        WMwv9IMSCsveUieXENuR7sLaHgT8
X-Google-Smtp-Source: ACcGV62JbPldOBrawL+gicnzVy01DHf49b/Cl2ETzopMM1NJSJDoNTJVFUA2rrXk8GrR6/9KqS3p9w==
X-Received: by 2002:a50:eb42:: with SMTP id z2-v6mr1048776edp.126.1539792764760;
        Wed, 17 Oct 2018 09:12:44 -0700 (PDT)
Received: from szeder.dev (x4db11ffa.dyn.telefonica.de. [77.177.31.250])
        by smtp.gmail.com with ESMTPSA id k42-v6sm6494959ede.94.2018.10.17.09.12.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 17 Oct 2018 09:12:43 -0700 (PDT)
Date:   Wed, 17 Oct 2018 18:12:41 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 10/13] Add a base implementation of SHA-256 support
Message-ID: <20181017161241.GS19800@szeder.dev>
References: <20181015021900.1030041-1-sandals@crustytoothpaste.net>
 <20181015021900.1030041-11-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181015021900.1030041-11-sandals@crustytoothpaste.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 15, 2018 at 02:18:57AM +0000, brian m. carlson wrote:
> diff --git a/sha256/block/sha256.c b/sha256/block/sha256.c
> new file mode 100644
> index 0000000000..18350c161a
> --- /dev/null
> +++ b/sha256/block/sha256.c
> @@ -0,0 +1,180 @@
> +#include "git-compat-util.h"
> +#include "./sha256.h"
> +
> +#define BLKSIZE blk_SHA256_BLKSIZE
> +
> +void blk_SHA256_Init(blk_SHA256_CTX *ctx)
> +{
> +	ctx->offset = 0;
> +	ctx->length = 0;
> +	ctx->state[0] = 0x6A09E667UL;
> +	ctx->state[1] = 0xBB67AE85UL;
> +	ctx->state[2] = 0x3C6EF372UL;
> +	ctx->state[3] = 0xA54FF53AUL;
> +	ctx->state[4] = 0x510E527FUL;
> +	ctx->state[5] = 0x9B05688CUL;
> +	ctx->state[6] = 0x1F83D9ABUL;
> +	ctx->state[7] = 0x5BE0CD19UL;
> +}
> +
> +static inline uint32_t ror(uint32_t x, unsigned n)
> +{
> +	return (x >> n) | (x << (32 - n));
> +}
> +
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
> +
> +	RND(S[0],S[1],S[2],S[3],S[4],S[5],S[6],S[7],0,0x428a2f98);

[...]

> +#undef RND
> +
> +	for (i = 0; i < 8; i++) {
> +		ctx->state[i] = ctx->state[i] + S[i];
> +	}
> +}
> +
> +#define MIN(x, y) ((x) < (y) ? (x) : (y))

On macOS there is a MIN macro already defined in the system headers,
resulting in the following error:

      CC sha256/block/sha256.o
  sha256/block/sha256.c:133:9: error: 'MIN' macro redefined [-Werror,-Wmacro-redefined]
  #define MIN(x, y) ((x) < (y) ? (x) : (y))
          ^
  /usr/include/sys/param.h:215:9: note: previous definition is here
  #define MIN(a,b) (((a)<(b))?(a):(b))
          ^
  1 error generated.
  make: *** [sha256/block/sha256.o] Error 1

A simple "#undef MIN" solves this issue.  However, I wonder whether we
should #undef the other #define directives as well, just to be sure
(and perhaps overly cautious).

> +void blk_SHA256_Update(blk_SHA256_CTX *ctx, const void *data, size_t len)
> +{
> +	const unsigned char *in = data;
> +	size_t n;
> +	ctx->length += len;
> +	while (len > 0) {
> +		if (!ctx->offset && len >= BLKSIZE) {
> +			blk_SHA256_Transform(ctx, in);
> +			in += BLKSIZE;
> +			len -= BLKSIZE;
> +		} else {
> +			n = MIN(len, (BLKSIZE - ctx->offset));
> +			memcpy(ctx->buf + ctx->offset, in, n);
> +			ctx->offset += n;
> +			in += n;
> +			len -= n;
> +			if (ctx->offset == BLKSIZE) {
> +				blk_SHA256_Transform(ctx, ctx->buf);
> +				ctx->offset = 0;
> +			}
> +		}
> +	}
> +}
> +
> +void blk_SHA256_Final(unsigned char *digest, blk_SHA256_CTX *ctx)
> +{
> +	const unsigned trip = BLKSIZE - sizeof(ctx->length);
> +	int i;
> +
> +	ctx->length <<= 3;
> +	ctx->buf[ctx->offset++] = 0x80;
> +
> +	if (ctx->offset > trip) {
> +		memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset);
> +		blk_SHA256_Transform(ctx, ctx->buf);
> +		ctx->offset = 0;
> +	}
> +
> +	memset(ctx->buf + ctx->offset, 0, BLKSIZE - ctx->offset - sizeof(ctx->length));
> +
> +	put_be64(ctx->buf + trip, ctx->length);

Some GCC versions (e.g. gcc-4.8 with -O2 -Wall -Werror) complain about
the above line:

      CC sha256/block/sha256.o
  sha256/block/sha256.c: In function ‘blk_SHA256_Final’:
  sha256/block/sha256.c:174:2: error: dereferencing type-punned pointer will break strict-aliasing rules [-Werror=strict-aliasing]
    put_be64(ctx->buf + trip, ctx->length);
    ^
  cc1: all warnings being treated as errors
  make: *** [sha256/block/sha256.o] Error 1

Something like this makes it compile:

  void *ptr = ctx->buf + trip;
  put_be64(ptr, ctx->length);

However, it's not immediately obvious to me why the compiler
complains, or why that intermediate void* variable makes any
difference, but now it's not the time to put on my language lawyer
hat.

Perhaps an old compiler bug?  Clang in general, newer GCC versions, or
gcc-4.8 with -Wall -Werror but without -O2 don't seem to be affected.


> +	blk_SHA256_Transform(ctx, ctx->buf);
> +
> +	/* copy output */
> +	for (i = 0; i < 8; i++, digest += sizeof(uint32_t))
> +		put_be32(digest, ctx->state[i]);
> +}
