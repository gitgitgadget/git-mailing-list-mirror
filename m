Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793171511;
	b=MPkRVf21VtyqnUs74PZypLb7VCZvwIk4Kph+PKWvKYrcfP848qyPD1liO4nLFi9gM6QR
	 MQnuvN6kt9mYFeAgShza2wghQf0Yqa2acot7vC+SoNvdi0DSa7SJ+bEIWgvGsz2k3DKTd
	 qjaF8qW1NseH8tB/jdrVaxSqdkEcMPZVyvfR5oUf8b5JzpQAIUHqxlB2CtFi45uTN8iik
	 9pY0mDoall+MpmU4luKAhFFuga+Xty0Tqzr62oqqxhV9TArqJS3TvOry1AEBFx4bkrrwl
	 YdH/KjVj5t5X50xJtB3QL5Q1u6WkcWQZNBFH9uhGuSeNOBH4+zb4napdjAF0MRKa8CQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793171511;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=Hv3Vnbw1aYEav54I/7rdqL5SlXn3y2l8CrMM/TNri3Q=;
	b=HX+zIlB/6k4/L6kQP+y/X5UHGtCscXlFzrOVvqKhvhUm4zXJtddPVOGuZ4qEhMXgDZTB
	 iwoTD/UTDtO9Atd33HryHb2AUUO6HkoJh86fwLxBerFZcRIScLBrbQblwzX9OJKvSkKqO
	 s1r5/GfVnx+faO2CwFlYLpzbfxXV4+cOD1mVNHpcTqJSYNSSJtrsBP26zBIieMpervbXO
	 9bhv/rv+FHdDMkQ/xLB/lW/VoYGGmpIO8bUAy78TGvY3kCCMsCz1jZblFdCg3GBijaYpW
	 lHO8RdhCBujwa7nwY02o6MSRX47VPZR2ujXpe7ApxkexnR7kg6jqR0n0v0EH1ZGItag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dXnw1rUo;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b="k/oonNXm";
	arc=none smtp.remote-ip=202.12.124.151
Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B885606A31A
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 07:11:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3B885606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=dXnw1rUo;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=k/oonNXm
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 71B5D1D00132
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 03:11:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 28 Oct 2026 03:11:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793171510;
	 x=1793257910; bh=Hv3Vnbw1aYEav54I/7rdqL5SlXn3y2l8CrMM/TNri3Q=; b=
	dXnw1rUoAFwh4FXDjcY5j7hrXKcmXovuP56OokdCPYn1dTs/jGySWea88/1kTSWX
	S4p15cVqDUqwzXlbOoY90hOD3XIc8+oXV2HDoeYtPgusHFr85/lc5qGyLDAPT5u7
	+8/T0WMezRDlxB9lt/mhduvPW3azfhBC+vNrcilUXS03/U1aobSLbieg6ueuNGrY
	yLbpviUCrxyGbSGyNi2LcH44pVuIuuXvEqD6LLE0JQmYrYPzFF8iQWjgKC9G0Vfd
	nd2kXYhCkyBL+CLSuXyBKb3iLdm9sxIe7uRO26xVx/V5AFwIgkJifdIYwSuLrcio
	YZi+VePr7monlPgjoAumUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793171510; x=
	1793257910; bh=Hv3Vnbw1aYEav54I/7rdqL5SlXn3y2l8CrMM/TNri3Q=; b=k
	/oonNXmtrNfRcd9SOLcD+gkrkyWDAbmUK1qFj5bhRD0v3MGoiBUgXKd3WpjuyakU
	cZo6nUL5t0Y/dQl/crwVABRYSxS4qT27jbcBeXOLqbNewR+vUIwd4kWCSi/Adq7V
	+gsXRElOzlqXAEGBO4Qk84MKUgHXUHetrO/x0XQEyl3lh/Mv36Ocx4NBigz6ruBy
	LC7f1WmdR3YAWiidzE4uqqiA6a9na6F5eF3YAi3hNdQHLwK1EfyUvzW+RaekyWrK
	sy+OfRCVS5xa0CKRNhXevgQSX6O6rGAjXCt7liLtlpYFYgAbRk5ZdlXUPfzrRXz0
	PweuH2ceJrhqI+3MxTRdg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793171510; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:vBnoZ+La4Hsye1HQYfdcusDjTkcUo9q33/HGiHe9JLKOfXj
	KskVRhvCiYNcmCZlSIzXlTSsXhxP8w7NlhBvgB0OcYcUCzNS3WxRKrwGOCkMLIzz
	ewLXdhNG0jiRcM4cjjDgAC5X1YNTnVVFN962rg9mstEJ3+W0EmMPjJkN30UhyDml
	tl6rUxMi0xGGAqr1NX2yM+GcEuHX3l7taHv94RMSZDt31qu4bVFTLZ1lHOXvBerk
	SslYyfYf06xa0Sg3Bekbft2nRzhtAU2QpOIAtpv5XsDAT3uyQqv+I9iyuDQKpclm
	QbvRukImySRouO8R55bEjsdN4EnoMDbuX7eITVQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:D3eTXGGP/JlDnHhgd4Wo2AMt2gIIn3eAUwGAcCzX0x8=:ipVhVm5r/v/A54PzOe6OQE1m9/D/j1MvPl/gOanCgMU=;
X-ME-Sender: <xms:NqDhahhPH7HFA8qmBSj7gJ65fw0FqJWKzY3NbiUCNJ9TDtRz_rw9AA>
    <xme:NqDhasDcFx6I5w-cHmeOag8xDvZEYnFKOsYOEsThRd0F80XMGVadwJBOrs6G4vAKC
    vBPwncDCh0lhtc3ys3s_do5V4xl4TE4FbOyQmWVeOwdSpqL1DPjfw>
X-ME-Received: <xmr:NqDhautzxnXIFR9fc3Svp-7l03m9JqwoC7ROxOfnwGo8YbyasuzpQQ>
X-ME-Proxy-Cause: dmFkZTGqwVb9Zx2a9Ezp4WSxT2i606UnuKLCIcx+aIpsTli2+PROVFaiaVmqRAwYTEUnMa
    7nXuRmwpJH244os2MYpz5V7sI8Zzn/p1xSVYrNge/wTGXF0GxVFLCS+u5eYAYn7nW7WgDG
    3asJ8Sm08YHb/1SnbEhq4Qd1ZvG/H7nxV1HihPgkcAVXPn+cti7ezW/bEMOiHzvLFwwNwf
    jDYbtuocEHXa/QyVHgIZOv3BtvQvpuSD/VgMb/AXh4KXyg1/0fxUWqJsvM4XcGhpLAmYKi
    74gsWhbknwQ7jFDsc6SBJ99KuhVXpJ6aeaiLW7/9uq1jyD7d5AtdrxiHW/V8f58i5s2Uob
    ag+H8a8+kv6qJDrRHl7/kgUcqQ5hOq0QFq6cB6FrbZnkXwVPJismOU9crKCmSVWSXOb0lh
    hLLh9i2lPR3MJfsaBSlLEfoUTSIlVo46gK+WQaVP0E8x66/oq07Eh2iemg1PRK89XLVY4H
    2SdQDH1T32hMm+ss1sU50npqFTtzLK1uSd+nNTubmzZuTiMDH4C0c7CjzmKVKqwTeCfdaF
    EjWN98wsY/oQ52u116N8YhStXoaWkk/e0FXuNjXg7PhmLJ5/1DDueVEqdZj2tmJahnGgR+
    8Mm+PBIhz1SXnKhSpcL0yQJtNugYfZ0rsdD+jMIAx84RPIh6NiMzAqMsVA0Q
X-ME-Proxy: <xmx:NqDhahbGIkAW8xy2FQCrhVD418W6Fg3niTCJDtk-Ko8lADnpwLDYRg>
    <xmx:NqDhahWZ1CayvOscfq3Ea_dsQipN2Soce8qJTXBHKfVgrmHSLJNgnA>
    <xmx:NqDhal73AX0Fi-q2YekOQCk_-WkBKEBaxBeMEVkrdT6lFm9_KMz0Vw>
    <xmx:NqDhash5UWgK-g-Semt-7QnRJ0dnWECQ1NVgJRVME3eB6HWH8okG7Q>
    <xmx:NqDhapQ1mEQ5gqUqfOMZFPWUVFQoJ4zoE-9hfOxRWHElM-jIP-X0ujTf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 03:11:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52fd9f8b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 28 Oct 2026 07:11:49 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 28 Oct 2026 08:11:40 +0100
Subject: [PATCH v3 2/6] odb/source-files: always load alternates via
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
Message-Id: <20261028-pks-odb-files-reload-alternates-v3-2-011ddb64b626@pks.im>
References: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
In-Reply-To: <20261028-pks-odb-files-reload-alternates-v3-0-011ddb64b626@pks.im>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>
X-Mailer: b4 0.15.2

The "files" source tracks a list of object directories. The head of the
list is typically expected to be the primary object directory, whereas
the tail is the list of alternates linked to it. This assumption does
not always hold though, as transactions cause us to prepend another
quarantine object directory to the list.

This is not much of a problem now, but in a subsequent commit we're
about to re-read "objects/info/alternates" when we hit a missing object.
So we may start calling `prepare_alternates()` in situations where the
head of the list is _not_ the primary object directory, but if so we
would now try to read alternates from the quarantine directory and not
from the primary object directory.

Fix this issue by instead using the path of the "files" source both when
reading alternates in `prepare_alternates()` and when deduplicating the
primary object directory in `odb_files_dir_is_usable()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 odb/source-files.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/odb/source-files.c b/odb/source-files.c
index d31da6e5d90..c0375e7cb70 100644
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
2.56.0.341.g393f52fd96.dirty

