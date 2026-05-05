Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C63D4B8DE2
	for <git@vger.kernel.org>; Tue,  5 May 2026 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778007713; cv=none; b=cJrF3Q4mxP9ChucqpaQ0Un0DXs5O1Mtcq2SDmMw9Zz9aZMm3dx9dSivVpj5G1wNpR12jezzSYFFymvx7xnVVXfP/30QY9K3wNCx5UHRgAgzOlHr1AOp6X4FPlLLAI9YTxEyfiJhg/lgmaW/NGRCOultsoDqQ00Owrhl5D2ynjOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778007713; c=relaxed/simple;
	bh=0OHJa8T5uPCgIbckzWNUeSqWXVLL4SwydsWBE5CoElI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWZcYkJNlfogdxYZUCUGVenBsAX6cgsPWt1X6ByJMZnkS4Ho21VSjGIa2aLMisPVZkUcCj2agCt4cxYErF30Cb2iUqKPImpkdsFlr1KkI7WRIIjhwUS9C/hHdUzUHhKhNVi3bgMtLiO0E6mjt/4sn9QbulpY2yoZ6EVIZIvnfpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ggYYBjde; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ggYYBjde"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7bdc947aaa3so10493357b3.0
        for <git@vger.kernel.org>; Tue, 05 May 2026 12:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1778007706; x=1778612506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OAN7VD8MSgwiKuLNMIR/Pk0+u1MJjojItQ/ihY/HE6E=;
        b=ggYYBjdeEbyy2nJNXubWsMLd/nRO74BisrPh7fw+QRc6jLP14IkTKve4weNH+sgOZa
         GxaVn+dQFqs0edtv4cuK1LD4FaXxSykfgrH8jibng7iGfmek6L52nL2ZeEmGwNg2C+Kf
         lhUreUBOTy0Er2PxNGT1KTEmjG4aIjbhtRg5+nCAiv+GJkDy9f3buwJDIw/W0ydt4e76
         tVAP3lEZ+H3WqCC5WEq4Mo7Kre4Av0DZPjnpT+HEuQDOz2slATqjNW6QE9Nnj7udZ002
         2QI8Y4iEL2NxW5D//6kFHYXmSrc5ClRYvfNrJokpO87ol5Tm17HncG8TBelfkhsh/Xkz
         v01w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778007706; x=1778612506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OAN7VD8MSgwiKuLNMIR/Pk0+u1MJjojItQ/ihY/HE6E=;
        b=GjB1FJkatWM/xNqE7bSzrhwu7Ja95pOmnbA2rJS1VSrYbmp01Ogav8gR3xWCMpZzbA
         UOLMJ3JpNuD2USVA5ntv5fWqnmYObBBENvTqOOYSOZDgOTWMw6G+BnYfiK/WKTLAh4qo
         CDob4iW2qiRJpICMr8NkHCJj0+IS7LwgfczCBRUI1kCsuT4fOE2+F6norizppFTgg+G/
         Kc4GweY5ICqQ3FpUcYTW1+9h8lEL5upuj6bcJ1+YX6TZfL5OKsyfdEY6vocj8Oz8HBmz
         Mz9BWP/QOKTtdgOxFE940QvXec/zc8s/sMREL5H8lpZMIVRDL+UtWXiAIH9ozbjhP1RA
         Z5rQ==
X-Forwarded-Encrypted: i=1; AFNElJ96nWl0EcKuEvhKIjlmLMkiQfxGRurYoUvb+XAfOqaLqJr5xEZPXxdP4Z82IWcMPq2r/W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcZW2YXGRuNKu+qA1aKeFAVnPcrRB5W9vKtpvaCyjwBJNSjvQn
	s7naZC77NtDz65g5Mcq8YkAxDDp970eVQd1A3KngIfudU0JkzukbvsEHFVC3Cw6osd8=
X-Gm-Gg: AeBDies9Dkrype4Sg7A81Ac/55wlslPwda+aArpvc7+Y7d2n7WgG35WfLc/jdHrka4/
	9x0AT+AOuH/gezic0tvBqr4lB9qmo/LW1pEBrdOArZW2kLXC6dMAIaFtY6QMmEc6pDu5KJiskTA
	a7ZA41wSYg88tqT1pHsksYn7LB3WHfY7wd062OmlK1ayoEvBfag5XE94neR7dfBPN0x4gTBCimd
	FCTmrGUmtWgajn4wPfiXbUvTe3mFlL/XvanjMm6r+RWYcY3/XBJohQWrFnFSwSov7qk3LEUXGo7
	eqsK7oOE5hwmSOdNp0tDm3NB55fWnaOjqo1uqVqk24nhq8xx/reeuTD1xHpcwXSLUMO2DtAO/19
	uLUu1fMhdW8s/tYFw1FOuQCgLWIi86Nfm9Pn7sxsxkdQ2GzwFtXd/ZSvfyJsu4YQCyJnIL124SA
	NW1b3Zjk1Rx1LmqBsjQoifV/c2bdzXbJahxqMnr4eb9mVM+IzmYVamqdNryshIssDWSr6icAXhK
	znh5SCv07hBvhUrALn48Ty8VNdq0Xxjnz6F+qDJUkgRaPodcHSMHxFuJ9KqgqfXHmNKPqgl7L4p
	eu2kR59xb5nHqiXdWXpGgOzTP4w=
X-Received: by 2002:a05:690c:f:b0:7b3:9175:30a4 with SMTP id 00721157ae682-7bdf5dd1267mr5498957b3.15.1778007705593;
        Tue, 05 May 2026 12:01:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6655d954sm68002517b3.18.2026.05.05.12.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 12:01:45 -0700 (PDT)
Date: Tue, 5 May 2026 15:01:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Derrick Stolee <stolee@gmail.com>
Cc: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, christian.couder@gmail.com, gitster@pobox.com,
	johannes.schindelin@gmx.de, johncai86@gmail.com,
	karthik.188@gmail.com, kristofferhaugsbakk@fastmail.com,
	newren@gmail.com, peff@peff.net, ps@pks.im
Subject: Re: [PATCH v2 00/10] pack-objects: integrate --path-walk and some
 --filter options
Message-ID: <afo+mEITFBSLevqV@nand.local>
References: <pull.2101.git.1777731354.gitgitgadget@gmail.com>
 <pull.2101.v2.git.1777926079.gitgitgadget@gmail.com>
 <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f5d8d4aa-2453-45ef-bc96-2b94bdf55c7e@gmail.com>

On Tue, May 05, 2026 at 12:18:28PM -0400, Derrick Stolee wrote:
> One thing I discovered when testing Taylor's series is that this series
> introduces new test failures when run with GIT_TEST_PACK_PATH_WALK=1.
> It's probably due to new cases that are fragile to the difference
> between delta compression algorithms, but are now exposed after the
> filters are no longer disabling --path-walk even with that test var.
>
> I'll make sure these are fixed in the next version.

Thanks for looking into it.

It looks like this bisects (at least in t5310) to "path-walk: support
blobless filter", which is 03/10 in this series. I suspect that there
are other failures that are indeed due to delta selection sensitivity as
you note, but in this case it looks like we are actually not sending the
right set of objects:

    + git clone --no-local --bare --filter=blob:none . partial-clone.git
    Cloning into bare repository 'partial-clone.git'...
    [...]
    fatal: bad object 782f60206c837dcd3d441e106549ad6f58de55b5
    fatal: remote did not send all necessary objects
    error: last command exited with $?=128
    not ok 26 - partial clone from bitmapped repository

I think this is a consequence of us not sending directly-referenced
blobs with `--filter=blob:none` when running the filters through
`--path-walk`. Something like:

--- 8< ---
diff --git a/path-walk.c b/path-walk.c
index a4dd197c37e..dbad01287e2 100644
--- a/path-walk.c
+++ b/path-walk.c
@@ -159,8 +159,8 @@ static int add_tree_entries(struct path_walk_context *ctx,
 		if (S_ISGITLINK(entry.mode))
 			continue;

-		/* If the caller doesn't want blobs, then don't bother. */
-		if (!ctx->info->blobs && type == OBJ_BLOB)
+		if ((!ctx->info->blobs || ctx->info->prune_tree_blobs) &&
+		    type == OBJ_BLOB)
 			continue;

 		if (type == OBJ_TREE) {
@@ -495,7 +495,7 @@ static int prepare_filters(struct path_walk_info *info,

 	case LOFC_BLOB_NONE:
 		if (info) {
-			info->blobs = 0;
+			info->prune_tree_blobs = 1;
 			list_objects_filter_release(options);
 		}
 		return 1;
--- >8 ---

fixes t5310 for me. I haven't looked into any of the other failures yet
since you mentioned that you're looking into them, but let me know if
you want to tag-team any of these.

(As a related side-note, I noticed that GIT_TEST_PACK_PATH_WALK=1 is not
currently in the TEST-vars CI build.  I'm not sure if there are
historical reasons for leaving it out, but if not I think it would be
worthwhile to add it.)

Thanks,
Taylor
