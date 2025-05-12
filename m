Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841B29D0E
	for <git@vger.kernel.org>; Mon, 12 May 2025 02:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747015791; cv=none; b=BTDwG1YBKtWJnChhv+hk5H87dBQHEDq6eBiVxgrS9L8SqMknQwzqPEOPFFX1ksC+Tr53vQl6x99dsrUxa6LSn9ZeH5LqdnIi3Ef2l4c66v6kyMXV6TrGFHlu6CWdV9AjUwwall4R0VyVyWaocV5HAQGThFy9/Tkj+o7EWRcsT1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747015791; c=relaxed/simple;
	bh=bTaQ9CBhIZaHz+nLA/BSzVtGj9dng4wKneJP+pvdTag=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XHGgmfbrQwT1LOzxxZ+KmOXH1H/4GJFxXpFg/ieMaZam6hTZQM6Z8i5uiUcXASAmxlGLF3CyTS4TCLVRaJMpaZbw3iLkVpSYm8SYhdOCsskkNQPG8C1sHfYMdQ2tdDNpTu+xI5+uT9+GuC96Vvb6XIpOvyhJHaHfMMuGhAHDIgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N+hqT7mD; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N+hqT7mD"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2542066a12.1
        for <git@vger.kernel.org>; Sun, 11 May 2025 19:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747015789; x=1747620589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HWRQcNmWk7cy4++IyV7IRs+Zn/qr2bvFdU9XQT39MbQ=;
        b=N+hqT7mDy4kQ5xIqdhptmrofKI49IXToVY4UvrMvoPZoobNW5E+tlFkuE9dKaOV1/N
         pSQVwIBjlLfrvaTREVEpeR0UiaVHu2kG050aLmkvHKuasLlL8DOoVrumFVJ4ukNxBg1e
         mEOvHUcxA4hsKFSShuBQPgF3RiIEC9GoqPKCxjfFbFeLWAxl2ssOaEWyQUO0CitHTvYP
         WZ+/YuChGuW5UvRAfFUG/9WVjs2Tuu3yWC6tv+++ToXjf24NVx59ugMo2oP/0PMRzXwT
         i0NUvtxTI6COvPfmWm6XCxVeHp1AKZZqqQAiqJQb6FVki8k85TAdogXESAOVHnv6hZ+1
         HBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747015789; x=1747620589;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWRQcNmWk7cy4++IyV7IRs+Zn/qr2bvFdU9XQT39MbQ=;
        b=R8UMRmJybQqHToZYcgPQzZr5OFgLvG3zmXIZLxK7JPHqGhKCOYHuwdwEa4lYNkeMYm
         8ORZKMqirfnBRLA6LpbS43EmuFrgmTshf4wDjWPs+OYqFSgthDc9GrDSX/Bmf03Y23dX
         f09cc1GaJg68JJc+PGLV36wT0zxebFPXhR4pDODNDKe8plsUY9G9TQgkb9Ewfpn0n5ci
         8qH/pbRjiIuXM1BjM9eGqvM0Ph6LxvyeSD+lh96ZL1Aig+JwqKIElmkGUTEqfgKTDZ/7
         sjJmPEvO3hVk3ViL0VUymL0RqlYWvsdxkQjAryImyv6gAaFgnodmY32Ed1BxaPSviNyx
         kqvA==
X-Gm-Message-State: AOJu0YzswfNRtaie8+hem1zCtQlkjU7KO3yApJ8HL9QzX8Ht4ssfDYyc
	3guwVXSU8Sa/RfZri1IkMS6NRSwPGuS2L4r2wdUdKaEgeCuTI6Xng3nZPnAV
X-Gm-Gg: ASbGncstPqNHp5lcrPo/LeSz00Ix/wlQFF0WepnoLKJiL6JnDXXomfMDsRxk3No01WS
	01T5Bm3Vvp+6vh/PYEQBA2te2nz7SIe55SL1Je8bREYy4pcW/Gx+xxCNkdi67o3e3/jtc8C7ZTl
	FjNNB7Qltt3Rff/GztEMjL4zmtyuAll+qShGAhauqvotenhiaG4KFXdCi23Bgc7XdLz30umxnxe
	pJL5czRKaboIINKNKr2iL5o0dWQI4hd8kbgGumjdbD1SjCYuXLRylmAgjowQrUcAfAsoQdanPah
	BgNWUNpXRrVlPG4PQ8ofX0R/mRwJRwW7p5ynrYF94HlRjVR41dCfu1F3H/QXkA12NsoOrHREBCN
	s06IKPX3Ls85H4H/q
X-Google-Smtp-Source: AGHT+IGqMckixJJz3Z981jzSA+0VClF6K7T3n6FhZPQcwsta+Xrmd59mwWHsubasXPKHQnkwu4qrqg==
X-Received: by 2002:a05:6a21:1085:b0:1ee:e46d:58a2 with SMTP id adf61e73a8af0-215abb4f989mr17615730637.3.1747015788762;
        Sun, 11 May 2025 19:09:48 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:e40:9405:a1de:10d2:a65b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a0cdd7sm5212185b3a.90.2025.05.11.19.09.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 11 May 2025 19:09:48 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 0/2] json-writer: describe the jw_* functions
Date: Sun, 11 May 2025 23:09:33 -0300
Message-Id: <20250512020935.73140-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

Given that my GSoC project will need the json-writer module for serializing
JSON data, I studied this module and I thought it would be a nice contribution
to make it a little more clear on how to use it. This will be helpful for me and
I hope that it will also be for anyone who want to write JSON inside Git.

The main difference in this v2 is the second commit which provides an
overview on how to use the functions of this module, telling which one should 
be used for each use case. Perhaps only this usage overview is enough, but I'm 
open for suggestions!

PS: this is the first patchset that I'm sending after being approved in GSoC, so
this is also the first one with Mentored-by :-)

Lucas Seiki Oshiro (2):
  json-writer: add docstrings to jw_* functions
  json-writer: describe the usage of jw_* functions

 json-writer.h | 161 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 161 insertions(+)

-- 
2.39.5 (Apple Git-154)

