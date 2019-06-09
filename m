Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92C4E1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 09:23:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728039AbfFIJXF (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 05:23:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46692 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727720AbfFIJXF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 05:23:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id n4so6129538wrw.13
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 02:23:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0Tg4CzShGtmEdRsOsd/y3KENS/RJHxBONOMmxNBNX4=;
        b=psLMEUEfOJl6kUYt89IdWdnr5BgwK3+I4Xp/k0DAIErjdBYhrYHLjVLRhCClgO/ANZ
         j5ijsY+FST9+JL1yXEZRnPu7GL65nfUPyjYBevGR++J3Hn9XX3UYekaFBb7TjrM0NHr9
         B0kNtZDUQ7YJhWaLldD4RrWsen2f7SwfFcD8oRKfMelVppMdrvgkC9sImn9KkpfUpGA0
         98x4qjhkpRVpqbxL+VnvAHa2X1vNPxCqWzpyHMjEz7nrUjJLisanXyy0i/fIn93f5Rea
         sL2FmIiSPsizhAgPWVoyerbOu0Hltbubc+0qfVqjoHYapQBb3p9/8ZMbOXXu0NOInU2i
         xUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0Tg4CzShGtmEdRsOsd/y3KENS/RJHxBONOMmxNBNX4=;
        b=g/EYzmhT+akXmhAC3Hu/XCeisyZkRAcw/gvVERolXLi9pFiYYrXUrmkx78uMTI3EHg
         s03hbzc4zBXPKA9RZ+HTABr03xCsECpUrTfNYRTt+cKGi3/gcRKWv5D3vhbikX5EnPC4
         CAs5SL0JmTTv1fMIZBNgzgKx3/yTsw5f9c6dDkiwMQ4gL350HLJUKTY8VI3CINmWWuDp
         krZBC+ru8Q2sNINBOiUh53SCd8/8ItfVGTGkZB0KhAEQTO1Q4o8SHrFuG7TfSRLKDyug
         wb8t98kU3QjoB2spkI2FYQyk6vDyoQ0wVKVWn71+vdKboWlKGdh5A9C3OhDdwnVdgMcK
         3RHg==
X-Gm-Message-State: APjAAAXOzNtxxu02ddYNkWBZEDHvHTb7zkpcKrM3LV8EhvmH61+crqjV
        I3ANGDFvfB2J5HXw+vOvl6w=
X-Google-Smtp-Source: APXvYqy5C+reCaA6YkHs0SO+FCZsROpOQXgO6RsZFlYRZcBOyV8oBY9DKjO8AQcZKrW/RooXwAMiUg==
X-Received: by 2002:a5d:6242:: with SMTP id m2mr28535514wrv.310.1560072182695;
        Sun, 09 Jun 2019 02:23:02 -0700 (PDT)
Received: from szeder.dev (x4db5757b.dyn.telefonica.de. [77.181.117.123])
        by smtp.gmail.com with ESMTPSA id y9sm9835172wma.1.2019.06.09.02.23.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 02:23:01 -0700 (PDT)
Date:   Sun, 9 Jun 2019 11:22:59 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
Message-ID: <20190609092259.GB24208@szeder.dev>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190609044907.32477-3-chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 09, 2019 at 06:49:06AM +0200, Christian Couder wrote:
> From: Christian Couder <christian.couder@gmail.com>
> 
> Add actual tests for operations using `struct oidmap` from oidmap.{c,h}.
> 
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  t/t0016-oidmap.sh | 100 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100755 t/t0016-oidmap.sh
> 
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> new file mode 100755
> index 0000000000..3a8e8bdb3d
> --- /dev/null
> +++ b/t/t0016-oidmap.sh
> @@ -0,0 +1,100 @@
> +#!/bin/sh
> +
> +test_description='test oidmap'
> +. ./test-lib.sh
> +
> +# This purposefully is very similar to t0011-hashmap.sh
> +
> +test_oidmap() {
> +	echo "$1" | test-tool oidmap $3 > actual &&
> +	echo "$2" > expect &&

Style nit: space between redirection op and filename.

> +	test_cmp expect actual
> +}
> +
> +
> +test_expect_success 'setup' '
> +
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three &&
> +	test_commit four
> +
> +'
> +
> +test_oidhash() {
> +	git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/^(..)(..)(..)(..).*/;'

New Perl dependencies always make Dscho sad... :)

So, 'test oidmap' from the previous patch prints the value we want to
check with:

    printf("%u\n", sha1hash(oid.hash));

First, since object ids inherently make more sense as hex values, it
would be more appropriate to print that hash with the '%x' format
specifier, and then we wouldn't need Perl's hex() anymore, and thus
could swap the order of the first four bytes in oidmap's hash without
relying on Perl, e.g. with:

  sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'

Second, and more importantly, the need for swapping the byte order
indicates that this test would fail on big-endian systems, I'm afraid.
So I think we need an additional bswap32() on the printing side, and
then could further simplify 'test_oidhash':


diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
index 0ba122a264..4177912f9a 100644
--- a/t/helper/test-oidmap.c
+++ b/t/helper/test-oidmap.c
@@ -51,7 +51,7 @@ int cmd__oidmap(int argc, const char **argv)
 
 			/* print hash of oid */
 			if (!get_oid(p1, &oid))
-				printf("%u\n", sha1hash(oid.hash));
+				printf("%x\n", bswap32(sha1hash(oid.hash)));
 			else
 				printf("Unknown oid: %s\n", p1);
 
diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
index 3a8e8bdb3d..9c0d88a316 100755
--- a/t/t0016-oidmap.sh
+++ b/t/t0016-oidmap.sh
@@ -22,10 +22,10 @@ test_expect_success 'setup' '
 '
 
 test_oidhash() {
-	git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/^(..)(..)(..)(..).*/;'
+	git rev-parse "$1" | cut -c1-8
 }
 
-test_expect_success PERL 'hash' '
+test_expect_success 'hash' '
 
 test_oidmap "hash one
 hash two


> +}
> +
> +test_expect_success PERL 'hash' '
> +
> +test_oidmap "hash one
> +hash two
> +hash invalidOid
> +hash three" "$(test_oidhash one)
> +$(test_oidhash two)
> +Unknown oid: invalidOid
> +$(test_oidhash three)"
> +
> +'
> +
> +test_expect_success 'put' '
> +
> +test_oidmap "put one 1
> +put two 2
> +put invalidOid 4
> +put three 3" "NULL
> +NULL
> +Unknown oid: invalidOid
> +NULL"
> +
> +'
> +
> +test_expect_success 'replace' '
> +
> +test_oidmap "put one 1
> +put two 2
> +put three 3
> +put invalidOid 4
> +put two deux
> +put one un" "NULL
> +NULL
> +NULL
> +Unknown oid: invalidOid
> +2
> +1"
> +
> +'
> +
> +test_expect_success 'get' '
> +
> +test_oidmap "put one 1
> +put two 2
> +put three 3
> +get two
> +get four
> +get invalidOid
> +get one" "NULL
> +NULL
> +NULL
> +2
> +NULL
> +Unknown oid: invalidOid
> +1"
> +
> +'
> +
> +test_expect_success 'iterate' '
> +
> +test_oidmap "put one 1
> +put two 2
> +put three 3
> +iterate" "NULL
> +NULL
> +NULL
> +$(git rev-parse two) 2
> +$(git rev-parse one) 1
> +$(git rev-parse three) 3"
> +
> +'
> +
> +test_done
> -- 
> 2.22.0.14.g9023ccb50a
> 
