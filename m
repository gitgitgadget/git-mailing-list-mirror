Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793618432;
	b=RXVOuKT6yvtmemy+8IcCcuhL9OEWX++FFo2rNRQiyeHYvVBQyE1rp50K6L45qzuacC6T
	 tOG4BA1NVb5Pus7BnC7t/7b/r7K95ckkzruQJu/c8gQ5sYQNRwiwkcTBplKupcEF0t20b
	 fyGcsG8gsFQO4vzROxv2GwU96DjVtiN0f0WmaLN6fsGjXbIGOC3WuNIBmgAoHUc93wIyV
	 u4ltGfyc45bLBzdpxzP6nlBFQBw0uER44bccP/yHH8PTpCf/oTvycjVQjp6ReOiH0ApUa
	 sbiQS/N1GO/AftbBxKyyUpiuUkocaBobOXyiOEOVFDVVoChq9MzAxdHrxgwttxEU68g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793618432;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer;
	bh=4yowabh52aKyD1cSKpCEAND8wGfHa8KuoFicNqWYw18=;
	b=e2sLyoEsJo2I3xC8eYUmozh7VYe8lck45Wyb41536J2N0yNnIzeULzfpeiij+lRJEjP1
	 o5rIdVHgnvPHr5Whrusht5FNcNNliACKwNyaJ3IR3fTH5jAFjKiUynbSI5Z5eA9iwlOcn
	 YK92Fgd6DtBGV3nD66zfQFeQPE6K92BRdpEKJ+B8Tlgo6kOYtd4Bfd5fbnrrru29FTBFv
	 pOo1IMZ9o6sgfuY+gwq8mT0aAz/IFEoBY23ct5n/+YMSz60StQ/fz2Kcl8jyDCNWCdA2Q
	 7WsQN3arspw9VG90DTjPHloMgz9oeGJPdwRJDPVj6nDdonQsHQMH7e576KhcspC8+gA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u8KAN2Ko;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cNuWq331;
	arc=none smtp.remote-ip=202.12.124.144
Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DEC606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 11:20:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4DEC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=u8KAN2Ko;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=cNuWq331
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 1DE921D0022B
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 06:20:31 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 06:20:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793618430; x=1793704830; bh=4yowabh52a
	KyD1cSKpCEAND8wGfHa8KuoFicNqWYw18=; b=u8KAN2KoQ3IPL0VtdLUg7X8zGh
	/3QVPndVxUFlfc/mguXpNnkGyUuK09+j0UXo54H5xr/TGCUSbR/pK0kFWhBHK3N7
	TLDhd2HjjaYUAtcBDpXNlph8n8medtJbHoVXjq3+98/GtxnhHVArln0OCZ/hHfwq
	qskxekgZOao9iKoEA/rNyVp3yeYG0W412qHyyzSmCfcAdR3j5k6CkdoYWW3QoYEp
	aobHvyPqgVL203hh3Dvb3j15NxQAkY9rMCgO6ecOYo+62Eu8oMYWsiD3F/QpfX2Y
	eHzr+/Gr0TFAh7gYrAOtDi2cfYiTLOdP4LOMexPiY6yncCpvfnZmc2M1+Q1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793618430; x=1793704830; bh=4yowabh52aKyD1cSKpCEAND8wGfH
	a8KuoFicNqWYw18=; b=cNuWq331WoKp1VBi7qpdGlkRO3Ddb0RTN5ngXCn04Dfz
	w4XX/+6O+a8m61FH2ddNbWL7SvMwnbrfclj9WpLFzGvxLfP++X2SfLKipaQ7qkUi
	6BQ4CrhpFUEq1ZmQfsM939pvdG1raa3NmNuGSJwBiUZuiFHhV3cDpBwcXM3eIhf0
	en2AMhRKw2VSlntWdIQZ90Z6sGZcnflKc4sDrnB0TKg/4ZM2PgEC9mEfEyMFQNpb
	J3buurADzbKjMaz02UCJ4dBUfuKRsEWH024/Xl0VdG457gInedURBJPCngBMBqv0
	AVgF4orV32AntdGaR8s+PahymdMN8pZ99XjLTqxbAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793618430; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:VJLXOgYN4ttUWeoe8FxEfk4JY6toYxZ8pkJ7mz1sADobUie
	zAkEP65MJWGFLkBWkNHc4p6VoJlHgCKfu/gBYY4iM6TNFZ+GL3YZLGI3FoAqj6yz
	zwNczNIcisv+GC4DqckJlJeatNNzfJn84mdAbVvnlk0/fUYfsqof8NBYoRYfourI
	aWXmtVk/72AleH2RD7O6JtaszDvQS2e9zIXqnATmf+kSgMJpPI0YE+00xuse1Ts6
	dlJcUtinfBoKtw0U8LUIEX4sXpMOHrTQbdqz0NsraEBhyMY/ImnM6tRrMwRgPm5B
	AnUgPDqZDB3wVQoq+J5sRYoBcYMw8iertTBiCEA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:5SZjW96ADRfaFwMwpcfGnfBU4J+f5/fTDM6N9AstynM=:rFXX5HvZbS0s9auz0JE6YVYx1OlQBCPrkphWLvudDOg=;
X-ME-Sender: <xms:_nHoarfN9Je1q-EaTXh0EystNYyBgkdqJn_b3pcIXzeVJVzJv2AUmA>
    <xme:_nHoaoIVYqHRfV5naVULRIqOgMxLvj3NakHcyL0RHtEWXQb7dyF1WP_NKuEkNXFSe
    1ihPBOod7xlKcuPbaRkUSUqYi6tSpInXvsrSnzp4LiNRIEQZ6_Gxb8>
X-ME-Received: <xmr:_nHoaqJfEOJ8CEt_mKQ_VkZBmPrUtou2-YDysoSVbH_epSMY0ZNlBIsbgRoWV8j479xnEw>
X-ME-Proxy-Cause: dmFkZTFCoELeh+V+rg5YWXZonpWDVlOCoi2mGKIyX2tGEGMb6brRi1/KTZzCh+tHSYckl+
    hsoY8XQmKAsVRa8+5vRBWqi8unzqkyhket3Mk4PcjOUFqZ2Rb2WvNowQ7WnVQp1nhp3oEW
    oPUFKOcAL/007KIVESSxxykzo7W7qtrpiFDlx6nhBl5JNbI65MswcN3ZK/h4W647zN/lSo
    HsK6JbR3JYLnNHBopRnQBBn2eu5XBpCeaY55Vwze8vtDG5d33JgNd2y+ng5xLD09mwflS2
    5PBuFNnqfAmCPTxfNnI/H92q8EWsEWKrRBaunq5bZO7C3oNidkWKvZ8nMusq5FJXyeDgsi
    0gOsyCq/u9AaHdemy737bvMtblCNAF5xgE8wEUF2QSALkXfTJW1jH3na3yj8jc0Bwk3IJn
    SZKZIkXvluh2nx6Y4PuhWyqpnv/ivHLVBESaXhxVwRlHODIoSZRa1m0Ep5B1aGTV3GyAEd
    OmgZ6yx5xb+/oLBA+tBBu/Fq8mT4egRou0tq7vmwSZIxPNRoXq3T+pQNxYDUkghSTNrmJ+
    zZWOfxKKgwLh3i2XKL0yoOxnqTG++PmSB2j9/vOpOWJ42floikaMOltT+cXV+JNjUcjyT7
    L+YMRDnJs+/1e46b9MCBEEa5M6po3g/o56+4y6Pvr7FXC+PbRgwBI4VGdJFA
X-ME-Proxy: <xmx:_nHoaiHFsQSyBy8zmj4Fuwis3mule6KMGnlXz9AYTKQxFbl8pdh7SA>
    <xmx:_nHoanmKXbBCyxnA6TXX9lPoye4WPlUpQ6NF4an8X0U1JAK2vl6xPw>
    <xmx:_nHoanKYc3m0AfnNasGO502iLJC9qow24tjVPgRe239in5H8hzqkWg>
    <xmx:_nHoagZeRQWv0o7G0hQmr4sTQdpQqLd_cTqqW7lvNwY4Skvf8DTmpQ>
    <xmx:_nHoatOelalOt3F1wNU40XUlPBN4blHc8LO3mSDHPh231XIF-Gvw-g0D>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 2 Nov 2026 06:20:30 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7729ad87 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 2 Nov 2026 11:20:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/6] object-file: move logic related to the loose backend
Date: Mon, 02 Nov 2026 12:20:16 +0100
Message-Id: <20261102-pks-odb-loose-cleanups-v1-0-fbbc86c29693@pks.im>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQ6CMBBG4auQWTtJC0HBqxgXtPzoKGmbjhgTw
 t2puvwW762kyAKlc7VSxltUYiiwh4r8fQg3sIzFVJv6aI1tOD2V4+h4jlHBfsYQlqQ8uRNa1/W
 m6XoqccqY5PMbX65/6+Ie8K/vjbZtB3uyWE96AAAA
X-Change-ID: 20261013-pks-odb-loose-cleanups-fb7e5b890389
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

Hi,

this small patch series moves logic that relates to the loose backend
from "object-file.c" into "odb/source-loose.c". On the one hand this
makes the backend more self-contained. On the other hand, this also lets
us quickly identify exactly those code units that still access internal
implementation details of the "loose" backend by grepping for those
files that include "odb/source-loose.h".

The second reason is in fact the main driver. I've got two more patch
series pending that do the same for the "packed" and "files" backends.
With those changes in it becomes trivial to do a quick "reality" check
of which subsystems are fully backend agnostic and which ones still need
more work.

The series is built on top of ebdc087dc99 (The 13th batch, 2026-11-01),
but it conflicts with bc/restrict-hex-to-lowercase. This conflict can be
easily resolved by deleting the conflicting section in "object-file.c" and
adding this diff in "odb/source-loose.c":

diff --git a/odb/source-loose.c b/odb/source-loose.c
index 54f680d6d78..e92da0d8b2e 100644
--- a/odb/source-loose.c
+++ b/odb/source-loose.c
@@ -81,7 +81,7 @@ static int for_each_file_in_obj_subdir(unsigned int subdir_nr,
 		strbuf_add(path, de->d_name, namelen);
 		if (namelen == algop->hexsz - 2 &&
 		    !hex_to_bytes(oid.hash + 1, de->d_name,
-				  algop->rawsz - 1)) {
+				  algop->rawsz - 1, HEX_KIND_OID)) {
 			oid_set_algo(&oid, algop);
 			memset(oid.hash + algop->rawsz, 0,
 			       GIT_MAX_RAWSZ - algop->rawsz);

Thanks!

Patrick

---
Patrick Steinhardt (6):
      object-file: move logic to read loose objects into backend
      object-file: move logic to derive loose object paths into backend
      object-file: move iteration over loose files into backend
      odb/source-loose: deduplicate logic to mmap objects
      object-file: stop including "odb/source-loose.h"
      object-file: stop including "git-zlib.h"

 apply.c                 |   1 +
 builtin/count-objects.c |   1 +
 builtin/fast-import.c   |   1 +
 builtin/gc.c            |   1 +
 builtin/index-pack.c    |   1 +
 builtin/pack-objects.c  |   2 +
 builtin/prune.c         |   1 +
 diff.c                  |   1 +
 http-walker.c           |   1 +
 http.c                  |   1 +
 loose.c                 |   1 +
 object-file.c           | 419 +---------------------------------------------
 object-file.h           | 100 +----------
 odb/source-loose.c      | 429 ++++++++++++++++++++++++++++++++++++++++++++++--
 odb/source-loose.h      |  41 +++++
 pack-check.c            |   1 +
 packfile.c              |   1 +
 prune-packed.c          |   1 +
 setup.c                 |   1 +
 19 files changed, 476 insertions(+), 529 deletions(-)


---
base-commit: ebdc087dc99d68bb340c282b2ba5f722def28d19
change-id: 20261013-pks-odb-loose-cleanups-fb7e5b890389

