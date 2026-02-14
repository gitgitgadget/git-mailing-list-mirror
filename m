Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A58623BD05
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 09:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771060454; cv=none; b=hBcYJUZK48sMhOjcB3drFesZca2g2gbW5h+OWK+RQhA5bwK9f91xTMbOqIX4fpfOGjsLi29zGSA1n7wRpC2JJEwrCF6L1DsT+YC6miNBSr1efvIZGvfK9XtaH9HD0lY+RDdJ6NQnWCtWQqqpnHrx8i8vQ+uohEcFaPHLZ62mjrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771060454; c=relaxed/simple;
	bh=xBTBR1A1P2n0E8pPQexi1Vn2AxVP1lSdVCjHIzw6V5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jMh8lLOER70ldjBKj7XITVUYA41UsFJbwvg3gImzwWSWeloZlLvOlJjCmCgTjg80pv1OGItVyDyiLeWf+Fd5wKcMcAskYsNZCrnZDRwVUWm2+6t6I2NLpKB9mLERNN00nXX0ojihRE8ESgfeY0cx8NYdJotVb402ZPBBLG0HQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QjQtkU2z; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QjQtkU2z"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-824ba8f0acaso1112828b3a.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 01:14:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771060453; x=1771665253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBTBR1A1P2n0E8pPQexi1Vn2AxVP1lSdVCjHIzw6V5Y=;
        b=QjQtkU2zM7OYRBKMjjr8E16w/5Qap4xseOIjEqgpQcXAaFxNF7NuuQn7eqINsRZ+Ze
         VjpQYnI+wStRUqKUpKiCbbAxAhjVKx9Ltk1HB3S8XdvuOLk/7gdf3zN92Hl7KqHri40b
         nGGpgiMdZU3DNfrlTLgMc575rzoQw0artTAElIe3mgjHNRpye7BvnMj2Q4CBnno39u6f
         SaHoYM6o9E1T35Sonx7XQF9IIzNtS3PoesD7BagvnY99GS+fCOChet2HGmrt+SgDEOdI
         jUxdq4+6YZa7Ao+TnFljbMEcKKMOvKwiwwNhChiaAu57wSPXxmbxumOJp0BLbOvCmON6
         QexA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771060453; x=1771665253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xBTBR1A1P2n0E8pPQexi1Vn2AxVP1lSdVCjHIzw6V5Y=;
        b=DiKZkH+uZ5HEHeFRIagkhD4ZsMj0BUeQq2tTbxMt6MBWGJjmUkqqgn2s55KZwledW1
         5GfXCU63NQOfzmYgUNu6Vwdx8W81tOnN4YIKq99bMKAchZyUCg4QMOfBF3AIPR8kXte0
         sDjoXyH1VRQQech45D4slTWMG8DnFNErsySO8gLUMX2kYRz3+5hbHdlrUzWIjpKZVNK3
         xkbV0NZ+JbriECMg6ffxNwBbJQi2jlmIA5whvhJjwUtIv5s789s/01DQmU7VjNNHJdqb
         RbVgws1w3T+aNkimuciSVIB+Nv8JGaV1aDjeVwbZnyTqAV1FzdN8m39CiY0rnac9vTKf
         3H5g==
X-Gm-Message-State: AOJu0YwiLFkLy6PpO4sorBVUdb4H0bUvFW1yTErt40A1pXY4zSWVoBGC
	Z8w6T2I0zodFdrn9hbQWjuIpBlYJEszzKejkGDv8Impd4SZjo7uTOBdV
X-Gm-Gg: AZuq6aIbxiZx3QvOE1PyHJkNBs2rdOrWutfp5ijXvRkSPWkRbynmuxb/RoAtJDOl2HO
	0xykdTwpAf3FOWcJ738w4f1ZdpzIsSPfKnJTG806KBhfDy9pAcYS5PMKA0U+RiqxbEqcHIDLmJt
	yRq26u4EM1OCHkSaunytcfQ5eDbNbcb0S5ICQGylO4eSo8nwkuFvE6RfLLSZSwcXWpbKPCdXQcL
	CvasNo+b1Hmpzbd69y+iS+1/Fz6eTvX29Nh41XepDtxd6yunc5DQYUWyXo1rDqOvjtOJMSHc5/y
	39HNC1xKGKgTy2qGABfOT4ednlMb+Sopotnw6E/84dT+33s3RiJcc+HTAWnG/hoQ4cT31dWBKev
	i2Y/Hx5lAXjd0PzpfJcwtKTuwPHZhEWhlepuG/XWZC+Ol9zjcMJnvK9TfY1oR4ZDlUP1qO0qOY0
	2u9BfROUI5KkwW9SaVm3BxJFeSWeT1Vv+77LSOtHSaTUP3
X-Received: by 2002:a05:6a00:1da3:b0:822:30e:d15f with SMTP id d2e1a72fcca58-824c9443687mr3711806b3a.6.1771060452636;
        Sat, 14 Feb 2026 01:14:12 -0800 (PST)
Received: from Pushkar.xu.edu.in ([125.22.10.154])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a29ee5sm6214195b3a.7.2026.02.14.01.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Feb 2026 01:14:11 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net
Subject: Re: [PATCH v2] path: factor out skip_slashes() in normalize_path_copy_len()
Date: Sat, 14 Feb 2026 09:13:58 +0000
Message-ID: <20260214091406.15118-1-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260130140143.5579-2-pushkarkumarsingh1970@gmail.com>
References: <20260130140143.5579-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Junio,

Just checking back on the v2 in case it got missed.
Let me know if you’d like me to tweak anything.

Thanks,
Pushkar
