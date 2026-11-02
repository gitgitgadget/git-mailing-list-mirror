Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.231.85.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793656150;
	b=ZQldK0eX2OZjgHGxqp3QCwlzPYLqIKvk4l9jPzCS/1z5T7mGvoHGNg36ZBBASBC7vk5l
	 nGMz7PMVWyQD2Y4kuIh06wj25Tx1IovqMpgvKi+EPzlsbPo5jJvI/ZxrzfNHTgmfkWHFF
	 kBCPfj2lCeIuLaiCE9fq2fxMfX4uoLn5wMbDPRQZzYfbpuwoRuSg2eHTGBbIou69xhe0e
	 CYy+MPt72fg/DCaSCwqXDvWn5M+7k8Dr9p5TAO0ew8T6lXjUffAI8yRWPhpU3fJqKqPmN
	 BFEsBTy9nvYZD6BaWa8C3XK8zegq2Iqm/PZ7SEJJKX2ib2eg6rEMzkuUOPP4h7qIObw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793656150;
	h=DMARC-Filter:From:DKIM-Signature:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:MIME-Version:X-Developer-Signature:
	 X-Developer-Key:Content-Transfer-Encoding:X-Spamd-Bar;
	bh=tVzKLolOVbZg7dhCCGcN/yCznQR8LU1wMfwbNVyaHTU=;
	b=nt37nPAlqi32vxLJty8DTqAka7kDMN/iIZ9QpRe5Qvb0gihuuuywnY98qFqoriBhd0v2
	 7MIQ4wnLm2sa9QRk5Kxm3imuWMwsCbcEXaslqwmMEVY7MIkBOStb2bSzSuhfAu0tXszOS
	 mhYsCKbVmt8h3jmBymsEtc9Kf+kWJv9hAJl1j6BUqqKpNz4Uup1FNFaVbWbaiXOXPeiIc
	 4kt2TP2HhcUq9wDRdtPdrwDE91YHcgzlYCrIh3d6856jdm2/pRD2KauCIkFPITx1Qy7RG
	 S/Ox3/fm5B+KzIlNpqKztDUyH5naZ5CNB7sBjiTxKFXsBHkvqJt5Jg6qZnsAb4+lVXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=delayed.space;
	spf=pass smtp.mailfrom=delayed.space;
	dkim=pass header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=K5aWV0vG;
	arc=none smtp.remote-ip=195.231.85.169
Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D301606A327
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 21:49:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D301606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=delayed.space header.i=@delayed.space header.a=rsa-sha256 header.s=dkim header.b=K5aWV0vG
From: Mirko Faina <mroik@delayed.space>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1793656146;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tVzKLolOVbZg7dhCCGcN/yCznQR8LU1wMfwbNVyaHTU=;
	b=K5aWV0vG8mGEJaXbYPDzG/d+i6LKHbMUhS+Umk+Vcm2JTCzItS+6TtMfxuF1eM9KBnXwsi
	B5R8fp+UlhfaTR64TcpOuYD16HmpSKbogKmTtx18FBcbmVR18F2CnWn91rWYgyuFNvRd1e
	7F3Tlbflri/AbfXxHsDlKrR+z6/nKvCLzofuXlQCtXKzjInij0KJx6LyYffgPwG3jLhc9d
	s/s0/I6RwBfWp4l0ZJBnESLlBD3hUIpx4qf/FSx95On63yMffCf5moIysLxa2MEM7FoD4a
	n/TkH2SC/O+H/RCsmYebMbuFX53zRmQLe0d7nQCUVymMCkYXfk2j/b6HQmnT5Q==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
To: git@vger.kernel.org
Cc: Mirko Faina <mroik@delayed.space>,
	pabloosabaterr@gmail.com,
	ben.knoble@gmail.com,
	toon@iotcl.com
Subject: [PATCH v2] completions: add some missing options for git log
Date: Mon,  2 Nov 2026 22:47:49 +0100
Message-ID: <5735bacbd5c2c48eddafb43f75f7ddcdf402ff17.1793656021.git.mroik@delayed.space>
In-Reply-To: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
References: <63106e1dec45e82c7f132a18816b2d1fffb52752.1791921033.git.mroik@delayed.space>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1046; i=mroik@delayed.space; h=from:subject:message-id; bh=0Ghl8eGvHyoEXPQCLyOjgYfuIK89bMeBXpVF+9AS8As=; b=owEBbQKS/ZANAwAKAUh5fqGcGb7RAcsmYgBq6QUGAbmft/Q5vpkUoEXStzAhB6Xxcdcsc4iaz iCjznvMhgGJAjMEAAEKAB0WIQT/Ky37K0pSwmwsybZIeX6hnBm+0QUCaukFBgAKCRBIeX6hnBm+ 0YWSD/wJauWhGNh6+e5RpONhmv99BKePeWiwXd9PM+ag8xZWc85qztMhJT7t44yfSiwrMJhJ1Nb cFS39E9mu4KTcZyxCNtzcGN5eCVF8+lDU5ML6HIBip0rtokhoMrf+0a7HYPXiFXzLlWaECZUY4H MyeO/d64O2tYIqyhv4q1bJcbZnx45IrFoj/N0jI7EYF8AG5uAs9u93MxT77fhXxB31ljLghhTeY dqxsi6348xewQm+4sUkM3LmYDhUaeH0/bFsp9yTFArhNRssnAd/b3U8C47mA3Oib3oGuCilDt4i WYCj194SRz6OrsazBdaoBIOOpfAcBvo1lqufR2JFFEw2cPiz8/FLwhW0ax32XPIRrkS2Vkh2isb 2K0D/PGMEMWveUvzUXzi44iloXcQlAQncj9t27IqkvoMiAG2KQScg7LR60qXg9fK3pRSLmA9lQV fExXz59Mffwiyg7MBSM4b2Ou9HK59SVAUcmkqpPvdoS6/LtoRKm2ho8suXYpa/3n9oh7s99R4tf dfr64NitSzGy5E1hyQMsUQIEy5WaSCHLdXj7KyIKnhgvo70fZY5eaC0+FBMiM6hsvUIUdl9XPO2 Neb+eLnvYpfF9+8s8sjmUWvX8Qi8b34+MhqqAnGmnJpDC285UE2ND6QFG1DWILe1WXOMNcUK7C9 J53ybupOZ
 UF8GzQ==
X-Developer-Key: i=mroik@delayed.space; a=openpgp; fpr=FF2B2DFB2B4A52C26C2CC9B648797EA19C19BED1
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /

Some options for "git log" are missing in bash-completions,
--graph-lane-limit introduced in [1] and --[no-]graph-indent introduced
in [2].

Teach bash-completions to autocomplete these options.

[1] f756a3c78d (graph: add --graph-lane-limit option, 2026-03-28)
[2] e9b5720bef (graph: add --[no-]graph-indent and log.graphIndent, 2026-07-14)

Signed-off-by: Mirko Faina <mroik@delayed.space>
---
 contrib/completion/git-completion.bash | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index c3a49e2e22..eab6309a69 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2395,6 +2395,8 @@ __git_complete_log_opts ()
 			--cherry-mark
 			--cherry-pick
 			--graph
+			--graph-indent --no-graph-indent
+			--graph-lane-limit=
 			--decorate --decorate= --no-decorate
 			--walk-reflogs
 			--no-walk --no-walk= --do-walk

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

