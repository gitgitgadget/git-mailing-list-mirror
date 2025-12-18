Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F61330E0F9
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766083691; cv=none; b=BZ0/Oelx2YmkPS+EkYALgi5wJs2L7Odfg+icoCJS116QDfU0o/FyVyM8fPVXcCRfE3GxtH8puKTN8NSe+/m1Dz7K9jOL3TPUJpg9GWN7pL598p4CEWNJykD1ozwnoNMwCdulOh7KoW0hMKfck2ML3bKGUiUZZ4pbJPjTGCgVAa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766083691; c=relaxed/simple;
	bh=YkucWDV3aLfVDh8D9PKGJKl2RsVpyb7O5QpJeKMH7LQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=dY5BZnIl4ga3AUTMn+ITq3vxH4ppEg6HRQB5EgBbi1uigHbwjr1fCoDTg+LPTU3WLek14i0N4gXpB/WOLXJmmictXSU3wDqKsWHNPz4Lwz3bBCDbc8UvP7cO37CL8ly2d1SsMAYDrIDC7lFc0GQd8fsUEDOWBR7oFJ2xTrr5bx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m8AvE+Qp; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m8AvE+Qp"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47797676c62so1323935e9.1
        for <git@vger.kernel.org>; Thu, 18 Dec 2025 10:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766083688; x=1766688488; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVaFnHRqtP3BZXqwkTdOGE2mGdwL7TyhSyjPYG1RNYg=;
        b=m8AvE+QpGWralYUYjq5yqDvB/Ppr8O4qWjoTox8pLxF0Id3hHqvV4yRL8e5uLqqQkZ
         U3iN5BqnoVjrQyz2aJJ/2frUoBJlTOt072s3N/RPFgmhG1dMCjUxDE7EeO+MuOBzxdAc
         +CVOqWle9p0LWHjRNVGAn/NOsiNG385cCBuTPLa1ZmT+mk/Uws1IQyP6e4XrUfHMtH+N
         GGwl5DiPWq5yJTHSAHAcyPw81MBSIxGGPhBJn/LE/7rMH6y0ANNPFdyyFMYdJAFPh7jC
         JSqQGfQPGgWTnYmCAOSrqcgiRZ3iGJvXbJ64Srj2pE1Wn2o0S6qC308HfJAKsC86nIEQ
         zggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766083688; x=1766688488;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVaFnHRqtP3BZXqwkTdOGE2mGdwL7TyhSyjPYG1RNYg=;
        b=mZrq7bkIhvbR9sEBlQ0+By4ZleWclG0DakRvX5qcWPh84G7634GGYYNj260KCRvAOr
         SiRZcQ6X4Vhgg2mZafiuws6PB61Xkp39hxtHm/lEd2MByMxfjnzAte4RPoLWbG3GOaTc
         HNG4ACaShWw6Ml1za60U4LFL3NO5YZiawaxShrLRWleFIWAMgPH+hB6U6u+xaU8Hi3sB
         rcEoV0LaCKnou0IY+2qaUZFW7+Wbz3XOTHcIK/E2kd/JY80XVGUW+ICs+SiiVyIqNQ8m
         hZs/NpHUQjyCRYb+ZMly/MwuvJucefN/v6+juCvEtqMsmnaJOs+UUDWoWbGjnBO16vCy
         tEIg==
X-Gm-Message-State: AOJu0Yyok8LJ/on/NvRkeyhwfPR2puFyYrViNu1r9hsiLTjLComfFCSP
	qt3weYlwRmSfu07TYgtmJHIptEbSkrv4uGsybNpTQ9YouoZGOVXK0R6iXy2QAi2q
X-Gm-Gg: AY/fxX54s5BjPWOlJEhmwSBPqHnll71y568QgYeIUGxVoY+EX+GePii0h2PzobdgHkf
	WhvDsBvk/BA0DIn/bEMtc4nNXYRZwpBreej+nfPHk03b+DIKbNNM5qDuYVezpQfnOgr29N/8Xil
	NpKASqcUHMg694bK1puku0VjCXSOPs1jvN4kkkjY77m9xP+EkXDw1w7G+qv8S9OKgCSF9T8io47
	GB3iMt1YnUFiF5oQOoDqQ9XX8KoLovpKSIUHQpCEXeR1Isxzz52my4HYuIAcXNLy9e1+eW0elKf
	IKPT5skRtFYX9V5O0YOBKZV+Q86LwvGkV9j9O0Lnw0ls5yUkKmCYbfiPChq4FOloB8Kte3w8PbK
	LcIa5VD0OL2GtWdeUUzErNg4dnhwTPyL1oI37JZoYZ5FHi/RB1OiK5JCP5Zm+UK8AnGs+m2jzn5
	jqf9ASIxK3jEgPwUs=
X-Google-Smtp-Source: AGHT+IHlZyWMd9dzmcbwxeUlQtqoT4QS+x3jMbZ4U0EdKVCePB5+yz58bnK3d5xKT/plTDrbCtDZ4w==
X-Received: by 2002:a05:600c:4fc6:b0:47a:94fc:d063 with SMTP id 5b1f17b1804b1-47d19538e2cmr1500905e9.1.1766083688174;
        Thu, 18 Dec 2025 10:48:08 -0800 (PST)
Received: from desktop ([194.127.199.104])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa46c0sm308201f8f.34.2025.12.18.10.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 10:48:07 -0800 (PST)
Date: Thu, 18 Dec 2025 18:48:07 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [RFC PATCH 0/1] maintenance: add config option for config-file
Message-ID: <20251218184751.31209-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A feature request I'm submitting as an RFC since it was about the same
effort to write the code to describe the behaviour I was wanting.

An actual patch for the feature would involve some docs etc., but first
I just wanted to see if the feature seemed reasonable.

Matthew Hughes (1):
  maintenance: add config option for config-file

 builtin/gc.c           |  8 ++++++++
 t/t7900-maintenance.sh | 13 +++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.52.0

