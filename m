Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792770540;
	b=4yySsbS5ab0Q2HcXxjaBMO7n1SWx+MzOpEQRhHEQCXdKAXRVHsVHz67Cx2AzXTE2w4vW
	 UhEhzNTZfOVmaOmTww2jhCFNrrGOMwF80TDk4clSxnZeDeiu62JEATyl7AeG31ym96G0/
	 Bkf/FYkxDaZGBsON9qTBJxaFJTnpnINzJi6HwjthpnJkXMop9qWEv2XuDjnYbeB3ISuMu
	 DLTZNdhM/KyH1SAR0Q8U0nsxQwSxTXqOCs+RWyu1vlRqErXJ4a6g6btCKpDqFm1RJY9pH
	 VniwojKCg4RNipco0gpFubWKbx9tuRXpjBogijGyStMy0KM4Vb1ZoP0wdwxq9TomvfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792770540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=oeU7lgwuiQ0Dh3K/jRD34mfqZTC5IM4sk45Wj+/qkIU=;
	b=IULTFeGwDvdRdU8BofnWYemypFoqp4hjWZzpdRi/hTP1e7NsTy6+GOEl9yQ4UH9yMFoB
	 6cZOAGIvpaWV68LbSexoLyT9hPZ2RZH0VYe6qURj2Vvkwp6UDx9VkbB1IEfzzbWuMLBZY
	 ktqXJHVN12etLxLFEpYrZRuI6EqJXaL3bvZJaBEGMLuRdob+r37vm/gQmEiYoSsD0oitw
	 SCVoQSjYjivBEdfBOiM7RmbrX3cLjTl8zrQf/lrzgLoZZyrn1SfsgtvlZQ13qB9CJ3R/q
	 PHmGz2W4YPaigULutUQ+f1UriHYWcTEMZbcf1Nd3PZrroV5xUzF0ER31IkR7ijD1sDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgtbCQLM;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856BD606A31F
	for <git@vger.kernel.org>; Fri, 23 Oct 2026 15:49:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 856BD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HgtbCQLM
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so6766365e9.0
        for <git@vger.kernel.org>; Fri, 23 Oct 2026 08:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792770539; x=1793375339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oeU7lgwuiQ0Dh3K/jRD34mfqZTC5IM4sk45Wj+/qkIU=;
        b=HgtbCQLMWYZ34eGg3rj9HA8/0n0PHpbDZQwEuNvkPYAoQ90sVp8YHdy/sQIkjjEreE
         BtLYeepp0hsY1srxb5X+FjmTN8t2SEfCUEBs74HUlldIKR2XIqJ3um41pgI3Q4OIIvdo
         l8yojBSy7DgbKXvmx5ZQTAOaHMQkOejEaaDiAL6XM5PxpzOg8IuXdMAnY/VAz5xYS1Ls
         obvwdH3wJqyNLhULuD2trY9NRUslq6jathUIjaZcIRjYW4e/ja4WoG74VcxOSPKJqyf4
         HNpb9LmFxl+yqsO4h1eaRHumWyMtUd2Uub2+o7HaWvresMTBoqCB4gawpPVIgT+LRJGC
         Xzmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792770539; x=1793375339;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oeU7lgwuiQ0Dh3K/jRD34mfqZTC5IM4sk45Wj+/qkIU=;
        b=WiBnG5heQWfNVcnX//CygmeJjguAJniQdJE9l6/p3JhZnnoxD7U0IaSEeGvkIO5RZF
         ff2DkIJYoTXObqtP3M0RMDPtN+/ZH+maMODaKtTSFkiBojfza0HPZNwxY4HHQJlM6qIN
         vJCZhBeSs+qZUykboxLgiHZEdF0nIvgmmZjp8Ov2suw58Rvl2rz5mgg+cHJWYFi1jjDl
         Yr4lHgcnj2ZhgdxKTnovmuNHfG2AbyJe8LaYQGhcZzQDeSIAdPejIKe9+XQLoDO0Jrsl
         BlVYGMQNVTA5hmEPblj47vTsQInbG9URH9iV1Tpu0rj0+hk2tfvj9xcqnmx0kSIAVS6c
         5SCg==
X-Gm-Message-State: AFq9FYIxir0ctgtZQVFklboC2DqlqPC/40d2Nu3AfnnSrWtkAWos+SlJ
	uKIBkCBgv9sseQ3VQrqVGFTAF8erB9NgIlgJ1+X4Z03V4KnNMbhUVbbcD4Ak430AQOQ=
X-Gm-Gg: AYBFou0YPJKHjQRJ/H/EW6nvxZRPhfZbA2CY++bN6O/u6ezmAVQRPb74WJ+m7r7uR6L
	VIX3i6QdzKIOckW9ZS8QgB8u+l0y7rOwV+U3M/mzahUXBkthrG1oebQ/e0/TjJZhy/ErVnMrsdP
	ekmIC5MyphLGZ8RlX0xo4eKDvT/f6LcWp5lqN0o6Xma3xCnQjR8mDQseVlTYMjnIl7MWpNOoiWr
	7AVBU8/a2DaGwCxqRqVVD277fkndP3mGiyrDtAUEeHcSdTAoGhiEIJxsLOs14E+brNm3HWyk3ix
	TpZLhmCzbJZqk/a0inAImZMgD/zIY8/vuCb5xbiqvVifyOcw5OEsy4NEgzRvZ0VA6nOtItMRca5
	f5wgrsuN3S5u/gfGeLOOYEWMN9oVsLNIINm8rb6gCEixSpihZM0Z4MOt/i76EVZEWrghxVLc5DJ
	1Ysnq+V6mymA6gNC5Bw5BAdrwY4CB3z9uN4/21Zn28/lMV1unVEXSc6397Y8Onn9d8XfpxiV5GB
	Ygxwb/T+ZYGsa0lOitOug8HP/nV8cFjHdl8PHHbL0iCzr2xD+BY/gzei50=
X-Received: by 2002:a05:600c:4e12:b0:4a2:b13:389f with SMTP id 5b1f17b1804b1-4a211edb2d6mr43475495e9.27.1792770538600;
        Fri, 23 Oct 2026 08:48:58 -0700 (PDT)
Received: from debian ([102.88.133.53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a2b065c850sm13444475e9.13.2026.10.23.08.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 08:48:58 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: git@vger.kernel.org
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>
Subject: [Outreachy] Microproject: Modernize file check in t5300-pack-object.sh
Date: Fri, 23 Oct 2026 11:48:42 -0400
Message-ID: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
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

Hi everyone,

My name is Sola Ogundipe. I'm an Outreachy applicant for the December 2026 round.
I've cloned and setup the repo locally and also played around with adding a git command
following the "My First Contribution Tutorial".

I'd like to work on modernizing the 5 occurences of file check in the t5300-pack-object.sh
file. I've checked the public inbox and found no one working on fixing the same issue for
this file.

Please let me know if I should proceed with the changes.

Best regards,
Sola

