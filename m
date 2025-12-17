Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A13F29B8E8
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 19:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766001075; cv=none; b=m4LyfUJ3bCb1wVkuS4BFCW+v6wNzdj8VytO4Gx4sUH61xURWWPKK22uzXArm6Z4/YOp96JHxez32fohlzZe6NyK8l3gTyTql1GnMwBK99HDgy/Wwwx0WOLVwe7yDK1g04VF/kV8X0DgnYmLsK+pyersVhHb62FSCcc9KBsW2dTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766001075; c=relaxed/simple;
	bh=A2oV+chm+2/TcTqGCejy3W2JM0KjxYlZKLf+1cJg3X0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=aokpAo8an7vJLjop7+qt9Ay/gKQdsgkod7ZH2S/svv0Uy7LnGQNzIIt49NARTCGSfJQt9RZwAcljnKCd1Li4SnDWELutFUV133rzRKey/qrEsQICBrT9evoYtNoV324QZqtqPrCsbxQeWW5wgyfbqe7mxTvlrnXZl1NvBbnpdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQ+nRPEX; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQ+nRPEX"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4775dbde730so6226265e9.3
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 11:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766001072; x=1766605872; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VWX4ktzng5EN1bqsSd20PePAVu7FdLnU486/jP0iRlU=;
        b=aQ+nRPEXmfqlwP+vB5CacN/r66pC+QLli59tWgoxNdbBnh/7cdcKEATpboUklWz3Sx
         1fLrxIE114tD5zbfBlAYDoyaWnv9LUlBB131YPfJzw5oRu9HL3Y9BRXZoJH8OCMySYlp
         EzrF1wa6WE5JNgyk9wX6lbSxmVLaYp9Z92g0a/49wboKalE7kGPc2AvbfLwBDl4md+fz
         kNwhHiIpobkVlob8MbNx8394e+IsCUhvICL+TpKXG9LvDo6hfiIFVI1Gp4t+0ObfBKKC
         CPQ+DtTvsrf0uz84Dj5fRuOyIPc+R6y0Ayz2yp7U0+xNdqWH6eAWYzgTcK4Dfl+IRY0K
         9o2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766001072; x=1766605872;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VWX4ktzng5EN1bqsSd20PePAVu7FdLnU486/jP0iRlU=;
        b=uQALeSDnC1kIvhA0Tq1CAexS0VGASK4wp6gIsNobD/hmTf3QRwv3ltPCHzjPwiGKLC
         tklaGpzf9oUWmBcHCknf7cTSjB6+m6xbS9z+xKK28oF6dafcL1QQi7MJi6uf3hmB0Qhe
         sCiwk7MpHzQ93QzXtPjutDCZ9InmAA2qCmN97n7EtDy7oLKPcaxu3aYdahSwqJb2/ATM
         ZZFjO7sfcdnbKPxUNY73hUqluo+Eu9HZjqRdulg+9ty4mnC9WgTQEdIjAs/QPWXPjCvp
         tZSRMn+jXFylDAm1JKNT4HYMrW+tyX2inB0Mh9dmkTxISnHSYqbWvhNbfc/f+pDop2pU
         pjDw==
X-Gm-Message-State: AOJu0YwRBhG2ejRO4FaQ/010O2cEokDPXHRo8JqRwmxpBsJULuOhBeJ/
	aDfvqQaaQ0yhKosbbd5ONWgKNAy4YA/bJYAZUy28rhgSxuAu8jLeRatikokOrtaP
X-Gm-Gg: AY/fxX7qKSxMH/tw/Jg5G8dk4VE3HaPT5KzL1bRtjMUZ6+nPsOMKB6ogWdZjuSO2udd
	jclc5BSV7X99e/26L0ja5qwlZhYLlMq7VFEmfQC+H55AI7bL/OC+0lN+FPfKgx35F1PN/zrrUu4
	K1QU/tt1uV+dH3amuhqit10kdAXKfSaO1hpRytTU6WxEIOx56nM4iZ84il8OUifDk0SuLPlCFUm
	OQ0Obvb6rR98dKzhT7WsXZ945KmUwfEIcM/OViinuZAqMdb2+QPBu0AbuJN0TFyb0nYPYRmbL0O
	U9wEi42iMVkxVLOU6hKE5KuHXwTBpD3jQZbRXQ3yaLcZxfzU08R3U8s1jvxotQU0J40phUxNrB+
	coUp8tksvcI7qEEv2+uR8SiAk7WfHcSxTj+3ry730aF164HQJntyO4yYXnz96sPQaCv3Yo+fcpd
	Hhvlg/y4hZl2QmCQ==
X-Google-Smtp-Source: AGHT+IE2pnc0LT1IiEEJKZWx4wytXEWGEjqyf9J8u6B6vohw108Vf2NGu6B8SyJtWkTo3N1OKUCSdQ==
X-Received: by 2002:a05:6000:2909:b0:429:cf2b:cb0a with SMTP id ffacd0b85a97d-42fb44c47f8mr11108869f8f.2.1766001072160;
        Wed, 17 Dec 2025 11:51:12 -0800 (PST)
Received: from desktop ([194.127.199.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43244934b09sm696897f8f.9.2025.12.17.11.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 11:51:11 -0800 (PST)
Date: Wed, 17 Dec 2025 19:51:10 +0000
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Cc: Matthew Hughes <matthewhughes934@gmail.com>
Subject: [PATCH] docs: note the type of core.attributesfile
Message-ID: <20251217195050.24837-1-matthewhughes934@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The previous wording:

> Path expansions are made the same way as for `core.excludesFile`.

required one to check the docs for 'core.excludesFile' and from there
the definition of the pathname variable type to understand the path
expansion behaviour of this variable. Instead, just link directly to the
pathname type.

This change is basically the same rewording as was done to
'core.excludesFile' in dca83abde2 (config: describe 'pathname' value
type).
---
 Documentation/config/core.adoc | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/config/core.adoc b/Documentation/config/core.adoc
index 01202da7cd..9bc9de29d9 100644
--- a/Documentation/config/core.adoc
+++ b/Documentation/config/core.adoc
@@ -492,10 +492,9 @@ core.askPass::
 	command-line argument and write the password on its STDOUT.
 
 core.attributesFile::
-	In addition to `.gitattributes` (per-directory) and
-	`.git/info/attributes`, Git looks into this file for attributes
-	(see linkgit:gitattributes[5]). Path expansions are made the same
-	way as for `core.excludesFile`. Its default value is
+	Specifies the pathname to the file that contains attributes (see
+	linkgit:gitattributes[5]), in addition to `.gitattributes` (per-directory)
+	and `.git/info/attributes`. Its default value is
 	`$XDG_CONFIG_HOME/git/attributes`. If `$XDG_CONFIG_HOME` is either not
 	set or empty, `$HOME/.config/git/attributes` is used instead.
 
-- 
2.52.0

