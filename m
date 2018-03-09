Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0BBB31F404
	for <e@80x24.org>; Fri,  9 Mar 2018 22:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932837AbeCIWeT (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Mar 2018 17:34:19 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34697 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932405AbeCIWeR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Mar 2018 17:34:17 -0500
Received: by mail-wm0-f67.google.com with SMTP id a20so5242009wmd.1
        for <git@vger.kernel.org>; Fri, 09 Mar 2018 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=xf0UC4OgKUtgwLUFfj68PmL91GufJjQT3B6zXmkGok0=;
        b=EXasJbM+6Y/7u9UnBE78Hnbuoi53B/bUaaj1Em4nEF4j+nbunOtypZT/7OzjvtHmrf
         d+J2yUN4hIY8n2a4BYkQVDyUIZte1zov9RsidaE1mCEH9YcqDgPg5ZlnRLW+zkjdRqB2
         2sNCDOQwDY9p66u+0EOCyrq4mq1zOUUzcv5RR+n7wJ8GU9hK0lP9zsVaYcgOwVugp6o4
         p/EO1vMrnPKVre2YA04/AJiM+o0xTiwLYLeJOZpD7ZS3co/FN6lrdxtXx0k91zdEpkDE
         9UstkoRlkmDwvTzUAe9WIG16KoYumBsJ5CHhSfBBWf4p8whN5KGA+9xDWivAkfYIiziH
         RyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=xf0UC4OgKUtgwLUFfj68PmL91GufJjQT3B6zXmkGok0=;
        b=Cyy0Xywh5WKB7TJln47WS6IDNwgcvb9mIIpER0UEGvd+V8y2S42V8Stg3d/hZSiv8T
         IcRK2Q8gRkKEz56fyYPLOTJhNcIRMZarJh2X43BkpgVNid7aavwbTxW3qbCSYsH3ejhU
         CJyVIOByO+xGlzGnMgS3vuP/ruZnXCoTIjdHLMH710HuRX8azo9l8tHUQOuxVE6k7arT
         YLGqIMc9z7vhLsGTGroNjZjCl7IrOL5H7vHx6mmgKH379lEywVYllVtQRIs2kUAEd6ZG
         0bwmkIbZzjxCkd/TKpSFCb4NYL0LJv2tzB3gMa2bw8vNHUn7zb3EC+nTPvc6+vdCSwV8
         AJSQ==
X-Gm-Message-State: AElRT7EZ85mjw3tR9H58jmYLl5tGNKvyrXnx2EFN2AAKnkO18sycc0o9
        VbrulzVyTGVZMVGxny8t5qg=
X-Google-Smtp-Source: AG47ELtEg9DjzMmRPPe0a026Ha4W0l8v9vbiDQbnbq7hBPFzEemCaNKlj5v+PLOoOx7BDVaptO5+/w==
X-Received: by 10.28.234.150 with SMTP id g22mr297338wmi.49.1520634855781;
        Fri, 09 Mar 2018 14:34:15 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q11sm2222153wrb.74.2018.03.09.14.34.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 14:34:15 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH/RFC v3 01/12] pack-objects: a bit of document about struct object_entry
References: <20180303024706.31465-1-pclouds@gmail.com>
        <20180308114232.10508-1-pclouds@gmail.com>
        <20180308114232.10508-2-pclouds@gmail.com>
Date:   Fri, 09 Mar 2018 14:34:14 -0800
In-Reply-To: <20180308114232.10508-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Thu, 8 Mar 2018 18:42:21 +0700")
Message-ID: <xmqqpo4c515l.fsf@gitster-ct.c.googlers.com>
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
> field is related to what. This also documents the holes in this struct
> according to pahole.
>
> A couple of notes on shrinking the struct:
>
> 1) The reader may notice one thing from this document and the shrinking
> business. If "delta" is NULL, all other delta-related fields should be
> irrelevant. We could group all these in a separate struct and replace
> them all with a pointer to this struct (allocated separately).
>
> This does not help much though since 85% of objects are deltified
> (source: linux-2.6.git). The gain is only from non-delta objects, which
> is not that significant.

OK.

> 2) The field in_pack_offset and idx.offset could be merged. But we need
> to be very careful. Up until the very last phase (object writing),
> idx.offset is not used and can hold in_pack_offset. Then idx.offset will
> be updated with _destination pack's_ offset, not source's. But since we
> always write delta's bases first, and we only use in_pack_offset in
> writing phase when we reuse objects, we should be ok?

By separating the processing in strict phases, I do think the result
would be OK, but at the same time, that does smell like an
invitation for future bugs.

> +/*
> + * basic object info
> + * -----------------
> + * idx.oid is filled up before delta searching starts. idx.crc32 and
> + * is only valid after the object is written down and will be used for
> + * generating the index. idx.offset will be both gradually set and
> + * used in writing phase (base objects get offset first, then deltas
> + * refer to them)

Here, I'd feel that "written out" somehow would sound more natural
than "written down", but that is perhaps because I've seen it used
elsewhere and I am confusing familiarlity with naturalness.  In any
case, if we mean "written to the resulting packdata stream", saying
that to be more explicit is probably a good idea.  We compute crc32
and learn the offset for each object as we write them to the result.

> + * If a delta is cached in memory and is compressed, "delta" points to
> + * the data and z_delta_size contains the compressed size. If it's

Isn't it "delta_data" (aot "delta") that points at the cached delta
data?

> + * uncompressed [1], z_delta_size must be zero. delta_size is always
> + * the uncompressed size and must be valid even if the delta is not
> + * cached. Delta recreation technically only depends on "delta"
> + * pointer, but delta_size is still used to verify it's the same as
> + * before.
> + *
> + * [1] during try_delta phase we don't bother with compressing because
> + * the delta could be quickly replaced with a better one.
> + */
>  struct object_entry {
>  	struct pack_idx_entry idx;
>  	unsigned long size;	/* uncompressed size */
> @@ -28,6 +74,7 @@ struct object_entry {
>  	unsigned tagged:1; /* near the very tip of refs */
>  	unsigned filled:1; /* assigned write-order */
>  
> +	/* XXX 28 bits hole, try to pack */
>  	/*
>  	 * State flags for depth-first search used for analyzing delta cycles.
>  	 *
> @@ -40,6 +87,7 @@ struct object_entry {
>  		DFS_DONE
>  	} dfs_state;
>  	int depth;
> +	/* size: 136, padding: 4 */
>  };
>  
>  struct packing_data {
