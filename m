Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895C71B7E1
	for <git@vger.kernel.org>; Mon, 15 Jan 2024 22:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qte2Aa5R"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-6d9b0c58e39so8741834b3a.0
        for <git@vger.kernel.org>; Mon, 15 Jan 2024 14:54:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705359241; x=1705964041; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=HpQSM63LOLEsS+mpmqvaYVL71GNgy2NEmhh8oC2kFZM=;
        b=qte2Aa5RfA/W9U16tFTJuMH/AEcChp0jOZh0Vs/P6Mu2pWQLRVQSNWr1rRwIK740IY
         TaCcHN91TYc6mOMPFErsRn6vlG6/bqUuBLz5kF/d+UhC/f3z9s2X+WzvF63d87JsUZdD
         Bc53+1hIusdOQdVI6xiAP4ZIV88xNOmcrUO3uwCcKnfu6oo/MISlM+eDglHu9G/3beTD
         bS8Q7CVe6DxEkOkaHeXHiAOdyzq4zfJSZEXEpN2bc7e2tJFLIUVOaT37wSJ49874YXoR
         FqFUarX5d/VObJzeefsf5hps0HYDwOE5MEiF7pXBmGn45a9uiLHmMykDn4E2bT0MYMa5
         rGMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705359241; x=1705964041;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HpQSM63LOLEsS+mpmqvaYVL71GNgy2NEmhh8oC2kFZM=;
        b=UZwdKJ6epA7lWPruNE0tvDnZFBBjRNGDqXHp4AUA0yOfxQHHHaWWa30G/29cYmcYPE
         MZPOlePD53F5IFLUBQ61SD0Nf/xDWu3mwAzpifO62pg1xCoUaDIuKJP824S5tNlliF4u
         LedGvDgsBapCyYTauPvbwwgKryUDyk44Bm30TPW97KqarnwsV46Cf1I8gQBoCSnAf1HJ
         UEKucYqgGWFSQ4e0QUx0kY0sIxmMHOw3OVPftqAyaxgMd7gks//mtAIE2phsO7HVH6ZK
         I1pkyRe+wbdKIhV52UX6lGkGvRM9Z+BYm8JgubA75mAw+iTawcLnT+7gdD7A9SCWV/O+
         OFBg==
X-Gm-Message-State: AOJu0YycL399jUJ84klNsXAdGDWNoaf7i3Rhhgxb2VaKbQhDOGPH1PJY
	J/lpi3D6Xb0LmX5SWGjvwTEHWo4hJmQPBs1V4A==
X-Google-Smtp-Source: AGHT+IHqH/WOiP//IS1vwp0uh1CnIu9WoAUhI10Zkujbh/Pd9IcU2eHdCufFgSXe2wsJd8EX8KP6qTVJhzs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a05:6a00:2e1a:b0:6da:aec4:7370 with SMTP id
 fc26-20020a056a002e1a00b006daaec47370mr947118pfb.1.1705359240861; Mon, 15 Jan
 2024 14:54:00 -0800 (PST)
Date: Mon, 15 Jan 2024 14:53:59 -0800
In-Reply-To: <owly8r4qi5zj.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com> <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <owly8r4qi5zj.fsf@fine.c.googlers.com>
Message-ID: <owly4jfei4xk.fsf@fine.c.googlers.com>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
From: Linus Arver <linusa@google.com>
To: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Linus Arver <linusa@google.com> writes:

> So in summary there appear to be the following possibilities:
>
> CHUNK_MISSING
> CHUNK_TOO_SMALL
> CHUNK_OK
> CHUNK_TOO_BIG_ALIGNED
> CHUNK_TOO_BIG_MISALIGNED

On second thought, it appears that CHUNK_TOO_SMALL has three cases:

(1) chunk_size < record_size
(2) chunk_size >= record_size, but chunk_size < record_size * record_nr
    and decreasing record_nr can make chunk_size "fit"
(3) chunk_size >= record_size, but chunk_size < record_size * record_nr
    and decreasing record_nr cannot make chunk_size "fit"

where (2) and (3) are just like the *_(MIS)ALIGNED cases above when
chunk_size is too big.

My default position is that these additional cases might need to be
treated differently, although maybe it's overkill also.

Thanks.
