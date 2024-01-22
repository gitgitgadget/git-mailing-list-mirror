Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51F6339AEC
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 08:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705913989; cv=none; b=F7/DKP0cBwXeIzDlSztd2oTh0vD6Vqx6rrhgPz9ekm0RJUBi84f2R7nE81PdSLHG4C7T63HGHQ+cmWcgIT4HYDDoj3+yCLuVnOX1WLXVy0Dh+wCiV50uHrUcKfBgj8egRpC9BhYIFS67hA3DhcZgDLwH40E1TGxZsYvLxy4yygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705913989; c=relaxed/simple;
	bh=a1Nax+OcgRF1h7eqq3Sc3ccVTy0CW6n1FzeBThwY2B8=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:To; b=im7JvASjENgqLnfla1LUalHmQz4AjseTAMsONBlyXqLts8CapaPbCKLtIWj3rEFYhTcxtyu1f4PVW2wlpFnAbUiCpaVKW9IO4pwXkzes9P82wibuBN0oSdCypWF/IGC7nMpyCheIZ6o3aAEeDFP17to1hkXi4yzi6diaD0HpZsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddGqoYyZ; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddGqoYyZ"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e60e137aaso32854565e9.0
        for <git@vger.kernel.org>; Mon, 22 Jan 2024 00:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705913986; x=1706518786; darn=vger.kernel.org;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTv8aGlM95ZnYsecOgzO693dxyeJhkCE71lONo9bWIQ=;
        b=ddGqoYyZMAPLgqMsO3WLQlWd1NDQJufu/7KFGWrcQB2qm/UytNFqxzOAqf9n2w7Dly
         uqDERz9PokMoLv9OMVHvW6jYXmvI22nHNnXNs3SVtZldAIUcv5FgXqkSKcaPiyM3XC8j
         agDH3CgPDFhzdFi8b0z4KOs1bfSpoBI0yA6uP7vJfDB9Q8jWANNxvePHiPQs4s717aNR
         P8WctLk+44x0Aah5Ys3Dfb8SP7qw1XWjpJF/f1zcP3ZrXaEuENLHO2XQk5NICz5e8BtD
         emoay81TBqx1Y0iVB7JGJKHAepr2jNdSJdOYkacEKDV7tZ+zIL251CKnwBAoZJDdN3OU
         UJyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705913986; x=1706518786;
        h=to:date:message-id:subject:mime-version:content-transfer-encoding
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xTv8aGlM95ZnYsecOgzO693dxyeJhkCE71lONo9bWIQ=;
        b=OM7udhPqAyrjtC+5jpxdA9CMRKznAP9MfbXsZFvzH3GwhUGLZG4fOfi8/JchkdXbaC
         KZrftHjkPmcyTxlet/23SHxFHwI0z9Dsi+q4oIZ19wpPxoFh3FFnghW8vAaEl79Jc8Mh
         z0xHLAnBPDFmrt5O8KymNVkHA2rdRLvc7VhFqIElwFfulmnNK/cTV49Q1QwXc337geE7
         EgjFsnWSxEOIPrMpdTJbBGMVJtNMycVnRp7bEpPTyKIbbwD+3DlRcP0CZKW2RlDtoXl5
         DW3DWg4T115JkhHW/FGQ8ukgMlR+6BU6OJ2p9aKrU81cBG2AgksOnRFTCjnfTFy/ZXMJ
         1AyQ==
X-Gm-Message-State: AOJu0YwCOnNQ6ynPlaVaQ8nxw0E3a11QMUJUuHB+awmYU9zEyU5oiVMa
	fVweL8EiK5vbyk0Egh+cKL5eUsbdw/qtaZRNZaW/gwBuAuB8C7TFU7vB6pK5
X-Google-Smtp-Source: AGHT+IE1UwJxis7Q5+wAKZyr37g+sjbK6BINf/zBYunngek9lCIdt5AAIAloj6abABDeVxiz002DYA==
X-Received: by 2002:a05:600c:19cf:b0:40e:50e9:9b0c with SMTP id u15-20020a05600c19cf00b0040e50e99b0cmr2056916wmq.181.1705913986238;
        Mon, 22 Jan 2024 00:59:46 -0800 (PST)
Received: from smtpclient.apple ([2a02:c7c:534b:4500:3561:21f4:29f0:53e4])
        by smtp.gmail.com with ESMTPSA id n22-20020a05600c4f9600b0040e53f24ceasm38234468wmq.16.2024.01.22.00.59.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2024 00:59:46 -0800 (PST)
From: Zsolt Imre <imrexzsolt@gmail.com>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.200.91.1.1\))
Subject: Git Push Always uses Protocol Version 0
Message-Id: <FD545E92-18EF-44B5-A7D5-61ECADD880E6@gmail.com>
Date: Mon, 22 Jan 2024 08:59:35 +0000
To: git@vger.kernel.org
X-Mailer: Apple Mail (2.3774.200.91.1.1)

Hi there,

I'm not entirely sure if this is a bug or I am missing something, but I =
thought I would share in the hope someone can help out. I'm playing =
around with Git and trying to implement a git server that communicates =
over HTTP and supports Git protocol version 2 *only*.

When I `clone` a repository, the Git client (version 2.43.0), after =
fetching the capabilities using protocol version 2, it proceeds to fetch =
the refs, again, via protocol version 2 using the `ls-refs` command.  =
However, when I try to `push` my changes to the repo, the Git client =
refuses to use protocol version 2 and tries to obtain the ref list using =
protocol version 0, even if I pass in the `-c protocol.version=3D2` =
command line argument.

Is there a way to make the client use only protocol version 2 instead of =
mixing the different protocols?

Thanks in advance for any help/guidance.

