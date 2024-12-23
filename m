Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B4428FF
	for <git@vger.kernel.org>; Mon, 23 Dec 2024 13:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734961179; cv=none; b=hWiNqJecbrE3huqdQ+XwgSACbdKD98pfopR4AePtBXCWhUOL8fyr9Jb8T2AWXRSKvlBbz5XHcoMU2GVXmykmYwIT9X2XISeSdG2tAnS6Jc9fLgllwiPkgBXN6TtGejA39JPY/rKgxP/MUgnoTaVZDKy9R2Xorh9jE84RfK71yfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734961179; c=relaxed/simple;
	bh=r+xELPVizMyu9WiS2rwvQcKQW6SZvGxw9dngiuXnHaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XV+UEzlRh4JD0lqcmo0218nxDKVugVMteROMM54SFbg044LOe8uSCyo3U0bV2yrvymHfXqzOtCo2by418dzTULeJ1TaN/5RBdrv4dOvWYXNVwuAGjKjgc9coEc9jmYjFOAiXyQh2qTai6I6NRTTuzW+JuKeOJ180lwCKiF6im2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=OxC7gvaT; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="OxC7gvaT"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-aae81f4fdc4so457779466b.0
        for <git@vger.kernel.org>; Mon, 23 Dec 2024 05:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1734961174; x=1735565974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyIoH7hflda7J+9t9lsI0Cphyj/c2v6RSDMOaZkiO7Y=;
        b=OxC7gvaTiBfSS+UiFk5QyQhQCqMuAjQEHgdDBGxRQhSUtQ2mJ6N9q8H+LzCjF4oy/2
         KlYx1j3PKMLWNbA+D4eXVqmSvUO4fej7LAopgi/sD1d0/OfvmloGKxwXvY4khWQiy73+
         dYRThPTuCov3Z+tbKcnJ75H/3WBWUq/OIaHbyITJDpRMVDHj9v9aR4iWDtfAuX8g5qj3
         hKNa2XXz7qH9EQc895J4X2g7Y7R5CpSWd3TlPLwseAVTS0Qf8yKkVVDGIvAt2npKa1Pb
         QOOpqYyDhUn+cM9RrRID6+xTRcdJRr0uJWV81/2EV/B3DKHx0PSQJRpdu/TcYYRh8/qz
         R1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734961174; x=1735565974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YyIoH7hflda7J+9t9lsI0Cphyj/c2v6RSDMOaZkiO7Y=;
        b=ZhDsN2/6Vj8uJXn71LxNeeeNpiMw6ikBV86yrykL7a+kGIWXFstGpnQor8oM//WTUM
         rqJfSu+Ki4qar7c7RQxTzAFyCOb8Ipg6zIybvdHV2MGe1P2tdi/a01NtkR2UOwYYr9m0
         rVxso1etdXp5WuxBiDbJ4kvljdR8R2r6ZBRxuLZ3EEJeB9sW/2SzNy/vJictVHp7Q8/f
         kXsAlrHOtcVHuuEywXZNpKsStX21m7TPjkvwWiiZInhzEfYwR07BsjEUVoeT+g2PXZpi
         3bI6paM0mMAaIKHYoswe/v+w8dS+KzaYs7c4J2SXKklCIIFkCX8hoappjYaZ1TzDHEYF
         G5mA==
X-Gm-Message-State: AOJu0YzEZdXLcIuBoCQxu2S1O5gYbzS1TIOqs+5uKHRm/3D3SReXujsr
	7y+69FKliSoIddu2WWG9/KLsQFlNve1iKptyBhazsUs15NeiLpj/xWsqmPXwsyQqP0LfpWbXo+0
	guWo=
X-Gm-Gg: ASbGncvx/fsuDpw5Vwjj7zUZCV9IfT+Qq0hLF4eBVsREb7BkIZe8Os+6uaNOKgRqpYp
	ZWxtQBILUSknDAwU31YIiotj4RaLPUrzUR2UC5dClerhPmH8S9E79RA+E69JLRDmNZPbNv26hfy
	RfZWPZwt2arHMLiXsT7XafqTNNKchDrV2w+ue8caCwGt31SDeyYg3QrcIrfg5JZ+mAGzQnJhhUV
	ILO1megzSG6Jy+442Jsqe+ZY/GPbIHg+SCTQnVAAn2kQcX53tbwDJezezASpsMMA5tam3GsHyQ5
	8yHIDFDbuoQd6404gpOE8pqdZg==
X-Google-Smtp-Source: AGHT+IHfcCJglcMB8nn55/u3hoULU0Q2RUNxCtA8VJ8+idWDkyj43x7XimNRzAc+inWS2TxsHl5bag==
X-Received: by 2002:a17:907:6091:b0:aab:ee4a:6788 with SMTP id a640c23a62f3a-aac34218829mr1478632766b.57.1734961173461;
        Mon, 23 Dec 2024 05:39:33 -0800 (PST)
Received: from ashopov-C7P4TNH9MQ.corp.uber.internal ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f06dc7esm519007266b.193.2024.12.23.05.39.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Dec 2024 05:39:33 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	paulus@ozlabs.org,
	j6t@kdbg.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 0/1] Updated Bulgarian tranlation of gitk
Date: Mon, 23 Dec 2024 14:39:17 +0100
Message-ID: <20241223133918.25133-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello all,

As I have submitted the updates to Bulgarian translations of:
 git: https://github.com/git-l10n/git-po/pull/811
 git-gui: https://lore.kernel.org/git/20241222200707.98738-3-ash@kambanaria.org/T/#t

I am now attempting to submit the updates to gitk.

I am not sure whether who is doing the maintenance of gitk now.  I've
read the thread:
https://lore.kernel.org/git/Zzxhn64xeQv6ItXm@thinks.paulus.ozlabs.org/

So I am sending to both Paul and Johannes in hope they will ping if I
need to add more ppl to thread.


Alexander Shopov (1):
  gitk: Update Bulgarian translation (323t)

 po/bg.po | 696 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 360 insertions(+), 336 deletions(-)

-- 
2.47.1

