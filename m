Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02C1A9F8C
	for <git@vger.kernel.org>; Tue, 23 Dec 2025 14:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766501095; cv=none; b=NPuhC+W3Mf90fg9+DYsVc9bcdaYnmQWdKsGqXAWZN7YsZ2mMWKhOMwtJRtCQ2l5o+iBCQuV9t8qPSDQXpW95fP6xRi/vQbSME0mj0nofdAaUBvHphACH/mUF2LkQjVAQYqWZL30078StlUJudL02NsA5P+HyBRxzler3Yb15H+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766501095; c=relaxed/simple;
	bh=ly+QEwRlbLeOJa4Ex3ZfgBWQXdypHxFccwyurVLRZps=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MjCjm6MtbX+siRkY1jGXUhmbT3DcJVDdgHoOH3l0wQPDLDFdrV383+4lHKfJOV90zpw1+2neN6EoWKnAWVQ3LjcedCC0C9+DfWqiD6oRl6Qo8u76zeCS9M5wdvNF/bVCc2KPxrbPy0qtzXNrXaRt4r+vc/MtQRl+94egesZrrik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5h73sZr; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5h73sZr"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bc09b3d3afeso2879666a12.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 06:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766501093; x=1767105893; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ly+QEwRlbLeOJa4Ex3ZfgBWQXdypHxFccwyurVLRZps=;
        b=K5h73sZrWziYDbiGIaCiqwwICPfHs/UZbOg3A28uc0E/h+Siyr4kZUIYAnmzYCHatC
         PjtS8893XtomRrRfO6p8eUpVXT4vVptuFZFodpIj4Ih4vwkuYGZP8DsRbyAGpNNW87o6
         Puqksj6WHV+Iadxls8grTbPzJ3/6c6GDgLLUf8OiXRz+h8gBXQuuXausIgZwk5p1iJ2L
         kgE2UC5YCU6prijos0/WLFREeOl+hoiApuhIPX67yvzpc32wmBUPeKX8K1H0tjUwR67i
         XWyuZt84db7MluGTBWSv2TzubTv0tM816JKf9Vgu2jYp0X17iWXq09qkYlpRbPMHtRvg
         n2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766501093; x=1767105893;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ly+QEwRlbLeOJa4Ex3ZfgBWQXdypHxFccwyurVLRZps=;
        b=VmgH0g8/g7TxZv0ygprISPvvOVb6bnAwhhJ0FySszxqPl0NqNGJ2OcpdVvs3LOeEqD
         bnE8p4EmtHSEwsM8lMRNp0+iRtRA1oPsUbNt4iG3+Cux82xu7oQvV3oAXQ8K+rO9XQey
         oGgF0cxinPvM5W2q0WbHZZ62gDGHle0rnkkHUwfmgjlc0OPc3/87xwrXbRtl/4CpudyH
         elS7+50VzLEuWFwnItCNQzqIUy9fVYW60MJqOYN23RQyggTyjDMpGNRtQ6S87ceuK7q2
         QvdWdU84nRynMlY2hUJ06SMITrNSR/K+pVbcxaWWp3sVwtlW1LATTV90T7+4uEVRmdkS
         gXaQ==
X-Gm-Message-State: AOJu0YxD1Gj9yCMdfxlRVpGF/54gVHTepPtevX8R7VYvBFGQOlfsk4QS
	/xZGwNutzqeJddZXBbrncY4Xu91VE0vEJv/dDV3R/b7WMR7uZ5ACUMAmJD5PdoFZc0mOqz45Xvg
	6Mhj/TgMCvSC4tiGPu/7ZV+eXYCjCOjYwBxTA
X-Gm-Gg: AY/fxX5kN4/CBGnQQngJWw5sz7D+dynFKItKqtKT6p3xvztGHL+GR03A/4RFuyiQbwa
	9MSUCHN0ynTk0JGT3w97BWCEEU0zp9mbkce+/e83GHvBm+0BCf9q4psNYXTBEgRuJp56BVEMeaw
	Idwv2sVxk+fz83cCkGMkc/uqzUFfFDQhIohHuehtM6tJz9F0puKO9FOzHONe4MItYddXZ3GxhSz
	PBIGzQTyuQ4Ol3FkaGP/NOQCaVsumjoy24sQx9JzxKskUsEc0H60Jg+kFa5lhFmN5J7eTopLvaL
	Vfmqbt/9ZKoAXicbY9jhAJwvamDeEWCWgpA9dGFLfqHANz1v6q0wInPkVNs4uA==
X-Google-Smtp-Source: AGHT+IFm2j4Ym/JDmFfZEr6eWWOgTPRBbRaNGvkXM6MDtPlj8rzBYQ961ssVxjYWz/5h58cKUxCYIWaCRgVZm3iObvs=
X-Received: by 2002:a05:693c:839b:10b0:2ae:5bb5:5732 with SMTP id
 5a478bee46e88-2b05ec6b69fmr11525061eec.29.1766501093225; Tue, 23 Dec 2025
 06:44:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Deveshi Dwivedi <deveshigurgaon@gmail.com>
Date: Tue, 23 Dec 2025 20:14:41 +0530
X-Gm-Features: AQt7F2qiFIZmVFLATUSLUe2dX2n6EleMW7mO3VWFsMzzwTbQY-PF0HGlV9-CYxo
Message-ID: <CAG7UgERJa8ktfetWty6A_0VL=s=yzfi-y0mLEta-NvQcd-0aDA@mail.gmail.com>
Subject: Introduction and interest in Git - Deveshi Dwivedi
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all,
I'm Deveshi Dwivedi, a fourth year Computer Science undergraduate from India.

I'm excited to be here and wanted to introduce myself. I've been
interested in open source for a few years now and have contributed to
a few organizations in the past. I'm currently exploring Git and would
really like to start contributing to it, particularly as I'm
interested in GSoC 2026.

I have been reading through the documentation and the "Hacking Git"
article to get familiar with the codebase. I have set up the
repository locally and run the test suite successfully. I am hoping to
start with some small contributions and learn along the way.

Looking forward to being part of the community.

Thanks,
Deveshi
