Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37E7481AB2
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 13:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769000428; cv=none; b=KXRGdbU8zq/HCn22LimLyRDRcShHk1R1imPfRGJFAxzPPof7vaWiOqy5UGh+wqbzz+fTVN5Mxw/2hbaqU45owcsCJ6z6SigwxRDN2GiTObkW1DfuINorNL0aOlVdKkiFTJHp+pn6RfZ4YWAj5M5H375gqJWe43hCD58uZ4RNZso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769000428; c=relaxed/simple;
	bh=T0e6Fgp5IhJ2v4w5tTKyGpkSN6L+/kefFrvT5IHG3AE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cjZX4WheJQR3yw0WmOMv5+njaUNj/8Eq2wvPaGCt6gLmBFb9ZkScz4HU3wGVtuv2zfB5gn+0r40Rkiz/m2nLdc+YHiS+IUj3WS9VagrswSiY3oaUwo3lTI4VcPTnXusP/czuOhzX3duXxqALpqwFbzWYVbAxIBTq9cqMBVF3l98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dtr7wZSY; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dtr7wZSY"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a76f90872cso9554975ad.3
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:00:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769000426; x=1769605226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B50ZkrS1bnD3dgS5URWytoPR86E3rBqaIKgTaCBM0WM=;
        b=Dtr7wZSY8SeqclPs8/cr57KI7Mwm9nxIQ+w8NLPhWEJcUAXjahynEXawdHuz/8TVz6
         6LIxpmspbidluCQRWHSKxYztvw6Oqc3Q0pCGe6wlNHBKH19Nw9TVGIduC4+ak2BTB0Zy
         oIMsh2IKj6uybny+JTeAOMOO/IovPkjUkK3OFPNaItGyEYzOY/3pmo1jdIKCJNoOVv5W
         DUqSjeHWrOQRBkDrT9+m9WWWLim5unHJvcgfqQR5mhJtATPFwU/vCWtJCoflgLnHhkpq
         9v+uWnmMC3m+XIHqx9vIXWbt07qi1wnXiWT+xqkCOfdkhqMWwnix2VvVVoDrbAyV2qqW
         mnhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769000426; x=1769605226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B50ZkrS1bnD3dgS5URWytoPR86E3rBqaIKgTaCBM0WM=;
        b=WNYGT2WTBaFmY1pP8VyvlOODoA8Eepctmmqn7ZEnoh0dlmgAa9af3rF0rCzg1sEYVl
         zvsbyqb8qqG9k3lw3TOML1pKJXQLQHB3+8wka5+zr4fbNM7Nktb9LBrODonskfSUQ1Wz
         6EXy7zUJwrfNO7XTdJU9cbFAnoTytMk4JVATIoTBuccH86P7i1g39SrYP1q8B+yV/q+Y
         nvTXQBuw8YaEPref+mDU8Czx/o1ZmAmFzealEqZuni2HbjsjF5rA/1Ie6IiGzesB/FA9
         7Mo3bxCpse/9wmIG17N+meF2bD8KvDFd9IbVADUykTg8qtYfhDAgUoaUpdJ+UfG6Nx89
         oJyA==
X-Gm-Message-State: AOJu0YxicxmUK4umXsMubCHcRBMnSJEGrZ80mLQR5tsM/ajy/W/XX9vM
	WVeSH2I2b7WZJh7Fdf6a2+jNK8V+S8KmAbsGNuzHW+PCVaH4zV7IwELwZm2VrQ==
X-Gm-Gg: AZuq6aJUUsVntb7l1hXTrNf0IvhPbh54yC5wiegX4lLsy5B/GHR+gqYWcFWZUoLrlOt
	PSPAWgpndTU4J3Y5pXts7xKPJasJWDySwo2q4VmL9w8+yVnEg7Mky6HOgSOsy+lykt/GazbVdPZ
	ry/TR6pOKUudiEnrMAUJX8rsTcCsqYTwWn0xsnHhdiVg42lbgpGQWCDoNyuQHV/tUPffJ+ISSB5
	vl9FS4YJlC3lnVQ1w/imLB8XUBxRlzMdEM3iSG3SknyaUpUJAzJueAB4H3WZhu3nDaQMLLlP/oP
	NUHdm+dEkdFLUtZ/M/CqB8y2VLBErafarDElY/f6+7sobcD/Dk+NSkYYd+yU0xpyv+0u69J4S5h
	iGSD4yYeBYk0UpRt10yE3iXdWfwedMuK1srnqMhZkJZNdMQj3bVSC3sCNFtMwHFKG7+Uu2V4oVB
	3zPuuibeHcjgB05ZS5X8TIz19kfT+VRqiMbfHkOPQSjHM13w==
X-Received: by 2002:a17:903:ac7:b0:2a0:da38:96d8 with SMTP id d9443c01a7336-2a7188a2b7bmr156515565ad.25.1769000425403;
        Wed, 21 Jan 2026 05:00:25 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd7:6181:4ac5:7f6c:c462:4847])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7190ca9d6sm144001745ad.25.2026.01.21.05.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 05:00:24 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH V2] t5500: simplify test implementation and fix git exit code suppression
Date: Wed, 21 Jan 2026 18:24:11 +0530
Message-ID: <20260121130012.888299-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqikcw1bei.fsf@gitster.g>
References: <xmqqikcw1bei.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The 'shallow since with commit graph and already-seen commit”
test uses a convoluted here-doc that combines manual input
construction with packetize, echo and embedded Git commands.
This structure hides failures from the git commands,
as their exit codes are suppressed inside echo command
substitution and being on the upstream side of pipes.

Instead of using here-doc to construct the pack
protocol that is directly sent to the
'git upload-pack' command being tested,
capture the outputs of the git commands upfront
and use the 'test-tool pkt-line pack'
tool to construct the input in a temporary file,
and then feed it to the command.

This has a few advantages:

* Executing the git commands outside the here-doc
avoids suppressing their exit codes and makes
debugging easier.

* It removes the need to manually count and
manage pkt-line lengths to keep in line with
the v2 protocol, as the tool handles this internally.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
Changes in V2:
 - Fixed commit message wording and tense
 - Improved line wrapping
 - Fixed a trailing whitespace

 t/t5500-fetch-pack.sh | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 2677cd5faa..4bb56c167a 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -892,15 +892,20 @@ test_expect_success 'shallow since with commit graph and already-seen commit' '
 	test_commit other &&
 	git commit-graph write --reachable &&
 	git config core.commitGraph true &&
-
-	GIT_PROTOCOL=version=2 git upload-pack . <<-EOF >/dev/null
-	0012command=fetch
-	$(echo "object-format=$(test_oid algo)" | packetize)
-	00010013deepen-since 1
-	$(echo "want $(git rev-parse other)" | packetize)
-	$(echo "have $(git rev-parse main)" | packetize)
+	oid_algo=$(test_oid algo) &&
+	oid_other=$(git rev-parse other) &&
+	oid_main=$(git rev-parse main) &&
+
+	test-tool pkt-line pack >input <<-EOF &&
+	command=fetch
+	object-format=$oid_algo
+	0001
+	deepen-since 1
+	want $oid_other
+	have $oid_main
 	0000
 	EOF
+	GIT_PROTOCOL=version=2 git upload-pack . <input >/dev/null
 	)
 '
 
-- 
2.52.0

