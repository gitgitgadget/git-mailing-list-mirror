Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93C38C427
	for <git@vger.kernel.org>; Tue,  7 Apr 2026 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775603508; cv=none; b=oDFOTTiH9SJNF0xI6Un1dl4tjxWDIlGJjLSpM7B3u220ooi3L/ixoe0xMFQCUzsMhNpQFqB4uGeOms1nkQ/9XH43SvjFa+5p0c8PEvQo5jDCgIjMsKFP0UGxHQCp57OaZN0Ib5CIWHGuGII0i+zRyrbJ5OpekAjDAVvi4sthnmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775603508; c=relaxed/simple;
	bh=qP4zOyKTyYbX1zuIa8X1buIfiAvFcXcZRVY0gHVyg/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbXjKg1VM+/gs12iJmR9p096JZYCOxKgAYwFgOL9gxEct42UcRRhCiVuzuiOyG7W2YIRM7ucGIIpPwMJt7/XyvL1mWltKmLHoOHc0qEyZflAPtJdxX3C6kp1GaNHaEXtG9olXv2DV4XSH55o6Rt3lvIvaBX396sv+uf3P8RupU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaeYy7WV; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaeYy7WV"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-488aa77a06eso44929465e9.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2026 16:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775603505; x=1776208305; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iHSrn70IsNuMF2U2pEmwW9jMOPJnRoby7hS7nRHHBG0=;
        b=BaeYy7WVGgq9uJ4zX3WVUc54qpP7wtlfrZbzhh9w+yDB3lkTOKWXuveBKxptneUuhF
         X2COTuAseB0JS+2lAkSigRi7cGn6beFOb6gZ8XWb4vCN7FhCPeTBEUvPP8tDg1S3mfu5
         kNGL7mT13vFvd+uchgAUsv+ifRhd+8F3d3+8WpoaqqrT13bKX/9aMEMucqB0dC4YeYgo
         GsyfDwzrMYrUV95pei5dr4N4/k7mVFj7uBkLAkHSdJjs0NGxrbFPyM0pVTsG7PGiv91G
         Pgt9VX8dSWuHzFYzIBf+8PQwPNKzW4UsSGWhqo+edhRHpIt0v8mxwOnElajVggt1mCAJ
         wfzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775603505; x=1776208305;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iHSrn70IsNuMF2U2pEmwW9jMOPJnRoby7hS7nRHHBG0=;
        b=TbINObISktyprSmkSqKPLGJavj2BTpX9FiZ9QeLEyqVfaSVzbzyQpjYE+S+C99VXqL
         nfgIVpanGwnAFKQ1Hzm/tkx5oRJfs7LInfrM7IAIUNDAM5ziKHsUUM5BF9x4/sc0D4cf
         9O1oFc3QShqP6k4hSE8YTiNGBinO5byZOrnr/1DJTMOub9I8amYxmduQZxTNpA4Yjpnh
         fGbp+LrH9/I8p/IjL8aXO9oPePrnWJ4p8+ayW9roPsaH6qx54kVbgNlW+ykodfUlc85X
         Rq/OUnvO7zAXtmirQLKgjBShfn/Yl28D2JRGEr/MibNknb5UWsjXXp3SyrkFYSS4W9XF
         O+FA==
X-Gm-Message-State: AOJu0YzfGWkIAJXo555/jTgflBMJZDBBvPL3RjooT3S/5zYuwQtLkYZl
	r3Y709akggINWR2XlxEQFF3vhEvyWhhBg313ebwhYTTSSUgCXcjwjfTD
X-Gm-Gg: AeBDietjf+7nrRx3XmAS/w+YvaBV7ICVI4CZT+GGqz7SMPTXDP4KddUfnYPyVbkmcQu
	wr2WmsmlBfZA65nBUTBvn3avPYoFhwq6o4n6FLLfQlZ9JjZLuNISzsZxCxQBiH9xErIN0Ryt6g4
	RlOG6vBAhm9eiHH0unu9RuwHj3dWBD5fYs155/U69IHI3f9IjQ0gsxB/AUswnlHmKQIfM/QyWd/
	KitlCOtZiDbYMF2JnfcnL+UZYJPEjjN631tmHlRZTPZMsVCDZHA+BRL0l0RUqdjkMjqST2ABxyf
	zvQFL63bc5BOr/Y+sfcxOGeXh7JlmWqqcmdcA9bA2fC3/besHmkfv4H+e6M7nXL/Xbosk4yFALo
	3et+NWqm8X0KowGBpMB0I5DNzt7IOjNi3y/ZYxOGCjlBzVuYDlBDC9TvHhWXatJ/CI71SSVPCjG
	tgkg6LZvSfsf6BbL6sSnMyOdzhvLeEjE+B
X-Received: by 2002:a05:600c:64cd:b0:487:1520:d107 with SMTP id 5b1f17b1804b1-488998f8b3dmr234158745e9.31.1775603505159;
        Tue, 07 Apr 2026 16:11:45 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e952b0bsm574279555e9.12.2026.04.07.16.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 16:11:44 -0700 (PDT)
Date: Wed, 8 Apr 2026 01:11:42 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [GSoC PATCH v3 4/5] t7700: test for promisor file content after
 repack
Message-ID: <adWPLhGeo-4Mqfbh@lorenzo-VM>
References: <cover.1774205661.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <8e58c1263d15fb8dba8ce1d2866d369e938bf2b6.1775431990.git.lorenzo.pegorari2002@gmail.com>
 <xmqqwlyi4p6t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwlyi4p6t.fsf@gitster.g>

On Tue, Apr 07, 2026 at 11:10:02AM -0700, Junio C Hamano wrote:
> LorenzoPegorari <lorenzo.pegorari2002@gmail.com> writes:
> 
> > Add tests that checks if the content of ".promisor" files are correctly
> > copied inside the ".promisor" files created by a repack.
> >
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> >  t/t7700-repack.sh | 63 +++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 63 insertions(+)
> >
> > diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
> > index 63ef63fc50..89a2116641 100755
> > --- a/t/t7700-repack.sh
> > +++ b/t/t7700-repack.sh
> > @@ -904,4 +904,67 @@ test_expect_success 'pending objects are repacked appropriately' '
> >  	)
> >  '
> >  
> > +test_expect_success 'check one .promisor file content after repack' '
> > +	test_when_finished rm -rf prom_test &&
> > +	git init prom_test &&
> > +	path=prom_test/.git/objects/pack &&
> > +
> > +	(
> > +		test_commit_bulk -C prom_test --start=1 1 &&
> > +		
> > +		# Simulate .promisor file by creating it manually
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		oid=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid ref" >$prom &&
> > +
> > +		# Save the current .promisor content, repack, and check if correct
> > +		prom_before_repack=$(cat $prom) &&
> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		# $prom should contain "$prom_before_repack <date>"
> > +		test_grep "$prom_before_repack " $prom &&
> > +
> > +		# Save the current .promisor content, repack, and check if correct
> > +		cat $prom >prom_before_repack &&
> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		# $prom should be exactly the same as prom_before_repack
> > +		test_cmp prom_before_repack $prom
> > +	)
> > +'
> > +
> > +test_expect_success 'check multiple .promisor file content after repack' '
> > +...
> > +
> > +		# Repack, and check if correct compared to previous saved .promisor content
> > +		git -C prom_test repack -a -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> > +		# $prom should contain "$prom_before_repack1 <date>" & "$prom_before_repack2 <date>"
> > +		test_grep "$prom_before_repack1 " $prom &&
> > +		test_grep "$prom_before_repack2 " $prom &&
> 
> This test seems to be flakey.
> 
>   https://github.com/git/git/actions/runs/24095497271/job/70292906676#step:10:5274
> 
> shows that $prom gets two file names, and because test_grep is
> expecting a single source to grep inside, the first test_grep
> fails.

Uff yeah, I see.

I also saw your other mail regarding the "SQUASH???" commit you made
(inside the `seen` branch). I'm not so sure if it is useful to solve
this issue tho.

It looks like, for some reason, `repack -a` fails to repack everything
into a single pack, but I believe that `repack -a -f` should force it to
repack everything no matter what (I think??).
