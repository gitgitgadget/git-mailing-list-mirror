Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A2B1FFC67
	for <git@vger.kernel.org>; Sun, 23 Mar 2025 02:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742696487; cv=none; b=oJE/VkFRLQHY7ifBCdzzb3odc0u3A/1jtcAq3cIN8sgAIHs2pzw3lK2iwreXWAR0OUWrsY8qye8mcsGBzuEL6nNS8N5qWxo4+W8YgoVJH6ez2R9KoU7SG2ZxAbFGZQd9MFiPrYj95RdDCYr4V3tl0X5JWJeBx4jG8okMNGw5PrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742696487; c=relaxed/simple;
	bh=83z6ZwqCgpOSVpsvmigwzfD2CMulMNACC2heuNHM93k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVLwg8/IqRzvX8lat3GH/xEfdnLsSzltAbX9tqgOBAoKEZKr+S+07Z4nHtXAxs4ZF3uZdiowvZT1kpUQlqrD1u/9EerR14yIqE0GSKnK6Dl14xSCkXhFgPUWUdf6WbrCjlQXAAEvZY8bS01eUcYLKMaE9jajx5OmWzBaN9NoCMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VWlewU/X; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VWlewU/X"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-224191d92e4so61516415ad.3
        for <git@vger.kernel.org>; Sat, 22 Mar 2025 19:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742696485; x=1743301285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/pBGuoc4v5+b8tS+bRa1ujet3nI6rROqWTHlenIPWo=;
        b=VWlewU/XDSIk6QXj0sdlkMoWkaFPI+uQEFBZ6810eg/IFqhOGO08PhJX0P6p8yM/it
         hZ1CQBK4COrnfXi+TvjxWuzg2BNlXI/ceFoTgQW5/l8CJtEuQO/o1tVrfsP38Qyz3dVf
         3L/gcjq7qV019szwr8ap9m7U3zq06l40GzuWuWGuM9WCASZEuKG5VV/fzaxjyvrXReyt
         MejK1Trq1d8/XwfPfgMnMHiyVdtxR1AlZZeBZBPBeRCHvA16iw6JE1AtcRbyalcWyke+
         4cjvdsbUWTx0YZCBwQBRbAIOoez48hib8PtVML/pobR8DjcvZhFmjxg3jeP8xLsP1sMR
         f+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742696485; x=1743301285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/pBGuoc4v5+b8tS+bRa1ujet3nI6rROqWTHlenIPWo=;
        b=Qd6NDYYCoyD2ONp/Po29FTPOnemopUDY+i4aRnlsVLASXCIZjvGuVmnmZG7LEDzdoS
         MjAjgCUx6miXg4LX4RowiGjSAm3vZTF1LucI43r9Eb3i5aTE6jIJPPMXeBVkzdMLX7A4
         j2rNHxcDYOOLNlGOBoNKjzQa2GmtfiKW3mX9Rx1kw6rTR4SZdk6zfUxw0ZEG0rlt9zv9
         2PivemiqDimwH1j0oh0cz4KtMMbOqLftUoYEe66ggRI9KYCsyfZYI8GB+ug2ynfipeTH
         UcGTfbzI/7Tgb7/vKAmahcKGqCCSw67hRKKCRMplegirx8eqDm+0K5+R3lzB4+XKjqof
         fS5Q==
X-Gm-Message-State: AOJu0Yx/MgPoFvI0ecgNAXByr5fISN1B/Ls0Jvu1gExL/diiaIsJzHAN
	MCzCrbRXQeIdLIQlCUbT2WoiAT5z/OxuJqDGTS6gdcwYEmxGHTG+GCzHwrJi2fQ=
X-Gm-Gg: ASbGncuYRyD841Nk5zUev5HZGXBHGWvd0yi721ADuP6hjSs2Ue4mMKJJiKVcjI1YOmw
	n1VpYELaYFukD9WqCcSuW5OPQZjW8gj2tL5zJB53KSW741hP/5pXhquFNi5HHB76eQgukEVkcrY
	h5ffAv39mJvSo+SL2jPSkQuec7Lb7N8QHYJkgY5e6HFT5zQwddwKU6L98ptBoWAx4ikE5ziJbf3
	cEjyQeE0MQVSW5J7MTW+3zBFaGjZqNYGwSYbP1QXz6T7MPt702WS62sJdpoPS1jqLW9DYSV19YW
	O6GzKgUNUgMNQwulub2Q+0h7ceERv54GTLw/qNafvaxhqat4jv+J
X-Google-Smtp-Source: AGHT+IFw704Y3HmQKYqrBbwxadiAH5Aw9mg28RUINEpxWbSPxo/g9viM08Y9E6MIhM1Pzl0SpW4aLA==
X-Received: by 2002:a17:902:ce01:b0:223:faf5:c82 with SMTP id d9443c01a7336-22780c7e05fmr111805685ad.8.1742696485344;
        Sat, 22 Mar 2025 19:21:25 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f3a2e0sm42817135ad.39.2025.03.22.19.21.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 19:21:24 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: 05zyt30@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	meetsoni3017@gmail.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v7 0/2] send-email: improve error capture and status code handling
Date: Sun, 23 Mar 2025 10:21:09 +0800
Message-ID: <20250323022111.20226-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250321025128.68463-1-05ZYT30@gmail.com>
References: <20250321025128.68463-1-05ZYT30@gmail.com>
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

Patch v7 1/2 wraps the auth process in an eval {} block to catch all
exceptions, adds var error for future handling, and var result to return
auth state.

Patch v7 2/2 introduces finer-grained SMTP error handling, extracting
status codes per RFC 5321 to differentiate between temporary (4yz) and
permanent (5yz) errors. For 4yz (transient errors), return 1 and allow
retries. For 5yz (permanent errors), return 0 as failure. Unrecognized
codes are treated as transient errors by returning 1. If the status code
is not caught or no error occurs but no result is defined, return 1 as a
transient error. Otherwise, return the authentication result.

Zheng Yuting (2):
  send-email: capture errors in an eval {} block
  send-email: finer-grained SMTP error handling

 git-send-email.perl | 68 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 54 insertions(+), 14 deletions(-)

-- 
2.49.0

