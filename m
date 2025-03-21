Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DF31876
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 02:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742525507; cv=none; b=LCM4KWpL6UuTyyU5CXfK57eFA2bQUzmGtiI1nN/MSbiC99kISLV3fzWF4hvwnHBRvzQ+MRfDREGEm18pnHjqmdNYzwEoYTPOAf4ACwNTkvv6Pt1MbW7TA8P3CnxoFsgXNz3mj0E+YCY80vIFiw0+9PbHW1RbIjT5b1Yv7K5UMsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742525507; c=relaxed/simple;
	bh=Tm0XYFyP6OTzuRrxwb+hyW9LWEEsttOjv/IJcatq0R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGdQl9blGvu6LcwOLCHHBiuc/k70HmlRiYRbVZxzMV3bcjbcgEMNX7cZ6YXCB/l4sI+L7itSZBeHNuB4loFGUgERfBbRmqwLGXUkTi2XulhJfubtNbCX4em+2zUTMb313WU00K7peyQrv6vN8DeAwq+jkfYJMEjz9SSrs2R1P64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IS51iNsM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS51iNsM"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-224100e9a5cso28665065ad.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742525504; x=1743130304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dDE3+hp5IylJROFzHpdodb0FesrKpIFw6xawftIw6A=;
        b=IS51iNsMQnma0J7trolHSa7p0ODPjAHKv07OrCxzgrqw1HsZ0T6NQ7kwyFs8yjgpAm
         33HNPwPiSpfYA7cz0e0lPWKCRYAOwdC2HTGP049/QjPXICEZmkyml/NWN+nlk+cW2Zok
         21aWCFn9EHxfSLHO5G4PGIXjQotpK3Bsyz049gzsfa4+TQhD3Ix/HUWJmVVu1kEF0JBK
         nhTQxxOxPQweOwHGG2n+1ldeWuPz8PkuGD8oo5KfYPEhqd5vfv6XBLMEDbSAERbo7aWy
         AoEXbmL62f0QtJ48/ZnBNSCXenetaQhnuB/ckfoDlrr3dWkPQmXsNbdTg2H958ftXPuz
         sI8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742525504; x=1743130304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dDE3+hp5IylJROFzHpdodb0FesrKpIFw6xawftIw6A=;
        b=irHzKwezhe54ClUi2tk/YPTvT23qLyE/GQSiw6a3u10Sk0PwjGIvitoflRMeDWiuil
         +PZYfcNDKvHTOxnvgqkkUh1tnH6RELqECopARzBTkQmY28pXX2gDB3aEMRRBl7MQyKw3
         6pIgPLSoIjQ4f1Vbey08yMEb7LAVihHmTJf8nUtiY7PgYDba+jfM+GDPcQAP/VRzH0Q/
         BrPERHji4zhxLHlZjqSTinAwQ4qjTBX1fcILIazpa7NBhly8udbuUBvmJ8C069NNhz9A
         N3hgE6gzYoJKHrghqFxMSBjrUszkYmtFQmooobHLyFrAtjQ7Pi09+IXyJb/7mgCgJ81t
         rBNQ==
X-Gm-Message-State: AOJu0YwT+ZWURiVw5zrGOZpuKjAlPHrPEsZhSTKB0wi2uz6ivLB8hvPP
	59tTxl6VG1UWHFUDwo8JKVFn4KheES3HPfnn0goSPeZePdKrh9VBmmD+4MLErmM=
X-Gm-Gg: ASbGncsMiB+n6gBKEsgMxqA3tz9QM+bxqbahx2k0uOqK1hmBrVLTgZRS6OpwMYq/I5g
	2HhVXxw9Kkf0YfdFjomSAnsgDeqJx6Q6FxINcESOsiBayKM7BTTWCrWRT+/wTdrfWTOgDXbky6q
	ZRx4hKxZN3YfbpMb2N3oixk/Z6mACnhk7F3HZxlNML38/vKc0KukC3Nn19DxpOtbzSUbj/9Xc3k
	+dhL0MdMNVurCopOlTYNZFHica3CWDN6BsWzhb97ukQ/MC929bIMyP5EE73cj5hoBDcYS7JDNCj
	eg789uHxXiF44Ab2T6MOZHGo4X7En5QqPf7guqzx3wGXV29m1K0N
X-Google-Smtp-Source: AGHT+IFUMWIUaTw7U2VT4MI/8MXLZXlPp60qWe/L6Wd8ClW2WmJzCmE04OkMUu6kX9nTAX9CLcwmQA==
X-Received: by 2002:a17:902:e846:b0:220:d439:2485 with SMTP id d9443c01a7336-22780da8662mr25015205ad.29.1742525504555;
        Thu, 20 Mar 2025 19:51:44 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.67])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-227811bae9asm5591395ad.138.2025.03.20.19.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 19:51:44 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: git@vger.kernel.org
Cc: 05zyt30@gmail.com,
	meetsoni3017@gmail.com,
	gitster@pobox.com,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v6 0/2] send-email: improve error capture and status code handling
Date: Fri, 21 Mar 2025 10:51:26 +0800
Message-ID: <20250321025128.68463-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250319020221.2160371-1-05ZYT30@gmail.com>
References: <20250319020221.2160371-1-05ZYT30@gmail.com>
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

Patch v6 1/2 wraps the auth process in an eval {} block to catch all
exceptions, adds var error for future handling, and var result to return
auth state.

Patch v6 2/2 introduces finer-grained SMTP error handling, extracting
status codes per RFC 5321 to differentiate between temporary (4yz) and
permanent (5yz) errors. Unrecognized codes are treated as permanent
failures. Otherwise return the authentication result.

Zheng Yuting (2):
  send-email: capture errors in an eval {} block
  send-email: finer-grained SMTP error handling

 git-send-email.perl | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

--
2.48.1
