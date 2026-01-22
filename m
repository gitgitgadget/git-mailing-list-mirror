Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626C02F12AE
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 01:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769045633; cv=none; b=W4O5Q7Fk+VH1BntvShyNNaX2uSBhdbGcWJQmcILuEUo0TIVgwLWopO5AjwullQ1zHejMbqsgSPhHQxYozjMSnOXzWnaSjWO/4fHOsRTQZ61hfIebHk2VKCjv1U2IZ6848PMDh9rcvtg+b6D5iBqvt39TcWeL4XCuGPDrq0hueP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769045633; c=relaxed/simple;
	bh=vdP6zx2l+ObCqg2eL9SM2rx0SIHs80yylHJQN2MgSNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMqr6tzy+Iuki6pFo9V3lFNJr9dMdxvUzmhJ4/x1ARhnjvJHwSM0vRUAqrwR6kZjrhAyPnHVrjuKu4K9/DEWofMtqvgY/62qihqMKAeyH2AnGIziuLtK9uGn0yVU5R1AnHZrfto9e08VTVPKSEjONkmhTgso4+MT0dlLNM2I7dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=HC43yukv; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="HC43yukv"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c66bdf675so4377727b3.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 17:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769045630; x=1769650430; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHkLJlc5aReX/WM/+m0dr98zd91pWjU12cBpJ5tlhug=;
        b=HC43yukvlD8yEgVsbOzICbJufqEYBTV8Z4qOGeaabb/m9n4Fb+ddlW6UMWQ8J7d0zK
         UWFvd/8qT1EuLbF3Gh/qLwfqZQabfDkjMc5AqKjKsDmHvrf6VLrbFxK6pM3xT/4uhR+G
         86TAMdG5aOU4BeneM8losKlH1r7LGfx2v/jIj7e1OeMa0lAu/MP1CjADWIWCnbSys+1E
         S+4Vt5k7pcEJySvo4UI2HBudRsflBWoPJTxuyF7ZJaIJKIJf13lzkvt04DNwBmqMQH99
         8YUxvJ+IESwOqdulqJBvbgSm4TQO41L3eBlQvb5mHJEnDtAsb1COIl6nO+k/8ATNM1YM
         pdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769045630; x=1769650430;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHkLJlc5aReX/WM/+m0dr98zd91pWjU12cBpJ5tlhug=;
        b=ZN5WlDjeyE3+MSmHKyUlg7kk+IFICXDFey9AgoJGVMvFm4opUoqg5QJVMjecnwL37h
         ZOZARLi264ceTSvVWy3aAKJa6OaSM4gGUkOWc6dxLZjNPqZLptCFbIumXDCxeSxilBuC
         khBwD4ncBSlY3gtkSzB1I07URz54Nw9SnxXtMCe2TU1HIhun2BkffRFZo5439qbNKvc2
         nz9dyF3Az6ZJepgVkDWGdXlZUyzJQsMRjx4TpMUqm6AXWUsmgNLXwFHxiX770kt+54CG
         E4XNnPtxNi2l4H3JmmwFFJ26kNapnOjRO73YEoPsf5xvGTLP9b+Kjss/D/txHCcwJ78o
         8+tg==
X-Gm-Message-State: AOJu0YxgNl35Oooc8VcJAmruI+oPHXsbB7PWBc20/2GxwqRW8CSFIOdF
	+zpMe61GbxfXa0kDzNoaKfR2sS3//6CGmW9UBBRme708YFPsDs+RPiF96cQlWG+C6Pw=
X-Gm-Gg: AZuq6aKrmkTA5wLom1uc86D6jh1Rwgs3vwslulZ69HH9sh5rH2RUXN0YlmgnmLgC2Cy
	OvAZfOPP+or+P4RWBQVLIZHHF2zQvUU5VBo7cPOD3yIymdotUwzl9tCVyM5adBtmjM7pIUNlmh4
	TTpjPvlxwv1MnmsrzBgbKyLtGDXgEgn1ayhuyOKREz3nWvFD27PeNyD9DhxpbU12yhVn9RGFX0+
	H7A186nsO8Mp05wN81rNLVegWlLaEffYkOGk72Ad+rj9GFPl3b3L8uRDzHLkFBhE6V1nDDDnjv6
	eDXiZk3On8ogC+6vLpQgUHH2ny0mtXt9zV9fqE7i59fHIGjb3avDjQjB99T0Hq/Q/oSd1ZkhrCA
	EYVwgaqBCilGhKpsfkDBlgl43ENV5C50vOU8mZlk+eKw4GWN5UYX8nYAbInBEsrM064HgEDgHJa
	m2fHrfDQ6UugIfWC9ZwtQuJ7YY3va6h9RVns5GKQWypMDjN3LuubwlOa/G1WD9hCUc/fWI+fd+g
	Mo1obLuHsDoF84MTg==
X-Received: by 2002:a05:690c:c4fa:b0:793:bc20:23e1 with SMTP id 00721157ae682-7940a113ccbmr64472517b3.11.1769045630306;
        Wed, 21 Jan 2026 17:33:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c68c31dfsm72984307b3.51.2026.01.21.17.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 17:33:49 -0800 (PST)
Date: Wed, 21 Jan 2026 20:33:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] odb: introduce `odb_for_each_object()`
Message-ID: <aXF+fMQKry71Gh0w@nand.local>
References: <20260115-pks-odb-for-each-object-v1-0-5418a91d5d99@pks.im>
 <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>

On Wed, Jan 21, 2026 at 01:50:16PM +0100, Patrick Steinhardt wrote:
> The patch series is built on top of 8745eae506 (The 17th batch,
> 2026-01-11) with the following two series merged into it:
>
>   - ps/read-object-info-improvements at a282a8f163 (packfile: move MIDX
>     into packfile store, 2026-01-09).
>
>   - ps/packfile-store-in-odb-source at 12d3b58b55 (packfile: drop
>     repository parameter from `packed_object_info()`, 2026-01-12) .

I was having a little bit of trouble constructing a base to apply these
patches. a282a8f163 merges cleanly into 8745eae506, but 12d3b58b55 does
not merge cleanly into that, nor do they apply as a single octopus
merge.

Looking at the base-commit identified below from your fork[1], there is
some conflict resolution required to merge in the latter series. I'm
including the --remerge-diff results below in case others are interested
in applying this locally.

--- 8< ---
diff --git a/packfile.c b/packfile.c
remerge CONFLICT (content): Merge conflict in packfile.c
index 4cc9d8c07e6..402c3b5dc73 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2164,16 +2164,8 @@ int packfile_store_read_object_info(struct packfile_store *store,
 	if (!oi)
 		return 0;

-<<<<<<< b7f649ca936 (Merge remote-tracking branch 'junio/ps/read-object-info-improvements' into HEAD)
 	ret = packed_object_info(e.p, e.offset, oi);
 	if (ret < 0) {
-||||||| merged common ancestors
-	rtype = packed_object_info(store->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
-=======
-	rtype = packed_object_info(store->source->odb->repo, e.p, e.offset, oi);
-	if (rtype < 0) {
->>>>>>> a282a8f163f (packfile: move MIDX into packfile store)
 		mark_bad_packed_object(e.p, oid);
 		return -1;
 	}
@@ -2574,17 +2566,9 @@ int packfile_store_read_object_stream(struct odb_read_stream **out,
 	oi.sizep = &size;

 	if (packfile_store_read_object_info(store, oid, &oi, 0) ||
-<<<<<<< b7f649ca936 (Merge remote-tracking branch 'junio/ps/read-object-info-improvements' into HEAD)
 	    oi.u.packed.type == PACKED_OBJECT_TYPE_REF_DELTA ||
 	    oi.u.packed.type == PACKED_OBJECT_TYPE_OFS_DELTA ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
-||||||| merged common ancestors
-	    oi.u.packed.is_delta ||
-	    repo_settings_get_big_file_threshold(store->odb->repo) >= size)
-=======
-	    oi.u.packed.is_delta ||
 	    repo_settings_get_big_file_threshold(store->source->odb->repo) >= size)
->>>>>>> a282a8f163f (packfile: move MIDX into packfile store)
 		return -1;

 	in_pack_type = unpack_object_header(oi.u.packed.pack,
--- >8 ---

Thanks,
Taylor

[1]: https://gitlab.com/pks-gitlab/git.git/
