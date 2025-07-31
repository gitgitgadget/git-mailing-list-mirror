Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB627F000
	for <git@vger.kernel.org>; Thu, 31 Jul 2025 22:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754002501; cv=none; b=V161xmJipj00D1caypbsnyYe7fWmmNMpH1G+Bj36wXJ0OhpAib4uqqq+1xB2JqoCCRQQj933usZV1DfRPS+Ma8YgKXG1Rg5SHhgnV7uNTq05iALLC25BdkeNUTzzVa2ZoqfFILuLzm92IU2R3ZZ9ujtlHFo2BOySrTb9fwnQZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754002501; c=relaxed/simple;
	bh=mwiHf2ew2n0mO+eNfd/SAiSqkZaqdr8rDCCKayVrfno=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hgFTGfAMCk+uecHs0OPhDlBXcxXuqKzo+s7Vcc9K0R4xpFztck3UoniZlIxJ85o+3Ib4PuFDBn8iBT+QBuSuA+FvR+qMF2O4MCc+6sOzNYGDGHA0OdIXLN61iRmRbRXOYdzSUv/llCMeeVTF4b3sTBrsiTIOdAMT22/sCMQHnPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4ab40633517so2315671cf.0
        for <git@vger.kernel.org>; Thu, 31 Jul 2025 15:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754002498; x=1754607298;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mwiHf2ew2n0mO+eNfd/SAiSqkZaqdr8rDCCKayVrfno=;
        b=Nrinu3JIEUoZk1Bw6RNHqvbmAnDr2cNesc0pdej8rgawVXirN9Kdvz7wcPlS/gRLOj
         Cf86H96KjdZ9l2ni/geRJpIbeC4Jtc1j65FlH0FWzLlrPqX2Y6bpgp4+87jJ1Bhz2eDo
         D9MyfXV4Kx8ApaVjW02LgmZGfKaP+3dO6Db7R6Ezmt37URNvvmI4e0MbGeKrKnl/AZVq
         CeFnJ/po0AOubowcutiNUyO6BmmBsQgsBZK3t+rS+rzxrC3I0Zl8v4YWqKp0Lb/6osYY
         HDL7lxuuILZ2OI7XHIE6Mb7uau2RhPNLQYW4L1L4QJ+M7cDj/viidIFmVhcp6H/GMDHC
         jRFA==
X-Gm-Message-State: AOJu0YwMywxrowStOV4ae4j0ujw3iDhou6RcZu8VWGdVla5XfUVVQoSa
	M/NHBSe4vwDc4l91HRPfFOqsmvviLtTz0S5l9DJPrLJXdK/Rf4Bv4l0EIRyQdRE5GfYR+vzLHOD
	imcmNZJ2xciwy64vJExVL+lgKF58pjgc=
X-Gm-Gg: ASbGncvx3wRGdw+IbUbMTWdIMLlBVTTAoe11PTN6EEPIHplftG88YVp2j7k8G7dvVIA
	Gx+/DsWYd/vdmfJHxb0l2YgsUKtykUA5QLMFqGbgyWv/ngOPKXDm4LOBh5lnVK9ChUI9Y1EiS0g
	zy2V3FLz9d2c1TAUSlP+Fy8RUdVZpa5lIACa8ugYs9z4pFacUfJlsujXpLdTZfo+fKhtjE49S+N
	p7KwmswEC0bJ2qnqHU+ei601XZUtHweRAsdO81p
X-Google-Smtp-Source: AGHT+IFNJyHdSnMqQLiI6XMzodKjMA7L4Jk8Rc8BBhBlFnqlVwAi0zGSTNFH73QLMM/9UtwRrb8TrnOCyU0I7Zq/6YQ=
X-Received: by 2002:a05:6214:c62:b0:707:1654:ced4 with SMTP id
 6a1803df08f44-707669a4637mr59300446d6.0.1754002498270; Thu, 31 Jul 2025
 15:54:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250731063949.1601669-1-gitster@pobox.com> <20250731224607.3942417-1-gitster@pobox.com>
 <20250731224607.3942417-7-gitster@pobox.com>
In-Reply-To: <20250731224607.3942417-7-gitster@pobox.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 31 Jul 2025 18:54:47 -0400
X-Gm-Features: Ac12FXzGAZwZcBHcXN04hf047XJkMfJhvgncV4NgBRYryRTFv87ktmcua_8CO9w
Message-ID: <CAPig+cQs=fCd8DYsuGyrK=e6xGpZE8zdyE5BTTCX1jpN-TpcgA@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] string-list: optionally omit empty string pieces
 in string_list_split*()
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 31, 2025 at 6:46=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Teach the unified split_string() machinery a new flag bit,
> STRING_LIST_SPLIT_NONEMPTY, to cause empty split pieces omitted from
> the resulting string list.

s/pieces/& to be/

> Signed-off-by: Junio C Hamano <gitster@pobox.com>
