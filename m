Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F6413FD86
	for <git@vger.kernel.org>; Fri,  4 Oct 2024 22:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728081010; cv=none; b=IyuT4ArVToGSfR4buMUd/Ak+eLw+CmAE1z7J4hdtWuSOl2M2IfZTGdtmZgiiejZM3m+nSR/wG87k2iJ5bx4Zhq9livlQx6BrhGakc4LqHQz+tEywEcGVRmQlfSDnt6Ndpv2VpIu71FGziyufI2h1eDQ6MTf921svBMoNUEdOUoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728081010; c=relaxed/simple;
	bh=D77HsV/yAkNGfHAVH05A7STgkQN59byQXT1+4jXwpMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjSUlORnjHMSeTrUpBUovX6S0il2I0lels5oRoQbsSxZlYEhHo/r01IJx6yV1pmFBqp6SdAl3nuMivIf8OkeSl/HxrrvsqgL4jPGktGE/+fF5BPP5haCfQ/fEmVC/eZ2c0xyeqlazqc/ZxaYMuJkMpkMQo67ckseYOKO0G7fPrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=unXywxkU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="unXywxkU"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e25d405f238so2344964276.3
        for <git@vger.kernel.org>; Fri, 04 Oct 2024 15:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728081008; x=1728685808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=URpcKoIQgMKcgBkrTSaa9ISlnix3NMNwy0w5X2fltVk=;
        b=unXywxkUhHDzPXDPVhLKs9Nmu+hDLyeqpdJi7RFSE9kPS+F3vtgbR+c7JsmEh3auCv
         57gxrauWjuiAS91lHzH/g/R+CYfCIS9Vhzp+WttZ8/CFuIJA/kbu/OaOR9zyy5AKydQP
         5SWkoVrBmIOVECgTTxPHYAutw71AoroW245OsWNqYwppwZ8DAm66vX1Ac86VUpTBhn5h
         pc6RdK6W13PjZ0tRUCYaNNDVbzuOJVqMNWyPJO1Z4/Lod3KXzAM0zOMlywClyewT4lH+
         FKAwYpfMcIbgZPlm7L+G7L2gThNHFQTIg1U0CU6DuGJeXj3T/5jYCPOV6rNfzEz999dg
         MZTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728081008; x=1728685808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=URpcKoIQgMKcgBkrTSaa9ISlnix3NMNwy0w5X2fltVk=;
        b=ROIV4kmT6ix1a3rNsQ1EoDmM/zYpBh6h6bFB+Pc+I25JbY5PrG7fqBCUGG3X3g5O1V
         iDP0MoW8nGU+G/1JIrHMZpecMI/lB7QmUJXSN9c+egzA5Qt63Qt91Vbs36Fw/IUq3Vo4
         bZQBcErno3wnUpc7OFSMQsQKGo/zA/onSrb6bc+rwc6xYMv9VHBw77rPP+nzoJkYZEb3
         oe2hpV0dyFltuPPwW5mH6zdvTyGp3o8aAg3wCybvuTUYYsiv7FTd9hLupatxbRFl8Bz6
         qf3woVhxn9IgA7RRZq4XjAaFIwaePurPlxY4+vSLyhaoTvp+iUAbz3Jrn0pstkS0lQ+W
         KC8A==
X-Forwarded-Encrypted: i=1; AJvYcCX8QPx+2pjMBAI/5rasSJaSSpLRpd/2/EsP/B+UONBy6F701ZAH3Duo/vJGb8lM52ks5RQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBjk6Gn1Yu4iBAbIS+PpdKWRF+xwxgROeBsbIwMn9Mo98M5kyE
	361N8dLydbTc3xGHm27MsKAZcYExShsxnw57Sz0reMqRQgKsE7wqaXH9II9aJvM=
X-Google-Smtp-Source: AGHT+IHi7IxjWONXgjMtMpB+Z9STfS6fxRb4h7ZNxhi+2Y6xeBNI9Ja3dAb16IcQjRkr/XBGUOCUXQ==
X-Received: by 2002:a05:6902:2b05:b0:e22:5da1:b328 with SMTP id 3f1490d57ef6-e28937efc0emr3539974276.33.1728081007690;
        Fri, 04 Oct 2024 15:30:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5ca8d90sm105926276.51.2024.10.04.15.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2024 15:30:06 -0700 (PDT)
Date: Fri, 4 Oct 2024 18:30:05 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, peff@peff.net,
	ps@pks.im, johncai86@gmail.com, newren@gmail.com,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/6] pack-objects: create new name-hash algorithm
Message-ID: <ZwBsbW5jsFw0mxKk@nand.local>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <pull.1785.v2.git.1726692381.gitgitgadget@gmail.com>
 <xmqqiku7d0ut.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiku7d0ut.fsf@gitster.g>

On Fri, Oct 04, 2024 at 02:17:30PM -0700, Junio C Hamano wrote:
> t5334 still fails 8/16 subtests just like the above run, exonerating
> this topic for its breakage.
>
>   https://github.com/git/git/actions/runs/11186737635/job/31102378478#step:4:1880

This is not all too surprising, since part two of the incremental MIDX
topic introduces some new leaks which were not seen by Patrick's recent
leakfixes. So I expect that this broke with 9d4855eef3 (midx-write: fix
leaking buffer, 2024-09-30), which marked t5534 as leak-free.

And that's true, without the patches from tb/incremental-midx-part-2.
The leak stems from the fact that the 'bitmap_index' struct now has a
new optional "base" pointer, which points to another 'bitmap_index'
corresponding to the previous MIDX layer.

The fix is fairly straightforward, and should be limited to:

--- 8< ---
Subject: [PATCH] fixup! pack-bitmap.c: open and store incremental bitmap
 layers

The incremental MIDX bitmap work was done prior to 9d4855eef3
(midx-write: fix leaking buffer, 2024-09-30), and causes test failures
in t5334 in a post-9d4855eef3 world.

The leak looks like:

    Direct leak of 264 byte(s) in 1 object(s) allocated from:
        #0 0x7f6bcd87eaca in calloc ../../../../src/libsanitizer/lsan/lsan_interceptors.cpp:90
        #1 0x55ad1428e8a4 in xcalloc wrapper.c:151
        #2 0x55ad14199e16 in prepare_midx_bitmap_git pack-bitmap.c:742
        #3 0x55ad14199447 in open_midx_bitmap_1 pack-bitmap.c:507
        #4 0x55ad14199cca in open_midx_bitmap pack-bitmap.c:704
        #5 0x55ad14199d44 in open_bitmap pack-bitmap.c:717
        #6 0x55ad14199dc2 in prepare_bitmap_git pack-bitmap.c:733
        #7 0x55ad1419e496 in test_bitmap_walk pack-bitmap.c:2698
        #8 0x55ad14047b0b in cmd_rev_list builtin/rev-list.c:629
        #9 0x55ad13f71cd6 in run_builtin git.c:487
        #10 0x55ad13f72132 in handle_builtin git.c:756
        #11 0x55ad13f72380 in run_argv git.c:826
        #12 0x55ad13f728f4 in cmd_main git.c:961
        #13 0x55ad1407d3ae in main common-main.c:64
        #14 0x7f6bcd5f0c89 in __libc_start_call_main ../sysdeps/nptl/libc_start_call_main.h:58
        #15 0x7f6bcd5f0d44 in __libc_start_main_impl ../csu/libc-start.c:360
        #16 0x55ad13f6ff90 in _start (git+0x1ef90) (BuildId: 3e63cdd415f1d185b21da3035cb48332510dddce)

, and is a result of us not freeing the resources corresponding to the
bitmap's base layer, if one was present.

Rectify that leak by calling the newly-introduced free_bitmap_index()
function on the base layer to ensure that its resources are also freed.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 2b4c3972e5..fe0df2b6c3 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -3045,6 +3045,7 @@ void free_bitmap_index(struct bitmap_index *b)
 		close_midx_revindex(b->midx);
 	}
 	free_pseudo_merge_map(&b->pseudo_merges);
+	free_bitmap_index(b->base);
 	free(b);
 }

--
2.47.0.rc1.154.ge6e38f19f35.dirty
--- >8 ---

That should apply on top of 'seen' easily, and will at least fix the
leak failures you pointed out here.

When the integration branches are rewound after 2.47.0 is tagged, I'll
send a new version of this topic based on Patrick's work here.

Thanks,
Taylor
