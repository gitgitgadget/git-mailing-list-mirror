Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E02071FAE2
	for <e@80x24.org>; Sat, 17 Mar 2018 19:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753657AbeCQTxZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Mar 2018 15:53:25 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35236 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751303AbeCQTxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Mar 2018 15:53:25 -0400
Received: by mail-wm0-f68.google.com with SMTP id 5so8786251wmh.0
        for <git@vger.kernel.org>; Sat, 17 Mar 2018 12:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KNO+a01ReFGU9wmNq81JbsyveF6DDVAtetDj6ApyaRI=;
        b=OFgtngaSVAGifC+JNHEERz65+38wS7i9vi1OhZHn6/SnnJs2t/QQfMXedWiz2yUmQt
         mbrjhK2YFlMvanelSTLVA0a92nc385Le8wy6kOsUb59MSyq3mSETmYu2qBODQ6mIPi6Z
         uNbs4Qp9c0/6vWMMVRWVDADmx7gmrZ3E5q/+FjAm8SUpHN1APMPCqUt6XcHNqUH5zb91
         j2l8n/CNNrb08Kwwnue/AdByjaZlFSoR81Bd3ypKTx71e/txkMWIimp4IlzHmKBKhovW
         ERLcT11Ztffm/6pjlJMZKsLtj/a/0xr7lELtG5LNzalKcJxN5Ps0lggArs+kLQFtMr2Q
         SSHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=KNO+a01ReFGU9wmNq81JbsyveF6DDVAtetDj6ApyaRI=;
        b=UwhJX3MmqYO9Pn/RTBvyM/VyczwGR1iXgbwfdIRZCIAeA05K5dTRy2N5okVlbhhTHi
         EgHrFwTHoKgW8KXdnJ6tBAW9pgOEAigYQ+vadR+tm865ENkA0xNOLdzwOW1zC2bYKpjg
         3a8rAG5dNFUTB0CsotjCdsOPUVzgeVqmkK3GSNH+VDi36IdTE256KciTCjVPSna3k0y/
         NJtxOZ+RPOAaf1oFufzCsKrsdJYTqwP2dlontUkdUgroHG+lmC6aHNPtQOoICMzDjTwe
         OTD7SEnaoe3qXWtx8lWoLwGLgUwZTMGYjbiz8V8ma+d97gLeH/4v2vTN+/azHM+fM0T3
         pmIg==
X-Gm-Message-State: AElRT7FcWpkm1K8q2tabs2s44lIXH9szBFqe9qsl2+LPZW4jhiIXh8ey
        DR1nX4Hn0racRICOzKhAS/k=
X-Google-Smtp-Source: AG47ELtZ3/p5rM0e8v44VgGfRSXbJ/CC1mFMhfr9Vvco3jezgUhXyeuDqMx6Y4HuYWarygjq10yCIw==
X-Received: by 10.28.178.208 with SMTP id b199mr2624256wmf.125.1521316403716;
        Sat, 17 Mar 2018 12:53:23 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id v22sm8043654wrd.43.2018.03.17.12.53.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 17 Mar 2018 12:53:22 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     e@80x24.org, git@vger.kernel.org, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v5 11/11] pack-objects.h: reorder members to shrink struct object_entry
References: <20180316183200.31014-1-pclouds@gmail.com> <20180317141033.21545-1-pclouds@gmail.com> <20180317141033.21545-12-pclouds@gmail.com>
User-agent: Debian GNU/Linux 9.3 (stretch); Emacs 25.1.1; mu4e 1.1.0
In-reply-to: <20180317141033.21545-12-pclouds@gmail.com>
Date:   Sat, 17 Mar 2018 20:53:21 +0100
Message-ID: <87muz6cwcu.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Mar 17 2018, Nguyễn Thái Ngọc Duy jotted:

> Previous patches leave lots of holes and padding in this struct. This
> patch reorders the members and shrinks the struct down to 80 bytes
> (from 136 bytes, before any field shrinking is done) with 16 bits to
> spare (and a couple more in in_pack_header_size when we really run out
> of bits).

Given what I mentioned in 87po42cwql.fsf@evledraar.gmail.com just now I
think we should add this to the commit message.

    This is the last in a series of memory reduction patches (see
    "pack-objects: a bit of document about struct object_entry" for the
    first one).

    Overall they've reduced repack memory size on linux.git from 3.747G
    to 3.424G, or by around 320M, a decrease of 8.5%. The runtime of
    repack has stayed the same throughout this series. Ævar's testing on
    a big monorepo he has access to (bigger than linux.git) has shown a
    7.9% reduction, so the overall expected improvement should be
    somewhere around 8%.

    See 87po42cwql.fsf@evledraar.gmail.com on-list
    (https://public-inbox.org/git/87po42cwql.fsf@evledraar.gmail.com/)
    for more detailed numbers and a test script used to produce the
    numbers cited above.

Thanks again for working on this.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  pack-objects.h | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/pack-objects.h b/pack-objects.h
> index 2507b157d5..8979289f5f 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -71,35 +71,36 @@ enum dfs_state {
>   */
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	/* object uncompressed size _if_ size_valid is true */
> -	uint32_t size_;
> -	unsigned size_valid:1;
> -	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
> +	void *delta_data;	/* cached delta (uncompressed) */
>  	off_t in_pack_offset;
> +	uint32_t hash;			/* name hint hash */
> +	uint32_t size_;	/* object uncompressed size _if_ size_valid is true */
>  	uint32_t delta_idx;	/* delta base object */
>  	uint32_t delta_child_idx; /* deltified objects who bases me */
>  	uint32_t delta_sibling_idx; /* other deltified objects who
>  				     * uses the same base as me
>  				     */
> -	void *delta_data;	/* cached delta (uncompressed) */
>  	uint32_t delta_size_:OE_DELTA_SIZE_BITS; /* delta data size (uncompressed) */
>  	uint32_t delta_size_valid:1;
> +	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
> +	unsigned size_valid:1;
>  	unsigned z_delta_size:OE_Z_DELTA_BITS;
> +	unsigned type_valid:1;
>  	unsigned type_:TYPE_BITS;
>  	unsigned in_pack_type:TYPE_BITS; /* could be delta */
> -	unsigned type_valid:1;
> -	uint32_t hash;			/* name hint hash */
> -	unsigned char in_pack_header_size;
>  	unsigned preferred_base:1; /*
>  				    * we do not pack this, but is available
>  				    * to be used as the base object to delta
>  				    * objects against.
>  				    */
>  	unsigned no_try_delta:1;
> +	unsigned char in_pack_header_size;
>  	unsigned tagged:1; /* near the very tip of refs */
>  	unsigned filled:1; /* assigned write-order */
>  	unsigned dfs_state:OE_DFS_STATE_BITS;
>  	unsigned depth:OE_DEPTH_BITS;
> +
> +	/* size: 80, bit_padding: 16 bits */
>  };
>
>  struct packing_data {
