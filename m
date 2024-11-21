Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410316C6A1
	for <git@vger.kernel.org>; Thu, 21 Nov 2024 10:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732184689; cv=none; b=roD6Q7FQyIytWd7a8dtHx4C3GjdiCbZvcpG2sx5deys7bcSeNtSYYQwEEFKVfennOQTn34JLs+JCwsySd0126vozRQ66lOzUEc3E4wsQb/YAoAInTCA7y53uUFxjpznGkqtzbz9+Lp6T23OkRxyNtObAgpnnH8mhAPLADFOAHRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732184689; c=relaxed/simple;
	bh=ymU9e67dxkG8dXCBT3WpOkLNlERt2QrLJe4VhOWaGLY=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=gpcLoX0CCdpsUlv9LAP5fw8no+xVEgdjAP7rpcaibojFPJn/uulgFR9nvT/XLJu9teyrCMG/JAbxpSt1PRZHswy9HhWxqRhBnfcv7+5VOYMWtddbe66Z9McHA/UdL5ycGTfFuLq43X7ke2rxPzNCE/jC9T4ffQGww0L3EYq9FpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tool.es; spf=pass smtp.mailfrom=tool.es; dkim=pass (2048-bit key) header.d=tool.es header.i=@tool.es header.b=azKqVJ8M; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tool.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tool.es
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tool.es header.i=@tool.es header.b="azKqVJ8M"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4316cce103dso8226915e9.3
        for <git@vger.kernel.org>; Thu, 21 Nov 2024 02:24:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tool.es; s=google; t=1732184684; x=1732789484; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fwN6HuKOaTdqUmkdShKrTgnv/ZiwBObdj6e4VauXkZM=;
        b=azKqVJ8M34h8bRoSdbNA71j1KUdhf07x4Edq0BqIuQ0q6nt8nAGqY3xC8LwarN5NAH
         OMan4N/9RsIJChn08YXNrDCimp+VUZK9SYocsb4dVPTpHpT17rVbdmJdRFGEDc6ChBZX
         QpGXTuWE06RKNKqyX4QXSj5ylSuS4caRTdeKvdXCBaa8i1feSMr4pOZvMBNJp30iyL3l
         OQHI4F1JGvt+AG9GFBycYP82dcbtcPT53icNbM/pAeUWqugZm2bke9oJgTbJy1UoP5on
         19lCgMm7LYtgAkINb1VxZRBQLJMFUi6pJqdZt2F8+GoKgW1VKuG7z6e09eHXevMe6UeS
         pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732184684; x=1732789484;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwN6HuKOaTdqUmkdShKrTgnv/ZiwBObdj6e4VauXkZM=;
        b=TVbs2fDiZcSE+X8HPnxS6xXETidYh3CveRicyBH2sffZ3KA6HZGvIKbijVnCHqeN5I
         GXt2sUW9q8YG/f/PwkyIryi4mwyxbqTsqONnjzc5SRLKskIeyyeei6eBgeMDCyQ1YYZj
         4Vi5Vt4OesWV+VV8ITgR7Sy+oMgbZh36TSBjjG9sats9k9Fiet6alvXgdblG3i0ilhfg
         avp4SYXackfefkhg618GtdWqGV8gFZjwtABK50gEnfc6osKF8mSWf72VoX5BhgnQOJv4
         qFxw9iZDUzg4jjQV/wb1vfZoV+kELkATFeoP6gWDNRyZWYKYEFmvhZumCOVBD099R3BW
         Eozw==
X-Gm-Message-State: AOJu0Yzvn9U4BtrSVc0KY4LFiQC8/oa5zIry2D/XXZmo8QFsUnrYEeGJ
	0ThdC2go0HGuWubmGgQgEdtXgsaNU9rO9Glan7F5bJ1ZHAq35bEdxgbfWWuWPjOMlYmOY6OCUCC
	F
X-Google-Smtp-Source: AGHT+IEszMwB4MNigQCFGZIvW89ze+oVsqlMZdfBdJa9s5A7mEDleczmmBVPFWR0dpi2QY2FjKOnHQ==
X-Received: by 2002:a05:600c:5250:b0:431:562a:54be with SMTP id 5b1f17b1804b1-433489a04c1mr63728455e9.9.1732184683900;
        Thu, 21 Nov 2024 02:24:43 -0800 (PST)
Received: from ?IPV6:2a0c:5a82:e50d:b500:b971:2222:c488:daf4? ([2a0c:5a82:e50d:b500:b971:2222:c488:daf4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-433b45bdb13sm49438815e9.15.2024.11.21.02.24.42
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 02:24:43 -0800 (PST)
Message-ID: <e020539e-b66b-4d4d-80da-9f51d4b66683@tool.es>
Date: Thu, 21 Nov 2024 11:24:42 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: es-ES, en-GB
To: git@vger.kernel.org
From: Luis Heredia <luis.heredia@tool.es>
Subject: Git problem in windows server
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Good day,

I have a problem that i can not solve after a lot of checks.

In my windows server 2019 i created a bare repository 
(c:/gitServer/git.git). In that server i create a new directory and I 
can clone it without any problem. The repository is good.

When I go to my local machine, i can start communication with ssh to the 
server (cmd ssh ssh://user@serverIp:port). I can navigate to the path of 
the repository (cd \gitServer\git ) and change anything (copy 
c:\temp\temp.txt). With this i can be sure that the rights in the server 
are correct.

The problem is when i try to clone in my windows 10 local machine (cmd 
git clone - v ssh://user@serverIp:port/gitServer/git.git c:/temp) i 
always receive the error "fatal: ´´/gitServer/git.git''  does not appear 
to be a git repository".

In server and local machine the version of git is 2.47.0.windows.2

Can anyone help me ?

Thanks

Luis

