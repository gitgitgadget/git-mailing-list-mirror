Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793274538;
	b=Ez5QuqJgtUWrE1288fSLLn1T2tKCQl3P4M8Eu4CrKrkBVRy3k9Rkrqi5upGDE7r+0fzL
	 sQ/8/Zq4HtzTp6ejoEjGui6G4W4ZlZaFD6LxbUtB3++EcuLzLCWtqtP3kpAPydvQ63iQR
	 0WtDeCUwfoK7pOjzTPAl7pD2lkw+eDHQ/A8Qr2TquND+5/SoxhPO3IEZykaPyBNNWvndQ
	 bZLrmYePq7ZiV2wFyGOuq/jGof+/I3uVoanFv8AeNaMb19EyskrspGdxXUmijrEQX4IG5
	 G+nKwwNLbpQyWJ2tgY+uo3hjKVxYBOoQIosgejtCpMXe5sDAsyXWiZtzB67VqJ2TWVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793274538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jtvn1khV9c6NnLrdQ03Zho56OFLqFFf4nTqLvmKnhjM=;
	b=E3mIXgN7PdU+9C/MTsD6k/8m1DpsJDMZlVp7i3Aw5sB/kuWlBIB41jR37NZfiOE/9Ec9
	 a/HLJVzLoJDcagozjK8ZR1iIzEmUeplE4hQVIU1oJdHrAossIq5U7Z48e59QZQLoplmkH
	 oX5UqFzalOp9vUWuj9OmWlYq9TFWJupQ7sywI5PSeAhKJVzdV1uSNKyUVS26yUEhHwuJI
	 ZjINszxZFum6i5/9L3CUNowmlOO1QWsL89UNh0LPGNL+wFST3/emgdvvBLUU7wsTW0CT+
	 0ZkyEH85GwZwy9V+PL2Bk5tdw4gn3CCGj99NsTaXOfdSE+KiAhqT8y86VFRV6v/AzBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXWIITfS;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C35606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 11:48:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0C35606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CXWIITfS
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a2167bd087so20751465e9.3
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793274536; x=1793879336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jtvn1khV9c6NnLrdQ03Zho56OFLqFFf4nTqLvmKnhjM=;
        b=CXWIITfSF5WnMjP7uA9z94giYislOFZdgy3d0J0IPqgd36Bp2eXLWMaU7PzjYxb+zt
         EZU5/VJlHWrHZv7mSqe8gb5yVbjggJUGaBJwlJ8OsNzHpqprQG8Uowhyk9pgkGfOKcWQ
         4++6S2dY0ZmRHjw/3IIDOufb1kaf2JlhiJEptY8nOCXGTHTkjvgBml6mlfB0BBoxwUJN
         74sB8X26h+MRqBQFtapA0grFChtoz9CJWe67Zdkfmx7kO/9gUHr3EdCR/4opAuDveOVG
         /sl7IAwa7IJ2UJ7R5Vwdokb0JPuCmEfdDgmtI1/X+5uQxIsTOfX76YxLviLV53aNVDRt
         0gDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793274536; x=1793879336;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jtvn1khV9c6NnLrdQ03Zho56OFLqFFf4nTqLvmKnhjM=;
        b=zfdI0h1lBfbwryBcEHU9yZPUvTo+boazkyTq1DXoZufVRHHPw7ysoiyjbTRnb03wmF
         KK8mxPyRGkLk6EbVuAcNFCZ8CFQhqfQT+PVj45AlJD4/L/xElxzRT52kyh5PDWQXR2DN
         mtGe/TaJn7gAchlITMIZfyV66+RKWWAexxVuYCkNjVwWdgitP/yDoHp2sZYCEVFdj7fR
         pa1cNf2XPF+K5jkGiyXSjt0XQ2q6zepMi2bAMgEIdFOsJvQIDl83UyOyjp/W7UM2i0Ph
         bskxQQ/O4S4Y7oD03iek+HHE1EbY4tv7oPwUBgdoQYEt/qRhkCxI54fOvCW0Q0QnW7u4
         KvRg==
X-Gm-Message-State: AFq9FYI2noQDFrvz+f/lVXEdCdb2VjkXs4vMzQ2mJDVFGAO/ZND0CzGb
	NNPssdzWpLxFp+WhNIGBgmtFZB8N7ybVi150eYHhx9nU35r5EMUy8R5o+9rGK4WL
X-Gm-Gg: AYBFou27F1/n75TP3PP4PkZwZwPJgs8nV1G1Up9Te9tWv2HU8IbhAvwIQdnhhdhh8fs
	TN1lSZPkHjX3WC7fj74KhR5YRRQxXJDFjBN+0fq7uREnzJkgdInx23/TSMKNo9ymVK2bKx8veJZ
	5mal+/DkDwxvTLMHF/qipZVt1RUlO5mbj/bbV72kl7eaWOTx8P96fg4lTNqYOGn73Lx3ZvtbEIn
	iVXwFFzN1ugPsiERoGYycVeUPn8fh2NZVIwhbQSmINloTp41YxpM/Ap/gz4GH9FBVP5hflLs1AB
	yYZ2SIXL3M5DRcvEhGp3bQosRSlcSzT34Za5rEFSAdBVZ+8e2569qE0YnUHBzQCNC0j5VppfnBm
	j+lGiyvDyBYpwkkVsZBAbsGQ8JpPkdKaHKIGL0MBrqP7uRbzK7ghMz0DhBxjEeVzb442eBVkHay
	+TJHLemQpcVtEXoK+dIZ98y0+JLUmTfoy4Vu7eM0sBiDbiaH2Cmge1G/gT/v+i5gA3F95lxcYSN
	EfosiSsj4tv1hCIcQSH8R0eHkuwNBa3dp09Zs+QvB8NlRuPeiBOf+HWn+feS4zanbPMb5o6ZYm+
	yMGQQS3JIEhm7jRn6Adc8qd3uyro7mL3pSo=
X-Received: by 2002:a05:600c:5246:b0:4a1:faa1:3813 with SMTP id 5b1f17b1804b1-4a9674e813cmr111893645e9.27.1793274536050;
        Thu, 29 Oct 2026 04:48:56 -0700 (PDT)
Received: from debian ([102.88.114.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a93103e72dsm82355545e9.2.2026.10.29.04.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 04:48:55 -0700 (PDT)
From: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>
To: git@vger.kernel.org
Cc: Ogundipe Sola Taiwo <ogundipesolataiwo12@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Usman Akinyemi <usmanakinyemi202@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [Outreachy] Microproject: Modernize file check in t5300-pack-object.sh
Date: Thu, 29 Oct 2026 07:48:31 -0400
Message-ID: <20261029114846.1601-1-ogundipesolataiwo12@gmail.com>
X-Mailer: git-send-email 2.56.0.116.g6de20f6092.dirty
In-Reply-To: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
References: <20261023154851.7876-1-ogundipesolataiwo12@gmail.com>
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

> "Improves" -> "Improve".  It would be nicer to state how use of the
> helper improves.
>
> See similar test updates from others and review comment on them in
> the past 4 weeks from the list archive.

Will do. Thanks

> Thanks.

