Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E4D318ED9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 22:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775861692; cv=none; b=Ak/zB3dPPE6QOtOV2mPLXClqtxXD96f/WmWc1baWvLWuVb7uRIWbIhuoMeA8JV88dcrL+zrgp7uFfwO7kzYURn+mlbFJyGLtdWcZQsO/J9ew7iyRqNd/haidDopNukZ/6AqEnvYRwpY/7RXilt5C+tJmFXga/RY6po5KfblhnGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775861692; c=relaxed/simple;
	bh=3r8/TDgzQbmi8TrBwJ0ewmfDsgFXfuaIyI7NPEAoAtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7KGcoJmhPRCoiHvtvOkx3CHOQhPuTC88fduETAG2tFcgCt3ZHU0+90p6ghPfssabjex5kYPqRk6dPNxCU8ZMvZ0wAwLvh2Qtvg/stsOxFzL8TbOP4BUxKYqt3a5dQ2xarQxaW12cyq9Ll5aursda6fbH6KRvPJgjqTCCtSFS2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l0OmcHEZ; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l0OmcHEZ"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43cfe71e5d3so1697272f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 15:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775861688; x=1776466488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2fC88HRgwiPutd5gykOgHGOJ7/tyvFaKSrONZATEnA=;
        b=l0OmcHEZPAS6DLJMyZ+a2MmA+prfvPfmE2iW1XaZtVKNegV9oBd+9u9je8ZT60261Z
         lRltLAkTvYIwl6YsOIhn7cARoyC+lLCRLj1efZSBPxqAC4q2g5sZf3FJHKw9d7xOsgMt
         p3ZtTnfs/h3Ndy4yMFPMj1FgKdnllPpN7DBtTizpFDgERBntF0PMLhnegE4dYuDscJKT
         sk3mySV64CaRBjZyaQlWNeWOnODguZcBfEfPs+v7KxKgK1ATmv5RIzjLiyYJql+2b3AC
         Letxr6CovQtRj9TpxWMlLbW9b94l2HGKG/SVRU0RRTpLHUd6eAgT1foE05u8YPGpMFm7
         wt8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775861688; x=1776466488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V2fC88HRgwiPutd5gykOgHGOJ7/tyvFaKSrONZATEnA=;
        b=RlxdLnOhfykdDWXoRTXcfp/L9M0hpLfok8GXrhm72PHz3KVlKT7YQ7XsvZ5Vcszkiu
         hpBT61ffHkaQODSi5JbhnAQauxXJXlK6ofGk2T6P5pwCOECawwxU4WaWT+YmeB0vgx1s
         LVNCwXh2VT2CKR11moF/p4udIXYYJOskv4SCoo3CrXq19Q7Njz+PDSAINW2WrN/x2n6l
         xuMYkQcdkGPH3GPlp9AFZOAyoXT3d7MyvOkmi+KR+FBO2fR9xUx+y+uIIwQoStcxwX/i
         mShwnNNRaq3rBhIEV743NF5tP78+DtPyzX2e5Ycb9nJxI3mDymzCJD9lwr4CW0/DgSYQ
         kEPg==
X-Gm-Message-State: AOJu0YxAX6iD+9vNXeUMrBfnUfuLUQduORJ1k70U3Ed8lfslXG2rgO1A
	SLB7SGivTxqi7QN6UrnI5KfK2TLYifA7khVUKbFpRlp+IQnUURN0af8+7jj3nMOjqws=
X-Gm-Gg: AeBDiesI4vSiRMW5gLmHOcDyZYDiLncStrwkpRLWWVDkRIYU7lDpnP21uL9ey5w59cQ
	dPY39Uh28EeoACdcgbby6qKfaNpkGuGjKR9Uqpa90nF68rJxhkLba88vx8S0CViu3K3t4nFJ09i
	hisWTFFK+Js/Uy6wFmOt4txIG6fYpdGnY4+M3DGC1OQ1hGcDozwJXXMIkskNflTsFlPRXDjuyYj
	oShKolBYwpA9OB/TyIHvPfyV0lzY/h8Q03GuN3XRkNKRG0sUD/iT64BIxwFaWYAx1xxUk8qvnHJ
	O9H0D3NXLML6AwkgzSaA05mDGjMv4aJfpaZHAbAXdurA0/M2NqvpEoJhxJCRJS4Dk05w29E+FIA
	IWEQZcboHnLc7WJVdnjEr3j6xL61V4WTWhKUDRKYp5yQRJz0avbs1fcW5QfEvy1fbb8fyhBojLC
	5Sei9Yk8ah/t2H2kDWx9NpV7YqbjuDSgbM0K6+McALV+k=
X-Received: by 2002:a05:6000:208a:b0:439:dfae:8083 with SMTP id ffacd0b85a97d-43d642b1779mr6819772f8f.38.1775861688110;
        Fri, 10 Apr 2026 15:54:48 -0700 (PDT)
Received: from lorenzo-VM ([84.33.160.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63de2a53sm10510179f8f.5.2026.04.10.15.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 15:54:47 -0700 (PDT)
Date: Sat, 11 Apr 2026 00:54:44 +0200
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	Tian Yuchen <cat@malon.dev>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Elijah Newren <newren@gmail.com>
Subject: [GSoC PATCH v5 0/6] preserve promisor files content after repack
Message-ID: <cover.1775861047.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1775832056.git.lorenzo.pegorari2002@gmail.com>

The goal of this patch is to solve the NEEDSWORK comment added by
5374a290 (fetch-pack: write fetched refs to .promisor, 14/10/2019). This
is done by adding a helper function that takes the content of all
.promisor files in the `repository`, and copies it inside the first
.promisor file created by the repack.

Also, I added a comment explaining what is the purpose of the content of
the .promisor files, since this wasn't explained anywhere (I found
information regarding this only in the message of the previously cited
commit).

Finally, I added some tests to "t7700-repack.sh" and
"t7703-repack-geometric.sh" that check if the content of .promisor files
are correctly copied into the .promisor files created by a repack.


If Eric Sunshine, Tian Yuchen (for the patch 2/5 "pack-write: add helper
to fill promisor file after repack") and Junio Hamano (for all patches)
want to be added with a `<Reviewed-by>` tag, please let me know (and, of
course, thanks a lot for the help)!


V5 DIFF:
 * fixed commit message (from `pack-write:` to `repack-promisor:`).
 * fixed timestamp `fprintf()` format.


LorenzoPegorari (6):
  pack-write: add explanation to promisor file content
  repack-promisor add helper to fill promisor file after repack
  repack-promisor: preserve content of promisor files after repack
  t7700: test for promisor file content after repack
  t7703: test for promisor file content after geometric repack
  repack-promisor: add missing headers

 Documentation/git-repack.adoc |   4 +-
 pack-write.c                  |   9 ++
 repack-promisor.c             | 152 +++++++++++++++++++++++++++++++---
 t/t7700-repack.sh             |  60 ++++++++++++++
 t/t7703-repack-geometric.sh   |  33 ++++++++
 5 files changed, 243 insertions(+), 15 deletions(-)

Range-diff against v4:
1:  b4990fcdf0 = 1:  b4990fcdf0 pack-write: add explanation to promisor file content
2:  34c4e79311 ! 2:  3558bb3895 pack-write: add helper to fill promisor file after repack
    @@ Metadata
     Author: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
     
      ## Commit message ##
    -    pack-write: add helper to fill promisor file after repack
    +    repack-promisor add helper to fill promisor file after repack
     
         A ".promisor" file may contain ref names (and their associated hashes)
         that were fetched at the time the corresponding packfile was downloaded.
    @@ repack-promisor.c: static int write_oid(const struct object_id *oid,
     +
     +			/* If <time> doesn't exist, retrieve it and add it to line */
     +			if (line_sections.nr < 3)
    -+				strbuf_addf(&line, " %lld", (long long int)source_stat.st_mtim.tv_sec);
    ++				strbuf_addf(&line, " %" PRItime, (timestamp_t)source_stat.st_mtime);
     +
     +			/*
     +			 * Add the finalized line to dest_to_write and dest_content if it
3:  72ef2378b9 = 3:  b483be7558 repack-promisor: preserve content of promisor files after repack
4:  0aceaed480 = 4:  f631993c89 t7700: test for promisor file content after repack
5:  d9f6341481 = 5:  ab307e68fe t7703: test for promisor file content after geometric repack
-:  ---------- > 6:  e8720aaf12 repack-promisor: add missing headers
-- 
2.53.0.584.ge8720aaf12

