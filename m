Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794985009;
	b=q+fDBynyrtBBUnQQ5QsDoVcDF3j3vGRhjhrCaqRxk0WaJdfhCS76QINCCZHOc+5i6Rik
	 1dl24NROGE2IVR/OItP/7Y01LGuMb7sQ87LVbnDvOkz3xxkPy+YEgN1OyYFCVbFftHOgZ
	 KlxDwNJe+cCmAu5x/5r1GGwEM7YrA6gS+teeNbhaAGr+3uWHN6KK2nt6+MzZ6h44XGCFp
	 Wp6c92WiW0FFYlCoqCVmaMB7jsJ51wqolYfQ4NfKo8stpUfp/7nWern9wsQ4Jp7QjHhrH
	 uMJYcSw6DL9eTTAkhrCAfIjJ4jqRklnQ9LCWHeL8AlsO6cI2he9zMyb8+zjd9Vu9uNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794985009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
	b=XZrrnAHYaXlWPBQJtkKTJlPlKU5aPPJbWbQLA4rIy7RaLZomO5p3IYTDA+0ifFJT+Lee
	 f0quzx5C8StbMUnISYTeJ60h9QrQ92aPVH/qnMy17zkFYEJ/g/uGuPq09mIj4fhTVzG5T
	 nhfLZBtdkDRQ/4+Q4XTFnBlYzo/jpleVUwNLbNWig5Mjz3CEWBE84lkVTUkfnt+FGarm1
	 kBZfz3DU12xzu9HxsEX38lGtvrMYhN0GHU2z8TtOh9I9aN0gS5LSMdYDiDjV2yR9NbRGp
	 7gc3RbjXC24ryrbNQXJiQO0lFlsaCpSKhfnsBPzUOQMw8W8dnSVUfmyDnTAcZFaCgtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCwXdz8x;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30061606A330
	for <git@vger.kernel.org>; Wed, 18 Nov 2026 06:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30061606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QCwXdz8x
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so4363565e9.2
        for <git@vger.kernel.org>; Tue, 17 Nov 2026 22:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794985008; x=1795589808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
        b=QCwXdz8xIjO8JBuiZZXg5yXptmyYSMgA8L1V77kCnlwciFEKLZRwnTvX0/DhcXXPFB
         wKR2sPJ2wDL0CRlwOUCgU1R8tAJ7DRPkKtPLfhd0wpqIsYPdfT9rLnQUXGO1gM9BVWpu
         Vxmwm0X5wAnaM0HNRQyegwVQrKwF/glQUeY9ZBN6PrJHaZI0grEC+/2csTmNnWAN1ClH
         +P1LI0d748jA4NOGJNfzstrik6yLWkW8QRk5gxu8hL4oMCWrCCwylAwJ45fp8k1E6Y4A
         m6/3IK3eg0VknFDXxnGNTFG/Qw3rPFqpdauvEZYn/6yIzZs20IiEDIBPMTULHRQXMFu5
         Nn2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794985008; x=1795589808;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0E3fCx9XCR8vCrn+9DeLShjIsItyc0sFuK5XQADgWpE=;
        b=m8nUJxNeVTWCwiz0sQQjnoE83Y9Avbtq5taryGQ6zYjretHQcK1gahMe8G+aAP3wVv
         af9agApq+4+wk1OtqY5L9koU5FZLmyqW+hSv12un2EQNNUKNFsZ7hwIMVOXG+HhBdEL8
         HJP8rAHeE6oKPOIh3PUst0XAR70arp5Jy+Ox+JAKrh8ZbP5wE46lMB5hyZvLG6/46qJE
         ckFZ2IrVoGWMPiMbgyy6+6j62EEk9/eoG5IOWWiA9IFvDqkhdWr1Y+cfwx+Lcd/Z7PGl
         lmDStYtdtebQmwRAOjGTgo5GQDOQ+/XN/FQS/XzjzWUoVU4IakhY7u49ZBwqA0JTRMRc
         30Rg==
X-Gm-Message-State: APuU4Z/ck653jQR2KbtxYP/n/FMvl9D3tPyktdEWaSLreHcj9E2PxpH0
	Rg5kErFQK9Xdnn7HDyzCnSC6XC8BTa+gl0gITbx3zu4wfIDTEZKec853PfYLVg==
X-Gm-Gg: AYBFou3qzAt732pE0fe0ynbi9rWHHDKnDZrp3NimcGzpjTcUt9qCszwJz3YhfwTM4kK
	aY51bBU8JmQknQuBv6999IsuSpL3F2Ka3va3xe/mpzE6cQv69+P1AxoB1vQsQf7ZnsYdIjE9X7H
	ckXIrQb+ZIyE+cvY3h4y6undcdzt0TCzBdy2Wzg7dBbMCL2KjS9ckb9x5xMD3oU94oDUFuFGCJQ
	DTjt3OMLNvPjf7Uhtv3KBRpKw3U+fvxmjaKMvgQz1HxdOxn3xD3fjxxZWAiUNcT16BB5wo4vmxr
	2d6WRRBfV/xJDYS+X9rNn4iRrZ+n9+qOHzmT9tCHcuFype93uAqEOVILngSOSKL/IizUOWuJ0WZ
	W8jgBfxs1ueQpqS51SM+lQXkld+zNaTB5gEWJfe383mX7Sog9873U4TnDImaOu3oGCTqzWvTMbU
	3sX2QZd2/epYXMwrBU0mNVzY7B5vys66fpylEv0J9xdpLfc4CwNfw9wMj6f0pxay35rFBQHXeOY
	Cirbh6o0htJL1EgTSUcGFNTCXMCOpsRVS+Fr/7yc9Wb18UGC3I12g7QFmeLZ07j2FQQ44Julxrc
	KPwcbXTHguCQSeYt2p7WDjjgTSWUB9Ebal56dHv2heGsAEg+y7qVb5bHW2AzxX0=
X-Received: by 2002:a05:600c:8b63:b0:4bb:69f2:87f7 with SMTP id 5b1f17b1804b1-4bb7da1b372mr28424985e9.18.1794985007576;
        Tue, 17 Nov 2026 22:56:47 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb783f7eecsm222311235e9.3.2026.11.17.22.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 22:56:46 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/4] index-pack: use size_t in write_compressed()
Date: Wed, 18 Nov 2026 07:56:36 +0100
Message-ID: <9952f0fb104450461661b3f8b5f646760198744c.1794984184.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1794984184.git.gitter.spiros@gmail.com>
References: <cover.1793446357.git.gitter.spiros@gmail.com> <cover.1794984184.git.gitter.spiros@gmail.com>
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

write_compressed() in builtin/index-pack.c takes the object size as an
"unsigned int" and returns an "int", which are 32 bits wide on all
platforms. It is used by append_obj_to_pack() when resolving thin packs
with --fix-thin.

With a local base of 4GiB or more, write_compressed() compresses only
the first "size mod 2^32" bytes, while the pack header written by
append_obj_to_pack() records the full size. Later, when resolving deltas
against that base, unpack_data() encounters an early end of stream and
dies with "serious inflate inconsistency". Shrinking the parameter to 16
bits and using a 100KiB base makes "git index-pack --fix-thin" die the
same way.

Use size_t for both the size parameter and the return value.

Triggering this requires processing a local base of 4GiB or more, so
no test is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 builtin/index-pack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0264c18c5f..f65228468b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1411,7 +1411,7 @@ static void conclude_pack(int fix_thin_pack, const char *curr_pack, unsigned cha
 		    nr_ofs_deltas + nr_ref_deltas - nr_resolved_deltas);
 }
 
-static int write_compressed(struct hashfile *f, void *in, unsigned int size)
+static size_t write_compressed(struct hashfile *f, void *in, size_t size)
 {
 	git_zstream stream;
 	int status;
-- 
2.53.0

