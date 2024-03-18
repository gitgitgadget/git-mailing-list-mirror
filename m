Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7018D1B966
	for <git@vger.kernel.org>; Mon, 18 Mar 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710737354; cv=none; b=lUXlOLDGfezAS0QJCwaTA28JJXNFruNRoegP+C5Vy0d+D6RrQ3kk+xsnagO64WUjhmEUEN0XJPJ/VB/MMQhaq75liMk76pVpkpcs2kv61diZcTMGPSxbqXUJXsUdai9cWZ6j1Tq8ssf8BOlVDEbKZArXTa9WED0YxKLSOrfEGL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710737354; c=relaxed/simple;
	bh=wBSPAx6WLZjPzeinp+nl1/h/lKugViqAsU3Tv/aSkEY=;
	h=MIME-Version:From:To:In-Reply-To:Cc:Subject:Message-ID:Date:
	 Content-Type; b=lhhyrJ0KHcPVoVBnPE8b8judI1TjdukYtHMkbWsFT6I/DRiSjAX9D2NqcA+N/mHIy6YOIpgOEWusw9NUc/k52I1mbvwtzSYHbd7MLqfA4LrQ+cSrl1k2fTOCuxf2DPaVOWss5Y8hZCdvrPiD0XO1pRWzO0Ed/PKPb1bcraUU7So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEhvpv/m; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEhvpv/m"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430bf84977dso10569581cf.1
        for <git@vger.kernel.org>; Sun, 17 Mar 2024 21:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710737352; x=1711342152; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A+R7V+1A7uyejjSfngW4j1754mBWGzasgrJ/29zWKII=;
        b=QEhvpv/mTrh3/rBD6drgByZsyKRLxb/Zn1VZMPzJykvnv52Uel+rY8eIiZgyfacY/N
         qZ53EOtLrVOn7YfhupoYEUxytKTUcldFc4Ks2eM3Quaw2GzSxIEUEiG0nl0VCKbJUesf
         LwX7q2dg1uUiXvDoIRW5Jnx2EqYqp7d4pFWlEDKnMSYkEmKa9ssrE3ZFl7cyVj2B8Qlp
         yA2m4sPf0etHZcz4Yytje7dS6uMhEDJX20d4D4+TnzsoTt99V3rM4/g5wyfFJF9rT9/6
         oY+CqYm2x4jRgubf5bcYXupkdaQvGzEXqgVuSi8WY0K+6wxJZBDOn2fS7a/T+yGvR2Cx
         CK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710737352; x=1711342152;
        h=content-transfer-encoding:date:message-id:subject:cc:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A+R7V+1A7uyejjSfngW4j1754mBWGzasgrJ/29zWKII=;
        b=PEtRXTA4zW7qnXzSYOLmhvCaMNUCK/kSH6oGDW/zMcIr8uNZenk+J3rezLkkEUmrrp
         +94C8iVAsN71UKOb5irHfpgVF5Rvno3odjMxwF4uAOjQJLA+a9zi1dYXCXLBcn1XG+Nb
         FYoHeEzRu95TVgoV3DYsrUSAul+2yoRn/E8jVRCEM3Iny68WlwMUExnC7RtWg557hK1A
         Ap4RMJuL0jexJ/x+x5X6e1I7dWRtjUQuCOztvxxbbh+YsCBBeIubPeRo7Xh7FpaBbnzT
         sWRDTLaS3TBvbTRpAVFAuG5nSqXyAEhfLJ7EkJjvPwburG3f6ERjMNY4p5g+SwOtVQE1
         YP2g==
X-Gm-Message-State: AOJu0Yx6tHiuML5lr0uykQr8VHkXpS5hMEXlE0gTmbWYeb1a+RueuZQe
	RMJBX87N1fDpjMTTY6getFh6T3s8up1i5svaBxRnx2cS0p9XYRA3
X-Google-Smtp-Source: AGHT+IGI22U3AtLB757RLlJKJlaPsYreh9SQTBKvt4Drwjr7aWEUf1zwddKT14wAUbqF7rWL/gcjqA==
X-Received: by 2002:ad4:40c9:0:b0:690:b9c6:efc2 with SMTP id x9-20020ad440c9000000b00690b9c6efc2mr3451604qvp.46.1710737352160;
        Sun, 17 Mar 2024 21:49:12 -0700 (PDT)
Received: from zivdesk (047-034-027-162.res.spectrum.com. [47.34.27.162])
        by smtp.gmail.com with ESMTPSA id dv8-20020ad44ee8000000b006961c06e844sm847610qvb.106.2024.03.17.21.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 21:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: "Linus Arver" <linusa@google.com>
In-Reply-To: <owly1q8a4qhh.fsf@fine.c.googlers.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] docs: correct trailer `key_value_separator` description
Message-ID: <17bdc28ea2b88503.70b1dd9aae081c6e.203dcd72f6563036@zivdesk>
Date: Mon, 18 Mar 2024 04:49:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus

On Sat, Mar 16, 2024 at 1:53=E2=80=AFAM Linus Arver <linusa@google.com> wrot=
e:

> Nit: This line was modified to have " each" at the end. If you did that
> on the next line, then this diff could have been a touch smaller.

Sure -- it looks like this was a result of applying a different
hard-wrap width than the previous author, perhaps? I thought it more
prudent to wrap to a consistent length than to be overly concerned about
the diff given that it was already a fairly trivial patch. That said,
I'm not seeing a recommended wrap width for doc files documented
anywhere either. Is there a documented guideline to follow here, both in
terms of preferred wrap width as well as when it might be appropriate to
stray from it for reasons such as this?

> It's probably not worth re-rolling, but a small suggestion I have is to
> simplify the language a bit to reduce repetition, like so:
>=20
>     ** 'key_value_separator=3D<sep>': specify the separator between
>        the key and value of each trailer. Defaults to ": ". Otherwise it
>        shares the same semantics as 'separator=3D<sep>' above.
>=20

I do prefer the simplified language. I had initially aimed to simply
correct the inaccuracy, but I think that it probably *is* worth a quick
re-roll to make this simplification. I will send that out shortly.

--=20
Thank you,
Brian Lyles
