Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F22B2FF641
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111156; cv=pass; b=u/scLOWfF+8EZb4gbUW//gOfD6vO3qqs4eZWnOEuM9CaB4o9lzj9rEHOiS7xSXavkAY5Bd9muT5E1GrzAQ9fs6jXuESIEftIKNZKX9mDcZMjkOuT++Hik+z8tg+gN/okvu2bLdxbu2ycIhGQxtoQUHRoDWZV4r4Ovou/NrhXqcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111156; c=relaxed/simple;
	bh=N2X700eqTfULofnQmGW8aJ7QXGQJeRSgX3eEdrcscVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qL0RIcz/S2SjbEEjmszAlZp5MHrYDcBQp0Bj1N8QzYq2eKy+YyS1rnKQduo7VzWUZQfYJU12wwTNdwHcDZgQ6LxbXcqi+jL5cmWOtHQOOoR8BX3fqkQHsbQZCzRktDpu3ak3xccjlbkEjNWLal28L5YsHJoyEMi3eZLBNWty2AI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPownSbd; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPownSbd"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e88b60121so2840216a91.3
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:59:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786111151; cv=none;
        d=google.com; s=arc-20260327;
        b=stXizOryUTJYDTtSISNc63WgsEtml/ZrDtW9sXduLiHytdqu07jTFo2mP7dTLw7zcl
         kKn9yaiHsaHSlZCBB3EXLZM817Kkw+oQomWuzoMWef0QVGP/AvrtqdjueCu+SoVO1FGA
         d0YUsXR7ghyO+puUyIF3ndAyjJTm7A8yP3KqWIBJSgBBvHXT3UDOfoWm9BaDbj49kNIF
         JwY8aUc6ul0AV9zMp9NNY2JzfBxo5fWhqO3A+kmvmSjHzqhSJ4oR+A14NIUL6O+zY8yg
         e0kr+LH9dUPOpWRQmsMYd22T621Pos49PIosr498fPEzMA37JXW7mKEqRge6kue2Mnzo
         MlZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N2X700eqTfULofnQmGW8aJ7QXGQJeRSgX3eEdrcscVE=;
        fh=2GA+52EOTTtrxPI6sUYdCtK52BJg4kdWCeOMQQlyAls=;
        b=LAcYuIPG1ndSxSiBWgbboenUxoeaWNFmwF6Pw588vBKWFZEKv4gbBEP8ey8aGNnCFR
         0B098QXpRNHlLs3dXVWmbU7oV4AOs/UlyII45SF/HA0r+nI5flRGvkr6G4mu8VHfeZ4N
         W8K00VTpzY9oAoa2KioAatxP6PYlNG4AqEIr5hHH4CwGtLiJbqLdVqLn9SbB15DGqEUn
         dP7lrHzwcNmkwcp+YF+2FoYiyOmekMWv/ObUiQi2llRAUkBZxOMbxT1kOouGaVLX1BKz
         F429/3RCt/knTliHJf/KOOUvlftA+3WZbknTRGncRpYVAMra9kEhu1iSZCDUiG7GgnSA
         sjZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111151; x=1786715951; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N2X700eqTfULofnQmGW8aJ7QXGQJeRSgX3eEdrcscVE=;
        b=hPownSbdJkOJQwiUYkHmrESpKbcrMqm808lCvuqW5zncNlQxWzZRxqHpx/RLhkzBiT
         G5YVQ4IKlbPpgFlBS5ClHDBJGltcvn4/SXcVt1MZ/yMibI95ElcFcVRvJ+h2TP9nkB7J
         Dg4vGzKjAqCup8rrh08mGJODxcNy2K4V37itvWQlyuRLF5sSFEU9u/OMRLODRdyJapTE
         IRri3fBDhRRS0cYjY/1f9F6/LkPYd+lT0XJepjhrWlBguF3kXngbv+oZ5CyhztvyYBLE
         xTdB5GpWePWV7Q0J4JS0O86ZdjiqdaMGIQZpk4A5L76biASqq4lfBY/9oHWj77Qf7SB7
         /K9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111151; x=1786715951;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2X700eqTfULofnQmGW8aJ7QXGQJeRSgX3eEdrcscVE=;
        b=cFAp1Tm7WyAZW1gL/weWWWNNJTyJ94T3S93nOmyDVz8TE7iuFYGUxqnSiZV/4OIbDr
         MNij04i3ygFu/ROI4F63UD0hlo7/OKFYvZBesLiHMO4lOV5C8h+7JUKA7XX7rkKAZfwG
         Oehn4vVNQabAsf9oQs+cC+JDM2yRLe4o+G9Z7t3VoybmvpxA3NDJWukPYwSdXs+FiD9s
         fXM3wfe+8nfUXs8faTwUbJZcof3KX1fnWB1p4IrBXgw+2vVuCWnJhVKEF9E7JsGCAA8u
         GChz7SXtlreMdfHtr+Q2SNs7RzqMvMmBDEM5MYhmXoroI2ywqfJfVer9iL8bNdh+bX3a
         Nq0w==
X-Gm-Message-State: AOJu0YzCtCuxD32sCCrM7O8wKRVjEhOGgzJi6LdhjXOFSLgMiw6ojmsW
	k5yHz55/1fX4a7LBG4HvQjEsC1iq6TAFe30Mn2CEHiaWlKhzve4D1KtekClCUQNh4IbkdEJfL9U
	wUwF/ZrxSoSwmPkPzWEwYsz7VpQcyLNYYQQ==
X-Gm-Gg: AR+sD10Pn/0oQUxFYW9XPWrC+rAiZzJ8zOkfrTcthB+VRWCj2lVSFOsFaSzp0X4ocs4
	HXI6pJqRSOl6LyZH+Strkq6EhasOeHjH4uzd2vqYT2y86hVE++JDC3em0Tqcajduj+alfA3kV8B
	DfUdcU2xsVGa//GhMwSbWFN9Gl3bAZNQNgXSWbPSLOMCFhPAp8nG6RBITl1kpXnLx4ev4lVATOZ
	0Zly703viMDYDorxthIK9K41BxqAeoe5byUzh3lVKZRBQQb7WLkpwqj803bhNgDAQDPpDo60DQ2
	zHOFlDu8AO6Ii/GLBhIlaKfeXgnQy5f2/xSKX2M7zQ5tl0R+j6Hl2QGNruknfqNCKnAIGXIlPXa
	TvgUWLrAB/X5ZusqlEHLtSXEF2yELbw==
X-Received: by 2002:a17:90b:3f43:b0:38f:57f3:4dc6 with SMTP id
 98e67ed59e1d1-3903c6798bdmr26257268a91.21.1786111151553; Fri, 07 Aug 2026
 06:59:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com> <20260807135511.1818458-2-christian.couder@gmail.com>
In-Reply-To: <20260807135511.1818458-2-christian.couder@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 7 Aug 2026 15:58:59 +0200
X-Gm-Features: AUfX_mxOicFP58N4PESabC908wU1jo8syWlVLmxKhTcL9-z4zvxLkoumU50NhqM
Message-ID: <CAP8UFD3txHujpg_NxZN9m4VbH2Yp5g38ZV3=HrXrDrFSHLpaQg@mail.gmail.com>
Subject: Re: [PATCH 1/5] promisor-remote: factor out lazy_fetch_objects()
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, "brian m . carlson" <sandals@crustytoothpaste.net>, 
	Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>, Jeff King <peff@peff.net>, 
	Elijah Newren <newren@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 3:55=E2=80=AFPM Christian Couder
<christian.couder@gmail.com> wrote:

[...]

> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>

Sorry I just realized that there is the wrong sign-off email address
again. Will fix it in v2.
