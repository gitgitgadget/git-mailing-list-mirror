Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22606C433EF
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01341610A8
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 03:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbhJGDCi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 23:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240070AbhJGDCg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 23:02:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02641C061746
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 20:00:43 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id p13so17758081edw.0
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 20:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=P5OiwRpACVtK/codZmL5I3d+2ahvrBvi++cUY04kWsU=;
        b=Xc88PtioJj7tYYAd63vJyzxcTjXPZXwLfMAShGwwMThvfGAuAFeLCuJXgtdrZK4wly
         y0mRCnFIBapzyTHqTvtKN06bzz2u9JV40X/MPFB/kPSmZvjN2XIhW5pggaJ7BWwrriKH
         1qK3M2dX2df2sguSjJnp6ZXvF0ZwuLT7xj7+lb3W5nqYgZwCiCZqyshg53SKql2NIH7/
         QrmEZAyssJqOdRH7kgGv4cfpeGIuhksn0Goq/f/gkjpfS8JvjtyYVjj5MZlLsDwx6Uky
         W8pb9KMK3x6vEQj9Z9gWaY/EWDwnnjMUWTfZK60caq2dLF47RoH+ntGKZE/UU8ANNWAq
         LDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=P5OiwRpACVtK/codZmL5I3d+2ahvrBvi++cUY04kWsU=;
        b=Gstmk/+gnmWJk5wXPrcdXI+RvXfNiguR8FDp+bc3/RX/UPnFq2q7ZEkjbH9QRRxkjp
         WOuNjNluaxOKLogM8phr20Bt/WiB0hcluw/7WkiqGNnWidKIYe6zJJuKj/K2c15KdIXn
         V7CID4mCNuUFMjnE4dTTM98WYU2RE6NvC6RkMWREfkpjbrbIegbM8aiHnKQ7hT9AloeS
         z0jnXbzNPyPhXpYppjFlPIpvcLZ+VPl+ucOvXg/nMzPvLUX0/Y+va24F1KIhGmnmh/4g
         kr2hvtCtUAmwRUtNioU2K2ZiaW3FoCBZfmYLTBmljpn77dc0eqXD8mxRRhFuYwNuJYim
         iVog==
X-Gm-Message-State: AOAM533ic2tmUtbyUBb5+A5YofqQCYWfCKgf8gk8scaJ6o6oW5nnZ7b5
        sgXdkZnPJaCIINq0dzF9e3G7Yrylb7PBuA==
X-Google-Smtp-Source: ABdhPJxJFfaDY/sK5TDKeqYGT4RJKtVavpPyA2Vibrd6BR+glq012a3/CWcgtdiONkn3loN8G9idxg==
X-Received: by 2002:a17:906:d54f:: with SMTP id cr15mr2466658ejc.300.1633575641438;
        Wed, 06 Oct 2021 20:00:41 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id lg3sm1735273ejb.78.2021.10.06.20.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 20:00:41 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2021, #02; Wed, 6)
Date:   Thu, 07 Oct 2021 04:57:10 +0200
References: <xmqqfstdr8b5.fsf@gitster.g>
 <YV5aaD418SyZqS/1@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YV5aaD418SyZqS/1@coredump.intra.peff.net>
Message-ID: <87wnmph73b.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 06 2021, Jeff King wrote:

> On Wed, Oct 06, 2021 at 05:24:14PM -0700, Junio C Hamano wrote:
>
>> * tb/repack-write-midx (2021-10-01) 9 commits
>>   (merged to 'next' on 2021-10-06 at ccdd5aaf2a)
>>  + builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
>>  + builtin/repack.c: make largest pack preferred
>>  + builtin/repack.c: support writing a MIDX while repacking
>>  + builtin/repack.c: extract showing progress to a variable
>>  + builtin/repack.c: rename variables that deal with non-kept packs
>>  + builtin/repack.c: keep track of existing packs unconditionally
>>  + midx: preliminary support for `--refs-snapshot`
>>  + builtin/multi-pack-index.c: support `--stdin-packs` mode
>>  + midx: expose `write_midx_file_only()` publicly
>> 
>>  "git repack" has been taught to generate multi-pack reachability
>>  bitmaps.
>> 
>>  Will merge to 'master'.
>
> Sorry not to catch this before it hit 'next', but there's a small leak
> in the test helper. This patch can go on top to fix it.
>
> -- >8 --
> Subject: [PATCH] test-read-midx: fix leak of bitmap_index struct
>
> In read_midx_preferred_pack(), we open the bitmap index but never free
> it. This isn't a big deal since this is just a test helper, and we exit
> immediately after, but since we're trying to keep our leak-checking tidy
> now, it's worth fixing.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/helper/test-read-midx.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/t/helper/test-read-midx.c b/t/helper/test-read-midx.c
> index 0038559129..9d6fa7a377 100644
> --- a/t/helper/test-read-midx.c
> +++ b/t/helper/test-read-midx.c
> @@ -85,11 +85,15 @@ static int read_midx_preferred_pack(const char *object_dir)
>  		return 1;
>  
>  	bitmap = prepare_bitmap_git(the_repository);
> -	if (!(bitmap && bitmap_is_midx(bitmap)))
> +	if (!bitmap)
>  		return 1;
> -
> +	if (!bitmap_is_midx(bitmap)) {
> +		free_bitmap_index(bitmap);
> +		return 1;
> +	}
>  
>  	printf("%s\n", midx->pack_names[midx_preferred_pack(bitmap)]);
> +	free_bitmap_index(bitmap);
>  	return 0;
>  }

Thanks, I think it's no big deal, those tests seem to leak a lot
already. Here's a patch that might be generally applicable and makes a
few more of its tests pass.

The s/free/free_chunkfile/g seems like a good bug fix, and that "m =
NULL" pattern seems odd, don't we always want to free in that scenario?
It passes all tests...

This brings t5319-multi-pack-index.sh down from 64 to 57 failures in
"next", I didn't try in combination with your patch.

diff --git a/midx.c b/midx.c
index 7e06e859756..d24b1e6a9d4 100644
--- a/midx.c
+++ b/midx.c
@@ -179,12 +179,13 @@ struct multi_pack_index *load_multi_pack_index(const char *object_dir, int local
 	trace2_data_intmax("midx", the_repository, "load/num_packs", m->num_packs);
 	trace2_data_intmax("midx", the_repository, "load/num_objects", m->num_objects);
 
+	free_chunkfile(cf);
 	return m;
 
 cleanup_fail:
 	free(m);
 	free(midx_name);
-	free(cf);
+	free_chunkfile(cf);
 	if (midx_map)
 		munmap(midx_map, midx_size);
 	if (0 <= fd)
@@ -1602,7 +1603,7 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		 * Remaining tests assume that we have objects, so we can
 		 * return here.
 		 */
-		return verify_midx_error;
+		goto cleanup;
 	}
 
 	if (flags & MIDX_PROGRESS)
@@ -1679,8 +1680,9 @@ int verify_midx_file(struct repository *r, const char *object_dir, unsigned flag
 		midx_display_sparse_progress(progress, i + 1);
 	}
 	stop_progress(&progress);
-
+cleanup:
 	free(pairs);
+	free(m);
 
 	return verify_midx_error;
 }
@@ -1927,11 +1929,9 @@ int midx_repack(struct repository *r, const char *object_dir, size_t batch_size,
 	}
 
 	result = write_midx_internal(object_dir, NULL, NULL, NULL, NULL, flags);
-	m = NULL;
 
 cleanup:
-	if (m)
-		close_midx(m);
+	close_midx(m);
 	free(include_pack);
 	return result;
 }
