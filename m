Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 988CB1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752354AbeCPUcx (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:32:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:51364 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751837AbeCPUcw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:32:52 -0400
Received: by mail-wm0-f66.google.com with SMTP id h21so5330807wmd.1
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=4m9hw//2EYiOmNNGT9HshCzNDKWXPeoVPds/OZSJtao=;
        b=FiKHKenTDT4emV0eplLGl5Jws068v3oDUC3X7JEjxDYeOoeXWKOi2b0QaVYNvhXPmJ
         GQnRq/1Cp0tESp2XyxWk62EpJCThThSs+GYYRQLddE1QmNNJqcDfJzqAnbkNwt4jvK5S
         1L3Qtyy69d7mouVxzAR8HYM/cSKO9bSpES/e6Knl7cdqD9+p6rdlbC3C3j9KmSU0zAsn
         31syJ2zWl9G0mus8LmiwMRtI4trC4ae/m6mejdE6DZlMZ6aLRv0qviOx5jvgD1wOLJMv
         Tbu56p+9KKeL4TjULDzTbYzZIz1g5hSn/41eLHYHJAFm8unEtV27dQxC4qGXLCRz8I7W
         vpzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=4m9hw//2EYiOmNNGT9HshCzNDKWXPeoVPds/OZSJtao=;
        b=gOwnX5Q2C5M20mmIp86t/QHlFwVfnVfp76RImldcrBnUeNe5ZavKskUOtWsx3Eh9Zg
         EzoCYJlhQ9xtj310F08jSYFjsmwDl3zaCbMAPJCmQyvu50qJoSGNt0gOe9zpj7TPtpIk
         39f+Tq36LvyIziSTfaygPJt6ePVhRDdqTKitFF/p6iCOn2/NoaPjb+0UUK+TkWyFPSdU
         fF1/Y/lyhEbO/i4GPceBwo3DNs3Jg08jKDTK9Sq9aiIHrkm5M4eoxJJGkpTxKOaSnb4p
         QaGrTUOUf7V3eW4bb3wV2BIBE27SAPn3y28kbg5MlU1opRIOs1ugXiBdBaGXnnkfxv09
         rQGQ==
X-Gm-Message-State: AElRT7HUXayaSYVPKZszn02TasFNy+VjTr10lnpVckwMGwbw942jQMou
        HcueugbXqRFMKZAlENn9eiXQgKGC
X-Google-Smtp-Source: AG47ELt1N1XN+qMC5FXncbMBwQ/bqC6CAZ68XyTfT6K4VZZB+eRmIP+zSLYqaO6MpifAAlPv8C7nTQ==
X-Received: by 10.28.17.77 with SMTP id 74mr2731989wmr.67.1521232370531;
        Fri, 16 Mar 2018 13:32:50 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id f23sm10148313wra.51.2018.03.16.13.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 13:32:49 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 01/11] pack-objects: a bit of document about struct object_entry
References: <20180308114232.10508-1-pclouds@gmail.com>
        <20180316183200.31014-1-pclouds@gmail.com>
        <20180316183200.31014-2-pclouds@gmail.com>
Date:   Fri, 16 Mar 2018 13:32:49 -0700
In-Reply-To: <20180316183200.31014-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Fri, 16 Mar 2018 19:31:50 +0100")
Message-ID: <xmqqfu4z2232.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The role of this comment block becomes more important after we shuffle
> fields around to shrink this struct. It will be much harder to see what
> field is related to what.
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  pack-objects.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/pack-objects.h b/pack-objects.h
> index 03f1191659..85345a4af1 100644
> --- a/pack-objects.h
> +++ b/pack-objects.h
> @@ -1,6 +1,50 @@
>  #ifndef PACK_OBJECTS_H
>  #define PACK_OBJECTS_H
>  
> +/*
> + * basic object info
> + * -----------------
> + * idx.oid is filled up before delta searching starts. idx.crc32 and
> + * is only valid after the object is written out and will be used for

"and is"?

> + * generating the index. idx.offset will be both gradually set and
> + * used in writing phase (base objects get offset first, then deltas
> + * refer to them)
> + *
> + * "size" is the uncompressed object size. Compressed size is not
> + * cached (ie. raw data in a pack) but available via revindex.

I am having a hard time understanding what "ie. raw data in a pack"
is doing in that sentence.

It is correct that compressed size is not cached; it does not even
exist and the only way to know it is to compute it by reversing the
.idx file (or actually uncompressing the compressed stream).

Perhaps:

    Compressed size of the raw data for an object in a pack is not
    stored anywhere but is computed and made available when reverse
    .idx is made.

> + * "hash" contains a path name hash which is used for sorting the
> + * delta list and also during delta searching. Once prepare_pack()
> + * returns it's no longer needed.

Hmm, that suggests an interesting optimization opportunity ;-)

> + * source pack info
> + * ----------------
> + * The (in_pack, in_pack_offset, in_pack_header_size) tuple contains
> + * the location of the object in the source pack, with or without
> + * header.

"with or without", meaning...?  An object in the source pack may or
may not have any in_pack_header, in which case in_pack_header_size
is zero, or something?  Not suggesting to rephrase (at least not
yet), but trying to understand.

> + * "type" and "in_pack_type" both describe object type. in_pack_type
> + * may contain a delta type, while type is always the canonical type.
> + *
> + * deltas
> + * ------
> + * Delta links (delta, delta_child and delta_sibling) are created
> + * reflect that delta graph from the source pack then updated or added
> + * during delta searching phase when we find better deltas.

Isn't anything missing after "are created"?  Perhaps "to"?

> + *
> + * delta_child and delta_sibling are last needed in
> + * compute_write_order(). "delta" and "delta_size" must remain valid
> + * at object writing phase in case the delta is not cached.

True.  I thought child and sibling are only needed during write
order computing, so there may be an optimization opportunity there.

> + * If a delta is cached in memory and is compressed delta_data points

s/compressed delta_data/compressed, delta_data/;

> + * to the data and z_delta_size contains the compressed size. If it's
> + * uncompressed [1], z_delta_size must be zero. delta_size is always
> + * the uncompressed size and must be valid even if the delta is not
> + * cached.
> + *
> + * [1] during try_delta phase we don't bother with compressing because
> + * the delta could be quickly replaced with a better one.
> + */
>  struct object_entry {
>  	struct pack_idx_entry idx;
>  	unsigned long size;	/* uncompressed size */
