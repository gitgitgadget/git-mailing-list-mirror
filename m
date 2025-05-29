Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2779A1362
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748477237; cv=none; b=DFbEdraZPdsZQk+aK2tNJ4DnsQ/JAUSL0q0a/4VJAkEujNIGKs+glT96aK/X+MhISSEvWNmDxal5DEVy/UU2Kx5HXRhvhvJGg7w4aMyHn7fLOpO8XtIRo6mYbvooA2IbqUYUju0WJ0LKEUDVKyekNFkShTeDqMbbBVv3ogvtA2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748477237; c=relaxed/simple;
	bh=vvRLv/Y2xgx6YtvG9Ff7JtxlxASIDoNnWlFeR8yhX94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tzh8zfMaltXP3TPjefeRe5nRJqeGQUhxLOYVk2wN3baZ6LlqJbfpDMtnABQWiAWktItP3w6G+vv3YBw1XQckVxS6OvEvOcgyn1LTtof2qn7qJixrEBtXTiVYUHnP/ZcUBB/mTeNAjOyhFLoh8iAIXjh5gXa2J+gRtKQtnqOrulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=L/1DnHYN; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="L/1DnHYN"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-70f31433d96so4749077b3.2
        for <git@vger.kernel.org>; Wed, 28 May 2025 17:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1748477234; x=1749082034; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RCH+KWbWhramtlQujWXO6it7fGrQ5Nrzs8LXZoa4gpg=;
        b=L/1DnHYNr+fUvfQfgmC+INlu0zTd/xMvBjKvcH2dIwVMYbDEATM3GOwCrzB+NCM9+F
         uyoN0Mm7J/dfPe21GjOsr+CfJErzZZvC10R/zi5A6yiwzP6vHUnl/EF1FmSNd1hm5sXM
         imTH4dAmjwD2OaZ5swf2K3rTt3Ee1Ydni8dFDIDBqKxJ2GINfZbGJ85qq4VHW4Y4Wwgm
         HKhhA5Rx1KnerDjN3/T4KhFH8fERucfrkD25TNB21jLaIqid9XNbSnGHGbSEYWON6ubf
         6WB+ECkTTzsfRE4p2b1fl+dPlg7MYIju9tYTIz8PbEb/0yBVLgKwHqF+lx3/DtyQhxkH
         lzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748477234; x=1749082034;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCH+KWbWhramtlQujWXO6it7fGrQ5Nrzs8LXZoa4gpg=;
        b=sN0DhKKplZ0R4NFYdZ75WHOpt3+i+8vmbxvHocmEFaKr6giOAz4jhf0umZlXN8Pli0
         oW0dyst6WNYXEGooH9N3VrxWtNVYXpNEvGPzN/vO5HfI9GWoyR1IWCkgB6FLFGa99c0S
         sEXIGmpqm2MrL0bC/Z3eqIo99u0JZxlCf93hKleLGZNsZYCA26V5Y8eF050LOeIpJZqJ
         BPS4RCMZpdsxcAMqckuYTA5N/j+MD55mo0Sx+6gRQzx6Dt3vr6k8KelMq0QK8GlJ8gu8
         MloFSngTlMh/+H7YkGelEWnurEPpoXIcolyg9irfNJas+rJ6KsMzmKjlisr9nuYWYLq1
         2KkQ==
X-Gm-Message-State: AOJu0YxHa/scRcwN7ntI967Ht6HXELEyN2OXz6myk9Il70IuG5Tn7vtN
	4i/vEo4oMSbOYZL6yZ8+sqlQqhp052YpBSDCvLRsKcO5DQwskdDSSKiamuM7U1iibQic46oyRja
	UtI3B
X-Gm-Gg: ASbGncv7Eqq9SSO1ko3uxoqOcJq/Y6R4qAUDT5bUmr1hGw+ok5dgTL3kqlPPNq5w2ke
	J8xX5sh3z7PhuDMUxCOTyJCcQzSJFWamo/n0KWYobbXMKjkCL9GKgL6bwHl6v2kZSJTtFhy0K21
	EqTVQqku2fijD/H/nkb/qwX4K2SLYlx75Ttj6Rff29etfX1LvoCq8agYTUGhRZ6Sf4HrdxHx+/Y
	6hVHEhr6zJsj6GZvFfVl9FAnuAdYph0aRKUjWiKZlhXTbsuFJZM5N3Ey6eiMdmpe84SihDfR+0v
	ELNNZWqzxO+koeeZn5ZKuqJBw3hb/WW9oRoGyqOU6uK1O8565FVcqBnQL9H5/UDhwl+WjkYGzZ4
	YujG75ruadPIyleFNKBs40089RHUSHV6zdw==
X-Google-Smtp-Source: AGHT+IFOcNTK0YbLFG/eFmGlj036/5T2pNB02uRqY/92E/Woizu78dkueha+cAlcUYhn/LWM0DNe6A==
X-Received: by 2002:a05:690c:4c03:b0:702:d85:5347 with SMTP id 00721157ae682-70e2db0dda6mr235264677b3.36.1748477233815;
        Wed, 28 May 2025 17:07:13 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-70f8ac11175sm542037b3.63.2025.05.28.17.07.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:07:13 -0700 (PDT)
Date: Wed, 28 May 2025 20:07:12 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 0/9] repack: avoid MIDX'ing cruft pack(s) where
 possible
Message-ID: <aDelMNw4AK0L9XHu@nand.local>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1748473889.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1748473889.git.me@ttaylorr.com>

On Wed, May 28, 2025 at 07:20:07PM -0400, Taylor Blau wrote:
> Range-diff against v3:

Hmm. My tool for submitting patches botched the range-diff here. The
correct range-diff is:

1:  986bef29b5 ! 1:  2753e29648 pack-objects: limit scope in 'add_object_entry_from_pack()'
    @@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct objec
      	if (p) {
     -		struct rev_info *revs = _data;
      		struct object_info oi = OBJECT_INFO_INIT;
    --
    +
      		oi.typep = &type;
    -+
    - 		if (packed_object_info(the_repository, p, ofs, &oi) < 0) {
    +@@ builtin/pack-objects.c: static int add_object_entry_from_pack(const struct object_id *oid,
      			die(_("could not get type of object %s in pack %s"),
      			    oid_to_hex(oid), p->pack_name);
      		} else if (type == OBJ_COMMIT) {
2:  6f8fe8a4e1 = 2:  32b49d9073 pack-objects: factor out handling '--stdin-packs'
3:  2a235461a6 = 3:  a797ff3a83 pack-objects: declare 'rev_info' for '--stdin-packs' earlier
4:  240e90b68d = 4:  29bf05633a pack-objects: perform name-hash traversal for unpacked objects
5:  9a18fa2e52 = 5:  0696fa1736 pack-objects: fix typo in 'show_object_pack_hint()'
6:  6c997853f1 = 6:  1cc45b4472 pack-objects: swap 'show_{object,commit}_pack_hint'
7:  0ff699f056 = 7:  3e3d929bd0 pack-objects: introduce '--stdin-packs=follow'
8:  58891101f3 ! 8:  52a069ef48 repack: exclude cruft pack(s) from the MIDX where possible
    @@ Commit message
         MIDX with '--write-midx' to ensure that the resulting MIDX was always
         closed under reachability in order to generate reachability bitmaps.

    -    Suppose (prior to this patch) you have a once-unreachable object packed
    -    in a cruft pack, which later on becomes reachable from one or more
    -    objects in a geometrically repacked pack. That once-unreachable object
    -    *won't* appear in the new pack, since the cruft pack was specified as
    -    neither included nor excluded to 'pack-objects --stdin-packs'. If the
    +    While the previous patch added the '--stdin-packs=follow' option to
    +    pack-objects, it is not yet on by default. Given that, suppose you have
    +    a once-unreachable object packed in a cruft pack, which later becomes
    +    reachable from one or more objects in a geometrically repacked pack.
    +    That once-unreachable object *won't* appear in the new pack, since the
    +    cruft pack was not specified as included or excluded when the
    +    geometrically repacked pack was created with 'pack-objects
    +    --stdin-packs' (*not* '--stdin-packs=follow', which is not on). If that
         new pack is included in a MIDX without the cruft pack, then trying to
         generate bitmaps for that MIDX may fail. This happens when the bitmap
         selection process picks one or more commits which reach the
    -    once-unreachable objects, commit ddee3703b3 ensures that the MIDX will
    -    be closed under reachability. Without it, we would fail to generate a
    -    MIDX bitmap.
    +    once-unreachable objects.

    +    To mitigate this failure mode, commit ddee3703b3 ensures that the MIDX
    +    will be closed under reachability by including cruft pack(s). If cruft
    +    pack(s) were not included, we would fail to generate a MIDX bitmap. But
         ddee3703b3 alludes to the fact that this is sub-optimal by saying

             [...] it's desirable to avoid including cruft packs in the MIDX

Thanks,
Taylor
