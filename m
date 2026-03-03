Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BD419CD0A
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772502376; cv=none; b=NTd9Lij4NfnNh4+KBI50cfxjrHNqBIiaPB4fZ4vGFWLlSRzpb/p3zeawGbYf4pxHKmnN8Eudljc9uuHAVYV00nB4ZbcRgBHBZBdr4f9BtxHZ680FzE5/+UeinER7F/uk264QWJy4nK5/6uH32zCWn1ySzCEpGOB6Ch/o6iW15NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772502376; c=relaxed/simple;
	bh=maZqfRNZc6XJESVTZczEEV9EeIizJONWcaj1RQn5APk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jMLQH1HNECwyHh+3T5fFLXT1dTN3nh7S7FKp2v+5esoHzhmCroTXi1DwIcNeH7QbAiwR1LO4TSxIdXu5sM9J/h4nIaCkiaMxx9ojmyJQ9jmUFjKzNMa2QzRdtr80Xz8GrJEDPltUDhibMqp2KL7N0t3CL3ejsxKZY8oJZQX6X6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=msmMj/53; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msmMj/53"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483bd7354efso67679475e9.2
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 17:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772502373; x=1773107173; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=msmMj/53CJBW6xoPmlIJlA7c6hsTQeml4b/4WUBulLwRy/FB69bxQKuVSv+yMlXyfP
         oZUXkuR2QcHMvwKFAqzuSlJRtdN1wYNYM5nF4/duxDwjmLTi1PYiYP0RzzD+RiTvkfao
         JWtjN1sj99lznqLLgd1kuTku5tWCbOptvH4aqaOdQX8dziujBs8/zcW+VDfLkjmOjZCP
         JNVmTFn0RCQCvJ8EIArdmI1aGSqHQXMHCL/CZrvaqP7VnX4Qa6KFqWAGBeAaV3kDS73b
         uHMSUA3z6vLEu1g5VXpQUEFxLGI8MnoliGGTOZxZN3XhOvpMBqqwmOt/5bAEOsb1asIF
         QpIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772502373; x=1773107173;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hiGb7z6ppacVuI7c4K9UqI9QEeRmB6oGzgbgpIBfpGU=;
        b=EIWHJ4q93UzYtGNUsF7aqSpinUD+a8YhcSOWEu+lyf+FF8B0Io8zs3OjQn98DOiEWx
         2qI4elGxiAwUZai0uVREJ0NTgDGEhtiZ66YVinKv1JbLRU/k11Hg0YAMlfeEN7o+P1n8
         kjSp9piDRbBQGTthjv9yoWmqWHWDENMWpuJGODFDQWe8hAPgOPV81ZhFfqAsrpJ0VDsC
         p91LAhxfhzpUgHjYKVQbRjiU2NTDu7JyUfmX7vi5KP0zwoBRhmAbrWuNZp8lIqyy5fU2
         0Q0oMo4eCvtEXcqdvUoHpIfnPF1r/jZNe5Q8RAI81zvu+0fqWeTGoR8dVgBtgH5WrLAp
         BI/Q==
X-Gm-Message-State: AOJu0Yx175LRWQKJjm3dvWNn0x0KftZqpF81E/pV+Jrwt4rgp8nYCiz4
	Ym5SxYCP0h0xThCshga6vjajbeA8eV5JEQmbMBVQ8ylhGMK+HLkH6R8o8pFfpA==
X-Gm-Gg: ATEYQzynlCWrgSLxsNJ6Y/G2nMQh0Blij7t0hWa562fbneApLGUAU19n4cI/Qu0iq/0
	K1RCrWhvf2egM5ROLlX1N0krnbjWu1Yyx66lXZtMH4bek7EGNgUe0/qc4ssd8yg89hC3BIT/fd8
	lzt5gwpIiU7SGb+2P69zriUSMzzwaCsct5T4ptMNhf/wbrZNpjLDkpRi1OKvV55AvqHHdgmmNpF
	c7yqpT2uz6U1KrVVhrj23ayHhsQagZPKT++/u+/+GXYCkkaSWJzM8lmPwX2ZPNLUDcHEKYJr2he
	O/D8mt+cVX/NGy+U6FrcT6uv7bagZvdnFMv3GO3odWIxgYcZfQOEcubRGj7JqlIr1dwmwHDcA6f
	DlEcIlkYpZvTmDC6GfUCsQalxsfLdZn6EKGLS+siVxJbCY8JCJyhuH/avym4KEQCSt076NOGQDB
	QtQWrKEox8+DAmq8NKXDBO3qmx2VPLJSyTSFU=
X-Received: by 2002:a05:600c:1f91:b0:47d:264e:b35a with SMTP id 5b1f17b1804b1-483c9ba366dmr273401675e9.13.1772502372878;
        Mon, 02 Mar 2026 17:46:12 -0800 (PST)
Received: from lorenzo-VM ([84.33.161.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd75df90sm457536965e9.14.2026.03.02.17.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 17:46:12 -0800 (PST)
Date: Tue, 3 Mar 2026 02:46:10 +0100
From: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: [GSoC PATCH v3 2/3] doc: gitprotocol-pack: improve paragraphs
 structure
Message-ID: <8a6b5d4c98bd239e66faaaaf5883cbb50f1f1802.1772502209.git.lorenzo.pegorari2002@gmail.com>
References: <cover.1772500189.git.lorenzo.pegorari2002@gmail.com>
 <cover.1772502209.git.lorenzo.pegorari2002@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1772502209.git.lorenzo.pegorari2002@gmail.com>

Logically separate the introductory sentence from the first transport
description to improve readability and structural clarity.

Signed-off-by: LorenzoPegorari <lorenzo.pegorari2002@gmail.com>
---
 Documentation/gitprotocol-pack.adoc | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-pack.adoc b/Documentation/gitprotocol-pack.adoc
index 9952fac188..f4c9e024b0 100644
--- a/Documentation/gitprotocol-pack.adoc
+++ b/Documentation/gitprotocol-pack.adoc
@@ -47,7 +47,9 @@ process defined in this protocol is terminated.
 Transports
 ----------
 There are three transports over which the packfile protocol is
-initiated.  The Git transport is a simple, unauthenticated server that
+initiated.
+
+The Git transport is a simple, unauthenticated server that
 takes the command (almost always 'upload-pack', though Git
 servers can be configured to be globally writable, in which 'receive-
 pack' initiation is also allowed) with which the client wishes to
-- 
2.43.0

