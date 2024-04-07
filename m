Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159AA26AE3
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712512942; cv=none; b=HIcmK7TOyM7gPu+rMLAts+Yg9Uo0mMHECU8bZySxto6h37cRCboizuaIvcUdcEHhq97Kikdg7NX+BPww40uqZp2gzBitVnlktEZDKtNat6yX4K8XZY4T2DnMBWJHoGdJ0eSnuQTs27wk3NJ9TCM6KlrHw+dTPhdUk75swKR+cHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712512942; c=relaxed/simple;
	bh=g/1n2nJhUlK5XHgeot43xM5gKhglduuDaONm/2SZvEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dHswLBKXkfsM74zIQOINYcjeEY9eHmA7b9W6WJiS+FDYMR4FlB82We05H6I7KD8ksrs/fIP0HqFjiEvXtCqo/CmVFwWMsLKTVnxzNae4zpPpgcdnkiXSv/YNbBv5Q7vorzEZ9fmPZJxDKqh+Cy3NSMQDezUpbUfvuN0pNDliGcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zohiM9YN; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zohiM9YN"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4345f35daa7so8228981cf.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 11:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712512940; x=1713117740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iwuypd+Y0tCKNFC8nmQ/rBfcnk4QYvrY7OulDopsDK4=;
        b=zohiM9YNuSu08cp3b59zqEuoYsDo7tuLp8CJTUQQ0/zy8akMK5SviIJJQhVa+9NTOu
         upPjfNaUzIbbOdXYrlvNhTcebQ8yAh9jK37dczJ+IemRGTfAf/tY8E0Cx9JA+It0/py6
         DpXi607d9jmM07hPRctdALWLqlgYDqKBlbUemOp04lMZEm2eRXYfLjQ5KZpMRN4cuWVH
         7oXkHgT3de5bPn1sWCJS3SI7TXPI0tfyAiEqX/eF5ZFNV+vmdMZLXFO99GqRlrSNlsOG
         4fi21JPgiU5jqnSijJdEZMJCEnipBhUT+z8f42eGCIkl2HQi1cIGDjzgxd4MOhz8uzzd
         boWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712512940; x=1713117740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iwuypd+Y0tCKNFC8nmQ/rBfcnk4QYvrY7OulDopsDK4=;
        b=kOpBdw7+M4bea4IkCsS5w2gnIv6BwxendAbcCO1Je/vrcNOZ2MNdzs6WvZuHneplNt
         1cSy9FrKoFPCfO1FUaMIuVgxT+RVtyrr3TfSnHQoXK8Z85It1j10EIsWLEtm1SnPY2Zw
         SgbLskFNSbgVSTswfPUknRZWtrwv5OAjCRSB6ApOtrtHGOF8C3n+tZyZQ4RZsHGkEyEn
         z68WH5OX/NffgnhKyEVSM2KWL2Yg9CuokWH+w5wnAV2aeOGh2wPiHVwtMUAUNBiY4R8H
         ae3MvoN0EheSjnGImem81LQqTPjMfW0nJx99017K3J4F+DFvBFKKiSg8aw/Ab8y2tVUt
         r4WA==
X-Gm-Message-State: AOJu0YwHUufCf5OYn3GI2jwB9ua+KqYzanzshID3jsvQAIYxb/xbC+lb
	8CBwoeVjAw8eH5KfVEQWxUHdwHwkrXBzdBoyqrmd9qqcqv5qGBdtqJ8QnELf1Ec=
X-Google-Smtp-Source: AGHT+IEm2WZGhQXpg36ZR5k3A9GrqGQVGfeRPBws8Zl/LLMwKZUVkwxDGo+VYR5lIo0tAc5robeuiw==
X-Received: by 2002:ac8:7d52:0:b0:432:bfac:a0b4 with SMTP id h18-20020ac87d52000000b00432bfaca0b4mr8910416qtb.59.1712512939914;
        Sun, 07 Apr 2024 11:02:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f20-20020ac840d4000000b00434a5dba537sm105259qtm.3.2024.04.07.11.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 11:02:19 -0700 (PDT)
Date: Sun, 7 Apr 2024 14:02:17 -0400
From: Taylor Blau <me@ttaylorr.com>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] midx: disable replace objects
Message-ID: <ZhLfqU9VNUW+2mmV@nand.local>
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
 <ZhKqvA1NQwrVfnfE@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhKqvA1NQwrVfnfE@nand.local>

On Sun, Apr 07, 2024 at 10:16:28AM -0400, Taylor Blau wrote:
> , I can still produce the failure that you are seeing here. So I suspect
> that while it's entirely possible that there is a bug in the MIDX/bitmap
> code, that this test is not exercising it.
>
> I think the first step to demonstrate a bug in the MIDX/bitmap machinery
> would be to provide a reproducer that fails only when using a MIDX
> and/or bitmap.

I had a some more time to look into this, and I think that your original
fix is correct.

The issue is, as you suggest, due to the following (from your original
patch):

> After some investigation we found that all repositories experiencing
> failures contain replace references, which seem to be improperly
> acknowledged by the MIDX bitmap generation logic.

Indeed, the pack-bitmap-write machinery does not itself call
disable_replace_refs(). So when it generates a reachability bitmap, it
is doing so with the replace refs in mind. You can see that this is
indeed the cause of the problem by looking at the output of an
instrumented version of Git that indicates what bits are being set
during the bitmap generation phase.

With replace refs (incorrectly) enabled, we get:

    [2, 4, 6, 8, 13, 3, 6, 7, 3, 4, 6, 8]

and doing the same after calling disable_replace_refs(), we instead get:

    [2, 5, 6, 13, 3, 6, 7, 3, 4, 6, 8]

Single pack bitmaps are unaffected by this issue because we generate
them from within pack-objects, which does call disable_replace_refs().

It is tempting to instead do something like:

--- 8< ---
diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index c6c8f94cc5..cbc543caad 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -17,6 +17,7 @@
 #include "trace2.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "replace-object.h"

 struct bitmapped_commit {
 	struct commit *commit;
@@ -223,6 +224,8 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
 	memset(bb, 0, sizeof(*bb));
 	init_bb_data(&bb->data);

+	parsed_object_pool_clear(the_repository->parsed_objects);
+
 	reset_revision_walk();
 	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
 	revs.topo_order = 1;
--- >8 ---

But by then it is too late, because the replace refs have already been
taken into account for parsed objects.

An alternative is to clear the parsed_object_pool before (or after)
calling disable_replace_refs(), but I think that approach that feels
sub-optimal for a couple of reasons:

  - We're wasting time re-parsing objects that we've already seen

  - We're banking on the fact that the MIDX generation does not lookup
    objects with the OBJECT_INFO_LOOKUP_REPLACE flag set, which would
    cause the MIDX to be broken in the same way.

So I think that disabling replace refs at the outset within the
multi-pack-index builtin is the right way to go. In addition to the test
fixes I suggested earlier, I would instead demonstrate the bug by
showing a clone (which fails with MIDXs, but doesn't without MIDXs) like
so:

--- 8< ---
diff --git a/t/t5326-multi-pack-bitmaps.sh b/t/t5326-multi-pack-bitmaps.sh
index 5e4cdef6a8..1fb3b0f9d7 100755
--- a/t/t5326-multi-pack-bitmaps.sh
+++ b/t/t5326-multi-pack-bitmaps.sh
@@ -442,19 +442,16 @@ test_expect_success 'do not follow replace objects for MIDX bitmap' '
 		cd repo &&

 		test_commit A &&
-		A=$(git rev-parse HEAD) &&
 		test_commit B &&
-		B=$(git rev-parse HEAD) &&
-		git checkout --orphan=orphan $A &&
+		git checkout --orphan=orphan A &&
 		test_commit orphan &&
-		C=$(git rev-parse HEAD) &&
-		git rev-list --objects --no-object-names $B |sort >expected &&

-		git replace $A $C &&
-		git repack -ad &&
-		git multi-pack-index write --bitmap &&
-		git rev-list --objects --no-object-names --use-bitmap-index $B |sort >actual &&
-		test_cmp expected actual
+		git replace A HEAD &&
+		git repack -ad --write-midx --write-bitmap-index &&
+
+		# generating reachability bitmaps with replace refs
+		# enabled will result in broken clones
+		git clone --no-local --bare . clone.git
 	)
 '
--- >8 ---

With the change in your patch to call disable_replace_refs() in
builtin/multi-pack-index.c, this test passes as expected. With that
change compiled out, we instead get:

[...]
+ git clone --no-local --bare . clone.git
Cloning into bare repository 'clone.git'...
remote: Enumerating objects: 8, done.
remote: Total 8 (delta 0), reused 0 (delta 0), pack-reused 8 (from 1)
Receiving objects: 100% (8/8), done.
fatal: did not receive expected object da5497437fd67ca928333aab79c4b4b55036ea66
fatal: fetch-pack: invalid index-pack output
error: last command exited with $?=128
not ok 352 - do not follow replace objects for MIDX bitmap

as expected.

Thanks,
Taylor

