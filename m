Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A267514A82
	for <git@vger.kernel.org>; Thu, 14 Nov 2024 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731591733; cv=none; b=BLextNY4jlP8Z7u9QRDSqpQ4risZdzHvP5OQJit59wGElzLMG5vXFipj2c1RFwGguRI3HTy+E1P9wVzvrBQzurmHdvN9GNd4NIHh1tT9IlJf+2zvNr1zQzZawQHcjCbACSgmM8KqObjfapmTH1SIQUA8K3QghAAYzaJHcNB7p5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731591733; c=relaxed/simple;
	bh=bu8TmKOp05vKGIH6KDPEibuAn1pEBwi6zGm84TaTmsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WPXbTIWici8b9LWvQ9LoiUzHioxQdLNDKgTzX65ynRIokXPAAv76b3T1l0pC/AGnTiedbtwLVybb23aaO/oSgUO2aMuHVDsKoUH/6F4l5eTXgVD9adz6W7F/ZD/O9MTcLobJLW8oZQy+7pzRKzE8OCKDDQhTttoz11s1vkXAYy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=bkTdq3W3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="bkTdq3W3"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6ea053b5929so6313037b3.0
        for <git@vger.kernel.org>; Thu, 14 Nov 2024 05:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1731591730; x=1732196530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zIv3R0OiGgjLY+WehSuFUuIfRT5a5LGyNvzNg1rjhLk=;
        b=bkTdq3W3AkLXlx3c54yzwIYKwir3laYhH06F8eI7oNbuntfcxuw00bulViyU1WZMu8
         gyASrK9N4YgtLyKBEdAhGfivrx8bnpoXKowQ32rBFwi40jz8choxWEl8Y0E82v0H8T7V
         E+mqrRBFq3bs4EWgbWg1N1Mj+IN2ra3ikpD4nLPE2sf1gILbruwo0GQFHm2lpDBWgYYC
         4G2PJvIDU5OIBJd6bsM7voM14pkkj0puHzsh1jwOEGU+AiBQTYpQ4qxRs5BvI4EN7fcU
         DF2RAvFPnWPNXBMtrXj5Rwof5lpVaB3R0EYQdJ0K38Bce/U2/cedO4f8uSt+RIi3w29D
         Fcxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731591730; x=1732196530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zIv3R0OiGgjLY+WehSuFUuIfRT5a5LGyNvzNg1rjhLk=;
        b=C1hw7nZFnyKj/O8QwdeskH8vll30a1lTFuhTIgZscEwoSiENYKf0bd3NZ9yyADM9Ld
         pwPLvD9Q/q7apnQMiSsCkTwUhi5XGlT6TKZdsEV2RIFSqpKDHWZfri6hRPVXhK52SoGX
         3x/I2BXYOGuPeiplBDLyyeFDdBUdXKFMMe2vhsiJPp9aziDRNhZmYhptsv5G2Vu235Bj
         OTgxLazomkThYH8ZFerHaeW9ve7ZHGfH7DM0DDeAUxKO6vAITBAmRcut28sLiEwySCc+
         HobrG3q6UCfZVbsIO9Agbsv6xH+9YYZNQNVyuAd277nLgaBz3t7Sy2Xc6Kvkx4o3DHsz
         JPrw==
X-Gm-Message-State: AOJu0YxFFmQMU9aaq6y/cg/ouHeuGLdoD6hWRmpJFHI2UBEs64viuRj2
	u9awBPuG0ZfP+o1ogJz2X7DvTbYWIP7epnrj4DuZ/0FNl/abeqp3J3haiTp/3bFloEUynYW3k9Y
	Ep1Q=
X-Google-Smtp-Source: AGHT+IFA/5oak1THWaZGXE/zOs5LNkdvViMfCUmK+WswQFiA5Td9SALjLgR7sIOWH6VdNgBdzj3N1Q==
X-Received: by 2002:a05:690c:4b8e:b0:6be:523:af4d with SMTP id 00721157ae682-6ee43360c7bmr22679017b3.11.1731591730496;
        Thu, 14 Nov 2024 05:42:10 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ee4404555dsm2380667b3.35.2024.11.14.05.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Nov 2024 05:42:10 -0800 (PST)
Date: Thu, 14 Nov 2024 08:42:09 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] t5332-multi-pack-reuse.sh: demonstrate duplicate
 packing failure
Message-ID: <d791b7b20c94d637e52bb645ff8f06ea25e4bd77.1731591708.git.me@ttaylorr.com>
References: <cover.1731518931.git.me@ttaylorr.com>
 <cover.1731591708.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1731591708.git.me@ttaylorr.com>

In the multi-pack reuse code, there are two paths for reusing the
on-disk representation of an object, handled by:

  - builtin/pack-objects.c::write_reused_pack_one()
  - builtin/pack-objects.c::write_reused_pack_verbatim()

The former is responsible for copying the bytes for a single object out
of an existing source pack. The latter does the same but for a region of
objects aligned at eword_t boundaries.

Demonstrate a bug whereby write_reused_pack_verbatim() can be tricked
into writing out objects from some source pack, even when those objects
were selected from a different source pack in the MIDX bitmap.

When the caller wants at least one of the objects in that region,
pack-objects will write the same object twice as a result of this bug.
In the other case where the caller doesn't want any of the objects in
the region of interest, we will write out objects that weren't
requested.

Demonstrate this bug by creating two packs, where the preferred one of
those packs contains a single object which also appears in the main
(non-preferred) pack. A separate bug[^1] prevents us from triggering the
main bug when the duplicated object is the last one in the main pack,
but any earlier object will suffice.

We could fix that separate bug, but the following commit will simplify
write_reused_pack_verbatim() and only call it on the preferred pack, so
doing so would have little point.

[^1]: Because write_reused_pack_verbatim() only reuses bits in the range

    off_t pack_start_off = pack_pos_to_offset(reuse_packfile->p, 0);
    off_t pack_end_off = pack_pos_to_offset(reuse_packfile->p,
                                            pos - reuse_packfile->bitmap_pos);

    written += pos - reuse_packfile->bitmap_pos;

    /* We're recording one chunk, not one object. */
    record_reused_object(pack_start_off,
                         pack_start_off - (hashfile_total(out) - pack_start));

  , or in other words excluding the object beginning at position 'pos -
  reuse_packfile->bitmap_pos' in the source pack. But since
  reuse_packfile->bitmap_pos is '1' in the non-preferred pack
  (accounting for the single-object pack which is preferred), we don't
  actually copy the bytes from the last object.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5332-multi-pack-reuse.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t5332-multi-pack-reuse.sh b/t/t5332-multi-pack-reuse.sh
index 955ea42769b..d87ea0ae19b 100755
--- a/t/t5332-multi-pack-reuse.sh
+++ b/t/t5332-multi-pack-reuse.sh
@@ -259,4 +259,26 @@ test_expect_success 'duplicate objects' '
 	)
 '
 
+test_expect_failure 'duplicate objects with verbatim reuse' '
+	git init duplicate-objects-verbatim &&
+	(
+		cd duplicate-objects-verbatim &&
+
+		git config pack.allowPackReuse multi &&
+
+		test_commit_bulk 64 &&
+
+		# take the first object from the main pack...
+		git show-index <$(ls $packdir/pack-*.idx) >obj.raw &&
+		sort -nk1 <obj.raw | head -n1 | cut -d" " -f2 >in &&
+
+		# ...and create a separate pack containing just that object
+		p="$(git pack-objects $packdir/pack <in)" &&
+
+		git multi-pack-index write --bitmap --preferred-pack=pack-$p.idx &&
+
+		test_pack_objects_reused_all 192 2
+	)
+'
+
 test_done
-- 
2.46.0.421.g159f2d50e75

