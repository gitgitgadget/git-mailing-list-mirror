Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB2D2CA7
	for <git@vger.kernel.org>; Sat, 18 May 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716042317; cv=none; b=ryCGHdVSf+HA/K5xKOrFKGm3nVDJIwYEa+t58ivY46WGCuq/xTdizVpic/LU/F2HtLaO/OijVNgwqRr3VpJt/+WQuj82MKpCez1wZyaZuMoF03sakgl1A49i6OADRyVWZWFvdsSugbfeUp2aTryX7PfZ7ebu3LgOfSdeHxeNz5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716042317; c=relaxed/simple;
	bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
	h=Content-Type:From:Mime-Version:Date:Message-Id:To; b=mMoZ5MVhgxLj3MVzcH59pXswxsrozEVO6ThBpTqoiJ5kWyxxJJjHjtRgZBLjJV7BJNtkAyc4n92dBuGU9EXrQ8Z1wV884fLHw7k5jyFXC6s6gyYwyNHcnqutk1UzQp9+rqqgVZ8cAmDG3LMHToi+8fiu+pCUmSWjWqZqLJeOAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aa6Ng8C2; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aa6Ng8C2"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1eb0e08bfd2so37400885ad.1
        for <git@vger.kernel.org>; Sat, 18 May 2024 07:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716042315; x=1716647115; darn=vger.kernel.org;
        h=to:message-id:date:mime-version:from:content-transfer-encoding:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
        b=Aa6Ng8C2fFAHDSMGKK/XJEUy83ymMO0JZo/AA034b5elz46y8sj31atOR5dr3Am0ZR
         GsPyP+tlyUWWdwWd8BFMvcPUEfbERHFAsUolBetgc52cVa0qXL4VbxRBPopxWPIBOADq
         5aPtHuAVBF2q6oKpsQs0x7SvbgtcqUV0TKB/+N5TrY3pEv/feEmwgreILrE7twVyx8qK
         xba5OzXI0ic8vUd7dEI6FAcnkHANrbJHpWsYss+r0dMrw9Zz2WMjAgcULN/6KCPMxqTZ
         HH/azYEpdkV3Eos65hzVIMTWwLoclIeVexgqhYGT6yp0+eVHjP4+qjVdPQKS7xUHYLZH
         fbgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716042315; x=1716647115;
        h=to:message-id:date:mime-version:from:content-transfer-encoding
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T0VDPRh2LHYXc2baLTXN9uA2nNgF85x09Bgohqgm2rQ=;
        b=CydABygueBZSoNDQJfjdjVNRjFGoNCK8tr8WePMnLFy7NzgOO6Xh8tl5lbWfs17lh4
         uboTtEllUM9wDVSRKlLawHvcR8HdoH7XtFmaekNJ9KsZJXeIVcllfkDDnL7YAgyloSn2
         NwxIubX44LboexdRF2g5n0w1FjFk5Kqew0LVRZPyf/fh1W8F2jU/NAoHCTGF3UJiTBQP
         TlSWTjfxbXw5Xo8uIBVR82gX7yU9r+hAvUG8oz/JV0eksql0RN3zMLflh/bwmVzoVhZ2
         cLaLbsHjgOCmyyUfOFd7ALUL7wmqOwZHPEtMJh3apMLSVfj7qQFIbbQOurGbHzNRGBWa
         sgIQ==
X-Gm-Message-State: AOJu0YzlrZV8O69nd93QJrWpSynlWgFO7F5QEv58d9TbQAev+6IMmiuS
	LcVKUgPpW50u0NvXotXSFxZkKTSN3r5wxjAJMV9yFjDQIsosah8oV8+m3yCa
X-Google-Smtp-Source: AGHT+IEEGPSvc6tr1FpXvPJ3sYrq1guC662eDXCldzp/nIy/zo63SMlm4NXBzgLEWlPY6IOdCPJOxQ==
X-Received: by 2002:a17:903:11ce:b0:1f0:8bb5:2ab with SMTP id d9443c01a7336-1f08bb5046cmr148347585ad.41.1716042314936;
        Sat, 18 May 2024 07:25:14 -0700 (PDT)
Received: from smtpclient.apple ([103.151.116.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bf2f4bdsm174036195ad.152.2024.05.18.07.25.13
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 May 2024 07:25:14 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
From: =?utf-8?B?5L2V546J6aG6?= <baozai55001222@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Date: Sat, 18 May 2024 21:25:02 +0700
Message-Id: <543A1987-7E93-4F0E-A311-4A8313D7ED4D@gmail.com>
To: git@vger.kernel.org
X-Mailer: iPhone Mail (20H330)

DQoNCuWPkeiHquaIkeeahOKAhmlQaG9uZQ==
