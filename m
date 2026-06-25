Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926593E0C6B
	for <git@vger.kernel.org>; Thu, 25 Jun 2026 12:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389628; cv=none; b=gYm+fZxEor/YZbNAJ0GuDm191jX2ckeG1NOokTUw3uvHvC20RR26QlKGMRdpX9qdl6xK3jqzUgPY0atmgxJxpuQ0N3/53NKrIpD7vGRPKbmha083oq1ug+nsfosFf4SIC6UsAEnDl4MxWP/yflJr+qY8BEMB/jc6LqoMx4a2W5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389628; c=relaxed/simple;
	bh=2/ddVnh31QSv6UZy0Msg/7COvntD2n/JD0aE7qMc4Q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqr0dhZqmRHcnYf0jsxjzU3OdpTXgfBLge2xzUouCgH7JnZt7LI21/7shUPlyt1e3IBva91stbDvj5PKZ93GpMIx7YM4sq8IWJ9N/xgFt1GibsL2ZeKEVdt/7VLFDpUXfdv4kb7EnlHFRvkHanRpeIgXVr5I1iKNBhDlbswkm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkRWYXxK; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkRWYXxK"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49261a64cf4so11017985e9.2
        for <git@vger.kernel.org>; Thu, 25 Jun 2026 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389626; x=1782994426; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxAX9eDSKi1nK41uUaWlnXI9mbsHwYHUUi3XBVKQ1/o=;
        b=rkRWYXxKR15aHd9UM+BC0OPUOg6jTNTXd+N4zBLu+rMHVMEOuJJuPsWdMEYpf4gELu
         EiFOyvvXGTij68LDaYR+U6324RPp3gT//Ldq6gOHxV8WulA9cXkxiZQqPz/U8I2BKd2o
         OoJlZBp5DMgzJFaPsl7sP1P/WHACn4Et7JgShciuU4pYJAukM/Bw4ekDdCRsvYFFbv8R
         b4aVRGbk2/hI7x5WboxG4tVd0+0JJQBxAQ44qX1hVAAGJyzG67xTiPNyHK7VDFQp4HVT
         i24qpnWrpcN1+C6hYb5I7Eu3CjCW/WrkyiCRDlkIDT2UonBJ3qmsKuk3j7E5kyOFLRiB
         6gMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389626; x=1782994426;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DxAX9eDSKi1nK41uUaWlnXI9mbsHwYHUUi3XBVKQ1/o=;
        b=j7aYQZlco1wHWRwGDYxhuq5rfbzFYoRQpNviWIQcU33d3DC8IgyLOGTaMUp9MqaKHb
         icpuCpd4z+39XSadIZTUw71sLeN0lN0nyO1PXHSvDeW6eAm16fO61tOuSdAjxPl2807W
         Q8F/FIeAAGhUg6H8PFHhTJbO/tSFWNX6W0R8MLq0VGlTkwRCSeJJ+F9RxPIgyehkIB+b
         Qr2WMoRaENA7A5BQk0dAXy3Qya8vVenxhBXUWPIUfMuYZeoNYPGIiF/n/gx+bTGuHLr4
         HLYH2p2ViY+D469/Z644hwGAp8Fvv2Scx4Xiq6eYnYyRt9TVdScr779U86xk1wI4FWyQ
         DPNQ==
X-Gm-Message-State: AOJu0YxsuC4rSCQmvmSF6yJeazoIfoxlAaJFqvtQWK+TECxxb2lyNZTZ
	mFF/LIWtEV1y1TsX3enBg6LlYCgcavXL7J6RtLe2HUhiPb6n79cQ0ylRYG1qA0d9
X-Gm-Gg: AfdE7cmeIPdKbc89+YzDOWGHEDfdnS50f0yNw7FLSMWMWuDdr1LTYD3fa/4AFX1X/xe
	KVnM4ayQ2bOW7Bx3AKcCpZgnf+8YNznjz37oRyLsybIE6AEUnoz2XUoz3+b3+9p7+vcmyK2dyqq
	OSD+WgRKtjMxv2r89wI0pO3+1W5b3u9Z+060HW+GpjIPKdMlz26eTiJ5ojyB86Mbg+OWa0jKlVX
	3cFm/B7iVJj1xc+zxsSrWkUzDOWDC3+p5sfiMJ3djmYu5hEJmMRyNrIcShC/3jvLBE1T9B2CTtI
	JIPGTneqxz3tcuHUJGM0LBZJrMWseD/9Pnemso/jYyozuqqEh6obtim220ojkUCWtH1xnzJa6gi
	aJ/7+4buKIBqpZB9+QmD6dP/XS+thyK9RMw0f75Aqsi8on1m0OINWSLwrLl/xZXZQZtsysCXPCc
	IljtU9/3anz1qU2/WFdmoGOZjYksX2hvKsiskP6VDVK9Dfp93v1Uk6yFmASRQ7PTge1KKmkEIaM
	FVUnLdvVZZY2vMmRWdm4R5Ox+KpGNHsnOLHI3/92qH5aRH072WU/IMIGJ4U05uyXnS25tJoTEN3
	G1XWUraRMTjJmiowCzh98/8wSmyoraAcuKwILdLcmqQU2it/NZrhRFcG8JTzHu4GNGBsmprLK8K
	q2q+FJBVHKQ==
X-Received: by 2002:a05:600c:37cf:b0:492:1e36:bb04 with SMTP id 5b1f17b1804b1-492668946b9mr32944205e9.37.1782389625498;
        Thu, 25 Jun 2026 05:13:45 -0700 (PDT)
Received: from localhost.localdomain (62.174.236.137.static.user.ono.com. [62.174.236.137])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-492660adaecsm62207245e9.5.2026.06.25.05.13.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 25 Jun 2026 05:13:45 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	Jonathan Tan <jonathantanmy@google.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH GSoC v14 05/13] fetch-pack: prepare function to be moved
Date: Thu, 25 Jun 2026 14:13:27 +0200
Message-ID: <20260625-ps-eric-work-rebase-v14-5-09f7ffe21a53@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
References: <20260619-ps-eric-work-rebase-v13-0-3d4c7315d2f8@gmail.com>
 <20260625-ps-eric-work-rebase-v14-0-09f7ffe21a53@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

`write_fetch_command_and_capabilities()` will be refactored and moved in
subsequent commits where it will become a more general-purpose function,
making it more accessible to additional commands in the future.

To move `write_fetch_command_and_capabilities()` to `connect.c`, we
previously need to adjust how `advertise_sid` is managed. Currently in
`fetch_pack.c`, `advertise_sid` is a static variable, modified using
`repo_config_get_bool()`.

Initialize `advertise_sid` at the begining by directly using
`repo_config_get_bool()`. This change is safe because:

In the original `fetch-pack.c` code, there are only two places that write
`advertise_sid`:

1. In function `do_fetch_pack()`:
        if (!server_supports("session_id"))
               advertise_sid = 0;
2. In function `fetch_pack_config()`:
        repo_config_get_bool("transfer.advertisesid", &advertise_sid);

About 1, since `do_fetch_pack()` is only relevant for protocol v1, this
assignment can be ignored, as `write_fetch_command_and_capabilities()`
is only used in v2.

About 2, `repo_config_get_bool()` is from `config.h` and it's an
out-of-box dependency of `connect.c`, so we can reuse it directly.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index f13951d154..ad07603755 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1380,6 +1380,9 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 						 const struct string_list *server_options)
 {
 	const char *hash_name;
+	int advertise_sid;
+
+	repo_config_get_bool(the_repository, "transfer.advertisesid", &advertise_sid);
 
 	ensure_server_supports_v2("fetch");
 	packet_buf_write(req_buf, "command=fetch");
@@ -1395,7 +1398,7 @@ static void write_fetch_command_and_capabilities(struct strbuf *req_buf,
 	}
 
 	if (server_feature_v2("object-format", &hash_name)) {
-		int hash_algo = hash_algo_by_name(hash_name);
+		const unsigned int hash_algo = hash_algo_by_name(hash_name);
 		if (hash_algo_by_ptr(the_hash_algo) != hash_algo)
 			die(_("mismatched algorithms: client %s; server %s"),
 			    the_hash_algo->name, hash_name);

-- 
2.54.0
