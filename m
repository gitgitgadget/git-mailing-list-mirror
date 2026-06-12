Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F69735972
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781247235; cv=pass; b=HbcqsvsW+b5uZTJkNkIAEEoO8M5p9g6LjtN9L8FvmNoWr9HzxmMx4rKYUTIhJhxp/roZdy+myql8BQ3aBVHIiF7/6ZmevY2jd0gJN2Yvo3mtkwqJX+Sb/fmrY6NOhRL+YzlPSKXd7bTpRnf6uN0qWA2k//Pln0teI4hTFq8wOwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781247235; c=relaxed/simple;
	bh=9M94ekQ/6CY/xuodnbboAUweyrwMUvJxJBu6xyD4GBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NO/wnVoPu92/o0p0ocWQZ3LOHacrUjT2OtFZP+xJnSszSY0efvfKWNb5D+X8dMxgbauKg5+pJ6XqlB1e9NHjMe/gcD62HaHMUUgDRWI44jxoo5yM6U2ymXGUalUb62ImSNirjMkMzbGfRjqyUk4/tdZZAKzoRumiP1yt5OMVbCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=TsBPyYqs; arc=pass smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="TsBPyYqs"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e87602f26aso7233787b3.1
        for <git@vger.kernel.org>; Thu, 11 Jun 2026 23:53:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781247233; cv=none;
        d=google.com; s=arc-20240605;
        b=cJ6waE0EfeXl0EL1bmNpWb1n3cQ2G8xs0SG/xBgkPl2hO8xSabnLwM9m2VM2EGQ5f3
         TIMEDxWGDjK4w9h+xhbwrmrNViLhlkym8sZ8z4YWdRT4vqtxJqUIKOXQyMx2OD4RqmV8
         rYYeEr2DgWaaZR/wASPFYmyJekWcoGvcC9ivcAZPuswMb31qDgjTd3ULA0Zn1VcvA7KR
         +Z/GJrdXushTaTNtpg4hGo45zeL/gICbTA/UOgiVxIwJq64OBzQImZ9bAj3rZb+OA65t
         oQsXHo1x9FNZKKZ0Ykix3MjrGs0lxnsS2OtQ9sGcAGweqDQ8yU7ZDbjbEXNwJ2e3Mlaq
         RCKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=B2g1nLjugm/JM1JdXw/NAyiqDNJR1u4j2flUIW2shJc=;
        fh=w+RP40LHaGwj5CMJw7gOYDElSdwwaysUHRvqWpTMG9g=;
        b=CbRt53GGIRHOV948Xh2/KDDKS7ggn1uATmtwVlSaNTUujCUOS9bYIIL+v1gT6dOJBX
         FrkvzLZA5U+krqLgRXNg7Q3ZdbYYZNDuTG6cGn66BtEUxcHn6UcFci+59CuzqOC0u0VA
         YLqsiEv9h62LgSfZXVbTfUQJ1LO27xzRxqPgQwqfhDH4Z4jILdcFlvVk2n9fL56Y5NoJ
         tOomzs5xHAJypGmcICanom5fKlg5zZUGLEUXGBVCrZ3THvLlAb4gUaFUhJaB+LypVPWu
         eVHne5ASZM1qemgGnzctEWW59AZGIETIP0YsDuzEnOU/B/xsHR0obpKe8brR4oJ/BGUn
         NE+Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1781247233; x=1781852033; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B2g1nLjugm/JM1JdXw/NAyiqDNJR1u4j2flUIW2shJc=;
        b=TsBPyYqsF6Hm5i3mx9MCvyUMGd5BZYL7K5RB/JR/J6WIFpI5RMZa6FjiuwugjGqda6
         mK+vvL6VyfKpFzT5vNXITWYE7juvpitK1E6TMdAlxGDFSI693cIr7K2b8crSBB3ev1mw
         eUa69ecoNyTL783rVHiwdMIO2qKOy7VtyRoD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781247233; x=1781852033;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2g1nLjugm/JM1JdXw/NAyiqDNJR1u4j2flUIW2shJc=;
        b=N7LLlWUcHeDmkvO76yQ27dpVY2ipzYUmfXOJce5vxTzxP6eegwEJB8w1DG93NRwkOu
         hqGyrRMYK2l+xPtPcKQldC3EZau/P3ytFcFnDlj2v8bZ7wES1nBBdABl+lWNGb4QRIVP
         iCgfRXOBK16dvZx/ZxgeAuzZoFV+903qJ+nHlMR8PmnzZo/MUSkumV5wk8gtnLZi20rC
         2CFPmuIrEfsomwZ271gI6a6G7jAMhUlP0Q7SMukmYdB8+MoicfX4kqxo6JP/5Oe3pSci
         m/YWvXjSSTZliveUqZDHltaHlReddbVz6XMgL4jYmqWmv0ZSDqxlt58GqL8GzzGJEbQd
         Cvng==
X-Gm-Message-State: AOJu0YykAIc4BA5547PB3tX+xjyIfYYCbmOweFZU0S3wLFOfvu32E4ak
	VlVGqb1yPkgdn87sPRi/kdqB/LG9y4t+oRAYH5fydoWuWEJDZtZuXUfEeRp4sRLyRCZO3KqCAPO
	aDdmmo7DEGNnuuItiNobr+TX6NBXQ3dnksBOhh5/dRA==
X-Gm-Gg: Acq92OGo4WRTFDumypi83J1y7Dgbj4SxrBynq0vE4J2jGSmxd7PhfMP0ngHgj0pc9tr
	FoE1R90qbblgdvSAkhlaEj4DJUJhjIDfIyip8prfzBDbZ4nvwj9iQrh5ip2AhBvBS/e09/yKkmi
	xtTIAAGKF3O3LkEmRyYRqZyrVMawBk4iGK6EKXC5pyjRAYLHE3CAJsjZMKpzo32aiqpvbYv7Gvi
	E6JUKrv27SMeHPkVhrRp9edY4XnJBX7GF/gfrdBqwoP77AF4JS9xHwCGp+F7cZ1pE8o7HGVB6bO
	jvsMUr37Je28IvvrSw==
X-Received: by 2002:a05:690c:490b:b0:7b1:9036:a23a with SMTP id
 00721157ae682-7f7966c645dmr15370537b3.14.1781247232988; Thu, 11 Jun 2026
 23:53:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-ref-filter-memoized-contains-v3-0-b26af3dba285@gmail.com>
 <20260611-ref-filter-memoized-contains-v3-1-b26af3dba285@gmail.com>
In-Reply-To: <20260611-ref-filter-memoized-contains-v3-1-b26af3dba285@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Fri, 12 Jun 2026 08:53:41 +0200
X-Gm-Features: AVVi8CeK-QzOxp0JYZtgbMScMoViOuPrH-C7Y1z8sUPqfvLTBQweBEFAwuzz3n4
Message-ID: <CAL71e4PRqN9iPCzvgwC1Vtj-kzn4Udv+v1LTFSUXtGnC5KGrpA@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] commit-reach: handle cycles in contains walk
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Karthik Nayak <karthik.188@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
	Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 at 05:00, Tamir Duberstein <tamird@gmail.com> wrote:
>
> The memoized contains traversal used by git tag assumes that commit
> ancestry is acyclic. Replacement refs can violate that assumption,
> causing it to keep pushing an already active commit until memory is
> exhausted.
>

The cycle detection itself makes sense, but would it be simpler to
just die() when a cycle is found rather than falling back to a
second reachability walk?

A cycle in the commit graph means replacement refs are
misconfigured.  The existing code already loops forever when it
hits one, so detecting and dying is strictly an improvement.  The
fallback adds a second codepath through the function, discards all
cached results (so later candidates redo work), and papers over
what is really a broken invariant.

do_lookup_replace_object() already dies when replacement refs
chain deeper than MAXREPLACEDEPTH (which covers cycles), so the
existing contract treats this as a fatal configuration error.
parse_commit_or_die() sets the same precedent within the walk
itself.

Kristofer
