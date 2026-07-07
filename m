Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7663037883C
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783414579; cv=pass; b=jGKCZNCwEnP7gHWDEn43c1UAyc3Xhwii6tHYjRIkctxXlAA0JuRPDzI6gBeKU/ftstHEhjYMPFOLyXNlc0mPNI3Jmliam4fMdDtc+/cuhJjctHb07FUxCwfRTzLtgOS1LQqwRGShHCH+bH2A74am90Rn1PTiQ7Qu9MhxSwCkJXU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783414579; c=relaxed/simple;
	bh=GjP2tN8fmICfMXbvfXGoETGUh3SxUDJ/1vi/FPtbQNw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9OHYMaJ04L8WjlE6DvhZNg+Se4AYeGRMDMafnfisBBFqs0i5IL3svfqoaDoyk8UMSDUmqWFN7NmvNHNrYUrW1ga2QtE2+idqCIe10+vUN1CqF5RZ/i7/ngOmrlmnoYUPL5mPNxxY7wIDBCNXO6ETqRD+MXZNHLq/mdMer5hOKA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dwYScyk5; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwYScyk5"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6984169c126so7101176a12.1
        for <git@vger.kernel.org>; Tue, 07 Jul 2026 01:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783414577; cv=none;
        d=google.com; s=arc-20260327;
        b=pCIEz0Tq/rcSxz6jummbDweh64YGDwB68pO+gWqSGePC8xx1pLWg1fiUGJFQ+tmDy8
         cq41P2APEIz2tiDLHYlBaoZLG39XtKzRbZtfI/D23l3+K9dUFgbmGIEDkZtgJLByO8W4
         RqoDe1MURo8gCWSiSpzo+2zWzJ4NVjI7udXZHNsfbCtWa+iyYY6v7smEG6OJtNDlLZoW
         ON78JeAh+QhnggoOAh7crmTlLBuTkOa0AXxcc2udSF/Ll4uhTfZgUCPzB9nkYT0feyFs
         mrV+UjZpu9kRcVwu0rrFMBjW2iLwq5o1GbzArd4pGTDUljCOPvBJ2XtiG5acblyMnqqA
         xWDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GjP2tN8fmICfMXbvfXGoETGUh3SxUDJ/1vi/FPtbQNw=;
        fh=mPLEmF3AuymcFs+CAdNWRn3t8VCR59nxm57d+09PYBE=;
        b=AiAPiuOoGJAKfEWadWuAP6WywfURvFfynqJS5ec//He+d2OwnwBWaWYgxJbiq7t0Sl
         rDaw/tHkUdJjBAz27n/OgwHbY7Z/oxthJF24BQ2OhaJfwXoRe61MDP6Qcph4HTBx1/YP
         wBiODB0r0kEWyFpYqkwdxnbzRZYYWTIAx15n/BBZnHRf/uN5GKBRlHwKPNAmClNoRnGn
         +eLerqpqILJKlKP6HcQVz4qnMXhM8XuiiPpzV7dXu/5tELYUbhI41aXwkZOB7G+QzIhS
         G/lKWR45UwBdvJTs8aXPZuHZe+U6CgN9iK4wBNVzZPMRyjyD+t2DMPoVd8Ud1iI/WZJV
         CZ9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783414577; x=1784019377; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GjP2tN8fmICfMXbvfXGoETGUh3SxUDJ/1vi/FPtbQNw=;
        b=dwYScyk5tORvFqXgh8SuZuj1xSkqWxDprRREaVj5KBZKUWPfpkf/BZC6gApwe8g7NC
         fHGNVe6AXLC5rrKVACtER4wS45VPQKSHbPGeZu7daSWQhB9rOZK58chtwWm6r3dR613x
         CtEy4JTYV/e+HC3aLBAw+SbXrTzEEaoe7eWWxd/MTSyn4CvGN+biANaUO5D/bu8RU8rz
         DMs49gEydAkzMq6qLrg0P8t2nTqgnlWbH89Qnk2slPGGEfi7u51ZPFEbNR8gQI28ks54
         S3/55R61TmppyEhI4tRDrK46kTHyu0fX2ZFV+sqOxrhrKYy9zhluEmhil+CJ9gZH5um6
         vTAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783414577; x=1784019377;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GjP2tN8fmICfMXbvfXGoETGUh3SxUDJ/1vi/FPtbQNw=;
        b=tBFdQdzdjYA5s9aO8BHZ6+DRNnphgUfV1t0xU/CJgRw+ogRCxpScDlx6C11ug4e1kn
         F2AqxL/rlpFHIfb0fgLPelGZVBGh7wO6sraysORWgRRgXOcKMnkctTzhtHSm5BFTiUEx
         cY+L5ZdGaJhMYEe01xdR6Xv9uOWYs46S52NnSFt5GCbFG8X0cQR8Rk+3O2XfDRUjhL6o
         QvcRjHb2AFkdeS/cnGIEdiCDnNh+5+7vA5JtYZn7ZFGwwis3PK0i4Fe0Uyi1vwwOPPNV
         t8cd16q6bCmQ/2frYnPeeM8e4MDOpK4swkYqnDLo2KmyxL+i8GQ0qnjcOO1Eop3AHc5Z
         fYAA==
X-Forwarded-Encrypted: i=1; AHgh+RoqPPqerTnRdBvInJ3e0Ejxjo+4Nl/xZNS4+Z1N8yq3FXJR0znA9WVJ6RqlE3hRrke3W3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGReTJpx5Tr17JF1rTJxM5UOFAMfhAROOPFX3cdU8oTk+qN1th
	Fmse2xeTGeyySQA8urBM/lK6MhIxyGV3fKD+Q7Qyl/X82CdZYYdfhongypa936bQx4eK7YtCMph
	PufJgTVge0tw1UJrdikEFRxxLUF59Pi8=
X-Gm-Gg: AfdE7ckUHB8HXZegipjJHEltet+Vr/GAjBaA6aXJz9H9hhAU0O7KlhNIUgA2Ru+t/Ei
	qYl7XbiNu4zvO3g4KstwR6CpEENUtFkLM5hU00mzOJ/yr33FPEbqIX6KRKaLzYGQZE12/OMio7a
	I/d/0wR1OkcbtI4BrwGCK+NFQbTdSyCtfwxsEE+hYDDNELoHHPSb/bh16Cib688Yb1HR3xLtTb8
	mJG2VK3Js2VJne2AmPIP+CERDPNV59B7+ZaxBrItPMZZ0ErbUaevYnVCcj2ZQNa689klPYH
X-Received: by 2002:a05:6402:430e:b0:698:62b7:a4be with SMTP id
 4fb4d7f45d1cf-69a85994b46mr2046733a12.9.1783414576562; Tue, 07 Jul 2026
 01:56:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2337.v6.git.git.1782635349.gitgitgadget@gmail.com>
 <pull.2337.v7.git.git.1783327849.gitgitgadget@gmail.com> <5a5dbfae-4525-4b00-9e44-936be606ee85@gmail.com>
 <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
In-Reply-To: <CAHwyqnVxa34iGmFvL4Ujrc2dTbmtF+7j7b=q5v95y=-pzUf0NA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 7 Jul 2026 10:55:39 +0200
X-Gm-Features: AVVi8CeLKPS1G_xM-Xgc8Ir9Ek44-SROLM-HXqDAA62zp6wb4TENx_mUW5TVZ4Q
Message-ID: <CAHwyqnVd2OsmD-Y4YKVr9GsYdHRRNDot5EKSSESoRM-mf82YSg@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] history: add squash subcommand to fold a range
To: phillip.wood@dunelm.org.uk
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Matt Hunter <m@lfurio.us>
Content-Type: text/plain; charset="UTF-8"

> > The range-diff does not show any input sanitization - what happens when
> > the user passes "--reverse" for example? As I said in [4] we should copy
> > what "git replay" does to sanity check the rev-list options, otherwise
> > we've got no idea whether the parent of the first commit returned by
> > get_revision() is the commit we want to use as the parent of the
> > squashed commit.
>
> Yeah, good point.

Well, the code already blocks "--reverse" and other unknown options,
but I can clarify that better in the commit message.


Harald
