Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E4E355803
	for <git@vger.kernel.org>; Fri, 14 Nov 2025 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763159834; cv=none; b=Gr4XqbOg4vipOuxEM9W7QwVC0GaGnil2Gkw6rK4EI2nqMTyHwYyGGT8Ced31tDC7+GRlNbZSYwR6J0hpdeSaYu3WNx10EHvGNbxBKrGO+bO+Sp8Q9Pi1oMDqUco7BgRZYnkUqJFuXDdFGI8sqwwTR3SLbgg1AvYMF8cG/r/Qv1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763159834; c=relaxed/simple;
	bh=EqSdaapoP4Iua/0005K7fJJQLg93opY0nNsFFjYp2WU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYspOsWtUOD0icfdIdZaLb0esKYuiIrgopc0x0s6vPyfBuM7yQzS5CB17eRUjU/1/2sKdernFlL1kGBYNUXwVYA7kjk5cDlYOQe3eZ4LXTgxojiTdblfp9FhX+9Fp28eBSpS+MlBfmd4wQn75fl9oJz2d+VXE2BgwFtV2N8ch8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8kcrmtT; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8kcrmtT"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso560052b3a.0
        for <git@vger.kernel.org>; Fri, 14 Nov 2025 14:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763159830; x=1763764630; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQ1xCZGcTGnq37poV0lY8Av9qjcJb/UhKnYDd3dwctY=;
        b=i8kcrmtTV9k8x7LexbfzZQO+2tyVDAITwybrzxrlMlf3DINhWm8aLKbwRa78fFvKhq
         YyBhgJNXnGlZRKnPhlf9s+gs3TRi/GZkD9pi8Vb2RM145dQvbo8844nmEeiPYdWW4Tk6
         0w7DkoG9EF4RMBpzMp/5+/X1LIZRtwXDO47V9d9usaL6LQanxCRP0khgSIHX4QM1epE+
         vp/cwGZIn5jU+lUHrEnCZBBOm7m/aE3DVccJ+qmEVoQbMmdia9ZnkafhPd1jkB8PbeXr
         T4RTbBiaGOuyjBVdxV8cdP25pEbQBjE/HL2FeOuasIZshb12KxB2h9Ws865vdSIjvTOd
         w6BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763159830; x=1763764630;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UQ1xCZGcTGnq37poV0lY8Av9qjcJb/UhKnYDd3dwctY=;
        b=KCYIzfd6/cZoBibDaXjPmZyhMuLbZfBw1mMtvoUOqZWtHgvCoZm5Av3xTnqjLZzvkr
         UBs+oDCi9V/Uz+bxKD6SaYN9RNxMdPl5K5CEP5pb14Q3G6Rz6Q5qoTnv30oQfoVY/KtW
         FRk3w2Et6T7E31Er/D1oE3F2gKibGrF339UJH+OxK91B0O7NUtBHAHcZD5JJsbHGbyP4
         PsRAYaLH/YI0Peucy3fKxnNiYBfLZkM0ZtAjVB0vXPtoZGbBRvzYT1f8XKpJV8Hl+1lu
         1VTFqpJ6D6F72MdqIlY3kMhTHUpBjSWF/nCxKBoVAuHQ9GCkQNb5KfHfVOCJ66qabyDv
         OnGA==
X-Gm-Message-State: AOJu0YzB2Pd4d3MIjg428wDxkHeCCHMFD6boQM7tAbPopLCnwlHWXMnh
	vtTCvajAlPyD3RTc56Aem4d2fuzP3t6h+fcGHJ02fYIP51C4n/sJRGTAg4Z4EXfD
X-Gm-Gg: ASbGncu3cM1pzw8Ey+ykwwN3qNUi7mP3tx93P+TpjukBTGUG8YePZmS2yZttG3Bpes8
	7lop+VCLyxE74QEO4ftMA1UCfIwHEQwh3rCTyv43jLxHM0i6eEQlwODAkoYbZhjdN09weY5owU3
	K9b0Cbpf38SghiQVuW4KXZGqo3KRDYzjn4ReMqv2J4/LfwwtlaVV0op5/4tdPQgfJzzxbEgdWzO
	chcx0qzmXBmc8TBGE+HxPwXQyy/PjFgR/ItfXJKvHnOaDt1SxMwUMXotHQXWjCZjTjH5E5AbI3H
	SAci/DxqYi4lE8e4A+q5JPTvYoMqTOrJ7MUM4tUBWea38GK1mqTLZBvmo6ijtvdyE/B/nzcYSwE
	SquJt6qHm6Bg4BIwJXMREI7V5/hJd3Z8UvSlyhTZMI+rjrh0NRRI/PfBrLTAaS6/hDHIlYi4dOl
	TVb4xeUZvXT3T4
X-Google-Smtp-Source: AGHT+IH5ddzPGG5b0/uPClbzEbzk9GxfNWJ4MAUJvIY/7IKTiuMCk6lDfjsacpXKbITdV/uUHGTjJA==
X-Received: by 2002:a05:7022:62a6:b0:11b:36f8:c9f1 with SMTP id a92af1059eb24-11b415006f3mr2034600c88.36.1763159829437;
        Fri, 14 Nov 2025 14:37:09 -0800 (PST)
Received: from [127.0.0.1] ([20.169.73.145])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b86afe12esm1497856c88.6.2025.11.14.14.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 14:37:08 -0800 (PST)
Message-Id: <39369becc87842315480b6c351ff8c6a3352be68.1763159816.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
References: <pull.2070.v3.git.git.1762890152.gitgitgadget@gmail.com>
	<pull.2070.v4.git.git.1763159816.gitgitgadget@gmail.com>
From: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 14 Nov 2025 22:36:55 +0000
Subject: [PATCH v4 09/10] xdiff: change rindex from long to size_t in xdfile_t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Patrick Steinhardt <ps@pks.im>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Chris Torek <chris.torek@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>,
    Ezekiel Newren <ezekielnewren@gmail.com>

From: Ezekiel Newren <ezekielnewren@gmail.com>

The field rindex describes an index offset for other arrays. Change it
to size_t.

Changing the type of rindex from long to size_t has no cascading
refactor impact because it is only ever used to directly index other
arrays.

Signed-off-by: Ezekiel Newren <ezekielnewren@gmail.com>
---
 xdiff/xtypes.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/xdiff/xtypes.h b/xdiff/xtypes.h
index 1f495f987f..9074cdadd1 100644
--- a/xdiff/xtypes.h
+++ b/xdiff/xtypes.h
@@ -50,7 +50,7 @@ typedef struct s_xdfile {
 	size_t nrec;
 	ptrdiff_t dstart, dend;
 	bool *changed;
-	long *rindex;
+	size_t *rindex;
 	size_t nreff;
 } xdfile_t;
 
-- 
gitgitgadget

