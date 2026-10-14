Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79482D5408
	for <git@vger.kernel.org>; Wed, 14 Oct 2026 12:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791980416; cv=pass; b=EMiCtG8uwwwZyIxKkkRDygFbzagmCOtDvkwZ/kMUW0IG7gllR9hN6aMrdogVPx7MBGFLYXeigASYUGc+VTRi0nBUMk6zdsQ9kJMJ5yk0M0fFLPtisjnfpzbO2DoO+rDnd+kt1XA2DKpbrsGLVaeK0KBKDkj3q6Y9eqIDV93AAys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791980416; c=relaxed/simple;
	bh=HVcCzzxHyOciFlVSGqZnnTbH1sMtVq7p4dqIcCUhmBA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=IsBywxncicLDWONmYMmBzEvuyJOdNNEPowZ428fMNaULdD5V0f44VSAkKlrz9rP4CbujjkV5KOkv85jZcjwkrQ4RAogrFz08XKFky+dedAOGNm6gqK8RIIZMHYoz4YDOSFfQCktP55fIWSDAMxV+8V0JpXcL6QnFdYkEQ9Pdgg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KMKLZdJd; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KMKLZdJd"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5339199d8c3so39542671cf.0
        for <git@vger.kernel.org>; Wed, 14 Oct 2026 05:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791980414; cv=none;
        d=google.com; s=arc-20260327;
        b=TRaUErDP7njr2P0V5WUUNf26T2s16BLH2ZnlXqqrQ8wE274QZZHKJNZdV1K47pRv9b
         rzdur1DAKozS3WZVI51vkiApWsXk/jQrRNQJuYuW9nngZ/8XMc3te3LwnV2wDXCViVrQ
         l+291Pcr+Bh2kfL8f9D3CXR9p6ReHe5px16ZjZsYsNDA9OIn2JAdCP1u/YAo4I7da3wR
         quhVZhMVm6HkDQ6r9Tx8y2sKqe3nuuoDw1cVO+Xe0NAG+IpkUFJl2RstU86rq5dFh1zS
         VMvwl+6JtTUcFTBXB7CMPIQrwtTUr6EkHEOv2zUVYNB1j/OpgnolxhSKfP5TLbxcf8/B
         RVwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=CqtvaeNco7UaZj7lwmmvVxfimjeIrQ5efBzLWV1joJQ=;
        fh=fpbQs9W+mB8JySTcnA9R9isVrERO2u0pIfUTdvgNFcU=;
        b=DgUqPgkM5BcN3wFCMHt7lh0uOkGY4YiItBhMlSI+2cXMBORTQmQdFXSi4aJ+vA0mIQ
         7SUeAhFlyaeORU1Fi8gJ4IbC8iYNG1J2oYzo/9ltLLTnQl11SKb4/5TIKlxf+N6yd4MH
         W1p8i8W9QkMqoD4lZhJmX8DWhgU2tHagT/s74xG6Ga3xxNnj2eLnosi76lmjvl3gEOCG
         w0aPVoImY3938OePb8d2A626Sx58gxjLDzVy7D4JZ2vu4j0lGpyo/ojO2EKxJI8dwVEk
         CfQplHWsFfut23thjEmeEeKIf86TvPMWe8DGSdVEIFEs76m9MXPCCIpB1SdwKsdIUWam
         TDig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791980414; x=1792585214; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CqtvaeNco7UaZj7lwmmvVxfimjeIrQ5efBzLWV1joJQ=;
        b=KMKLZdJdi+zHSOOZH6/qY8tS0PXdZljXgY06xr/waeyW4M6373ZLf83w20ezLYc4I1
         N3A8XOmTf5VxF4AtR46OqG8amkcBBUZTTSD1siKC8OmTkFA0aAsSmuVwNEBQ4oDwMpw4
         IxHa4zhFolwWLVZPgqIp2MqaYKbnvVy7JgXXK2rGgZTxK2W7UlQQYvWCYSnZUiOTOK+I
         YS8CYSjdS7yGy+rojDxSeXRBhLFWSlm1SlHWK7leCRxz3urbGjuBmr5pYcLj0eOLstM+
         pPgvZSp969Y8ncvsI70xc/gXXayr28Y+RkZ8TsePrF5YUzkIA00tlBTiWz8xYUtAxIp6
         6hpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791980414; x=1792585214;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=CqtvaeNco7UaZj7lwmmvVxfimjeIrQ5efBzLWV1joJQ=;
        b=NUfKizS3GibByn+vqSKq+JLe7v86tuyC8Ye1zqiRGzI80rxQUK2i9hECkbPEkGRFIH
         12f0D/7rxA7ja8YOlUp401PRCpYhxJm02ycJY0Ovt4gX6acIH/xEsHQ1H9H40fyOt0e4
         UiUqaIffHUdpiHU5gQs87pQtPrRn+w7fnj2YweSsLoyNo0jdZL0v5ggZ1xCzU/35ha+3
         3nNd8p5VVg+bedAwEqpLRXSszd6y/kUb9mFPoJonBfRcvhnbZVzhBkIdXhuAwgeIAHmN
         jMTJC4xto85dRSiXkZzhRMMuncS4FSq2itwsQxhOg2lCuF53w40qy9kW46BdkHpVijv2
         89Gw==
X-Gm-Message-State: AFq9FYKfKFFj1BV4vkwjF7AA28c8Ig30HoUNNxtcWVkA7RYSR1G+oF5h
	Tr7STKUbfjba+UZrG+nwKaBL3e8Xzkh2H5sEj5opiG0oQYj+zXhpMXN5RZW4eITiXsn/fzJC4Yy
	ePIjbgOV8Wk3UPxgQYVMC0fBO1eDyg7qfwOd4k79oyVmMZ/R9wQ==
X-Gm-Gg: AYBFou3WRuG7kX6IPqEakEg2JdVdl/6l4W+hKNonFsDdkphVNs3y6lG7TG8CfPFx9Yq
	72BzKnVB3CVBAj26haalzFMnhzxwJdPCsCTIkESOvqXQt93DMe7TrhEZugwoK5P7Q/MDjrVaVFD
	vDSwPt8Fu6pl067fjGe7HGDvoEccj1jzblYBWnAD4UGVA9YnIDCqThlpSwE2nc4Wknx+/50uneg
	DBZgQZ9TcVnT0u0c1AWWHKq4MzSYdUpymGROsDqF67LVPVe+fL/hITPzFB1nNjWHdDOqEmLsIoY
	OmeKsk3T8Q9aAt9WHiWSagbp8lDillv3r3k1jT78frlnEMwh8YGwGJSQNCGusm82PFlsXzjiByi
	j5VeUy+dvq7n6c5CVc6FFbrGhBiJQxyBGfTs1ONiOCgBlG0chwtTFredYGwYrlkLiJ9ZfYg==
X-Received: by 2002:a05:622a:22c5:10b0:535:fc2d:b7c2 with SMTP id
 d75a77b69052e-535fc2dba9emr30252511cf.33.1791980413474; Wed, 14 Oct 2026
 05:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Wasswa Edson <edsonwasswa54@gmail.com>
Date: Wed, 14 Oct 2026 15:19:59 +0300
X-Gm-Features: AclHuK_prapPLb0SVE-btKbWKK8Ki9b3Q7hIftihKc6UZ0GaPmJXhk4LvD34-0Y
Message-ID: <CA+ew3JuatNJ_bQkormLgm2O1DVQ4ZBTXnXnJPjOMcfcKZZ+Ang@mail.gmail.com>
Subject: : Interested in "Implementing promisor remote fetch ordering" as
 Outreachy Internship
To: git@vger.kernel.org
Cc: kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I'm Edson Wasswa, an Outreachy applicant for the December 2026
round. I'd like to work on the "Implementation of promisor remote fetch
ordering" project mentored by Kaartic during this Internship Cohort.

I am a second year technology enthusiast student pursuing a Software
engineering Degree with an interest in C Programming and Shell usage .
I have more that enough exposure  in this language  from both Open
source contributions and  personal projects. I also happen to be one
of the contributors on the OpenMRS Distro where I have utilized Shell.

I am more that happy to be part of this profound work and ready to
take on the skills while I learn and from the Community. I am a fast
learner who loves innovation and science.

I will be glad if I am added or invited to the communication channel
for introduction and Open questions.

I am just a text away from starting my journey to learn and meaningful
solutions to substantial issues

Thanks,
Edson Wasswa
