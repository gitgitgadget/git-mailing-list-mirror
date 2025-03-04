Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A01FCFDA
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081366; cv=none; b=abEBfGzj76VReP2fXoXBnr/cOTYIsA7dNon0K/UGu5AqwywoHoAL55kAGdAl2vekoCDxAxBVU+wflxKtCpx0jL760inDVLhoauSgK7V2SQLGZlutdd3w0KAOSGnvW1hIZeFEQ5rt9aC0Nj2WV7bJb+plAyRgHfVi3ZoSj0/cRoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081366; c=relaxed/simple;
	bh=KLNegy237kuaKa8NScTY83IR1OyliQCrkWRIi8JTz7s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Qc7oN36CwlXaOoZUwEoBA7jm/2HW9heVqrk8xEcHN5Wg2J9ip20N6beIJwVIPTQHd8ydQp4q35Xh4KYEbYA7thXDh0CLWlI5gyiUPB47bjVIrIpJ+h3yi3aHOxZWeOCV6E5IG/26mKDUfREaaflEi/bmthTzVCxBvPkqdnyP/oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOqRQwCm; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOqRQwCm"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-219f8263ae0so99074995ad.0
        for <git@vger.kernel.org>; Tue, 04 Mar 2025 01:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741081363; x=1741686163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pIFLxQcTOJ+BuUzFTO20IWozypUKhimt5Yb9k2w04nQ=;
        b=GOqRQwCme9tFBuqUEiTH9SSxeFWuIC0Ak7sCUb1Ev43jjk1zo3cb54DnsDAVK/x9gq
         36qDTeMh+6M0uDzhvNraiPf3MJ9EIarKxu1fPBtVf3NjT7kd0TSI38YXniUpeX6vgIN8
         tnxsHJTusr1doQGCg3PQ5RotTMZSKjAmg+fuMTom+tcsFR8sNCLI0gMrQgZNrlZyotu3
         I3ZcqNifk+UIVPf4Gq8nyEKrEZjEre+vha2ScvjiL14DSywp6jBg8k59YpSYhYzo2Tw0
         VEHY3f+yEU4n2txNDWbJKO56bJHqfD7ie3x8CKoqOGJzwUnODDc+hl/Oo6DzqNLOq64+
         Ljew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741081363; x=1741686163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pIFLxQcTOJ+BuUzFTO20IWozypUKhimt5Yb9k2w04nQ=;
        b=TCs45CYSRMftC1UIL/k8WwUrtE5qd1rZSlITiDX+u+++h8WVXkIykdi1eGJ7y4pkT8
         Et72HfJlUexUY7RojvCVUp770lBsTcBGQvzbZf3MeX/ZgvMhrtY/2S9j1tgSa/rmH1t0
         P9kTIZ2Z63tbCIfvnqPkF45T40HT6ye457ntQI9ko1ezb/SKQN6Y2T9eM3imJBMYtCby
         a2vEQ54QcADg68NeT4kIsCvQq94a0kOXbHfLbUgMS+gFYL7ZchVSGGj/9XdPRGPZAg8n
         nQNCxLRDDBuy3X0rt4PjXSHJY76m45+gwg2q3DYyuPr3tIGN/48qENBSELwStTs29RNU
         KYTw==
X-Gm-Message-State: AOJu0YzIbz8mofmD0C30N9CcJ+dM+k2dcw3uFcXQi8R8Ni6XXADyqm19
	+YJGINXfO/K6YUgCOOdMfFuwkwr3Blwnw2d52a2SMQc4hvubio4yhA1tLVahTmY=
X-Gm-Gg: ASbGncvGkERUlT6JsvCNA/SJtJ+VtKDu5jJUG83IlTJZO9bnKBu4i4t/TfJZ6/hPccF
	59rnGeQ+qN5th8ipKkJZlOSxOS2AozEmgb7JQzzABtkoDSlhlSAd1Bt7jXijc2m3Gl0OUiJPYEA
	/K0ur03wnSWHuWPL4w9JdKq4WnAuczYrIc7RVDlFI2D1oLh+eLfWxfmY1Q2HnqJbrl1Nb7wqAGZ
	ifFEb6zynsIWcbPOpmTNF+hH4mI4P0Ivqns4tCX7AzYYbSm+XuZV3UQKUuwdwiQfK6DTNh+5B0Y
	Dp8K4F9Kq2hO5VT4z3mbp/zakLBg1YEXUUokEIdjUJ9TIX949QvE6yrGmRmDlHYZdvgurkB2PNL
	x5Nk2NBvDtA==
X-Google-Smtp-Source: AGHT+IHqau7NrKgFv9k08vRwSGAEgc+evNRuMfuxpm7h0HN1jxFhnZ4DjmqOA1nFhlWgsJsGkNEDxw==
X-Received: by 2002:a17:903:1987:b0:21f:4c8b:c4de with SMTP id d9443c01a7336-22369213d97mr261565875ad.42.1741081363216;
        Tue, 04 Mar 2025 01:42:43 -0800 (PST)
Received: from localhost.localdomain ([2409:40c4:307:e1c:f069:cd37:99b2:31c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22350510ec6sm91858265ad.220.2025.03.04.01.42.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Mar 2025 01:42:42 -0800 (PST)
From: Mahendra Dani <danimahendra0904@gmail.com>
To: git@vger.kernel.org
Cc: Mahendra Dani <danimahendra0904@gmail.com>
Subject: [GSOC][PATCH v3 0/1] t1403: verify path exists and is a file
Date: Tue,  4 Mar 2025 15:11:52 +0530
Message-Id: <20250304094153.28959-1-danimahendra0904@gmail.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20250304091556.22478-1-danimahendra0904@gmail.com>
References: <20250304091556.22478-1-danimahendra0904@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

test -e does not provide a nice error message when we hit test failures,
so use test_path_exists() instead.

Further, verify that if the path exists, then the path is a file using
test_path_is_file() helper function.

This patch does not change any code in v2, but is rather submitted with proper formatting
which was lacking in v2. 
I apologize for the incorrect patch submission in v2. 

Thanks,
Mahendra

Mahendra Dani (1):
  t1403: verify that path exists and is a file

 t/t1403-show-ref.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Range-diff against v2:
1:  42dd686abe = 1:  42dd686abe t1403: verify that path exists and is a file
-- 
2.39.2 (Apple Git-143)

