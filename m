Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34E2286A4
	for <git@vger.kernel.org>; Thu, 30 Apr 2026 00:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777507992; cv=none; b=gFslmaDUqBrKyYTnHNecTVq90HNaj0Ol2pY9eKtYaNeNnKyZ+Uha2WO03m/gtBXeEMQo3hgeilYfrl01xRqrl4uAn3m95uFMnuW+U0nessMXdBkDajRaxR/DdQWpmHR78NxvLSdo3BIExKI4w/xmGp2BGyd6D1ZpAISQr0dc6hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777507992; c=relaxed/simple;
	bh=I+qb3mTKQoe5Ix5E4bZNQqoAfYEhmSN3OlO2a3nPJjE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1+/oFYGEx7z8ZakX43yKnwBDMmiONXrsFQOFxWXWkCehtUUnVnbyAY5yu5nnK23UrIqwXeVAjS3poJYedGKGB7Lf3cHuCVDxdJE5GzT2grcBBy30/2/QuiayFE+KhqrUto5zIMRfh7iHhlZmP7u37o/R4T7T2PD5cAwWOjTuYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=bQtosTyr; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="bQtosTyr"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-656d749109cso186461d50.3
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 17:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1777507990; x=1778112790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yh9XWIVMsVgw6rgzz3d7O/zi+d4MBGwuT9BBmGKx4rw=;
        b=bQtosTyr04yCEJ/4AH7zbGzJLOP3BiDHeoamZRivq7V/uJtPDRXGTlcUO718oz+wDP
         jCSoQEZwvxcggmJ/See4/1Uw1FWVyfR690j0b+OXFXly/Oei7iVFRF14YnNWIojbacG3
         drQH5fZrdO587MmuCCsgjYaurB+x1258LYJtgklg6Y17vk/5gFAN7vj+QXL08CxpwoHo
         wFesGShQYOAEHhYLOXle0hrDnTw+3CfuO2CCyPNGlmbzaxhUxMdsGS4FU5NsXZzzg4ta
         i3exzUkoBhXeWW/9JBYNhZaekzap4E2w+nAwCay9XLGhCfcMubJEJOqHRkdXrOzPz5z0
         lRcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777507990; x=1778112790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yh9XWIVMsVgw6rgzz3d7O/zi+d4MBGwuT9BBmGKx4rw=;
        b=Uu8ou007bge67DM6PyrGLaSfvdyHriAgi2PMZzZb7k4CUYkAQrjV1R0q8KoU/UGNoN
         nmAtIw9A/eGPFsLfcEt2tRlY6q+yMd6NiRfcoZGp29W6tEX4WBCDDMTmaOXIZUFBtmca
         P4971ypqZ3nRaIRUIf/izBaRQ5Id2+uRTwgl+eBN3c8vcByhoVsOCDX+R4RMue+u0cla
         TWvBFBFTUmbzQTwqSwdyrDf1/hG9N2n51u0chkyakt+tLFERdX6M+BuzTCnTlwwcSSBe
         eVe0QilDXoYc8XSHDklvoID7y9kVVUdtvWS4Xl8N5ssCPW0v3N2s43ku6XENv613cFG3
         SiZA==
X-Gm-Message-State: AOJu0YwyqJoL0x23GD2fPxAXAvxBL5WCrYYAMdILlaXghNcGwTFwaSOL
	WiIzqo2ym8AzckRZWeH7Op/RuwArtS+Y/ZgTwI1UUzWiCcit1ZZRLrcVBUnU12L1KlUUXPLkHI4
	CY8MzSlpQCg==
X-Gm-Gg: AeBDieukZYztADp0fbhJMR154B+3CzLH5gbvVulc8MIOS43Qc5HPAiC5jRmsJISU9v/
	daVcSqkXov6JSMZLgjkCqdR9w79Hrvcu8eGbQTNMc6uPZFCqd1Cpk/jTfBrs3fqoiAYCzHbTF6W
	+Z54gd1JuaoRrS+ouwJCzC+jBQvnxHRz7Z11lFILzy8PDeZCB6mSGy8hrh7UO1y8aXW8QzD8LEW
	tF/u/kHPav7PT+DOkSwooqJyj76Wz4ApQu1al6Ftq7IUeNjlzNly1/MGU6GOvabSDrcCrYR/S8a
	IBd7WNU+KXq6Jn3C4fY7j/gptFFEaIEK5Uzcbd4NZNdQHFnIjLLxKoThhM72IQyBukvnx8H+vhy
	fDl2+tFtzFsV8HQhjaPnxwM4CEG2DvwqGDS0bqNW6jmEDUvsaqHXlwe189JEFrZRD3AZCOJWf/f
	Ul9o9DNX0X+es7Ep7zNkmNffDCSNKf0NYU5f/Q1Nd8LbuDpXOHaiKb/EIall0IcmyQuvWq0Kkf8
	1/z1qOJZH+ETWnjgg3ZBN6J8vrPEquGfVU1Us56PCyGtMugTywYKJNxWSXJtfGe3IgGYfRbOeNK
	yQ4LCjRWzGBasD7/N1Qp61KGO3Q=
X-Received: by 2002:a05:690e:429c:20b0:652:55ec:6a2b with SMTP id 956f58d0204a3-65c18c97c3amr376048d50.25.1777507989605;
        Wed, 29 Apr 2026 17:13:09 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65bff4c19aasm1981384d50.3.2026.04.29.17.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 17:13:09 -0700 (PDT)
Date: Wed, 29 Apr 2026 20:13:08 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 01/16] midx-write: handle noop writes when converting
 incremental chains
Message-ID: <d6c27317c25895da223906e07b82615afb6f633d.1777507303.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1777507303.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1777507303.git.me@ttaylorr.com>

When updating a MIDX, we optimize out writes that will result in an
identical MIDX as the one we already have on disk. See b3bab9d2729
(midx-write: extract function to test whether MIDX needs updating,
2025-12-10) for more details on exactly which writes are optimized out.

If `midx_needs_update()` can't rule out any of the obvious cases (e.g.,
the checksum is invalid, we're requesting a different version, or
performing compaction which always requires an update), then we compare
the packs we're writing to the packs we already know about. If there are
an equal number of packs being written as there are in any existing
MIDX layer(s), then we compare the packs by their name.

This comparison fails when we have an incremental MIDX chain with
at least two layers, since we do not recursively peel through earlier
layers, instead treating the `->pack_names` array of the tip MIDX layer
as containing all `m->num_packs + m->num_packs_in_base` packs.

Adjust this to instead look through the MIDX layers one by one when
comparing pack names. While we're at it, fix a typo above in the same
function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx-write.c                            | 18 ++++++++++--------
 t/t5334-incremental-multi-pack-index.sh | 16 ++++++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/midx-write.c b/midx-write.c
index a25cab75aba..9328f65a201 100644
--- a/midx-write.c
+++ b/midx-write.c
@@ -1152,7 +1152,7 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 
 	/*
 	 * Ensure that we have a valid checksum before consulting the
-	 * exisiting MIDX in order to determine if we can avoid an
+	 * existing MIDX in order to determine if we can avoid an
 	 * update.
 	 *
 	 * This is necessary because the given MIDX is loaded directly
@@ -1208,14 +1208,16 @@ static bool midx_needs_update(struct multi_pack_index *midx, struct write_midx_c
 			BUG("same pack added twice?");
 	}
 
-	for (uint32_t i = 0; i < ctx->nr; i++) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, midx->pack_names[i]);
-		strbuf_strip_suffix(&buf, ".idx");
+	for (struct multi_pack_index *m = midx; m; m = m->base_midx) {
+		for (uint32_t i = 0; i < m->num_packs; i++) {
+			strbuf_reset(&buf);
+			strbuf_addstr(&buf, m->pack_names[i]);
+			strbuf_strip_suffix(&buf, ".idx");
 
-		if (!strset_contains(&packs, buf.buf))
-			goto out;
-		strset_remove(&packs, buf.buf);
+			if (!strset_contains(&packs, buf.buf))
+				goto out;
+			strset_remove(&packs, buf.buf);
+		}
 	}
 
 	needed = false;
diff --git a/t/t5334-incremental-multi-pack-index.sh b/t/t5334-incremental-multi-pack-index.sh
index 99c7d44d8e9..c9f5b4e87aa 100755
--- a/t/t5334-incremental-multi-pack-index.sh
+++ b/t/t5334-incremental-multi-pack-index.sh
@@ -132,4 +132,20 @@ test_expect_success 'relink existing MIDX layer' '
 
 '
 
+test_expect_success 'non-incremental write with existing incremental chain' '
+	git init non-incremental-write-with-existing &&
+	test_when_finished "rm -fr non-incremental-write-with-existing" &&
+
+	(
+		cd non-incremental-write-with-existing &&
+
+		git config set maintenance.auto false &&
+
+		write_midx_layer &&
+		write_midx_layer &&
+
+		git multi-pack-index write
+	)
+'
+
 test_done
-- 
2.54.0.16.g1c05dfce579

