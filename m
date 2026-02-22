Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 777E61D61BC
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 20:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771792561; cv=none; b=UD3hiRO8MlhkcgQrVw0rluBOuVV5tFyVZApIrVEcPPlCiBH1EJKrm7amOHakaveQaDQed5KJhne+GLPwzdbAzDuN8wxI83+0jmqJ8idipBMwP3ckDprnRecyNbo88O0OMezt6DF6vx5tCLEuGsoazzLyhXsbBCqceO/hURaPJLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771792561; c=relaxed/simple;
	bh=OreC07CWQ6dvAIZtvd98FhBdfyJ1aNynrCt24rIhHMs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PmjjjTF0um/G19YSn71sVKSwd/4Cy9fldVxrzK9CiJ1VSvb3cJhi+EDuFmwtx0HeWX5BPdeNb9A0PUzsBudNRIvqF+DXyCqoYPtZY7UzsmpU8cm3HlAJFkJBxhto+0MO7EMD8mrCqUKIiz8wVIgZn1ke2MUS6evFf4Ju/umZr20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SwsnYDYi; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SwsnYDYi"
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1270adc5121so4207816c88.0
        for <git@vger.kernel.org>; Sun, 22 Feb 2026 12:36:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771792559; x=1772397359; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OreC07CWQ6dvAIZtvd98FhBdfyJ1aNynrCt24rIhHMs=;
        b=SwsnYDYiTwDwWL0HPAOyqnmhg54mS5TBYS+2L09XAQzX2GoD9iN6psbQL/iZ5YUTPt
         fc8nZR1WAnVfyw+HAhqk1CMXTfRwGDcd1vcj6Uh7e+wohEN6+5mTwdmz8lH+bU3j+o1J
         YYjuAIQtsvuH4QhRTmznsiTnHhsV0i2N8/6Ps6T12/KSg3qF8LkBbW6PHfBvzKq21wPI
         quTmUrP1rgou1gb4Ipbm3ip+aRwH0JbbLZuFq+PLe/ZgBx/W5kqfcvKbxEXTu29BXIo3
         OCkN/mSW9GEpicnSnRzYecM8e/0b+K3N7Pmwd8QY4hHtbngrrZZTy30DmplFZ0rRpcHc
         8k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771792559; x=1772397359;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OreC07CWQ6dvAIZtvd98FhBdfyJ1aNynrCt24rIhHMs=;
        b=vEehMKixDs6Nm1edoLYIJy+MwdDb7Iebr1RcZeCX3F7crKiXRTPXo4Bgvxo7cPfJci
         3w9CfrBxk0TXrSrpFTUhWZzGaRDl6QD7M8PzEs/mC7EmwPKihr76iVPoDx3QTrunyr7o
         3j5goCKfwhs5OElzNG5sbnlwbSutu8Vt42PtjhGPldP3yRIoKzf6kiOF3ZBwBiLBR+KD
         m1q7GA0MzUn0rk5DDxLbrojAVTDrSTRqYrLFKSIG12fgofnCsYhLcY08sFA5Wf1CffPH
         EZalbCNBmnybrri9L/UQR/IjcGpRi6MtHRVInXY2RCU2z1CxmhIKyWWNAKByQZVjnbDb
         Ullg==
X-Gm-Message-State: AOJu0YyfiqSmqSuzjrLFMv2kj1uW7H/t9bdBgYmA2YAkfzhgGFKhlpn1
	tUWFiLRF8z35huvfl0HQbGsTvCizN06GYVoP6RF151Rh/xUErzfWNQCzREdfTg==
X-Gm-Gg: AZuq6aJ418zNjEivKPF734KD3yTsZiPPLk9C09ETmunYyIAEQk0MbQXddo/05f9EojA
	9rd3vVyQSPuaoz0c7DehhD6+hwpv3QTP2vjvdE3a+HAbuVefgjztCy7/CFTrTV1TkcwWkavxVyu
	HiJsZYZROoeLFMAJA4jA4wUOrT0jueNpmcw1h123P2yASMsM5Q1Nk+K6L1Y4efBZ3AcWfvCSWw5
	LeO8OlQuGBKcN4KlGYwGWR4Cjei2ESuOXpMY+HslJM6tw01OClSkkp23XKaLVR/idG/9NKUZRqg
	iDwnZWlJ1uXhLd5A12cQ1eDALmDwtzW9r2kKZT9NTLaLTq1cWfAs4gAr2Z17IUqq7jSPp4BQm/Z
	B3M86q8HVf8eVJvNfVnfNervv83a4hsn/BaJ66gzAt0hXZlWENbh2NmVACd+51j9KP0XFX28KQt
	nssLPeWdRJOyIUg5VONJV+dvSvaz7+F7W1QX4q+AeLF+bbnqMa/7nDSA==
X-Received: by 2002:a05:7022:160a:b0:119:e56b:98a4 with SMTP id a92af1059eb24-1276acf37femr2751530c88.11.1771792559452;
        Sun, 22 Feb 2026 12:35:59 -0800 (PST)
Received: from smtpclient.apple ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7daa9295sm3647495eec.14.2026.02.22.12.35.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Feb 2026 12:35:59 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.400.21\))
Subject: Re: [PATCH 1/3] repo: extend info paths and structure statistics
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <9f2b3a46a4475ef9dcfec65def3a9965b476b4c4.1771784936.git.gitgitgadget@gmail.com>
Date: Sun, 22 Feb 2026 17:35:45 -0300
Cc: git@vger.kernel.org,
 Karthik Nayak <karthik.188@gmail.com>,
 Justin Tobler <jltobler@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 eslam reda <eslam.reda.div@gmail.com>
Content-Transfer-Encoding: 7bit
Message-Id: <F484D1DC-5446-4FB1-9A77-6645F7F24C7B@gmail.com>
References: <pull.2208.git.git.1771784936.gitgitgadget@gmail.com>
 <9f2b3a46a4475ef9dcfec65def3a9965b476b4c4.1771784936.git.gitgitgadget@gmail.com>
To: eslam-reda-div via GitGitGadget <gitgitgadget@gmail.com>
X-Mailer: Apple Mail (2.3864.400.21)

> and additional git-path based locations.

This statement is too vague. Each one of the covered key-value pairs
needs to be mentioned and discussed about why they are being added.

> Extend git repo structure with deeper repository metrics inspired by
> git-sizer, including per-type maximum inflated and on-disk object sizes,
> maximum commit parent count, maximum tree entry count, longest/deepest
> blob path, and deepest annotated tag chain.

This patch is doing too much. It needs to be broken, at least, into 20
smaller patches, one per git-repo-info and git-repo-structure key.

