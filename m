Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794270177;
	b=lNaTiJbyz/rC6AiudgsExPXA3ivZIuS5QrZI7ANQiXm3OGnRnOPm/brsxxw9eCiHDgp9
	 H5ZFkqa1fdUzH7CcuSJkMBrpu/bwo+uydUuhxdPW3dxhBTvNZyRG64uaNUiBBIcKIRfOy
	 D3uqNHWXzF38mKM4VGVNkWf7OC00/RMLq4mD8/0HTxJruolhOlrpXpcbijouJVCPsjc+q
	 ObkBhN/Ap87jTjccofUl3o/L8R/kA3e9oUN0TRtVWlB848wwUtF4WSU4beoRnoODDG0e+
	 n3KjiZAl/BBBgZILNIELyRPS3UPiXASSNZevi/7nfdkLsAj230Vb/40BEmQ43ZwutvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794270177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=VyoqiJ/zTdeNVvNdPidTagQb3wLGhrW2S2AsgK3njZM=;
	b=1D13Br5xY1yKEgSGMWZeYM8VArv7bRDQ34jZeXek99MrKNw6GvrHD0JSuz6tkqNdSrh7
	 bu9DdPgGeGA/UrRLGDhQh3/3kcHYkuYgOB0x8+SiBoRzUC2B3dOohCmXVQvjIxOEpqQC/
	 NklIxvLqpi3TcmeFoowvE1sOpvnx84CZFrVQ3ay6YD68JOrP440EcnNngPsCu+ynZALYO
	 rFN1NFShpSNx71gFjWVESRRnX6nVvq1VT4Tzdt7K+k0HqqMuyUmbNSYEm3cVRD2U/0/l4
	 onSH+57HhNvbNJE796VPlUs226YnuvtIiigl+X4ww/4tsv6pgntBWinX9nDF192lLog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNiSyQjI;
	arc=none smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09585606A326
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 00:22:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 09585606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kNiSyQjI
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8439fe796ebso957988a34.3
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 16:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794270176; x=1794874976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VyoqiJ/zTdeNVvNdPidTagQb3wLGhrW2S2AsgK3njZM=;
        b=kNiSyQjIcAjm6/l50Drd7XvcAFXKau1wggEGoF/MT5sr58AxfD8VS6az8miO+1+T54
         lhhzjqdlqBzE8OateqcjXQfzVlo/dHQYpWU2gwEdB4pfSXj64NlYOdOics64mph5BUhm
         180drZ8RFB8az5MY38t8AfnMMrCgrTtNdCXwNEl1nvWJkbTaWGjr7CutPBOfEKvejdVC
         GSpHqWGs4FOSlhiJyKcDlcPMTeCqgzVF5pQoGGRlWUtTZTxbljYLyFeZNlfVzGLCktzH
         ZijZmXDe9YznQxUQqtf6SfyBleGrSjS7D7uxYwkt+qfU7V+1LXnko1gkx8Zk0PwkoqXO
         Y9rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794270176; x=1794874976;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VyoqiJ/zTdeNVvNdPidTagQb3wLGhrW2S2AsgK3njZM=;
        b=yR5IoqepqoPRO8YDRykrpnFcTajA/IvBivQPJ4WeCOn3GiWrn1CNyqc6ZtwHSAOid9
         HL3e6pNa3dCKnXYgVLYbxJnQQrdJCdKOkZ/2poJ+dOlZHCza1PAMLqTpMs1Lg028mnNm
         wEKqibeCnIQfKeNdW0c8Py15mg6wDGGCsUozoBbU+P+U1Ljv6A/yhNUII6j73ncnysFU
         jopaPey1ZAtCuxOy65gH9QEUEXBA/2vGykInHHT2WmbPjcKuGstf91zh60ABI685X5lD
         ONO3c01Gw90CWnld8GbBzexv6RrBTNmZ/8lvaPUk4qIBsjCzC5MO/Wg/KZyUxqf5IM1q
         v5GA==
X-Gm-Message-State: APuU4Z8V/rnPp9tkdKLjH3sQSBDoMscNYgVw9P6/a4/WxO56SjcJqptM
	QpTGSypHj7XsaqeTt8b74xVHQcogQ0wyXJmcdZVUBVKyXcnfP7qe+/TEvnNY2w==
X-Gm-Gg: AYBFou2BQh9GTDkLCWHZUMto1jtu948hBuu+J73qCukLnLyy0wKOjmp6Xlsv+X7isMN
	KRfR7QX4CVlUAJxBKU30z0xYR+0vFZc57Zt3QyU+G38ci6oEt413J/R5TDuQNNn1vxUrEvBmYt/
	zFtNR6qflZiBhkXLo2lAYbRvzknWvka+YzFmHAUudUHsy/kFoUC4IozRA0f1dKlh5+ZzDAKbuWg
	BZVOmJ0GvXOhiJbThLNIf+UgVWVdegNIOd+coy5YVO80JQaYxIeNZimUM4d/RChk9HCkfFbRAgA
	tGP16pFx7h8IRKh+mr9Qjh27opGcnhRWHt3nYsQg9GHEkI3LW6DteBdcHtoie7Bnvl+EA69IK4t
	4OPy7G4d1ql/R+Lic02+t9iwB/nMdCN4SmbiHB5zhQsGmjDRjlVbyf9IE2u2k004QTwZQnEF/Hc
	N8nJmYovoRCANvg9IXXUr15ZMH10JOMhKRpRJUWFAa/+c7wzPrq9soiExROqYvbXavCMKrclYF9
	MZ1HQ7nmLZVIE6wyoGIfG5DkPRf+1QMl5RS107aNfNXn93va6t/+wQoW7GBbmROuernxFgnhekI
	1py+bKthadRy3WVT47tH8gQssHshzxeC2D3GtZ1KWWWuPPcA7ygefB/DKrJHLX52fbVy
X-Received: by 2002:a05:6830:4c0d:b0:822:e81b:3ec4 with SMTP id 46e09a7af769-860dc75ed6cmr824807a34.7.1794270175904;
        Mon, 09 Nov 2026 16:22:55 -0800 (PST)
Received: from denethor.localdomain ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dcbc82b5sm680518a34.17.2026.11.09.16.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 16:22:55 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: Justin Tobler <jltobler@gmail.com>
Subject: [PATCH 0/4] object-file: eagerly create ODB transaction temporary directory
Date: Mon,  9 Nov 2026 18:22:47 -0600
Message-ID: <20261110002251.2007617-1-jltobler@gmail.com>
X-Mailer: git-send-email 2.56.0.173.gf57c9a7388
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Greetings,

This series continues work for the "files" ODB transactions and makes it
so the underlying transaction temporary directory is created eagerly.
Previously, by default, it would wait for the first object write to
lazily create the temporary object directory. Furthermore, this series
also ensures that objects are written to the temporary directory for all
transactional object writes, not just when batched fsync is configured.

The first three patches consist of some minor preparatory refactors. The
final patch swaps to creating the temporary directory eagerly and drops
the lazy setup.

This series is based on 3c60ef1e38 (The 17th batch, 2026-11-08) with
jt/tmp-objdir-loose-idx-merge merged into it.

Thanks,
-Justin

Justin Tobler (4):
  object-file: rename default transaction prefix
  object-file: only flush batched fsync writes when enabled
  tmp-objdir: preserve errno when directory creation fails
  object-file: create ODB transaction temporary directory eagerly

 object-file.c         | 99 ++++++++++++++++---------------------------
 object-file.h         |  1 -
 odb/source-loose.c    |  6 ---
 t/t0004-unwritable.sh | 19 ++++-----
 tmp-objdir.c          |  8 ++++
 tmp-objdir.h          |  3 +-
 6 files changed, 54 insertions(+), 82 deletions(-)

-- 
2.56.0.173.gf57c9a7388

