Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15E4156258
	for <git@vger.kernel.org>; Mon,  6 May 2024 20:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715026627; cv=none; b=igtuMqaR0+pBjbemKf/IGO8w17we4Keg5NKwJQ4IKrsszfYsaQxG0F3mG7I8ov3Kcj0eeCfkwnEP+12xJfXhiVSJj9uDADdb9/oya8TR2FKOCpurPyahTKx1K6fVNoAfIMXIkQg9jJZbvgCYFLZhFTtnxxvj0Y+mUiqYHQ6uhXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715026627; c=relaxed/simple;
	bh=s7bGQUnNZrAtl6EiUlEOaelDpDrQOx6aEEmXOLMDHGc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XfnxN+MKogT5k6u3wcyOYhOvBHzfr+nlO+hJ3M+VOAmYbp6jm7a5sMacSsyVVmj0gmeIIhar1jUFIZYm85mZHj0Bxzptk64BjswTIyCWvRLwqRSf+pjfYVRrs1QPDYoCbY/0aWd0RV8sHw21d0R37bK5c9Jv571KVgbP5TKezig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=joVe+kxv; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="joVe+kxv"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-6f04ec1b501so869923a34.2
        for <git@vger.kernel.org>; Mon, 06 May 2024 13:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1715026626; x=1715631426; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=s7bGQUnNZrAtl6EiUlEOaelDpDrQOx6aEEmXOLMDHGc=;
        b=joVe+kxvR6dJJOtSIfqVHcAwFM9Y8fU+eGBY22pELqo0croOPh6S20gkVT3BOs4r+P
         YcCOyNdKPAoX3RqlSNpUW1bgyt7vv1ljv3LmTM23OT+AtHWN0R0ve1L5XT2FCOPqQkc5
         JlBxtyJ2gLcIIATZ1sIwz2vNVCh3sBBCqfD6W30pj2F0N+/ixfQnJgcp/FKz1ZZrmGD9
         tBhDY9U9KzQS4fk9n71WTPSod8z6EoOFbg11JfrtI7Gs1VfgDi58lXRxPh3rFrkVPFGz
         AMcpaxtnRWMtst3LNFJfdaUsM44iegUn3ksUAyHdo9f5mPkDu2uEWMXNu+PAiGEzKqkO
         M0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715026626; x=1715631426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s7bGQUnNZrAtl6EiUlEOaelDpDrQOx6aEEmXOLMDHGc=;
        b=PVSlxwTCoFgE2k5aki8CHmxFHCjJfN8bDeiWKflnwE752nQpOuakbLnxBf2+aGsh6P
         rEZaWP7JyHu0i/VajRpcBJkb8Sdl2TGlecnKDOverwIebaLe7QLUhTWVbj6Cn+zXyr7D
         ZiF3BhvwCYeDGgcDYBxe5KNPzcXROv5niZUoqsu25kAozDIsj/H0cx/z2n0hTCIPxqOm
         4ujlSl4zi+BuoWO4JJ9EYhBtD4leuqQgCFrjb2ezakF2lvDdEv8XHaJrOU+iXSiPWJgR
         nGnqBi7qHHWyA1Q9J0APuVktsmN++GM/lxaNo/06pwEedZ7HpJ4mPG3oSfiq/kiJYhoX
         4s0A==
X-Forwarded-Encrypted: i=1; AJvYcCX7fOdF/13cjdu5WZ+txp22gxHX/0xZ+bU0l84t0odXp+X+MPgarUwzbVfrfsHIQF2r9nS561D47Mr0swVoG7FzE5vd
X-Gm-Message-State: AOJu0YzItU3f1UFu7oqMQ8nv8jufnRnvet/bkqh7xMTQ4blquAihr8HZ
	SBpmAT2LTgQACu2Kl9HFpYc7B8xJvca0+lDJIJenzH6nMVzWIahii0syDetkxaE=
X-Google-Smtp-Source: AGHT+IGtSZnXJvODw1wUF6k1uaSw0bVeZNr96EASltESupuIae7HnB6LtkQzL7lQFNTAAkYJgXE1fQ==
X-Received: by 2002:a05:6870:818b:b0:23f:eea9:ae35 with SMTP id k11-20020a056870818b00b0023feea9ae35mr2145076oae.41.1715026625683;
        Mon, 06 May 2024 13:17:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v25-20020a05620a091900b00790fbf629b5sm4162128qkv.115.2024.05.06.13.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 13:17:05 -0700 (PDT)
Date: Mon, 6 May 2024 16:17:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Josh Steadmon <steadmon@google.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, avarab@gmail.com, christian.couder@gmail.com,
	Enrico Mrass <emrass@google.com>,
	Emily Shaffer <nasamuffin@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
Message-ID: <Zjk6v3Y7zJqtPVVq@nand.local>
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
 <20240417163244.651791-1-emrass@google.com>
 <xmqqr0f47wp9.fsf@gitster.g>
 <xmqqseyzar96.fsf@gitster.g>
 <CANq=j3u5ZHYbJQjhwtnq05GocOE_AVrHodjPOqVCNN7OZHwVsQ@mail.gmail.com>
 <xmqqfruy7oq8.fsf@gitster.g>
 <ZjU7CWdwb+xKubul@nand.local>
 <mdgbdajenbv23r63hreieemielgdtdkwjzb65pdv3b4rylyyxi@4d3eeymtjvva>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <mdgbdajenbv23r63hreieemielgdtdkwjzb65pdv3b4rylyyxi@4d3eeymtjvva>

On Mon, May 06, 2024 at 12:36:06PM -0700, Josh Steadmon wrote:
> How would you feel about a doc outlining how the process changes as you
> go from: A) small/medium patch series, to B) larger discussions with
> (parts of) the proposal recorded in patches, to C) large discussions
> with no patches? This is the structure I'm leaning towards for my V2
> draft.

That sounds like a reasonable direction to take.

> > Another way of thinking about this is that I would be extremely
> > reluctant to see a similar document proposed for reviewing at the patch
> > series level. In my opinion, the system of reviewers and participants
> > discussing the series and the maintainer solely determining whether or
> > not consensus has been reached is a good one, and I would be extremely
> > hesitant to recommend changing it.
>
> Sorry, I'm not sure I understand why you wouldn't want the patch series
> process documented? I'm just trying to capture the status quo, not to
> propose or recommend any changes.

Apologies, I misspoke here. I don't mean to say that such a document
shouldn't exist, but rather that I'd be hesitant to see a prescriptive
document outlining how patches are reviewed at too granular a level.

Having a document like Documentation/ReviewingGuidelines.txt makes sense
to me and seems like a good thing to keep.

Thanks,
Taylor
