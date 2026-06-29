Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C40379EE4
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 17:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782755730; cv=none; b=p9nAPVAvx3gQ0Bv8xEvYJirlCWTzUWr6gQ4p4MhXsLAUFO6r501rQ/i+JCzO8ECmTVqBtW1y6B23M6BO5sFnpg7RN8gwuj98NMl+I2+2ZB98SFOGAFhOPvH77wAB+gy17bOLBePdfvuzSJBfr5g8SXXWdCrws1rET0OWG8koKGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782755730; c=relaxed/simple;
	bh=DFqU3RzUaR2u8CTmI9MfvDJ2UwrQUuwoA8j6gsxsgSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A82UgElyYbZeKXShcYbzrYON5TlNAKaMVy85HwpBfczjZAq9gRiVU9KegRULlg/IOXYkHKOKn8DgO1m7kKmbuj3Z70YNdyygrteqC+OJucuCHCETsMTj2n1T7DE4n+ZUwUoDBaPEJtur83PJBRU57M1l0qRgwAmUXWjLZrh5CFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpKBPwwp; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpKBPwwp"
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-6a18386eac2so282261eaf.3
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782755728; x=1783360528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JxBJkxFojpaAlz2jFVRlM4IL6vkd7r+xcigmXoy6S8=;
        b=LpKBPwwpvIu6xUO/7GfYMxd8uWIvki3UsUepumBVg/HmHNyTtUYq5NTR0WavNjMVQz
         X4C7G9UGB4cQCZamqqo8JyEumNuYHI0n9ka4NSm7kJxiYTqeSsEBKj0eau2ddVvJPkFW
         gRJkb0DeJN0wwwkzvgjNdtH/Ps4zg33etLeSLfRc8cZq+cCBze2w/VWCVZtExCgCnWMK
         1fhBTO0bfJHx3ZVdZ2Zl2S5bBuZ1sR/HP+jOissXlqo8PepxyYVIxxp94QlUDmvk9aWF
         RXtxKaX655XWzFcsY3o5hbaxJPNuaiZdB2y1ieRks97mcurOzq6O2j02+gvAnOz69eaX
         rMDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782755728; x=1783360528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+JxBJkxFojpaAlz2jFVRlM4IL6vkd7r+xcigmXoy6S8=;
        b=ZO16mdyz1GNJ9osF2ToeiWcxZgQpZDwKN6qeqgh56KbMwmzPMenIVlkv7kBzW7ids6
         wFnmT2RQnguGowZgDcIeZi//CksIee63tnpyCA69U7OoMqcVA7cXr95vo/7LLhV3xkl/
         CtjX46oj5Ky1iCc7TGcWUMHwZW+3gCCePt9FdhQhbTGI0yKgslmaLcG4OoNHbWkiRF2q
         85BpksBEy09/3F2mTYKLg0lJbkcBhugsRtvzc7g9P7E4Kw/j5Mub0PBfOidRon0UZV6k
         EObOYf9Xc5S0voxCyJQo01gJuD8YVtie+HjCtkKg8YSZnLIAHO+q9gPxEKx5Sul2W5Kq
         Mg4Q==
X-Gm-Message-State: AOJu0YwBylyEVHeguNLDnhg5MqAWqJknJa18Wul/X3jX6lypAvdB+HOv
	oapb1T8OWsYuB4S8rLeMj25YAl5i569itIveoca0WSCTP3P+th7wRTRu/s589A==
X-Gm-Gg: AfdE7cllw+e3nTYj3Ww0/SM9p4fFjcBdN7IMOthsQ4zGUHJ0N4qO6ydZDA6kkEwU2db
	gR/tpd97cC82JzPOI/r0zJOCYdTUXGRP4Saf7A7si6TFZByVBX70KPWXpX7hgcRhY7ewl7Gjli7
	Uh5BJop3QrdMIDvhMpSSNpiFuxaB46hfNdikhMoBqavczVBc8JMwnuInFJJ1TmT20TH4OTdgpji
	9OAidQf6DnCN0MZxorlvoE2wrHe06NpBIS6bCIcbJCSOIM7ZcKhz9U4WR27G90fcBSItakr76yD
	Ka++XdxzE2BPNUjbAR3aOLHmy2paeOhDTVOROUglWlW8Kl23Bqg0luKD1DElWeq/2j759DpNIyK
	SCiV0mgVABOgn19MDTVVLuMUYLDyr50LxQu+CAGj8Gm3wogmt2SCw+Xd8mHl1srvjTfNLTxuJfe
	uGYUfj4w==
X-Received: by 2002:a05:6820:7087:20b0:6a1:80a7:2c98 with SMTP id 006d021491bc7-6a1892645f9mr332659eaf.58.1782755727886;
        Mon, 29 Jun 2026 10:55:27 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e9ebaab674sm375434a34.0.2026.06.29.10.55.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 10:55:27 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:55:26 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] treewide: convert users of `whence` to the new
 source field
Message-ID: <akKwnZ8hReIfKyyM@denethor>
References: <20260624-b4-pks-odb-drop-whence-v1-0-8d1877b790ac@pks.im>
 <20260624-b4-pks-odb-drop-whence-v1-4-8d1877b790ac@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624-b4-pks-odb-drop-whence-v1-4-8d1877b790ac@pks.im>

On 26/06/24 02:19PM, Patrick Steinhardt wrote:
> The `whence` field has become redundant now that callers can learn about
> the exact source an object has been looked up from via the `struct
> object_info_source::source` field.
> 
> Adapt callers to use the new field. Note that all callsites already set
> up the `info.sourcep` request pointer, so the conversion is rather
> straight-forward.

Ok, looks like we only adapt the callers here in this patch. I'm
guessing a subsequent patch will do the remaining cleanup.

Looking good.

-Justin
