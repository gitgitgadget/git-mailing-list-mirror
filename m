Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794122394;
	b=xvmgKbGsDLIrOOjri6aZFFdcx3lqWqftLbm96sFak75zEuJ6qFC1uRopvBxLggAsZysa
	 1rQcuSACtqW00qE7IqdAzhKwcqNSYlYjFZ6WAGQuajGuqFfbFWE7ZpoXkH57XKaqy2trX
	 wYU2l6pOqHU0saMdIdaHkYLE23oTqcTCX55l9ovlOj7usDQzGBVh9IpgDDxDoOtMfzADq
	 +YCzQ3VbMwUw6lc2e47nmP/9M6LvgT/Y5rbW3XQrcfjr6OUbxskpIxh0DpTitZhqnBRyc
	 HTMn/r3RUYWDtd3VYG2AMoJFEe1ZTmS7qlb6y6+6RI+orq9aMLvzHOQgHR4K3Mem9+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794122394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=AMFzT6x4gVKNstMGWY506jFUluKcMZ3pvXVtK870PX0=;
	b=wHQl/xCJp/lb/XOmWVFXFFyWW6Q41G9ZOJxRZOyklTXP3IRs1aiB/cwD2fbF+uJtmZz2
	 gJJZlEmB1yaALCw5KZHmiAoyj4o5rUDk4yt34ZuMCBj79DNJAJmIVlca106+QkFPTG6bl
	 9mcDFkvvcviXaGedBtAqhW+HJMr43danESLQlFe2AU3CTnwtdniFUDdOjjN45LuBACznO
	 X2xAMYigcrONASMxyo1UQ1AlSEtItSc+13AMw4XmAXuI6SDshadFNs3tbZD9QC0sKaUkl
	 edoye5F8azmp9SK4ONHpz3GiubkMR262hvBR5H010mOiBFCLJll5DdpzA3h6/belhdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="egCAZqD/";
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2046B606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 07:19:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2046B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=egCAZqD/
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-3700ed8dbe3so676664eec.0
        for <git@vger.kernel.org>; Sat, 07 Nov 2026 23:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794122393; x=1794727193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AMFzT6x4gVKNstMGWY506jFUluKcMZ3pvXVtK870PX0=;
        b=egCAZqD/886YrBCuofxzX+gghhGA997Gnr9EJpHTOswdsxa4d4s7KxcBowcsH3yCXW
         8XpZpsf5/vt6+zdiv50hXADyOgDmSYW0wS8y7OLfoKGax7yAbhTWjAlHy4mb7NZDkCPa
         1Fa0TMQT/HG76uuBMMUaH7XRpU6TO82hNJDpPScoB0MhYAvdvhuFRC4br2TN9+PavDI8
         kZUiTow6YplX0xAVp3WctDLD+4Yn8WYkqSNm5LqwGXvsa5SiTFMPTPUvu3eUURgZQxAJ
         t3pv+l7fcSrQy7SzXPKYS+UONVmbuJpkDqtgHkBOwaNYYADb7z98PMCEKmYQLZXOqh4D
         OYcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794122393; x=1794727193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AMFzT6x4gVKNstMGWY506jFUluKcMZ3pvXVtK870PX0=;
        b=BQH2rdPruZdcdNRmyk8YQQSgWMwmBehKKuzJnE7WT5SvMdqDgugPxdaxm002KMusuP
         RkgZj7pI858aiAcTepcnCIDUKqa10XJxKOHP+wxIFxjEv8G5dlLlxInrvlOr/BNBLOZ2
         zOq3HL9eut1W8v8bTb2BGfna/Gos/DqJ82nKxtAEju0f1O+kHHHoigktRoJzKVnYlvGC
         5Geuf8d4ctXmolO1ystaIb62DifNVSlYLnf6J9Och85NTxYim3z6G4/zR6OibrALHRMb
         gUSs2CslFHX1efSdsSwLbdaSbzO3/JzA+lswPQHmlyVu4PtQtlWkaH1MNNfZ61khar38
         UK3A==
X-Gm-Message-State: APuU4Z/34FDXDXyQ1xIVYxdtXazK1LtTZreYAG2SkV//UmGFJckvqhnC
	XV5JNdRsK4bHgZUakbyWoroytVrPZLxa33Z7EBfYN47Hw37crN417A2xwEu+Pw==
X-Gm-Gg: AYBFou0PQFdwen0dNN5iX4AuEe/nHPeZ4d7fYrisUnFDPEg6xcjOtSiIP0O2ifBHVlA
	do8ZU63YVhjPvUiopqxwlqPY8R1eFwmsf0imr0poxdybGsTKCCsnVMxAQY4/qB2H1+hpGxFtKho
	T/S/Ap/UPDA0ujNd8WJuHjEKElWs1Ef1dWIfXMHop8Rd/4KosFDrEpz/tPQcISW5CYN4AGsCgG4
	ZHnWFfj+TCfqu0dZd6vwiyUWH5BKlpYicqDwWXoXS8LDGvogdLOdKRmfnttrvQb00gFiHla8q33
	SBPrq3lMy7tqO4bGfeqFPXQEbbW151cnizw6YaYRI1qpbs1CPvoh2jD8XkW08Lx4N8Yeu7I2dZp
	3yIv5wDI7rBknu2Tj9+dMEli8R91AI7M3675qpKFXSoSQf9jB42wtRJ5FdJz5BehiISWopMcgn8
	yx9F8robCnKLL3xXPAu9+x7g07YUXS67APGEio2z3pplBNrZI6lMO2JU9shTYQAcCc6Mf+vwnze
	aU3k6n2oDq3bkCO3GI3k7xPpQrsG73XSx0bDBxgh5LhEZXgygGzRITHJInYBqUvcoMFqen3WapD
	IpKQG54Hu6Pzk74Ql6125Vz2/OhBWnod/vjLDMq6JukOtm9KyUg=
X-Received: by 2002:a05:7301:6701:b0:36a:79e7:2fd with SMTP id 5a478bee46e88-3725f010ed3mr2565036eec.40.1794122393229;
        Sat, 07 Nov 2026 23:19:53 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3726039c635sm3367132eec.0.2026.11.07.23.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 23:19:52 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	Hussain Sitamouwala <husainsitamuwala21@gmail.com>
Subject: [PATCH v2] doc: describe promisor remote fetch order
Date: Sun,  8 Nov 2026 07:19:33 +0000
Message-ID: <20261108071933.6586-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explain that promisor remotes accepted from a server are tried
before other promisor remotes, and that the remaining objects are
requested from the next remote when a fetch fails. The ordering
was introduced by 8808e61fd3 (promisor-remote: try accepted
remotes before others in get_direct(), 2026-04-07).

Signed-off-by: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
---
Changes since v1:
- shortened the subject and wrapped the commit message
- clarified what "accepted" means and the fetch fallback wording
- checked the wording against try_promisor_remotes()

 Documentation/technical/partial-clone.adoc | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index 18718a3840..efe9acac65 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -195,7 +195,10 @@ cache servers for fetching missing blobs while continuing to do
 filtered `git-fetch` commands from the central server.
 
 When fetching objects, promisor remotes are tried one after the other
-until all the objects have been fetched.
+until all the objects have been fetched. Promisor remotes that the
+client accepted from a server's advertisement are tried before the
+other promisor remotes. If a fetch from a remote fails, the objects
+that are still missing are requested from the next remote.
 
 Remotes that are considered "promisor" remotes are those specified by
 the following configuration variables:
-- 
2.53.0

