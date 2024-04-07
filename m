Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131092D60A
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 14:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712499407; cv=none; b=b4fq/oiDTdrwagdOaqIj0+CFYFyq1mGPF8SWFFAGDyY472OgLeRriRdQxyNX2hGoR20wHyzaK3HL3/ZF/jH2zhjIoVksTKNH1NlN+NMhXsqWwlI2OhsvFwbYwndBUKeVNP17rOMG5kh7pY0/GMte6Npt4DcNVFbVPTcmtm2pCsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712499407; c=relaxed/simple;
	bh=y5ZBIIhLksqQLFwLDmzPvB/FV5opntPXnZlQBcnTpxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EqSJPT+0fJgaVN0UOE7cfV+XUpR0W5PYxsoNRLpw4mhJBkizcg8LHsVso3uxMvLixSrEhfsvXWGBR0mG87zOF3L8Tf5L21M96j7fcxaQespMV0MRCjO8DvXsp+57Qt6lJ141dWNtyz/PNV715lttGMYUNzUzFC3Qd3iD1dwGRrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=NiJyC/3y; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="NiJyC/3y"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-78d575054c8so64544385a.3
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 07:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712499405; x=1713104205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7dZdG11xR76edph+9cckbQKQJeTd8HGmqQmo0fgHRHM=;
        b=NiJyC/3yv+ARwVXlbRGx+xyD8S4IrzHGT2pN/XIZBFSkEBUeYCv8VmHQWXb50NNShD
         0LqfCINspB63bpd2FLxXI/lLGdw2S71zdfOsBCuYUJ06++jNj1Juo4fZdij5XT2q7HP7
         sZZeGcebNPQAi6pZI1NPTq0hJigphCPVoyXt4c9PtYlitMD1nbhq/O7cvfD6F74eV+dv
         YeCweAQXuzHIHU9sEIkoaVUZ/otmpmHRhHoq5duehxPhAep1WowpnkFBvoV7gaNyYJQ3
         3DJpdMYBugmPoxJZh06jkTq+T+y+WWyGOdBMkwXx7TevOPcaOPJFKq7QjOWHOZn6nHUL
         N4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712499405; x=1713104205;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7dZdG11xR76edph+9cckbQKQJeTd8HGmqQmo0fgHRHM=;
        b=tDpWMRf89MF+Ymv38SYaEAifFZBbYc5YqfrjLWXsKEKDL5Vn/qMvr9+jKLRX9PStRn
         7bi9bCCEo9T5S6wtr5/nhFfzKeyJ5Etdj2Hbs1SGsjW6OL/aVH7b5RPxWNGIGd0UDA5e
         WFlFMq2LbS3+AFIHZ6Lz4baLkEpDwDayVnfvmQE9uQ7yziG2t7jIWkfEw1HFq9UDCnfi
         mtO9dWecueGff2Px2svldcjT9m4pYdcrhWpu5BgIEWoXbad3UwHnSu+wNzCug/aFNdgu
         kyC6MpU56dPbrvNs8j3BQAnAvW3GRLehUa6yjGDezLTDftLfaXuO760273nSlXmtm7DI
         o73g==
X-Gm-Message-State: AOJu0YycjtChV0mbIPheOSkHrW/xJ0xMaWpSrXAmeaOL63hFaFJIiz1Z
	TW4B+QqteSPtQhFwqKeYMaOWIP6fwcL4adqwWgK+0stxbMJzGoq0t6RkY2nW7f0=
X-Google-Smtp-Source: AGHT+IESNi9ogSVsj4Oh7QDt4z3BBBsD/Rtq3tzTvzlTCKvTx2BfCeiZ/9m4HWqxDuiLRQAcDMtKwg==
X-Received: by 2002:a37:e114:0:b0:78b:c6c4:b0bc with SMTP id c20-20020a37e114000000b0078bc6c4b0bcmr6210455qkm.48.1712499404867;
        Sun, 07 Apr 2024 07:16:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u13-20020a05620a022d00b0078d5ffa723asm873540qkm.94.2024.04.07.07.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 07:16:36 -0700 (PDT)
Date: Sun, 7 Apr 2024 10:16:28 -0400
From: Taylor Blau <me@ttaylorr.com>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] midx: disable replace objects
Message-ID: <ZhKqvA1NQwrVfnfE@nand.local>
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>

On Sun, Apr 07, 2024 at 01:11:47PM +0000, blanet via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
>
> We observed a series of clone failures arose in a specific set of
> repositories after we fully enabled the MIDX bitmap feature within our
> Codebase service. These failures were accompanied with error messages
> such as:
>
>   fatal: did not receive expected object ...
>   fatal: fetch-pack: invalid index-pack output
>
> Temporarily disabling the MIDX feature eliminated the reported issues.
> After some investigation we found that all repositories experiencing
> failures contain replace references, which seem to be improperly
> acknowledged by the MIDX bitmap generation logic.

I was suspicious that this might be related to the MIDX or MIDX bitmap,
but noticed something curious upon digging in. Applying the following on
top of your patch:

--- 8< ---
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 5e4cdef6a8..8543f8d097 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -451,9 +451,7 @@ test_expect_success 'do not follow replace objects for MIDX bitmap' '
 		git rev-list --objects --no-object-names $B |sort >expected &&

 		git replace $A $C &&
-		git repack -ad &&
-		git multi-pack-index write --bitmap &&
-		git rev-list --objects --no-object-names --use-bitmap-index $B |sort >actual &&
+		git rev-list --objects --no-object-names $B |sort >actual &&
 		test_cmp expected actual
 	)
 '
--- >8 ---

, I can still produce the failure that you are seeing here. So I suspect
that while it's entirely possible that there is a bug in the MIDX/bitmap
code, that this test is not exercising it.

I think the first step to demonstrate a bug in the MIDX/bitmap machinery
would be to provide a reproducer that fails only when using a MIDX
and/or bitmap.

> @@ -273,6 +274,8 @@ int cmd_multi_pack_index(int argc, const char **argv,
>  	};
>  	struct option *options = parse_options_concat(builtin_multi_pack_index_options, common_opts);
>
> +	disable_replace_refs();
> +

Supposing for a moment that this issue is in the MIDX, we know that
regardless of what replace refs might be in place, the MIDX should only
be storing the objects that are in the packs being indexed, not the
objects which are their replacements.

Are we storing objects in the MIDX that are replacements? Looking
at midx.c::fill_pack_entry(), I think the answer is "no", since we're
looking up packed objects by calling nth_packed_object_id(), which is
just a table read into the .idx, all of which is beneath the level of
replace refs.

> @@ -434,6 +434,30 @@ test_expect_success 'tagged commits are selected for bitmapping' '
>  	)
>  '
>
> +test_expect_success 'do not follow replace objects for MIDX bitmap' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		test_commit A &&
> +		A=$(git rev-parse HEAD) &&

It's possible that much of this will be moot if the current test gets
rewritten, but here are a couple of suggestions for writing tests in
Git's suite:

- test_commit will create a tag for you, so there is no need to store
  "$A", "$B", and "$C".

> +		test_commit B &&
> +		B=$(git rev-parse HEAD) &&
> +		git checkout --orphan=orphan $A &&
> +		test_commit orphan &&
> +		C=$(git rev-parse HEAD) &&
> +		git rev-list --objects --no-object-names $B |sort >expected &&

- We do not allow Git invocations on the left-hand side of a pipe, since
  doing so will squelch its exit code. Instead, try:

    git rev-list --objects --no-object-names B >expect.raw &&
    sort expect.raw >expect &&

Thanks,
Taylor
