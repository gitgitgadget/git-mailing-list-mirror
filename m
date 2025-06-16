Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE5A289E38
	for <git@vger.kernel.org>; Mon, 16 Jun 2025 19:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750102617; cv=none; b=h/7ChnNoiQQrBvif0Y2rLBhA8wLSnSU0xmBPewHRLQvXB031kHO2dxoBBQivNdDdHhXIJfRRngJXrfieQTh/hZfaLzmYJ5WMl0qnWxlItci+5Lms4rtRgS7lRbvoyldKXvLTKAYBOA4lJl1bzlK8ddlbDEAuAZuRIEEz+nokk2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750102617; c=relaxed/simple;
	bh=558QoRoWeKTbO8jPIo/Q8Qt5kWEBIAokHrYM0En/1wY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WfWvmawj2gC6AfY1fcqkdkzvz4Occ4TFOfOcxmjHPOo1JR2L5TF8FSuSaEryQjMM3bns+mcDlNZ7ayxRMR0sLVYViDz6VbmfXnGeHtxSN50DKbHi+120xqmHJU+K32d47z1C+eBwM1zAUGmK+U69gEFXrkkMWppWO7+50IPOx1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iH3BDPKJ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH3BDPKJ"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e733a6ff491so4503054276.2
        for <git@vger.kernel.org>; Mon, 16 Jun 2025 12:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750102615; x=1750707415; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=558QoRoWeKTbO8jPIo/Q8Qt5kWEBIAokHrYM0En/1wY=;
        b=iH3BDPKJYQ65Jlsobx9T531Hd0iiDVqMCdFQUXy+Pldtri3ucd8+EZ66N2eJPzG+li
         rUiTBilGJdJJ/WpURPe6cHH1emjcInV7HpPEprcHmO9706Jq4CTGcal2IZ2p0SUXIoEP
         dyHR6Ix2Qfr9uQh2EyOtW2+mlg2vWxLi9OTX0FxBkJg6gr16dPNd5fKA+HyBNe5flWcn
         VbDryBw3ej5GfHlYmMCLPHvTdQSrv1fA+mqvAISReKwWPCOCRWk1nLJ7SmvBhHxTEUvC
         RdtlGni7g4oK6+jlFpkifg8kN7mgJ6JzKgNmJt/Hs71yyXsVimiXFSQ5D30KxYWQmfcP
         xlpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750102615; x=1750707415;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=558QoRoWeKTbO8jPIo/Q8Qt5kWEBIAokHrYM0En/1wY=;
        b=lvzC1KwbU0pXqhIPo/bQRFRCNM3w2knygSMRDQpmRxtkF2kEYwOkDKBsNA5VlJdB0d
         vFgjZIptAR9AB80a2Rw2fPzcSo/rgCl9hXLmKQ0UUcHycwHFkCP9KJCGAWf8rTT6POwH
         hMxRB7EKEL/Y3AfBvgY/7sCuugN2Ldb06wzM1Wh12V3IDpvqnUwW3uPskkGpCwKl/FM8
         EfZPKHP+qUPPjbdFU+so/5Ywu+BLdau6gvKtvtQ3ETh9dAvIaO6T9oxpw+tUju/s8tFZ
         sUl4fMtWK7q3/W6dhJsXwo7QHW4F3CjNYZErWEMqh3Yn0hOq1UcyrFN8X7BEyYL3F0SF
         BZ9w==
X-Gm-Message-State: AOJu0Yx8kb3D463fHConjokrfhGq9/4axO84cf9VHSgr68ohHX5lH1k0
	3Fep6OrNOe8RwYqCJa56gWoXo46X0+l209ZYuwCWFiko/txwPilDTWQtw0QrE0yaBSZ0teMGb8a
	tFgcFDQffIp6/6QsA4Hcny0RPDHggFOAfdGdC32U=
X-Gm-Gg: ASbGncuNjQh5RBnS7IbVNCRpOV05hW17Q1365pwPyT+LSB4jcHfTJTGEXvb6HWTfExO
	PXSebE+lvukwfNElQXH8qb3h/4x0r8PaIVatim4AYm8nYmqACWjzJSWFLL+HfDgWxZsia1QxLQt
	9kgRLFR6otihHGG2IxgdezxdxD8LkszPx0bTDI4IFWT/rYBV0qqltWF7JQWL4H8IOMxqhy65KTT
	mh03GA0mO6Gf9Y=
X-Google-Smtp-Source: AGHT+IG/p5R50L/ZXp5SAB0awThomTdmCN3icuAWKlJW0Y5jtIrKdtmh9oT1LeP8faHC0bkfMWnStDmbMxmW/njZnEg=
X-Received: by 2002:a05:6902:1b85:b0:e81:a149:4560 with SMTP id
 3f1490d57ef6-e822acc590emr13922248276.11.1750102615291; Mon, 16 Jun 2025
 12:36:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Serdar Sanli <mserdarsanli@gmail.com>
Date: Mon, 16 Jun 2025 20:36:44 +0100
X-Gm-Features: AX0GCFsRJTLmnl9eZS-8jgYBISQaeWC_IBR3AlXhWGgoxJjTmVK6OVm9IXNKNRU
Message-ID: <CAM90XXeOic7c4FdWpjnqn2upcBmRQGRUFzR5vSeBP+=1cPErQQ@mail.gmail.com>
Subject: Bug: Paths are wrong when --work-tree is an ancestor path
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I have /tmp/dir1/foo.txt and /tmp/dir2/foo.txt and a repo at
/tmp/dir2/path/to/repo

From the repo if I do `git --work-tree /tmp/dir1 status` I see
`foo.txt` listed as an untracked file, as expected.
But if I do `git --work-tree /tmp/dir2 status`, I see
`../../../foo.txt` shown instead, rather than `foo.txt`.

Can't see anything relevant in worktree documentation, this looks like a bug?
