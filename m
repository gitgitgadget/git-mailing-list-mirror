Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792759692;
	b=oJs29asbh3bScMq0kRXVC8luR5WNywOSgU8QlRUSIwPUSmnVVQMk84gXN20UYsOZDHfT
	 t9XiF9tNOrULBvCE9oZ1cPIuj8S3vfvDhr1FkDp+q1BMxpJI9Jw0P9sRpM3VaxPBYRywT
	 ple0ytAuWNZV4v7pEHix2TzvOjgRpJy7UCYcd3CrEt9jNU/5YLAGCkYWCcr5k6CDeyaHT
	 j0N/cU25GwQ5iSk4d+0IM1922YBr3l+jsoda2Ja+FmjtLYMceGF6zSN6yLg9OItH5jDwt
	 jU1uCA66ZN9nFgvSbj982wOgkAI4nhzKQ5Azpn99mS3076iicWIJhX3F+60giUDgM+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792759692;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=KYef4HWG4pmlkNqeCyLork0HY4SH1HGfjnDESCzBxOg=;
	b=hztKa7NF4jX+HwlWYXaIPRcJqE34RqZHAeNtvAsXINK0PIeo6fm/jJkzOB4R/8T8uCG0
	 dsTvi3XoYPHcw0od161Q4e9ncwwdfDmd+t9kQkBloh8UeTT5jM4jgkwJq3x40/6nBo+gl
	 2lmpP7NBYupA5m6iogroYiE8dAuT/iGxnlOCpzdiVmTiAtDiTDqS7nZE+QoJ0j2EFMOoP
	 zbFi5zUEQ29E5BucLFDFikkpTVlZHHF0kmJYBxn1P16R9Pyz0BYOenHVAwjjtUEFZVBGe
	 XNZuXzJZarbzltUUSEIsak1PHbAupLo9/Z1lcA4ZoEVRwOLaQW1qiSCDyVCsgVfY8tw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=WdiFKm3e;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=k57fRdca;
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A781606A320
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 12:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A781606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=WdiFKm3e;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=k57fRdca
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id D957C1D00120
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:48:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 23 Oct 2026 08:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792759690;
	 x=1792846090; bh=KYef4HWG4pmlkNqeCyLork0HY4SH1HGfjnDESCzBxOg=; b=
	WdiFKm3eYMTtmly0Ru8d/vGX3WOWDlR2ohYg2Vtz/JL/seVGTR19Nx440rfS3Y0C
	HlH2gAvxGWQ3ipg4BwWh74/ufdm63FQZfPG7dMPy8ZIL8LvF8xlmB+1MgSFYnyD4
	ROA971U5N0cYtsWIkvQEJoviFVaBWXLyxBm40EWzRJ0Iarv3LRYfgSAi15+C58nt
	Bhuyf1umVZdxED4N7NoR0hI56FAn3E00WGrfDGQTgBtpbS/nvMOK7Dx8nU6ts1UV
	6QcVTPaTAWqzXTd/0XAMBMg2flbfuechDMtVeEVyJ8eli9Avv0S5wCW0cIg8I8vr
	zWkCWuUxZDtfZl31zsaJ6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792759690; x=
	1792846090; bh=KYef4HWG4pmlkNqeCyLork0HY4SH1HGfjnDESCzBxOg=; b=k
	57fRdcaRjwNR59VT8zCpXti0yJnp5QBuwpQzwwztkd3HZ/YOaBVgFoC7SNfOwwvu
	O9yBMA6a3XkCC06+cOG1NokXUccErf2J0+0/W9+xnyqJ6ft1Rs2MudChF4vlBddu
	CxZuhyCKzk7/6o+Lh3YunjXikdh4iXPEJ+3lsuI+rU6zn1WDzVyojlaToxvR+Zsb
	Vf93xmtVcirkeCTrH+b6Mo8vMcUY1+QEJnFZ5vMjAdwIgdAG5vXBvLVURyxzFTEF
	W3zDeIW11/WhylYRyxSsacjI/FCF85Mv/PAe4VB1mVAsHd3CaJZ6z4oUx8xeSqRB
	vDjx0oQ9Led7ylSnsbipw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792759690; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:evo5+fKd3+WNndNqU+TdKWVNI3/ZT2Lk8/RebQFv2mONkqm
	OHMFOeiKk895vAjslQlCb9wDrPE/mJ5PKj6/DyKFzFRu1R24Ml8iTp9qL24ikpRk
	GDT4T7Iw/ZsrQm7KzG8vD/y94A8nAV9e1zTvKLk5yxwbO5TWDpxjG751yoX9JJzA
	LOlC2csSy/WYaBzLiN4wYOSNSzRwHXrnevRx+lEIXWr4arWitmZ1mFg5FmYmLlsR
	jf6H9FNwIgARa9wnlehCGqVN4PUEvfdS7pt5s0hO2NkwFHSn0h7S935+0VXkgIw+
	hIINUuSY+dSpUg592auUARuUXgd8+7nzMazt05g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:LqxI6ModTvhIl7aPhe7nu4U9yuDODhioFpYmPLpFxAA=:TjAnUQtWlod8+vqCQm3T4MppCX6LShLkkVi9NVbr8Rc=;
X-ME-Sender: <xms:ilfbagHSX007KjqDo6gJLodkcs04OwRALPGpn0rA5A2tEE8sk9Ex7Q>
    <xme:ilfbavXv-FfJ3tp6KJYXazGo2pk87uzBqb17XBXYc71qm9tLpzFn2K_n5NRpyXs80
    cQf6Dgf_NBjWqrnPYGcG01gqpBDz6qRdV9De45wTBAhyk4WLD2GDMY>
X-ME-Received: <xmr:ilfbanw_ufwiOQxT9HGq5zBYYvtwau093mKryaqXKQPLRjkrwrxGKaBq3rsvWWvrb0dJGQ>
X-ME-Proxy-Cause: dmFkZTFXYpwSUTgOWPOd9z43Hg37ZZ8CAdP2ksWTuM6OoNJLGUsHyuctfk3CnipmXbwFAr
    5H20UlGQz+Wb28m4Q7WoV+ct91npoW0BfFXDJL2LylbnIUyt66Ow0/XrR/Rv3pxhpGLmH0
    wjUH1cdVatUT9XskdjVQO4V/mpQUECnJI3C7Bkl50PohsNOuHCaKxajr85WuOrWsAlxyQx
    OJDPN4ORMeEbPBOqOHeB/1sSBdlDRCoa1SGEeAn2TgDb7lGe3COgm8G15Njd5FCMYfj6vJ
    IxM4h2Bm6YAysZ89/iOv5kL6s+yKdg3uS49Cvzwz3B7MRMO25Aib6VfHjZfI2GYrTnIjN/
    Z9q7gHQqF8qkYJ9Hpfz+N98MiBxpxzjkozl/Vwmnzc9BhDOrjmiLkc/XWR8VWCBREsZ9KY
    PlDsarchxMYo+6BYRLFt4jFcX/iDCltgrSezumkWFaBmUtQyC5OEby2mvEPBaHesO1K0Et
    SyaPfyJ7NP8bFVtIyIkUrhU3sEtYMLlKC7woozFF/S3/0/sYUx618XLIT+9Al9Z3wJ+Fp0
    tUrwrq21pByxTzvZcg3NRbzQKROk2pT2pwptY6ppiU+0ksP8pVtMP22Bb0387BupNCd+7j
    rVmal5K503Gl/qDGbLG5y5AYtbJ59qbUYawPec3Z5UTJm4nfErSwtIhUhckQ
X-ME-Proxy: <xmx:ilfbatO4E0DtIGwkbCD8GocHMZw_3xcVtH6zhWUjRWpYXNlRUDAdhA>
    <xmx:ilfbao7BvUbnC-hVGqFa4sGXBIhsFWnmHCFKwaHhxqJWD4XTpGrzdA>
    <xmx:ilfbauPoMMucA2urNtX5ALN1d_AL_f0KSFzKo4XGJUDgkIcSkP6QEg>
    <xmx:ilfbamnN59tJr9mS3iX-oSYtf_viU1RKF2QLkx3RPTvV6L15i23qYw>
    <xmx:ilfbag1FLG8eafb6kv07fFa6AD0gOHstyVCqU6Uq9YHU7YQMo7L74Xtw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 23 Oct 2026 08:48:09 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 57b4f886 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 23 Oct 2026 12:48:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 23 Oct 2026 14:48:01 +0200
Subject: [PATCH v2 2/6] odb/source-files: always load alternates via
 primary object directory
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261023-pks-odb-files-reload-alternates-v2-2-30559d7ff43b@pks.im>
References: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
In-Reply-To: <20261023-pks-odb-files-reload-alternates-v2-0-30559d7ff43b@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

The files source tracks a list of object directories. The head of the
list is typically expected to be the primary object directory, whereas
the tail is the list of alternates linked to it. This assumption does
not always hold though, as transactions cause us to prepend another
quarantine object directory to the list.

This is not much of a problem now, but in a subsequent commit we're
about to re-read "objects/info/alternates" when we hit a missing
objects. So we may start calling `prepare_alternates()` in situations
where the head of the list is _not_ the primary object directory, but if
so we would now try to read alternates from the quarantine directory and
not from the primary object directory.

Fix this issue by instead using the path of the "files" source both when
reading alternates in `prepare_alternates()` and when deduplicating the
primary object directory in `odb_files_dir_is_usable()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index d31da6e5d9..c0375e7cb7 100644
--- a/odb/source-files.c
+++ b/odb/source-files.c
@@ -228,7 +228,7 @@ static bool odb_files_dir_is_usable(struct odb_source_files *files,
 	struct hashmap_entry key;
 	bool usable = false;
 
-	strbuf_realpath(&normalized_objdir, files->dirs->abspath, 1);
+	strbuf_realpath(&normalized_objdir, files->base.path, 1);
 
 	/* Detect cases where alternate disappeared */
 	if (!is_directory(path)) {
@@ -390,7 +390,7 @@ static void prepare_alternates(struct odb_source_files *files,
 	struct strvec alternates = STRVEC_INIT;
 
 	parse_alternates(alternate_db, PATH_SEP, NULL, &alternates);
-	read_alternates(files->dirs->abspath, &alternates);
+	read_alternates(files->base.path, &alternates);
 
 	for (size_t i = 0; i < alternates.nr; i++)
 		add_alternate_recursively(files, alternates.v[i], 0);

-- 
2.56.0.307.g5fe7bd680c.dirty

