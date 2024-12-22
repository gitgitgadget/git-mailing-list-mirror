Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C757748D
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 20:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734898049; cv=none; b=Qs+tR2WOZ3vTZtZ5O4wAgDzne0GZlUSeN+iT+ybjCuMkOChQw1t0FEaRb+9zJpxrfBQ2YKRNxvpFVGOS4JzsyE0YMW7cTs2UwgP8jWirklk5YNGdW3v7pgrLQRy8E913qbgJre7a0d0d0T5GV6HJVOsr4HLVUy0w0lsuJjWABiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734898049; c=relaxed/simple;
	bh=vDv4lbXQGbg/0NfD7ziGh2QEoly4zLGPI63XMubiIyY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZIj0YJ8WPKAHf+mgR3jti+z4MxMa8IO/TBmKQFiyNy0+C9l+2zfkHKRLtA5UHreN3AFf1kn0/UezCuFqhd3GzVIMXE9pH/yqL63D5CJpNIEXsiHwNQmUUHq0UpqCark9WQydEyr95nZ0DxrRa10qo2zcTouVaSLY2IQAR3XXQXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org; spf=none smtp.mailfrom=kambanaria.org; dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b=RKuOekPX; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kambanaria.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kambanaria-org.20230601.gappssmtp.com header.i=@kambanaria-org.20230601.gappssmtp.com header.b="RKuOekPX"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa6c0d1833eso742658266b.1
        for <git@vger.kernel.org>; Sun, 22 Dec 2024 12:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kambanaria-org.20230601.gappssmtp.com; s=20230601; t=1734898043; x=1735502843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IATF5xokwGD2DWc8fjpkcc9oBGFODR3VICTsMUgZQ9E=;
        b=RKuOekPXXz5t8dlctonuUjwaqofn6s9/TKYsg/7PBAyW11P7lAISczoXVMMabqXxYc
         6J1Lmsqjdol+juiO2l+k9vH+9hMpkBpyhGchlE5aBkSVrAQy/d0XeDwNvpdj7AAfVjIz
         Z6CTiw/RPIrsRBZydeZSL1/5ivriNmhzmWGEAC7XmDqyYgS0OXDnxF63E6TLi7Ubdkun
         i55WtjIkmNxzcow5EMMpx+xqBFP9URBwsKu7iliF/KUkTenRhRRB4V7WNWUnCBVEZSOU
         j2Kza0G1Rr1288IdmgCQ+a9fLAJxwPGQCpWl8aoYd8vKvrDJ87vRfH9+5VwlbqvtPCnp
         Lwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734898043; x=1735502843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IATF5xokwGD2DWc8fjpkcc9oBGFODR3VICTsMUgZQ9E=;
        b=jZNfxvXhW59535W4+dI57JXvpvc24iBOLTU1URKf1cIAhnITT2N0Gzsokk1rtjaexV
         AUvNlGzB8Y59oCitCJ3i7Bmulovs7FQWD+TP8gz+FFDI+rzSspmJ/nA8LspGcJPOJUie
         7PbVRT8R+p7n6WEjHZB6wdQx56dh7s4X0F9pPGG68XKLgHNGdQowMojnHgVZY85BiCfP
         javC6mvZ+Kx/vVhhkWmYZxYFLQBDqRv+yHqJg3uT0xTEzsgo2SA6vsMUlwU9h1xvCGzX
         5WvnrTAxIaqW3DSIw+KwVAAas6ENk9YBMjRcpQ0Ug87YG+E+00L2Vt+kHNr1y+A9xoES
         6spA==
X-Gm-Message-State: AOJu0YwFpvSRxeboegaZ9UyiINl3aVBJwuv8V1iEqBdtG3VJsZB3CxKo
	KPXIslya6L9TdMRZLeITAKekQvZs9Q0ByA5kEJcxhuJ5NS5bAPhotRVFzyCXlifMseVfRSomO7G
	jYcQ=
X-Gm-Gg: ASbGnctk0dzAj+RNphq1n67Gl4g5SsNKd4mHv7Zl7Bxb5A33Al3uZ0jZARuBsFEewz7
	wgsUxRfJ6WzzQl+bB7edQMhYqgtvEbp6AAlZOOUivDJoP6R48oPf82zNO1VWa095Wupe++lzjpy
	/Ps1OInir3MHvl90XpaUTpMsLNNBlSHRJqNpMLLRIJZkTyzAtppjub1KmrvcRcjN9Le7ZFmEz8a
	0w9yTiVqJmAHYKFZza2qErGgOVEDOb5a9L7FTXjYcruez8OSO0EOsEuhHTjKETOvtfkk3O8IU9Q
	01iq
X-Google-Smtp-Source: AGHT+IF3otiLjVcjhN/ioxeJj0ZekrIh54vZTrOdKQYDB2XVWsHdWsbDCduMi31IkWA+2ZBNShGkgQ==
X-Received: by 2002:a17:907:868d:b0:aab:d8e5:9d44 with SMTP id a640c23a62f3a-aac2d43d151mr981933466b.25.1734898043427;
        Sun, 22 Dec 2024 12:07:23 -0800 (PST)
Received: from localhost.localdomain ([165.225.240.157])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aae9a325afbsm208293866b.181.2024.12.22.12.07.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Dec 2024 12:07:22 -0800 (PST)
From: Alexander Shopov <ash@kambanaria.org>
To: git@vger.kernel.org,
	gitster@pobox.com,
	worldhello.net@gmail.com,
	j6t@kdbg.org
Cc: Alexander Shopov <ash@kambanaria.org>
Subject: [PATCH 0/1] Updated Bulgarian translation of GIT GUI
Date: Sun, 22 Dec 2024 21:07:02 +0100
Message-ID: <20241222200707.98738-3-ash@kambanaria.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As Git Gui is now maintained by Johannes Sixt <j6t@kdbg.org> and I see activity
I am updating and sending the updated Bulgarian translation.

I am leaving the localtions in as:
 - I see no rule to remove
 - Translation is much smaller than the one of Git
 - Rest of translations contain them

Overall I hope this will be merged in time for v2.48.0.

Alexander Shopov (1):
  git-gui i18n: Updated Bulgarian translation (579t)

 po/bg.po | 3721 +++++++++++++++++++++++++++---------------------------
 1 file changed, 1890 insertions(+), 1831 deletions(-)

-- 
2.47.1

