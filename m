Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86803AEF51
	for <git@vger.kernel.org>; Tue,  5 May 2026 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777963398; cv=none; b=oakB87x6pcVZYuI0IrDTGABg1fSY7z/WEiqgI6yJIcZHjsQZykrRcKDlHIWS3I+Bp0ECLlD24ZBb4t3d8TDi4Wvx+IX88JPzrcXL3xR6CHig8JxzScdfjzz+75gx0QFq0tjUoyio0xfLO7hn6nADC+a2wMdcsYhR88rhBcbOemE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777963398; c=relaxed/simple;
	bh=i8bFhd+l7MuVH8N48lwIMq+LcYjaZD2BLpO0sT9FnPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz5BEg88yVN+62PloaUF+RiekRDCiN4Nh0G93SI2pZwkLzIhopkh9TE7oQNHInFYSxamWDBcZhwauSnIYQZsQkYFWImGE6rVzRDn67zOusdM5awhwlu+gaHNYFpPxd8Vd7UKGP2A6LwxGAfeFS+7eMvj7o/Q4J1dL6b4E2VVLfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z45p2yRp; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z45p2yRp"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-44da2de25f3so1213329f8f.1
        for <git@vger.kernel.org>; Mon, 04 May 2026 23:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777963395; x=1778568195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i8bFhd+l7MuVH8N48lwIMq+LcYjaZD2BLpO0sT9FnPI=;
        b=Z45p2yRpGF/meLWMf8yBpbRH9S4Fgn+K2FhP3I+eY8VHnHpdGH3f47hp8eYt5DUPeO
         2d4xUNRHiSU8qJeRgqP5XnR9OeY1foaSKMzQ0rsRKRWJUPbrfZ7JRrwpCQJ0wBdarUPp
         77Ear6p4hwhdXWtwOHEmT+8r03xmDhFC6eazuy05GKWPH9aDFZi0n8UIHMq3VDAvsKBG
         WyPFwdlW5kh5G37dKhHsCRmY/l3c48MFuZQHRaOdDBVOyeRblCxwuliCoUSJxgUm5hDj
         h0oUKZPvA/jCWTcejmnGR501kc0h7/Gf/g6GN582MI+G1hp49AG5wnRN1odg5+B1xSFW
         G+DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777963395; x=1778568195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i8bFhd+l7MuVH8N48lwIMq+LcYjaZD2BLpO0sT9FnPI=;
        b=BaHZSUv7Sag0gfmUIdCG8D/PDsoMxQS3S599CJjbmt7p03qYIKaRcu3k1UaaBuQ3Tt
         WoSanbRQsdd0L1NsLfwOw8l0NSr9XOLyvsAJHbPdYNZAcfHn7RqmfOQwIOs8wBC4OpYF
         HzCWJwybX5mCIv9WiC06lGhoM0SMJcFGrMFKwFo93p8TZX4Dn2EECgvlnYrW4bvudutj
         /EnDXZY0HfGndgE1Ov6aQwTIOyFtulVeQR8bwG9DKlUYv7Cmaae5Tt+BK6lsCls07NAk
         a4ovUrWTePackP8168uQ7oLjfI+u3QeSWoo0P8QVreApnK4UkEy68og6koRVyxMU5ckt
         WI/A==
X-Gm-Message-State: AOJu0Yy8SUaVhp7kEr+vPSI+4SO6E5s85664xc7yk0CwM0Z/4KxLQwx1
	PCyfBufhFoucbC4RKsxlgWTlrAWCQq7KHXdWvmjE1JjaIyh7HWEBhyj2rrihmYgE
X-Gm-Gg: AeBDievqJ8r/EdTX0d4tqvLT2N9XATOpK/gegriTI3QbmoP56f6iBIIfCFCJC51t/Mh
	54VLtf5ywTmANvALpd83QEOPXMv5LM6TU6REmGkjNkDd8Ep3Shz0mqcp4DUu849c6xgGT/EQjqz
	UHnksPI9Cwu7dNucjmj2IiVaC/tM5kykHWk9i8YU0h9OhnwOlJXTnz8TJ1bKg7+jz6EZl0985Xq
	DavWHc+kkbDHSn6K131BfndC1rqle35RRUK6DcdvY2tqjD7383AT3baxuoHxCDsKIy/dS17Du5W
	Zb+f/VirWIRIcUGmvrFKn/4YOmsD9xLcdNRz9ENZrx454BgmNWbw534kh+qo/ELXf+6lLqk/m+4
	gRQupoOQmWmg5lLi/ARbd+H7Ul6yMH81iTcZrccCVMqct5BBmUrMsE/yZad5AXs1X2BMswZamyQ
	qv1gfloW2J6kuNHccpWewutngJfTY3FpSUAu/slP1xB2pibIM+1tNi4VpDpAL0AtJ2XS1E+7zTV
	rJuk+MkXSnZpc32oBDIeD6AyOPa
X-Received: by 2002:adf:fc88:0:b0:44d:821:1a09 with SMTP id ffacd0b85a97d-44d08211b76mr12741429f8f.25.1777963394398;
        Mon, 04 May 2026 23:43:14 -0700 (PDT)
Received: from alibaba.. ([98.97.76.20])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45052a48b23sm2286742f8f.14.2026.05.04.23.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 23:43:13 -0700 (PDT)
From: Zakariyah Ali <zakariyahali100@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH v6] t2000: consolidate second scenario into a single test block
Date: Tue,  5 May 2026 07:42:55 +0100
Message-ID: <20260505064255.195476-1-zakariyahali100@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429103607.406339-1-zakariyahali100@gmail.com>
References: <20260429103607.406339-1-zakariyahali100@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi everyone,

Just a gentle reminder on this v6 patch:
https://lore.kernel.org/git/20260429103607.406339-1-zakariyahali100@gmail.com/

I would be looking forward to your review.

Thanks,
Zakariyah Ali
