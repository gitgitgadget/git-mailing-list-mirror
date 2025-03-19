Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F180E290F
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 02:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742349760; cv=none; b=fha/cb7G1O6pDvIKbYLh+Glt6bQTdL3akzvAVlHE0hZKEqZPmxoYQOBEqseQJOnb1953669/Txuis+Ep+1WzO6C2cbAK5dgYFe6Z5newjdAo5MBOGFyeOoun0pKI0esi85pJSiIAjB6wyoowiEeTo/nbG8+mnKSlvlmHhst8A6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742349760; c=relaxed/simple;
	bh=8EgV9+rD9sF7qCoetTFxfy2BgS6LAr6y3ru1OtIaIfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4/BnCmLoS5rnXAKp6rruMIzsIYitZ7M+ok/5YkkRlHM/NBVXsjy+f67WwL+l/OKte9hwj5Q9V+SWLUecC/MX15yBcdL8ehq7S5AQcCVv6sijt3sMsnIHbjKutWhO7SenJijwxtP7wPEIHh2sDw6vF+qbiNqZLB+D/eODJ97/jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6c9n+qg; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6c9n+qg"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-225477548e1so111582435ad.0
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 19:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742349758; x=1742954558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qYu9u1GRGeUC5P2zbgECaCHewW2FEUuaHZxkuZmYC/k=;
        b=P6c9n+qgDNsYpEkXXoAnXjNczZsvFsfIl8KFiuv26/8lMyYLOFbyBueG87qB2Ih0Bt
         FdIf9GG7aTMCHv/hSRJH5Zn7sRSvb/CI+D9NV1WcVUejBeDtkR/bobn4QkL06ldMBvvh
         rnzRcsafRGVYfvNAUQYZlNLxmW+KFWa45z7f/YkNyqcYvU9U+yyQT0NIvC2RtVy5rz+o
         GfxNBWuF2G7lwm1M+abvYGhVN/b5JdAwEcrqEvi8Kkmm6DMDkvyRoTzPPbLgPmw7E/pU
         ABweOOt5Z2IDs35Lsg0es4p7uyDuDLDnKlmogKVZVNAtff7LMyphUcsL4uESGYwaevvR
         XVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742349758; x=1742954558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qYu9u1GRGeUC5P2zbgECaCHewW2FEUuaHZxkuZmYC/k=;
        b=eJaGlFC3CawNxXJg73ZMQYzMZzPD5jQnWzWJjZpgRI19NofEp830xcc6e1W6kCSpzh
         ihBwTUizmKIUqlC7Bd8oNrK1iHoOBuY9CBBoqUsHdlCbexsnYWDvwuDF+I0orZY0kkwj
         04hnvvWUENMJf+32j0CCaf/3c9FTxiKAlj9IrpULmk+ivhtBuMxgmw1gwz5T61PDUq+W
         xzYy6vd5w6zS1dFQxHLdcqQUiCv+C5S8+LusQ0LNSn/WvarAMgUc/Yyu5zo8vqAbbWZ+
         vclf87Yb47h1/wPGgtqwMDoGiFaKnyqoyDp7wtYGTEK+PvkZDgPII8OJ4QAwG0Rw4GOo
         tH1A==
X-Gm-Message-State: AOJu0Yz5HjCN8sALye20TDYVLn8+lHbH7vjDFRE7FXyQVYKrrlI+7gNa
	iX4Km5c5fpPyxaGHmcIvVVQEJgjAEQqdYDnAz3Xu7fgUZezWjWR1
X-Gm-Gg: ASbGnctB2rPmcfw9u/QC5oj84VegQc/jG3QErQMe0XFvejocdW+UBODx1uJjyohv66B
	ypjFNRkK4ie2bGl2yUj8X5YIiGKBrmTdYJ8B5mRrTi8MkEbwnc5I56qc6BmuH/+yhmjpHFgZRtn
	qwTgI5K9zZpRIB6oD1272NwsDgywjy3j9ayKGkMRIzpQD7Epg7aJvtDQT3qyW7jax/x7TTk3Nvx
	v3iXATuBS6h5XR/SA4NRW4sMMAhdLbaDQcFeE1usMKXl3J5P0/l39nnpzWqebF6AEPRSXW2gbnD
	ZZyqrQOl+uH4YLfwLOQ7UMFw2TYOQH8WBjH0NF81/7DHIZJjPOPeEgFDgnFztXI=
X-Google-Smtp-Source: AGHT+IHLxf2q60CJt8WEkICtP3Fst49ip9nsN1+G5WXyiVQ0HwtZgfUjqkao5MpgwF9b5m7OXSgPNA==
X-Received: by 2002:a17:902:e5c9:b0:21a:8300:b9d5 with SMTP id d9443c01a7336-226499282admr12082305ad.23.1742349758051;
        Tue, 18 Mar 2025 19:02:38 -0700 (PDT)
Received: from localhost.localdomain ([39.184.60.80])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c68aa616sm102516965ad.93.2025.03.18.19.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 19:02:37 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v5 0/2] sendemail: improve error capture and status code handling
Date: Wed, 19 Mar 2025 10:02:19 +0800
Message-ID: <20250319020221.2160371-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250316050920.3264895-1-05ZYT30@gmail.com>
References: <20250316050920.3264895-1-05ZYT30@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series improves SMTP authentication error handling.

Auth relied solely on return values without capturing exceptions,
misjudging non-credential errors as authentication failures.

Patch v5 1/2 wraps the auth process in an eval {} block to catch all
exceptions, adds var error for future handling, and var result to return
auth state.

Patch v5 2/2 introduces finer-grained SMTP error handling, extracting
status codes per RFC 5321 to differentiate between temporary (4yz) and
permanent (5yz) errors. Unrecognized codes are treated as permanent
failures. Otherwise return the authentication result.


Zheng Yuting (2):
  sendemail: capture errors in an eval {} block
  sendemail: finer-grained SMTP error handling

 git-send-email.perl | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

--
2.48.1
