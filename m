Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D735E18E1F
	for <git@vger.kernel.org>; Tue, 15 Jul 2025 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580886; cv=none; b=lDaFAfqGAI1exE/gXmqDe0/1gAuFzVd4QEtWiA+1g+xxbl0kCCfFqjqkjv9T47fvIzPjT6H9VbJASaIVfJcLoFueoY4L8IVubt0af6+cKivO+1Ex11kKtPP6U5WfAYyMMhSgMltLfbnlyQvbwUmKr1SbQMWAeKHztjIFSCo8mA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580886; c=relaxed/simple;
	bh=3Rit/A64sz3NTemzGWcBMfYlzLV96sfIE3XDIP8dNSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KpycjfmkOqnqvGiAM6pS9ht+/0FeIH+waLwr3ZQpU+TQa8G+OoL4I9MlV3tIVnlJPRBerQzZ/FJQj/2QOQBepSPzCqnn1CpxZGMVxzkdl1x83f4s4dsmjwFsv7/r65UX9k84Efq12lTUoT5Ht1vbPVDQq2P/jhhyOnXgZ50O/Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hKgLdssl; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKgLdssl"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a507e88b0aso4060771f8f.1
        for <git@vger.kernel.org>; Tue, 15 Jul 2025 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752580883; x=1753185683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Rit/A64sz3NTemzGWcBMfYlzLV96sfIE3XDIP8dNSQ=;
        b=hKgLdsslb3iLQ5t9e7ucbshlsSkQw9UTvQkA8PXqzMK0vwGd/nNNTN/sEflJqLLFk7
         B+WwE9OGnpm0/Kgq3KTiTa7vcOj/mtr84DOfjuX51NLRZAvbGZy80PvzehaAomCg4NCd
         Xv+Aij7ZJi3bSXjb2ibffOU2xMawiiYK1MAiqZUsUM4vXRSCzyVnpk3gbp8/1aMDdvEy
         1eipYX2sJsFSqUlcVY4fe0WQBDBoM/6fmgWehLClWS3TOFrhmKJ1mw/NLGCaB8c8nhBP
         OmkX+trS8D7i1DvVEIwvq8xafd6EcmiMGGx4BPFtk57/5/u+U8JbOJS/XO4u4iSei/ox
         y/pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752580883; x=1753185683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Rit/A64sz3NTemzGWcBMfYlzLV96sfIE3XDIP8dNSQ=;
        b=fyjdulb+K1ki1UtxVozIqChQONaYaLaqZgLexvjxo8FKxMOIXxPNXuVCwDvHU7B86+
         o3iqcL1tVEA5YxukYcahq30byhTaBfSXub+kwC/c7yW5FT+TJ7urOVHw+2Ra+ktE8spT
         hMPW6E/0+A5hTYb4kaDm070xoz/lCDGbmjIZaorNB+fvx42pG1Kj8p81vym/BWDBF62F
         rqFEuHBUvT9uMIg0wknGL84SOOGplqKAAp1cI1KfF+1ztVXZOIzLY8MeGIIlvpCQLg9D
         MFhs8sVN76snFw8TTrF0t5vX2LVnBO9g4ouzSs7pqcGXX+2uoG9anEcC0Pka0O8l9g96
         iZAw==
X-Gm-Message-State: AOJu0YyapmYJ2Ku0+6QELtzMVQJDs7RpUYALw/AOapnpvQ4n0pdGi3k9
	TDHzYBnPCweCOGnGp9ETPxrNXZ6sJaCMFY8mW1azMgDmnVgH82uaT4XCKSIw+ttNaGZLt38Li9+
	aBmMB3jA43M1s6hN6i4XBH7s12XZXLhQ=
X-Gm-Gg: ASbGnctIdeLtAvety8yEkKw9IRyotrY2tDA0x5dx6+Js2CrNngJ8Bd5wOZBG+7wfWRF
	+7RyjvhskTM0n8reLkwyrQprGARrGi3KOYaPqmP9ei2V71Q7Xhmaosr00qzBigZ6dKUe6+QqTSh
	/7sNH9561RUA+zmVgNB7QTqGxV0OyhMkVBfPwPaFd6YeI1xcBxmlSJGBP67IG+3ZOFZeAy9b75m
	ipIb6TiRPogbg/4L8xe35LuA+ttrGcuvLfq7+jAQ+7ML+bd8w==
X-Google-Smtp-Source: AGHT+IEVphAFa3Jan2EBdddR/ZW57rrsMoYAYcOm3rKkQECiDsrAl3GGD3nX9dhstMR6oZhRbRDgMGaqWpaQrc5hYOg=
X-Received: by 2002:a05:6000:2a8a:b0:3a3:71cb:f0bd with SMTP id
 ffacd0b85a97d-3b5f188e702mr10956648f8f.23.1752580881200; Tue, 15 Jul 2025
 05:01:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250713122341.17976-1-carenas@gmail.com> <20250713174807.32444-1-carenas@gmail.com>
 <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
In-Reply-To: <2414b962-e843-4ac0-814f-bb4bc7aacda7@gentoo.org>
From: Carlo Arenas <carenas@gmail.com>
Date: Tue, 15 Jul 2025 05:01:10 -0700
X-Gm-Features: Ac12FXwodxdjBxgCVaIGcf6SHGZAQHBEkxOwSp1tY5-EM-JILYuRPt9TzsN2BQs
Message-ID: <CAPUEspjCbi0U6HYxEvpqMW9FPLn98VMePDTNfadQbt_9GHsZsw@mail.gmail.com>
Subject: Re: [PATCH v3] meson: disable PCRE2 dependency by default in macOS
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: git@vger.kernel.org, gitster@pobox.com, sandals@crustytoothpaste.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 6:55=E2=80=AFPM Eli Schwartz <eschwartz@gentoo.org>=
 wrote:
>
> Please double-check my work, that this compiler.has_header() is
> sufficient on your reproducer system to detect and disable the
> non-working feature.

it is indeed all that was needed, abd makes me wonder
if a future version of dependency() shouldn't have a "has_header"
parameter like the one used in find_libray() to allow for this
validation to happen internally and fallback as needed.

Posted a v4 with your code and modifications to still allow a
fallback to the wrap.

Carlo
