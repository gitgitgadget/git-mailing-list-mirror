Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635AB67D
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 02:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718160062; cv=none; b=b0FBNs3T+kseIbU1eSlze3vi8IWbvLmWkmYEigY1y1xVaPFIU5j+kCzyr9DN2PKApsVqKcCNHtiJtp+0f1tKDQa0822ky/P8WOyZzOkcHNarvyYjjMo97leAxQQOKRiDWqkMI5adEcIW8gGPsyWPGhF/HFTi3xfw6avnS3N7hVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718160062; c=relaxed/simple;
	bh=BGjkiij2GIWiIaaYUXi/TdPAmKkOmV6oCUt1H/eY++I=;
	h=Date:From:To:Cc:Subject:References:Mime-Version:Message-ID:
	 Content-Type; b=Q6wo3467fxq23vScyxr6/KVKgcJgmBsnUKsbDcpEhBejdkHi2GWKlhzDczrQmCK/pOvoeiDf6J4cvWbBmOaluKoATCPZYxrAmZWu7M3mNXDOunQTZnsl7FjWbk/zQInmhodwRIYCxw+8MfF5tBNUYEishXcqVQLSJgqR5dcMgCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw+O7/qJ; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw+O7/qJ"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-6819d785528so4415162a12.3
        for <git@vger.kernel.org>; Tue, 11 Jun 2024 19:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718160060; x=1718764860; darn=vger.kernel.org;
        h=content-transfer-encoding:message-id:mime-version:references
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BGjkiij2GIWiIaaYUXi/TdPAmKkOmV6oCUt1H/eY++I=;
        b=Gw+O7/qJsgXCDFI6hK3BHW6dfzi8JUBS9419qJZaT8dyhzciKP5BGB06YKfkFgsFjj
         UBRA32kDHm6vT/0vXBoUR4GmfKqHk7SpQ2XQ0YRWLBzIWlhMRrgL5BaZd+zdIEL5fkOM
         2YI/Kt7Lof1CBHS78u2FONOS9BOaF3e6MJJ/M9Npi3+bqLfAH0ye4SEb1jzzpTx9aA9k
         WDgsP3r+goTXS26axB6EVMCCoHmlJD1XmCWSTSmAxwS2EfIgPDr7LRD8dDt6P4qXI2RT
         2CpUq9WC/Q+4NwEO0g+kZbJaWjAdsBr9dE7UgibQD8tiTTpWO/yzlXWNwuX7Z+jqyJoZ
         EwTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718160060; x=1718764860;
        h=content-transfer-encoding:message-id:mime-version:references
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGjkiij2GIWiIaaYUXi/TdPAmKkOmV6oCUt1H/eY++I=;
        b=WXQRDZTF8E/+fRih4TRcCnFjGESCPNKo0Yvo2x5MXSvJA3U4GH/6T+Hp7j0gBYaydj
         Nsdx4+/85vZGDGxsICd12PaadKyXvQejlJzCzLtgIBrrv2K7qwAFksXUp0XVh2C5fF+0
         0v3r5nMFeNrBeREllWbEQzhrftsL0gl8O9BjpTBbZt1M5pOqBgix1Kvo+rp977lLc0W2
         RmcqiX4hkEJSzse3AqJk+C76K7YYCrzMBLu9ykdm5rsC2TCtXq8RBt8i/dVaQ9M3alIv
         oJhrhwA9M+X90Lpq8Qudkwfesi24P8i57/sIJCjLjODKQJxyqB5Rx7940fQVv5iKKE58
         Ig5A==
X-Forwarded-Encrypted: i=1; AJvYcCV5izNJq3lqjcfzjuU+q3xDgvoTsed18Wxpv5IDQqoiU7x4os/+h6copgw6dFUkhMGOOPjfjaOSAnEEVy86Ll/e9O7d
X-Gm-Message-State: AOJu0YzML6pObSNe3yFHyKU4okzhdTzmZFp7A7bMqTYK6mKlL1NjPoLW
	QRAoJ3DX9aD4gRJ7QzwcblaHO61WiiOkLTT3AJGUD5CtFi1QLaCe
X-Google-Smtp-Source: AGHT+IE2XPcm+xdfTbNKdV9KZcgJu1UzZfn5niZgoncq/L59oBegpHKn3MD8qa1NfBGss+DIRWTN0Q==
X-Received: by 2002:a17:903:2349:b0:1f8:3f13:1970 with SMTP id d9443c01a7336-1f83f131efbmr1181595ad.56.1718160060470;
        Tue, 11 Jun 2024 19:41:00 -0700 (PDT)
Received: from kylezhao-PC1 ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd75f45bsm109017845ad.35.2024.06.11.19.40.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2024 19:41:00 -0700 (PDT)
Date: Wed, 12 Jun 2024 10:40:59 +0800
From: "goldofzky@gmail.com" <goldofzky@gmail.com>
To: gitgitgadget <gitgitgadget@gmail.com>, 
	git <git@vger.kernel.org>
Cc: "Kyle Zhao" <kylezhao@tencent.com>
Subject: Re: [PATCH v4] merge: avoid write merge state when unable to write index
References: <pull.1731.v3.git.1715917639587.gitgitgadget@gmail.com>, 
	<pull.1731.v4.git.1715920862420.gitgitgadget@gmail.com>
X-Priority: 3
X-GUID: 6B5493BC-ADED-4E7A-843F-467080BFDDD2
X-Has-Attach: no
X-Mailer: Foxmail 7.2.25.254[cn]
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <202406121040581668410@gmail.com>
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: base64

cGluZyAtIHBsZWFzZSBsZXQgbWUga25vdyBpZiBJIG5lZWQgdG8gZG8gYW55dGhpbmcgZGlmZmVy
ZW50LiBUaGFua3Mh

