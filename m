Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3055A26C3A2
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753258639; cv=none; b=dhUM4elu06Nhy8Cv6DofCARhBkXyR7roOL6KKqfExkL4rZa87mgmn/aLxclCamgWtIyCN896rE0vvIyKmzo0mHECagrpFxHK9oacawK8yoDrEAh6V10CbPurZizFUpZQDiZe+OB0+QiO75Ir3F9Xvzhw+Hv2OdUjABYTDafmecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753258639; c=relaxed/simple;
	bh=1OQkfYtaDgJC3r2r5oWPqOQnpfXnntNIGL6eK19eX44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ex+T8ywJ4CfowO4eZVvXQv9al+Ew9oadc5A+gWWBSSFMPjwQU5RhdV4p2Ts717X/4MXb/V+d1ejWzeZ8ddiNYFVUMGP5+5IdEAldtXucSc9Wa4mK7I47zHOIHbtWyEwwoHvGe2LmtQH9qIHfjAy4exf9Xf9NWtS/LBG0TwYyOI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-706feac2d6eso1155586d6.3
        for <git@vger.kernel.org>; Wed, 23 Jul 2025 01:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753258634; x=1753863434;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SXPX/nbHxgTefJ06xbeQddrQirl9iumhJjhe1aPWMO0=;
        b=j9Hzxx3vcZsufN1YiRzodE+faGgT09XrWvMhFcOOMTU5tScNR/UrsY+2Q9KS5JXQa4
         VVCgZMfKQA3CtK/4O4VMoaADykXQu2AcTqDpGcx1jeL5Vn8h5F4iIIFHF0d4C+Bm/aF2
         YEj+0GlG1WP07Qv7J9lzbyIXoNcygdQxV5Cs7gVwstPjvv588Fj08TdmlWv2CHkWHJUx
         2eqXAQzze3MAgu8duu9hus/nci0sAGicsh2yxARUAhm3s782kdOhUBOfwsD45veLua4q
         oDCMeE0jjuu/1fPKdmU2/FXMma2ymTVKlQC7VaaFKT/26Q3wqw6nXwsUaRPAmxSiia9l
         twRg==
X-Forwarded-Encrypted: i=1; AJvYcCX014vAQb6P6SvdF1VeB4sml5KEd8Na1PG99B0+obb585SAOskBv7lVW6wToAVpbc3PsY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8L6L5nVv7htJMzIwLVAPMPsBy0KDmMJOeO+Ug1XatHk/RkpLA
	nehKNl9HrVO2PXFHygvqmZlzST3X7ipeoMgNXnUMvour7u7ISFBjMfZFkpKj09Mp4IiLuGYfmop
	hg9o4A71vDwYfFGx07pcWdoZsGwuD9Ss=
X-Gm-Gg: ASbGncu6F/DySpthTUxASeCQgsYxSzIopwwR5yA7DjXQJH2/AL8Jwv8jlKBmd8REcC5
	iBm+MUAzld/lZBeB78HHTL5u5HxLFyvjNe8klyDnjIzxzkjSdFBugjmDj9G3ibdnWsh+xhQ8HTN
	s9KLFrbp/RIIkGp0Uh+wCoy9czxcb7og3aF/FaY3QgnYQ/MD5cr2nEVRDHmtGEMsIcjnmfwZZvd
	evhFKy4FEWQ3qw2S9ok0hiTDME2Xa3a4KSnQzImI6ejtZpm/v0=
X-Google-Smtp-Source: AGHT+IHNfwyYnMgm6xZDyduhr5keHgqCbbD3y0CzycGMjDyA2xJWt4a4mygUff4Mk9qgrALc8HYa7kPIwYf8s+oBkKU=
X-Received: by 2002:a05:6214:c2f:b0:702:d3ac:96b2 with SMTP id
 6a1803df08f44-7070062441dmr11897996d6.6.1753258633633; Wed, 23 Jul 2025
 01:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250722174102.1876197-1-lhywkd22@gmail.com> <20250722174102.1876197-3-lhywkd22@gmail.com>
 <CAPig+cR-r=CeEaSTeWsX00MLCSRJUUVXMUWS6Ui-HQcR_qMGJA@mail.gmail.com>
 <20250723075513.GA570540@coredump.intra.peff.net> <20250723080639.GA570920@coredump.intra.peff.net>
In-Reply-To: <20250723080639.GA570920@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 23 Jul 2025 04:17:01 -0400
X-Gm-Features: Ac12FXzMwlyOkaMgNiCGAu1nStb5BGKetca2ODvt4Eq-BE6GCLNC_DZ8sqvdqE0
Message-ID: <CAPig+cQAcEiM7aPQZXYX03Ok_qZktWpAgPPS9DUWu3UPVrxx7Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] t/helper/test-delta: fix possible resource leak
 and ensure safe cleanup
To: Jeff King <peff@peff.net>
Cc: Hoyoung Lee <lhywkd22@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 4:06=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> On Wed, Jul 23, 2025 at 03:55:13AM -0400, Jeff King wrote:
> > I dunno. We are reaching diminishing returns spending brainpower on a
> > function that is meant to be somewhat quick-and-dirty.
>
> OK, I clearly could not resist spending more brainpower on it. If we are
> doing quick-and-dirty, why not just die()? The end result is the same,
> but per my argument in the earlier iteration of the series, that means
> we do not have to worry about cleaning up at all.

Yes, die() seems sensible here. It's nice and tidy and makes the code
easier to reason about.

> Incidentally that would also fix two minor bugs I noticed:
>
>   - passing st.st_size directly to xmalloc() is wrong, because of
>     truncation from off_t to size_t. This should use the xsize_t helper.
>     This is even a potential security vulnerability, but probably not
>     important in a test helper.
>
>   - likewise read_in_full() might return a non-negative value smaller
>     than the requested size (if the file racily changes and we get an
>     early EOF). But we only check whether we got a negative error value.
>     So we may read fewer bytes than expected and feed uninitialized
>     garbage to the delta code.

Can of worms opened.
