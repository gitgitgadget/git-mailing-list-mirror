Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07767545298
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 12:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081513; cv=pass; b=ods1nqKSGojm6uwqxwMCOPnF8CCBGbJ3kNZvuwZPZpBJbjkf9Sjr22T1mgjWBMBirGLe7PdxQC5X0MFU/n7gGcjODKGe7TOnw6q9z5ScKy6oW2WCcSnVWfhLM8Hq/c8iq6GWoABOZtgxUfhRlfsrjfR4Y2w0rBMHHZDIDTAGuCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081513; c=relaxed/simple;
	bh=z4v1mfprMdlXunCOEH+NF1SaTANULAmgswzP2EKIPZY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZWxGGK7vG3gTp1kuDH/iaUv6DG9uAU/C6KAm6Na/lZ7CGIK8kw4yU2zWlrT1y6p/A9kONI4kt5GxSv6i147pbknGbGMOlxSWM24V9bIh/DoWwnqqqwpGbqPPkVG8kfosUiver2cApSxSXfeJXOlSc64rhYOVG03NlknK+csVgZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CBW2StmU; arc=pass smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CBW2StmU"
Received: by mail-pj2-f42.google.com with SMTP id d9443c01a7336-2df4aa80a73so19318525ad.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 05:51:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790081511; cv=none;
        d=google.com; s=arc-20260327;
        b=onvA2UfMtcCIdT8fUp9ri4eJCTJ5ASrh8QWElvPe04Xksh97xDVHRas/ihPCUSP6kA
         U+few64WG4c4Kxm0ByCfb6v8ECQqDm1SJd3MfTG6xADc3dxc4DwM9OyUY6jTE6ku2AtX
         Ibg49FN/4T1XXdGEiUNLvRzefT62QibqejelV0ap7BDdZ7JTSI2sPHP9JfDg7J/PaF9n
         T5qh41H6Kj+I0qdpWGnlQv7txYBnsLa05rP4v60YhOh0sOY7Hs1x+p00L8bOqE51Og0S
         FCb+TdjWtV3ydfdcvRZm/1lIjpBVH++K4acfihaC+3Rqi65SH3Fcne8ms3ymsvDCLFbH
         57OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z4v1mfprMdlXunCOEH+NF1SaTANULAmgswzP2EKIPZY=;
        fh=JwKIycEK1A425YJY8qLMxO6Yc11i7Y5uCpj/+wYJcqw=;
        b=ERr5nOvG5wL0DoLU58xTtSD11SaLnVUoBh3K6+UWO0u88ziEbYLRFVetD1sScTtOb8
         npRWcdriueoVMLIlLzFv9xb4TzFHnbMoq0cjCa/ZzqHKk7u5CyizscubacNtcuZyF/Nu
         BFtHx5tzcHemGCOMaitSpTja+hJ25r/o9ISUfBi0lJZ+oQZY/BlTfKeVsYXdVwGdPTuL
         af1x47KqTfKP90yFnij79c1Hor0RSuaz9hB+6UGShNbFvz03Q1WnyiVQWb/9SsE4m+hs
         pDhr7V4Y2a5MlouWet1cF3XD+hqRZ9AV3Iv8C283RMqQhHKV9v82zQ5EaKVLQ06m+Pci
         ahIw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790081511; x=1790686311; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=z4v1mfprMdlXunCOEH+NF1SaTANULAmgswzP2EKIPZY=;
        b=CBW2StmUo/O/G2HwsPcG7H9Zlym16HkYWUxV67WPyEJuwhWon1/VgbjvTl3kiwdco6
         7EjKRFcXl6Ru+01A/AfQQWuUeatDS0Mnp2LiCqyVl1oYI3vL+Ue08zwDFg8fTm6HAAOr
         yGnAqrEgW1vWJEFMFk/vGuEIfk5UwLrrczS/a8Mbcykx5wpA8WZAu9H+2CkYZ4Pt+40J
         tj5sd3IOD77GufZ9Pmq9hHNyhXXeHeblijldUy/rMDCLXxKZh5TvjcVim5dmD4x8ysE8
         WCoyhuLwoPpuX4FrKSZseVAuV6D42Y4KG8O95SITnA7lb5d7hC6cOh74m01ccoSFvq2h
         FMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081511; x=1790686311;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=z4v1mfprMdlXunCOEH+NF1SaTANULAmgswzP2EKIPZY=;
        b=14BUVo58ddGrFMfQUtmOuNeq14z4p+BM6OxHcJ7nW1sr+50CcNZNbbd+eRgijTIviP
         vLMDX7PG2ipDSqKSrilCPyomRFtiBSz1DA7mkw8C7WITjBLz0LO1dlCTn3xYiiHJ/53C
         o0XJ7S+Nnt0X/9CgnZIGmop/U9Wz7TqlOQVa0bntxFRK50sZHgYybBVcj1BPV48vT7/k
         Ghd0YGIDgsI/hT6iZeidPK2x26NxRvp1AMhzzQHnulIrvI2RPQKQuSX6VAHrqT2/nKsZ
         lXcu74ZQOUrIlW345s+K0ApHV4Wql05AKSZTOjI7viZq/f8l5EWrGqcDI2jeFweIVSK6
         88VA==
X-Gm-Message-State: AFuF++lyf0QBABCm41Tqz0ImJ17mWvWlyIiSkTtNv+BYobywXzZjzbDd
	K81HHJfHw0gQhFDPeHzAmqXEBk0LjMj40yUss8FFuXovVrmE4gyc4SJ826Av0cQzMDZE19CST7l
	5IowfS6JLa7gNBYegKbPUP/1XpmHXNj0=
X-Gm-Gg: AYBFou3luE8fmJPu/Cg9BGDl4Mwq+NR0nXAIArQQoK2M7D4b5M8ib/O2py8f/luS3oP
	aAgXpqciBGt3QseaoWdyN4853Pk1fpLUT49wQ3pYvh4gy1V1R6pglCM/pSVs789y5ZDFYJf5jIO
	0kIx+ClxBhQhv57FIXM+u3JiMcfsyPeKhQpGje2Pe83xXSAPnTiZBxmPcp+QEB5XAcqKZ4C5MBv
	aB5VhG4Jvb2sG5Z0bOoho80kBRskaPjMpDy/2MFkLl7tNW/DSANh7cUAik76rd+VeX/EnLmHlku
	fI3NzZoKrZv8R0/wzf0rBDLdd/V8vwXy6SMmJufgaaT5tu6qcKAzx5UiZs9RqzpR0jh/6OBGSJc
	n5oMkvi/+lZuFVi4W0VjamtMTz5eWHTV2K829h+7/3TOdVTUdvK3e+oIUmGsHOizKn4RJqHhJV3
	+6yEURkELX
X-Received: by 2002:a17:902:f54f:b0:2dd:c0ff:e732 with SMTP id
 d9443c01a7336-2df60b9042bmr12078385ad.68.1790081511127; Tue, 22 Sep 2026
 05:51:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <782fe91251111fbb28359574d860e4a6d2e45fc0.1789853192.git.ben.knoble@gmail.com>
 <2551b801-4cb3-4880-ac01-7d14a188ddd4@gmail.com> <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
In-Reply-To: <CALnO6CDG4Emny7xESxN8GObaXb_P9gPHBZ857hrAvDjiMSqsKQ@mail.gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 22 Sep 2026 08:51:39 -0400
X-Gm-Features: AcwNN1XAyj4jiZWm-YSiNAXrKsyWTVBipG3LTnwvyYxzECQw-hB9YOtIMz0tgR8
Message-ID: <CALnO6CBbQToKU-mJdRXL=XsDGMQFD2qPswKDK8sjdf7b1jCLGA@mail.gmail.com>
Subject: Re: [PATCH 2/2] builtin/stash: merge index in-core
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, Taylor Blau <me@ttaylorr.com>, 
	Patrick Steinhardt <ps@pks.im>, Derrick Stolee <stolee@gmail.com>, Adam Johnson <me@adamj.eu>, 
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Victoria Dye <vdye@github.com>, 
	Elijah Newren <newren@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 8:43=E2=80=AFAM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
>
> Oh, but one other thing: we unconditionally reinit the merge options
> later on in do_apply_stash(). We could conditionally initialize there
> ("if (has_index)"), I suppose?

er, "!has_index" of course (which is what I originally typed and then,
confused, edited).

--=20
D. Ben Knoble
