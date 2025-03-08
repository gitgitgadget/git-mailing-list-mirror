Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D621DD529
	for <git@vger.kernel.org>; Sat,  8 Mar 2025 15:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741448505; cv=none; b=jJhwo9bDQTXaC1y/UqkqEVwC+nfgMwHji32qhfKoM5vfnPI4dy3eQUiDAvLITj2l/UWjGplImXutmQMN9yRVcTTt54oeWd8IJ3+GC70jhLWuP0zXXfxj7YvSxj4snmS3ImaF7073N6VXfIKBE1fO+BHDD0IPo34sD7h4SCNygrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741448505; c=relaxed/simple;
	bh=W8veAusDatFgvXxvavNeQjy3kEt1wsH3DRvpCPOsOZ4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=aPmVUVlKMg2TQhM+LXqNzsfr5YupSAekT70edFHQBPElM7PaDTai/Qvk6SNUggkUkyaF8rKGnA3SSFD+fM5Q+eDQtZa7iHF0aYA2seuBdgMu+ogobR7yJDzFkXDApEbFeMJuZTU5gvzMUlIUcsGHS0yDtILcMwXTC9ORW6gY9uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMlXG1j1; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMlXG1j1"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-474faf23fbeso35467541cf.2
        for <git@vger.kernel.org>; Sat, 08 Mar 2025 07:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741448501; x=1742053301; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W8veAusDatFgvXxvavNeQjy3kEt1wsH3DRvpCPOsOZ4=;
        b=OMlXG1j187HSjYkeGkfeMapZ7nYdifZBu22KZsQz7SIta9Bmmu065u4kQwv0jOiYuO
         V48Zw9XkLL8JYcQkaPPfVsGXF7F+h2BgvVGbkDlMJJdcIJXdPW9/7WPVaWi2BzYzL7/p
         FQoZch/NtIwW6SdwJnj8ZCMJqdPx2M5YW66OUdWbFR2n2+1YdD9zqeeeXOMgxXxJcEKN
         SkXptZhRkPwTTpAgkhzFyfcAO4uIKImV3e+PexBX3UZQvfm6htpG8U0bFnXW2zb0Ki9J
         3T4HEGbDl7zo0v6SWr/ObYOm8WWrV4TT32tPpSp9Cv7h8sjKSdV5hFGXSBxNg3fRJUhb
         qCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741448501; x=1742053301;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W8veAusDatFgvXxvavNeQjy3kEt1wsH3DRvpCPOsOZ4=;
        b=qXoQ8jpYL//gLi5A80RKhBXv42Bjd7GOAnsmw/5fuVTTWU8gTIWyylL1rPdF8iU1eG
         XVpeQ2civbaSWj0psGH/NLvuC+oUDXhlwlVHmEfFyd5PYpWCBIcroVyw+DsexMLd4F9W
         wRUtStXX02bHWNBhU6wIAos+D7uJARQk1MRnzQn+wsot/65c/+/+42jQgdNfJn+16YdP
         7iY56QOTvgmBxmISM1ulxfdYRvHK8ZQVwouqM50WTk/mqp5i7Sfgg7rhlwTEh6jeJHHA
         Ez8z/GsfuI0Lz+RarfwszNB83p2RCpYDdKpUm5xlAXInJMXUMpyXcxmwBB2vbxkaKPlo
         Z42Q==
X-Gm-Message-State: AOJu0Yxzy0AbaLnRcTNY6C3J6P5qG5dx4pzg3R95CRnIIWglU18dZIwb
	K7bUeJa8b+B9NQjRqEWxKjeKKw3tK3C4ncl/SpuvmT/mu+fVPWdnHZtqpiRz032RoePj3kyuiAo
	2r7Noy6eBziO3fVUwUUX/rpKGSNOAcXXbTqk=
X-Gm-Gg: ASbGncvbi/YnJYAS3hu/7CDtEvlA8hsWqHKmyN9kRioTeLRt5Au3WkNsG/b1aWnkDpe
	C3/KRisg71ulrFOLpT3sVvRPiR7UJ3+7rnVAy60uXGaoDhm+kESg83wyxyNWlBCU8iq4cURQ1K/
	01bgmD21u4VeJtpkfxPtp3o28FGeG0uhLo70nfrzoH4eXehzoBJp8oY/ra9SI=
X-Google-Smtp-Source: AGHT+IGpyCNbLkZLOP8kMc58nqFasR64lrls2UHauyBqb1ZnwFhRk1ZN6kRsQxt75i3aQcZNS+hFVdFmtIxIECvVql8=
X-Received: by 2002:a05:6214:19eb:b0:6e8:f133:3795 with SMTP id
 6a1803df08f44-6e9006751cfmr105080826d6.32.1741448501127; Sat, 08 Mar 2025
 07:41:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sat, 8 Mar 2025 21:11:30 +0530
X-Gm-Features: AQ5f1JoLOMG8AZCEHkl9ZZHfMRn4r4smNiVpAJG1wG-WoSi1DzwJsL-7TsZXono
Message-ID: <CA+rGoLc69R8qgbkYQiKoc2uweDwD10mxZXYFSY8xFs5eKSRVkA@mail.gmail.com>
Subject: [GSoC] Microproject: Updating Documentation
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hey Git community, I'm Jayatheerth (he/him) you can call me Jay.

I'm pretty new to open source and since I know C, Python, Rust and
Shell scripting and experience with Git, I wanted to contribute to Git
itself.
I always wanted to contribute to open source code as I use them on a
daily basis and I would love to stay even after GSOC...

So I had a question. I went through the documentation in Git source
code as I'm new to Git and I found that there were several outdated
elements and issues.

Since Git suggests starting with a small microproject I wanted to ask
for advice if updating MyFirstContribution.adoc would be a good micro
project or am I looking in the wrong way?

Thank you,
Jay
