Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495DB54654
	for <git@vger.kernel.org>; Fri, 17 Apr 2026 00:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776386798; cv=none; b=mjV4EXmuNQDVD9bvLrDxEG1ORngYci5+KCz16lTp6IdjdhbZh+qSV/6xZYXxVsgGQEeaUNWhF97IbBL2y7PtOVp3pOIr9HrAhVIdpOZ72YXLpzgVJ2dwcOtZeDVkWxfMFi0WClTIYd8PTcWISDao52PbCs3tuCAp7Oi2VcHF9gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776386798; c=relaxed/simple;
	bh=M8kYqZnO8Zq3BbcQ419AK5V9r91Dx87Jwj9MkaGi/2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fahjCPXk2hiAL22hGGmUm+O99deoMez3lEUmUfuoaoO9exgQ1UlKizVyQkiodXWTRIbmWAnb8x6NbQRyXYOyw2qITRpshUZtKGRH499Prf/uNcAnNr73n+8k55YjAY0ApFhkz9FtDkTXHj4rHtrTA1t6bbic37+UaOtnFUU+vZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmZpLeA5; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmZpLeA5"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-482f454be5bso12090885e9.0
        for <git@vger.kernel.org>; Thu, 16 Apr 2026 17:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776386796; x=1776991596; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L2wJ3aKbPkmfIRXvzciE4eReqplTrcwgy/lsSji9Ix4=;
        b=JmZpLeA5myvjeWhjAN0JRnp6n81flB4ySVSwFRtbCmnrgh1dD3Yd0NcF+bbsAca343
         ZzEihkof9GpNNoKUOM2ibg7jhZ850WARhPx8mgos4t6BBf/VUPwFY0MaXQKdFOZcHgQh
         VMGEyncFr+ZY+0PrKzgi4r2MnGIn1slxoo3dnWk9MLWPqcFbveYY24bEb/RS51/yLxOQ
         dv6ZRdrs7vSYrzltyP0lRGapYsk6xWRILCWogGLChm//0fTm8dX7CDTGU+Ck8F7VQDXx
         3SU2XqVD4DpUsGyxbX8X7SnH2bnHdTUNKRtQpm8lYx0k51LxHWlqt5wAqY8j0JAGwo0l
         wxdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776386796; x=1776991596;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L2wJ3aKbPkmfIRXvzciE4eReqplTrcwgy/lsSji9Ix4=;
        b=cw7S2sTZebLkBpfl3CAuDgX+xCSl/bIqdSKsASWnao5yHq/6WxNfIeM6Fp0I5HNESk
         r26H8vwkVfJnglZ/aj3CogYsbzLwyKg09jpQcfaapU6AlIbc3LbZhH+tR2LqIluF0eHL
         hi28aMvhHQKUCyqGVdzfZIXrvtpcjlHJ/GPln8UMJsK7/OZvMTb4jUdUREamDPe44XL1
         vflLxhKYol47N6BxEQDv7Tvj5tgkQW93ddMaUnN7nwoMEqDLhqu2NgfSbNscU+IQp/OU
         Vho6vOldVKNoanaceAh4ekmC5AIKe6BCcsN8hnhGrUeGbrQm/JzN3dePZQq7Rd2Bk9zH
         y1qg==
X-Gm-Message-State: AOJu0Yx/QNGIi8kvfM5rtHrgufWJCCpcyiwUB3m33BjkvOmRh8myphlA
	4ldvFNguuC6cGz5YkW+x9ttR6s9Chgdb6TYO6bRmtSVPscYKWiPULs4m
X-Gm-Gg: AeBDieswYcrVxvHDOI+dGhcj1wkXSPBg/HF9HcQWCtDKFk25+bY4a+aHVP9YYN2GecJ
	/ZBR0xEuoektNy2n8O84yWKxbSd4yXaZmX+k9eGMUF7UmrVBDJMmImjR+4X4xsu7/k9Hcz48M8l
	oB+A0seMLAemo3/AJUo+gIbPqmvFoHzgCp+4Asyho8/MK2Ra9aISNUbXyMElTW4bZ1snon/ChHI
	lesa3n23S8ARYkyQLjDm0FYj+yN69Gld0bOa4XVVl19j+/fNj8xD3qidnMEZ+N0GKnFh2ISn3UF
	pyGmEPcxeJIFEI7v9sAYWcMPY6bvCCYwrE+Yj3+PDC9w1+LEi2Jp26aAxq0aMk65VHNuEdAuwkI
	urV7yzq1OryeMB3w50Zdy7sQ+K1vLF/dHRoKoeztJsMbOxkaAtrAnehHX7bt4dXZxcMb69wEsvs
	b4BUd0hYDBAwYFeTp7/RhQFu7qaQLjLmMXvxSIZm3ZDshcpPNL+afy/srDdAFBUTKJ0YmEZg+55
	eWJ9pvxBtUnGlwEMjgCmPLHnYbYLQ==
X-Received: by 2002:a05:600c:3ba0:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-488fb8b91a7mr6571505e9.12.1776386795590;
        Thu, 16 Apr 2026 17:46:35 -0700 (PDT)
Received: from lorenzo-VM (host-79-19-37-238.retail.telecomitalia.it. [79.19.37.238])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc1c773fsm1461575e9.12.2026.04.16.17.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 17:46:34 -0700 (PDT)
Date: Fri, 17 Apr 2026 02:46:32 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC PATCH v5 5/6] t7703: test for promisor file content after
 geometric repack
Message-ID: <aeGC6Mm3BdjAOGQe@lorenzo-VM>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
 <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <ab307e68feb9f84898dba748ef1f4598b07fc0e2.1775861047.git.lorenzo.pegorari2002@gmail.com>
 <a20d7433-2297-4ad9-a68e-302443f1f941@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a20d7433-2297-4ad9-a68e-302443f1f941@malon.dev>

On Sun, Apr 12, 2026 at 02:49:05AM +0800, Tian Yuchen wrote:
> On 4/11/26 06:56, LorenzoPegorari wrote:
> > Add test that checks if the content of ".promisor" files are correctly
> > copied inside the ".promisor" files created by a geometric repack.
> > 
> > Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
> > ---
> >   t/t7703-repack-geometric.sh | 33 +++++++++++++++++++++++++++++++++
> >   1 file changed, 33 insertions(+)
> > 
> > diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
> > index 04d5d8fc33..a8e3e6ae3f 100755
> > --- a/t/t7703-repack-geometric.sh
> > +++ b/t/t7703-repack-geometric.sh
> > @@ -541,4 +541,37 @@ test_expect_success 'geometric repack works with promisor packs' '
> >   	)
> >   '
> > +test_expect_success 'check .promisor file content after geometric repack' '
> > +	test_when_finished rm -rf prom_test &&
> > +	git init prom_test &&
> > +	path=prom_test/.git/objects/pack &&
> > +
> > +	(
> > +		# Create 2 packs with 3 objs each, and manually create .promisor files
> > +		test_commit_bulk -C prom_test --start=1 1 &&  # 3 objects
> 
> ---
> 
> > +		prom1=$(ls $path/*.pack | sed "s/\.pack/.promisor/") &&
> 
> This approach seems a bit fragile.
> 
> - Perhaps you’ve heard the saying which goes like "never parse the output of
> ls". In a nutshell, the output of this command is not standardised;

Didn't know that. I'm learning a lot! :)

I will rewrite this using `find`.

> - *.pack? This may produce multiple lines of output, which I don’t think is
> what we want.

`test_commit_bulk` specifically creates a single pack. With "*.pack" we
might get multiple lines of output, but only if we first created
multiple packs.

I think doing something like this makes sense:

```
[...]
path=prom_test/.git/objects/pack &&
# Create first pack
test_commit_bulk -C prom_test 1 &&
# Get first pack name, and then get its ".promisor" filename
prom1=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/") &&
[...]
# Create second pack
test_commit_bulk -C prom_test 1 &&
# Get all packs names, then get their ".promisor" filenames, and finally
# remove the filename that we got before, to obtain the new filename
prom2=$(find $path -name "*.pack" | sed "s/.pack$/.promisor/; \|$prom1|d") &&
[...]
```

> - $path instead of "$path", which cannot correctly handle spacing in
> directory names;

Ack.

> - sed s command matches the "first" string it meets. We can’t guarantee that
> the '.pack' part won’t appear in users’ path names, can we?
>
> (Fun fact: There are approximately 8,000 people in the United States with
> the surname 'Pack'. Source: 2010 Census ; - )

True. I will use `sed "s/.pack$/.promisor/"`, which will only look for
".pack" substrings that appear at the end of the string.
> 
> > +		oid1=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid1 ref1" >"$prom1" &&
> > +		test_commit_bulk -C prom_test --start=2 1 &&  # 3 objects
> > +		prom2=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d") &&
> > +		oid2=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid2 ref2" >"$prom2" &&
> > +
> > +		# Create 1 pack with 12 objs, and manually create .promisor file
> > +		test_commit_bulk -C prom_test --start=3 4 &&  # 12 objects
> > +		prom3=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom1|d; \|$prom2|d") &&
> > +		oid3=$(git -C prom_test rev-parse HEAD) &&
> > +		echo "$oid3 ref3" >"$prom3" &&
> > +
> > +		# Geometric repack, and check if correct
> > +		git -C prom_test repack --geometric 2 -d &&
> > +		prom=$(ls $path/*.pack | sed "s/\.pack/.promisor/; \|$prom3|d") &&
> > +		# $prom should have repacked only the first 2 small packs, so it should only
> > +		# contain the following: "$oid1 ref1 <time>" & "$oid2 ref2 <time>"
> > +		test_grep "$oid1 ref1 " "$prom" &&
> > +		test_grep "$oid2 ref2 " "$prom" &&
> > +		test_grep ! "$oid3 ref3" "$prom"
> > +	)
> > +'
> > +
> >   test_done
> 
> Thanks, yuchen

Thanks,
Lorenzo
