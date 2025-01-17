Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449D71F8683
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 07:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100769; cv=none; b=NFirSwsrFgornQzqLW7z/5AmFH0Z9EWcmHaBxGAYkUeXW8WeQ7EJk4XUJ+wi+B/SyyYWCZn83AIbkx6yYzwzWQ5gWTSNPOqpdCPqKKYHyboxzv6acozdajj+Y8NMU/MQWEvJxTB0L7Ia3Xf/AdbUPxe6GnB5eqlb+uZDr6Ch314=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100769; c=relaxed/simple;
	bh=dyglWpT/ENLi2tejpgLNRp66urht5IEV9y5g7UNzRSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VlDqTPOVLjVrhOehbfHs1xJMdzxw1xxNADwyGWfolhHj7qwKOl3PeV3SMZDkvVS8nUpgdYyB5Fnh2LViTS31A6Zyv/fOayMojfQ4xJPlopd5Wpx3KjD2HNQJ1zia6oOy+hXRyVemcrbptI/5RUD7sXqk/4ypwkULOEBmtC3uv/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQkKhZwy; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQkKhZwy"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2efb17478adso3173820a91.1
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 23:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100767; x=1737705567; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LgCuUKL5buAB2VkLKrCxdb+hXPjfWGhFKLdP327ngUk=;
        b=JQkKhZwya6BNglk6YdGUEl3PpI1invFzeKETnkGI/zSb8NLy1DUjPMzfjnWYcFX7Yr
         pU2GXljL9Ys9QVLoiWg+hpA9ZJk2936MQKjymaTys0g6B0Uw8Wkij3YFuPV23A70ZMHP
         i4j5RhL7NGANW6O6xnciEBWVKflx4ne4z/Hw7ukm2UhYO7q7DN5qLz3OiLsWbNvuA0sG
         HPevq0W46He5TpvXk5I4Xc1oCoxPYwdPV1u9AqK7NOvMVOtU7nHJ7G+GFd0Yg6GtGHke
         vv4iDpqzyJhi9BgdzjTvdoV6HWYHNZ/S+cl4pVGVYUEY6TseqiSPLj7X2LKjLJ35PSgx
         6a3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100767; x=1737705567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LgCuUKL5buAB2VkLKrCxdb+hXPjfWGhFKLdP327ngUk=;
        b=MNo5sDchrKzrw0b2jLBC+9BYdRkrh5GPQqveIZZE35r4gJ/AE5CrxjVFP/NXB31rp6
         90uRDa2KNdSszSEA9+LkbDY63nFI4Wmc7Hhi6HIM5dAsNUbzcCq3xquU0eUvG/qHCGyg
         xAlyRqcUwvKn31AyhkFFsNBkqRLsg/kBFnetok/buddSHBOdpKGMiF6/tGp2tBabsRWG
         9AXydSkPMnn8XD/Td2q0dlSlKPC4nFR3V5sBvJk0uxlDKfAUkpQF7FABHpv2ajqLMbrY
         XTT9oTtvTOmlvJDT/a/6jee1ZZ/fJjGbLCijmG1prRLMB0Qdibim88UBtb7DUz71F3wU
         hECg==
X-Gm-Message-State: AOJu0YyIgjc0+tS34qh1F5thxgj452NKJTzcNWXd1LUJkS2H/gmhnE83
	9d613dd7ukz8POYKr5pdC7Dii5G/FfuPu8jR4IrFje1d8TAeCBleAznvbIWD
X-Gm-Gg: ASbGncucNXdUAhwuHPqL686gGzeetZzsbIJId+uV3qFr/fnEM3Z+e6+RL8wCBs5lNuG
	uojYPDca2UXBodm2vCQz6H3kkqnURufPkyscDWUvO/f8PrMFB3PdsQEflM9z7CxmxatvuHNlCWq
	Jo4Pff4E08CSiEPmIfA9fPboDYSeIAxVf+tWvGx4PAMPiJNhr3DDBSIEqLONkmd/E+tHW452+28
	ezPVNmUhY7jEGQVTojOtJ8qm9fjaYeMPjoQFTt8kzxaiUkySYarb6Tp9u8=
X-Google-Smtp-Source: AGHT+IHbK4bF2npmVNYEG8RwUsmQ6O6THvnpT8ym4AK3uvkdoo8ZhUdJTP6fMnc9vHr2jRiIorGnNw==
X-Received: by 2002:a17:90b:2c85:b0:2ee:f80c:6892 with SMTP id 98e67ed59e1d1-2f782c4d587mr2303333a91.3.1737100767452;
        Thu, 16 Jan 2025 23:59:27 -0800 (PST)
Received: from [127.0.0.2] ([103.39.127.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21c2d4025f4sm10517595ad.204.2025.01.16.23.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:59:27 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Fri, 17 Jan 2025 08:59:14 +0100
Subject: [PATCH 3/3] reftable: prevent 'update_index' changes after header
 write
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250117-461-corrupted-reftable-followup-v1-3-70ee605ae3fe@gmail.com>
References: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
In-Reply-To: <20250117-461-corrupted-reftable-followup-v1-0-70ee605ae3fe@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, sandals@crustytoothpaste.net, 
 gitster@pobox.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1370; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=dyglWpT/ENLi2tejpgLNRp66urht5IEV9y5g7UNzRSM=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGeKDdWv67KzE2m8HBm6DYObqiRjrSc1V+nt+
 Gnm1DSvtDUtCIkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJnig3VAAoJED7VnySO
 Rox/9iwL/AueQGJ3GVs4PCC+V7UG0nn1jaJBJ7rs/vLglH9d/qDkQigBThqaSQQbxMfIcRHdZLs
 dIL9i6cUlc4tbsx3UcEXfPItlX72kDJ1W4uT7SO9gU8ZMV5ZLVRrC6xhStrHqk+gQnR5DDcQi+n
 UqXVUkOeW/9Io0tinUndwnegEiHwQRzNNM+ynkLU4+RGmlIMeps730tBlJ595I7bunbSSGmjlxV
 XG71BQ3gq6DFxjRDBlKlhFSO19hCOy+1Sr+lnvgQKK9jGcm6vZwGKNV76zAqWMZvst+iQM+Il0e
 klEr7HprVB4lfcPHRN0RKXC/WYivd9n2kzVxHSDttrOSuedKtCE3bUxiQivLD32Khs5LATGwO1F
 3E2PBzheCNJps3tCsiQ+yQpq7OicVTdbmiPTUO3WjugRb4MCq75P7ekR2knSD7qZrdafS5fzhUe
 Ch4+zoscD07JVvYOdbXu8NYBepXvqWwsf7l3KQIYXvzfv9MO7hGPobM7lL+6BmN8zFqZ5m/xt57
 Vs=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The function `reftable_writer_set_limits()` allows updating the
'min_update_index' and 'max_update_index' of a reftable writer. These
values are written to both the writer's header and footer.

Since the header is written during the first block write, any subsequent
changes to the update index would create a mismatch between the header
and footer values. The footer would contain the newer values while the
header retained the original ones. To fix this bug, we now prevent
callers from updating these values after the header has been written.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 reftable/writer.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/reftable/writer.c b/reftable/writer.c
index 740c98038eaf883258bef4988f78977ac7e4a75a..c602b873543790e36178f797ed9f98112671f97f 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -182,6 +182,13 @@ int reftable_writer_new(struct reftable_writer **out,
 void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
 				uint64_t max)
 {
+	/*
+	 * The limits shouldn't be modified post writing the first block, else
+	 * it would cause a mismatch between the header and the footer.
+	 */
+	if (w->next)
+		BUG("update index modified after writing first block");
+
 	w->min_update_index = min;
 	w->max_update_index = max;
 }

-- 
2.47.0

