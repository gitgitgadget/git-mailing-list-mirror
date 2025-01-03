Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1964B2E406
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904044; cv=none; b=Qiaq6b32FIo4zCrwUoTmShumf1YIsmNnIDponIh4B1SbzH7VuzaKCm7ZEWL4GS5xkhbDKjKOwZFuigrc1uM8aJua59cg0QumpCUJz6FkjNSYj1qnPjABx7xD7db7mLqPAfKzHX2UE6zLlV4qSDu37UFUfvmzFAUEnN9Gp6BhsKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904044; c=relaxed/simple;
	bh=rJNjjtgNO/cdrNXWE6uoL6YRU0xhotEghugtPsPWNDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PjhLUc9hFqmj/XcsKxtjj6MEzOgVsnX6liuZu1qWXmszxDIRmX9DrVT2WpUG0wrGY3vdq6MSBG3+d5d4qj/QIQa5oFCaTAaW3boJmFvt5YkmOLVaFz8hF0S5n2M8kkbANJ7B2XXF+oFDykaTzD0dB5Yo/FkOaKFYfMZSVfjPM7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQhbbyK2; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQhbbyK2"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-303489e8775so139110351fa.3
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 03:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735904040; x=1736508840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wLK9Zokdk6wHWk9uSFgPyFv2o41p7Nr6agxUE3Jx98c=;
        b=JQhbbyK2eaAolkrl1kjf+BO0R2otujPeNwCu3diTbAjqDGi7F+iUnkI3K5qPzXYUJG
         DqlcQI2fRygZqErwsyJsMmtCOIenilLP5OhQNgUHRNXc2omjh4NebJ6HHIJe3mrtFMur
         /pdh37rPCm9nKZ2SjbNav+TqNgiwdUEgcFIIFHR27ENEnnMSdV3UZ8wz7PGq9btvx6X2
         bN5cjjpfFQ37X/bWh+YEjWejevvaG6OmxJMXo70Tps385OhK4zVlX2CbbzgJKdAHLYcU
         qrld5pIk4sO2xHO2/Dcmz1TjeKFVT6scF0d8cURSvJCS8IRXz8IGPd1Zq1mKv5ewLEQm
         MehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904040; x=1736508840;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wLK9Zokdk6wHWk9uSFgPyFv2o41p7Nr6agxUE3Jx98c=;
        b=FlgaOhCzWKkNLxPdupcnk17+UTQ74c5E/tJ3l3cS5AYxvpaSx7VINkpQyIMkw2Pdb4
         fXJghjtVF/ffC3NadQSo6XhawM22ukqduB2vQAUrSoi1ZuKnGrftJI64jLOlWacB6UY6
         hs0v/NPEKJyDoEMrtlbam5EWpCaQ15Oh19++/XXUBIhgaVubR1ipVwTGCA8R2y3aj6fD
         0zS+UQS5e+BHmFOc2I0vPAXbnVjmG6rrLDPH29JeetOSl0tjGsAmeFCApNDzo4jW/tfT
         TtBtKCTzppX+0gE5kf/IyhbJsHH9n5vVlECjzXTyLIVfaS6cchVxSdJ98i1PRpF/ktfT
         m4ug==
X-Gm-Message-State: AOJu0YzGPF8ROFt6P5Ulx16zDLv6Ppc759T1qgQzKOngxjcifDoCJ9I/
	PYVEsij3sApAJCIRSV57+h+1XFuIWyluKhx4To+4oeCfC70/Irv6FCZ27g==
X-Gm-Gg: ASbGncuBvjc/hfQopylFBXVReXz+fLTb0OsM3xipqN6pBIG2/cVkKD8OpcgQqrv1pOT
	/LiWYLw0yjko2/Ctx1kY34n4/aPzb7J6i8NyMUO2a51gnDiER5gT4/BVKljO5n0nfoNHrhN3vls
	taCgt6rgH5qMXLEG1Dy7RqRRvBgs1uGDVv0gK7mMdv3RZ39pPMOctTzs+pdTZ+ks6lwZ70aVuJF
	rPH0df32jbkoq9Jht5tSVWLTAbO4p3+FQpbQJsmjQwMnhwtK1n9nMgs0y6gwhaEg6Fe4zrBxftk
	nkZVkrDge8pPmOgswerWLFdKgMxRXMA=
X-Google-Smtp-Source: AGHT+IF37ubkS+prC0Xh6ux1Ci03FWaVP0EvYFQyFGF+dILa6DTuUzwoZCK8QnRKm2Vux2bfbcq/Qw==
X-Received: by 2002:a05:651c:1a0c:b0:302:1b18:2c06 with SMTP id 38308e7fff4ca-3046856bc3dmr152407711fa.17.1735904040257;
        Fri, 03 Jan 2025 03:34:00 -0800 (PST)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad99d06sm49527951fa.34.2025.01.03.03.33.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:33:59 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Alejandro Barreto <alejandro.barreto@ni.com>
Subject: [PATCH 0/2] documentation fixes for 2.48.0
Date: Fri,  3 Jan 2025 12:33:29 +0100
Message-ID: <cover.1735903029.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc1.241.g6c04ab211c
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These two patches fix some misrenderings of the built documentation,
introduced during the 2.48 cycle. As usual, the exact current behaviors
(symptoms) differ a bit between AsciiDoc and Asciidoctor.

Martin

Martin Ågren (2):
  git.txt: fix heading line of tildes
  gitcli.txt: typeset pathnames as monospace

 Documentation/git.txt    | 2 +-
 Documentation/gitcli.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.48.0.rc1.241.g6c04ab211c

