Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54C742055E
	for <e@80x24.org>; Sun, 29 Oct 2017 01:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751568AbdJ2BgI (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Oct 2017 21:36:08 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:51171 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751209AbdJ2BgH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Oct 2017 21:36:07 -0400
Received: by mail-qt0-f195.google.com with SMTP id d9so12592113qtd.7
        for <git@vger.kernel.org>; Sat, 28 Oct 2017 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ML1EGOCki/VzfHb0hBn6AP79KDoc59tmD1vQkmq13o8=;
        b=WonE9La7A+AMVaGDzi90w/KyjZFrdbCF2xCoJAD5A1RP6mJdHVTl0eNKtMHHEk0D1p
         Bf2c6GSt01h3EbK6A0A7bX7w6aVouLgYxtV84E58I6+ZBE+p/yhWqT7SCILAR/RhVvyp
         8poy3fEoC19w9/Jh/99G3SqQrdG/fa9IpIB6vAypdNcgQHtKb14ftll1QmncAZjNcrGS
         CsqIHU6POh/Q/270gkxK15whOL3mZq+nAWctZiR8ZmQ+viq6eTLJkPAYUIM3DrXe/27N
         R1JFQNzZjCpb0121aYBrkAEzeBowGF/a7DLg1Mu0BKLVRl9UABZlJPJQKFg/BRwoWyGt
         5vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ML1EGOCki/VzfHb0hBn6AP79KDoc59tmD1vQkmq13o8=;
        b=ZWqmuRR10bl8TE4CDZg/ee/vv9X01vvVmZ7FI+tW6XQXnkLQAj41Amt4g8mJw2bhzd
         +QJtKP2YaraQZGtOrgcz6NKjjZEm/zxs5Ds+GQKbF+PJPw5gkI/BvvWKjSNJkmevNlGp
         3ueZK2cHQ79ZDEIVP2frAKZgH1vljVausJE6FZbX1FJElePDeEvOtKehswGC4PfUSB7E
         UvwxkTEyyg9bEWemW6EMY4orMthrgxm24wq/UM4yX8nnQeorNcViL+FXK1H2HQWynYBB
         mWApw73/5rVjidRvEhSd9qZZ4yglC4D7Mygpp1cFt8M7RvNm3fI7iLJan0VVVZzlkvlT
         k2hQ==
X-Gm-Message-State: AMCzsaUzCMPj9gaqua9TjWmXKj0U0AbahfcvPlnu/FB/JcBHmPYrCUPh
        35giD+EgV0RyzWgNl+pnaD+ZYal8pfz8UIyRKU0=
X-Google-Smtp-Source: ABhQp+RFZ1KXlVTnWiFKNthk0JlF70rX0M5YC4r6+FDdyx35G5rkpDB7UswWxXVaYmO0+KQi9xnT32p9aVy7pyaqIeU=
X-Received: by 10.200.23.82 with SMTP id u18mr7939793qtk.163.1509240966269;
 Sat, 28 Oct 2017 18:36:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.146.118 with HTTP; Sat, 28 Oct 2017 18:36:05 -0700 (PDT)
In-Reply-To: <20171028181239.59458-3-sandals@crustytoothpaste.net>
References: <20171028181239.59458-1-sandals@crustytoothpaste.net> <20171028181239.59458-3-sandals@crustytoothpaste.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 28 Oct 2017 21:36:05 -0400
X-Google-Sender-Auth: 0aBqmhe2h9ULBFl-Z7tEdMTtK4k
Message-ID: <CAPig+cSX_+mN8Pz=0k3xnHRa-Teoq2JrSHe0zQhzJ1NZafXPoQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] Add structure representing hash algorithm
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 28, 2017 at 2:12 PM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> Since in the future we want to support an additional hash algorithm, add
> a structure that represents a hash algorithm and all the data that must
> go along with it.  Add a constant to allow easy enumeration of hash
> algorithms.  Implement function typedefs to create an abstract API that
> can be used by any hash algorithm, and wrappers for the existing SHA1
> functions that conform to this API.
> [...]
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
> diff --git a/cache.h b/cache.h
> @@ -77,6 +77,61 @@ struct object_id {
> +typedef void (*git_hash_init_fn)(void *ctx);
> +typedef void (*git_hash_update_fn)(void *ctx, const void *in, size_t len);
> +typedef void (*git_hash_final_fn)(unsigned char *hash, void *ctx);
> +
> +struct git_hash_algo {
> +       [...]
> +       /* The hash initialization function. */
> +       git_hash_init_fn init_fn;
> +
> +       /* The hash update function. */
> +       git_hash_update_fn update_fn;
> +
> +       /* The hash finalization function. */
> +       git_hash_final_fn final_fn;
> +       [...]
> +};
> diff --git a/sha1_file.c b/sha1_file.c
> @@ -39,6 +39,49 @@ const struct object_id empty_blob_oid = {
> +static inline void git_hash_sha1_init(void *ctx)
> +{
> +       git_SHA1_Init((git_SHA_CTX *)ctx);
> +}
> +
> +static inline void git_hash_sha1_update(void *ctx, const void *data, size_t len)
> +{
> +       git_SHA1_Update((git_SHA_CTX *)ctx, data, len);
> +}
> +
> +static inline void git_hash_sha1_final(unsigned char *hash, void *ctx)
> +{
> +       git_SHA1_Final(hash, (git_SHA_CTX *)ctx);
> +}

Why 'inline' if you only ever take the addresses of these functions?

> +const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
> +       [...]
> +       {
> +               "sha-1",
> +               /* "sha1", big-endian */
> +               0x73686131,
> +               sizeof(git_SHA_CTX),
> +               GIT_SHA1_RAWSZ,
> +               GIT_SHA1_HEXSZ,
> +               git_hash_sha1_init,
> +               git_hash_sha1_update,
> +               git_hash_sha1_final,
> +               &empty_tree_oid,
> +               &empty_blob_oid,
> +       },
> +};
