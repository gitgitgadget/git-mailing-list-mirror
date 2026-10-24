Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792879221;
	b=zx6bfMTyqgPy1BaLZuI5bXnfkxZPyykp6Vk39iWslPTaJ2Si/624kyQYea9nZ94PkEZY
	 6Nc0QxmMIrgIGEu8ZmGCcy7ChsDT5fAx2Blznp0uKzlWk31EovMEL6Tq/LglPt/rmZKVL
	 WY/diAclSZtUOtau5lDdUb5sTYEBE1CgdWbSoBvI14FTOJDnjXQlj6pfuDftOfOa4rOrf
	 njvasCQh2YmyRh2uLmbafEwOyzh9vljypZbJ3uiPYpCs69OBkBiqmxyL9FJQXP86EI7E5
	 NA3ldnHQLttlOjl6Y47cAkc5dmXBO+wehvka4/O/efXbsqULTclpDIMu3tjhigde7Bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792879221;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=U4WdvLGayqddEoc/2tSeOSmz1mRq+uO7WeCiwt4eZuc=;
	b=Qm0bqRZjont7DX/SMq+j6d6SMoH4HRv9rs08aTsRa+tJHrgctOU6HMzQ7suGA1HVyCT5
	 L5vt1QABtQvdE1lU0eV7qbVzrecmiSzcEbEU4WJmGcwVRGjWdRrAVPOjD7+yVGjSBwm3I
	 XFcYuGYV9Yzo+j34BYf128QXRHw+K0AnoFCgADKapYVQJWwjK5nWsxmWuUl0C1Rxu0J9h
	 EMmk4iIk8MmDTg0hB8FvAE/i6hGOy3iNS0k4rF+uZCGsV/vLJwbpe+MCL3GuvaUTptJcT
	 rVYjO26FWDw6K02hiM21rmiBjkLMO3ii2QaGg9LYxXUoNVmf0k+gyhpTtfkqDFMGwdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P8CECPqb;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F890606A31D
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 22:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F890606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P8CECPqb
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-181516de561so1216402c88.1
        for <git@vger.kernel.org>; Sat, 24 Oct 2026 15:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792879220; x=1793484020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4WdvLGayqddEoc/2tSeOSmz1mRq+uO7WeCiwt4eZuc=;
        b=P8CECPqb4xr1bmxf+E7uY62txfpX8j1dXGCNCXoVv3VRYlcOXQDzlsZ3vToSxp4e8T
         zhQJrMZ5XnVdbDQ9gkxb4NxemkjBLyiQkSgFWbHKmHWQnY2C9L6Wb4JY2S30i5u61UDp
         /1C1jB/Q1bcJGV7ZvOp0hzjV7aiF7TG3Rk896A5iTZ2RCrXGhwBkFXfoD3eypJLGG+Dn
         pcsJ9wYN5Moa2S1mZvj+COaQqmY25I5WyVDiS0i4szhWqRN3F8gsFoydZxOxJ0MdqcLb
         ymSvKhVJbdAV0CIm6STA5MvwxExGoZ125hFRxnstt9fRwtgAMRqZz8lLldjqrnfp0Qpr
         1CuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792879220; x=1793484020;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4WdvLGayqddEoc/2tSeOSmz1mRq+uO7WeCiwt4eZuc=;
        b=e0xHi3VLFgJywUA4gmc19IW7V/j+wpmq4PG4sItu/3sumU5+rwWJWNnW02g8ueu8ib
         7O1AMjbwkGo2fXVAS/tHxk3JQzWGtQEe9B+jVFvQdOJCXiivoabMjG88RJYxAk5LEWlP
         OWTCIE/3ct3xWIm6tIs7zCb2Htxdj72GWfb6rbLcCEA9dSmFx1MTCzuFpz+2NjdsN7WV
         ibnw4BmpJaJlsMXPI37O4tU4v3lcWnjgVE08g+nlWqnoFt4ToON0WBmsrcI/igLmpTlU
         tBotVCPSzoaz144YZ6sli82mM4cJ6J8H4YS4rwrIrPlv/avzzU2d6UBdp6h8Y8R7rpAX
         JmWQ==
X-Gm-Message-State: AFq9FYLkRcp5XGQNkrhEuxb6tIkPICZqU9RwcnapVUEje0VL8GnB4uG5
	w7e+KKkgpDr1z2RiDco68IoHX74aUQ4VdjZp9fLYwF451BGotrv9Sdd3ORjHlA1/18I=
X-Gm-Gg: AYBFou0iVUdbo4fYGdSkHiJ34/LFdBAP83wYmnr4x+Lcd4sWNTJCOuEuqC9+tT1nQ47
	y7DHFIyTDU/YIknIUctXQcyplT5zagYPtTtKT9Fyxl6ekByRg6RsOfkIricCBr7S658Zq7QRj31
	iX91vOMct8X9ipEZENfM1xPWYcAo/nD1r3d6JVG1HC7WkQ6gt6M5TU0DmjdvNfbThOvVOVx9GA0
	nJkvNUFa97MUFdXxwMdSIbftW6kUA7OJJkE2KYKwyW8Qo9scPtFlYlooI8oQwo6nc4/W0JEVaHr
	oQ9QfSxUTBRmwsHsusbbNXpWDG1Xk66gumAOlGsez3UZJmRtemUgPL/ERmPBfpXa9kO0+GXL4GN
	zzcFK6iASOZl0U1lQbAMDZMx67tCyMXvXIll90KQotDmGhbLmB02B+FdwXEnKS9TU+JtXSVYz1w
	hDoXhKYlZ/m3TZXucNJ0wDUMw9rLayMfBenksUN8nQG3L2tgs9HXDd3fnO+jv8PWWCNw4LQRBLK
	E02NXN+2XIGurmJJ9cRAikUC2NoggFSMRu7XDT1rks37g2vBz1D6DKH82E0eNLpmmy0NYhdZZKy
	nMKupm0Wi03ylHNwtIiau50WVQ9M6WZR5KAVOuWeJA==
X-Received: by 2002:a05:7022:51e:b0:14e:d0ba:75af with SMTP id a92af1059eb24-1994d8b728amr5675347c88.6.1792879219484;
        Sat, 24 Oct 2026 15:00:19 -0700 (PDT)
Received: from LAPTOP-PVRSMPQK.iiitd.edu.in ([103.25.231.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a0f81ea9sm11578875c88.11.2026.10.24.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 15:00:18 -0700 (PDT)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	cat@malon.dev,
	belkid98@gmail.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH 0/4] environment: move line ending config variables into repo_config_values
Date: Sat, 24 Oct 2026 22:00:08 +0000
Message-ID: <20261024220012.486-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.56.0.240.gf97865f162
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series moves the global variables behind core.autocrlf, core.eol
and core.safecrlf into 'struct repo_config_values' to continue the
libification effort.

The first patch passes 'repo' to the working tree conversion
functions which need it to read the values. The other three move one
variable each just like the earlier conversions.

An alternative to passing 'repo' would be to store the resolved values
in 'struct conv_attrs'. I went with passing it since that is what the
earlier conversions did, but I can change it if you prefer.

Aniket Gupta (4):
  convert: pass 'repo' to the working tree conversion functions
  environment: move auto_crlf into repo_config_values
  environment: move core_eol into repo_config_values
  environment: move global_conv_flags_eol into repo_config_values

 combine-diff.c      |   4 +-
 convert.c           | 107 +++++++++++++++++++++++++++++++-------------
 convert.h           |  60 +++++++------------------
 diff.c              |   2 +-
 entry.c             |  16 ++++---
 environment.c       |  43 +++++++++++++-----
 environment.h       |  26 +++++++++++
 object-file.c       |  11 +++--
 parallel-checkout.c |   8 ++--
 9 files changed, 177 insertions(+), 100 deletions(-)

-- 
2.43.0

