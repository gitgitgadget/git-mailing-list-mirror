Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02F192B94
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 23:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734565774; cv=none; b=jm9FMU48yP1BkrnMhz2VSW6hBehqGKBC7ny1DPHzujbY33cPpfOn48EVD1HVOATk7ymWPczmg+cN2L/IDH1fphr2ZThs4f/Z7Ned1njZ2kct+0j4D8u2eYJy543W4o7Cy87ab6LhuqjXPDaDVqpQnYEIUxVNAqi4witWoqVIe0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734565774; c=relaxed/simple;
	bh=caKyPuy8ArN2gPyamZPm4/eds6wl1CzEhhwNh5nARe8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ4IcinLO+m0FGj4iFA7WT5ADfftC3SZbOrsNUhc3heG7IPxAhq8Awo8F/rLmi/4+d5TDXTXBqrAQ/DURTD7r2fE/KPVmXK1e3MzSguu+i+mHyk5ykOW/FfIQJxZ2Cswl5fsr2dAVdETRbtLxAOD+PCrv+EFf0KkwQSUmTbVTtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=LMrBkEuF; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="LMrBkEuF"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e3fd6cd9ef7so1179259276.1
        for <git@vger.kernel.org>; Wed, 18 Dec 2024 15:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1734565771; x=1735170571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=stkv5VqZxSJYyLrOUusvcIhDOZAOfjKi8aE/TuoRcH0=;
        b=LMrBkEuFRwDfKTx2X5dLrKgniPp4U9KOzmPyGAUEQRBS2dcO9JOki7JG1YQQiE9XAb
         2+vDlO2AZteAmZ6V5NxyDNw2NkP5G25rTy/b4FYbhbs2DASeulNnlZ72gBm+0S8ArsIJ
         7LrejGF8MtE/sJMPxtow7u6mSOxQvBXCv5w15yWbiMVSe0OKE4yrQNiqohr9WlGpYLFV
         uNjPkFFb1CYANYKyzbxmgAguhgbkH+5bHlX4tsFCn9pek1Imr7jKNO2W3Oib3dToG+SL
         5vV3UcXsj6Q71+w4Ik0qKYOkvogw0gKIrEmz+Nc3G0B1iofQp3+fy+wBVw0BCwl+5eCY
         xQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734565771; x=1735170571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=stkv5VqZxSJYyLrOUusvcIhDOZAOfjKi8aE/TuoRcH0=;
        b=foXV94wU802qYDIueJMivslNBSwvmL96eLntuDb7+9AIi9TTLDADAgWMBCy2iBWbhu
         hft4t+h+prm94nDPhkmoa8BW8pOeCzWh7xNG0duZuaNrGI+UJMXCVf7NXLguSJzFRAq0
         DANBNFuhaLsXUVpvgF5PBiE90kHpCgCbY7bTkDxrMykfFuudZDiUQnamRkJwZky+GwAt
         MZQrCuzNLwKGCjlx5x8WJmeRdsgkVoOwATcu3+kH/i1w0qHUb9+PNbzFClKSxFurqcGJ
         sjlLFUQto1JugEve677ina8UGBPnlW4F9Wvfc8hFgavFGmxRnOIOFul8jE4cJnauAV4P
         oVkQ==
X-Gm-Message-State: AOJu0Yzn5AW2gKv8H9hvFFX/Ms6LnQ0UAOkjBDWdkLBzaLPMN4/Cq6ky
	w0C0xZM1gdSvRMmYHMnzXmn+VIzODUMGh8lq45a1iJL+XVxGsmTollS7jwFWeps=
X-Gm-Gg: ASbGncs74rKfymA8FlaeJ3mbadmcmxZhwuhnIodkT7HLaIN/j7YLR73gZTXJh2+A6LF
	uZ69z0QXe0jPL6bXmZTalvyHcE4cIKrGPBHhaEtIsg5bATrvSPb2jnwhzWpPclhYsO5BeXF/lNW
	XrSPNh0qlBE4XrX4paDgiTKz9WHZytcFygO9C8yI9CaLd/orHbDkDb/+0fpRNa52F3+0LQAyIf5
	Ozqt1h8XRsQ5knVm4zbM4TQwsa2onF3sa+JB7deJt+m+tT41Z8hzdQwCXNHiNflWnW488qnZNsJ
	TJB3FURzQI0XKrVPIuIkX2Y+0p1U
X-Google-Smtp-Source: AGHT+IERbs69+bdR+hBLs/bkdW6o3b8wxj6dS9/xRIXL5Bd8jD/czlwycrd3PokLMFFuLgPbgmxdZA==
X-Received: by 2002:a05:690c:6892:b0:6ea:6666:c0c2 with SMTP id 00721157ae682-6f3e2a656camr15114437b3.4.1734565771529;
        Wed, 18 Dec 2024 15:49:31 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6f3e7444b68sm248847b3.39.2024.12.18.15.49.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 15:49:30 -0800 (PST)
Date: Wed, 18 Dec 2024 18:49:24 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
Message-ID: <Z2NfhDOJOOUdK2Xk@nand.local>
References: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
 <xmqqa5cspym9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5cspym9.fsf@gitster.g>

On Wed, Dec 18, 2024 at 11:41:50AM -0800, Junio C Hamano wrote:
> Both are from you, and I am guessing that you have tried all of your
> topics in flight together, if not the other topics.

Oops, sorry for the trouble. I believe the correct resolution is the
following:

--- 8< ---
diff --cc pack-bitmap.c
index ff09b15eb7,83696d834f..0000000000
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@@ -388,9 -427,17 +427,16 @@@ static int open_midx_bitmap_1(struct bi
  {
  	struct stat st;
  	char *bitmap_name = midx_bitmap_filename(midx);
- 	int fd = git_open(bitmap_name);
+ 	int fd;
 -	uint32_t i, preferred_pack;
 -	struct packed_git *preferred;
 +	uint32_t i;

+ 	fd = git_open(bitmap_name);
+ 	if (fd < 0 && errno == ENOENT) {
+ 		FREE_AND_NULL(bitmap_name);
+ 		bitmap_name = midx_bitmap_filename(midx);
+ 		fd = git_open(bitmap_name);
+ 	}
+
  	if (fd < 0) {
  		if (errno != ENOENT)
  			warning_errno("cannot open '%s'", bitmap_name);
@@@ -444,6 -491,25 +490,13 @@@
  		}
  	}

 -	if (midx_preferred_pack(bitmap_git->midx, &preferred_pack) < 0) {
 -		warning(_("could not determine MIDX preferred pack"));
 -		goto cleanup;
 -	}
 -
 -	preferred = nth_midxed_pack(bitmap_git->midx, preferred_pack);
 -	if (!is_pack_valid(preferred)) {
 -		warning(_("preferred pack (%s) is invalid"),
 -			preferred->pack_name);
 -		goto cleanup;
 -	}
 -
+ 	if (midx->base_midx) {
+ 		bitmap_git->base = prepare_midx_bitmap_git(midx->base_midx);
+ 		bitmap_git->base_nr = bitmap_git->base->base_nr + 1;
+ 	} else {
+ 		bitmap_git->base_nr = 1;
+ 	}
+
  	return 0;

  cleanup:
--- >8 ---

IOW, we no longer need to check the validity of the preferred pack in
either case. But in an incremental MIDX bitmaps world, we do need to
keep calling prepare_midx_bitmap_git() along the MIDX's ->base pointer,
if non-NULL.

> I wonder what we can do better to make sure the work a contributor has
> already done (in this case, resolve interaction between two topics) is
> not wasted and recreated (possibly incorrectly) by the maintainer.

I am not sure. During the interim maintainer period, Patrick sent a
couple of rounds of ps/build with a final patch to the effect of
"unbreak everything in seen", which could be dropped.

But I think an easier thing to do would have been for myself to indicate
that you'd run into a non-trivial conflict here and provide the
resolution proactively.

Thanks,
Taylor
