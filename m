Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8133B17335E
	for <git@vger.kernel.org>; Mon, 19 Aug 2024 17:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724087423; cv=none; b=WRDufgoB4MndLXj/v63gFsiXHYWG2uyG+NiQMEbWlT05pUoN5Exky1Kpw56Leup0eGpczLauWkpok23RNHzKkDiar3kfk0z5Y/hl+7PwbnB16bK/ZKhihP2cQVojzW+ewUe2r8glbpvKl1FMEu89EBCZZuQeP0XJBaq+k621OsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724087423; c=relaxed/simple;
	bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=ssKH4LH1IuzQ3FZm04Ovlk84u4rdaFM5sFv+KZwz0HFYC0M68rdtbWb3pxwja0dtq5MfZ9bmrFg6Cl4tPuKy21R6a5/cPoLQk1nLGYIe2wiHvoIeC5mRg7L7sgNc6yiUEwQYo/5h0YwFYAgODu/GT6o0yRR/24u0tqgH+ZwG2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ggGk5SO5; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ggGk5SO5"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70d1a74a43bso3028131b3a.1
        for <git@vger.kernel.org>; Mon, 19 Aug 2024 10:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724087421; x=1724692221; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
        b=ggGk5SO5oAcufoyr4nDwfR+MDtTqt5Z8shRzP5rVR5qCwa0n8zKJVcUcqM5o8siv52
         eU9o0PXXAkH7CoaiGb2DlhhYy5o2mFuainmCrHC6u/xV/unY8nxNUK0HhOv6t8jYktS4
         TDkj9DTV00aDsg0tCruK0wKX/iOOAZtqkuU617cgif595KgQwiKFoYEPdxi6buB4uzZb
         bKe8ihNQK1AOVyhcEsEPKEQnAx7Rf6LZCtjFkVSufVmLfrj96EJ0onKybr0ZInMqmCJn
         RzErujuXtyPUTAspCpD/ijLYxjqnCjJ4bEMeBXWN4IuJlb0fvTc8DVCHCAAXusHHn/N9
         klUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724087421; x=1724692221;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g+P000lnwdkAcKAqGLnWodm4n9Jz8YjwtOwVUhM/wkQ=;
        b=GXWkBi5vBQRrri6d/ynn5XOf6EcCUwHvfMiJW/C90+KfCGUHu56eTIDCyVqzfVUKSb
         9yRXUgY7c/YKHrna84S8iWj9tNf8dp9Mfr0LYhMKsa38bDI6kGJ4u9wzgNMCyoojIq3d
         TpcZ4mU32kPrWxpq3N1FtNtuNXlTkkgu8nAQ/0XgEld/EwV+iAZUxU4I4adks+xtRBx4
         y/1vNYyXlRUyewKjJIbfBvDMb0R5RWsbEl/4WUISeNes3gKom1bEd5D92JUWi1Ywp3tg
         HDHUdy/OTW7wTKvCFe8tqnGb87Ff8Jtjf0eq4ej9TSBpEVcrdXUXgkzPGoFsUxnBMU7/
         oDAg==
X-Forwarded-Encrypted: i=1; AJvYcCWQy2J2B/yI+RNA+qlvowiuJcKI59IPVjusXbLR2r7ryX+bPNnot5ip5QTzlrRr3PSKja5PadX57uL5wIeqjEqrju0P
X-Gm-Message-State: AOJu0YwBmv/AeUtU5y+oQjONupV2bbJy55mlZwItlf9DQwm6tTg5q7ZO
	qQe1BIgoK9GDpCVtCTT+1zs1IXSCeS8vezS4jUGUjXMQwbkvE1se5HsNyAhN
X-Google-Smtp-Source: AGHT+IHlR+85MA81NjmvyzQ5WQfipe5NbasMAY57/q/NjlIifu0qx5cxaCFN/G7W8TQkrLEpGxa3LQ==
X-Received: by 2002:aa7:8890:0:b0:70d:3337:7820 with SMTP id d2e1a72fcca58-713c4e2ead9mr10853202b3a.8.1724087421269;
        Mon, 19 Aug 2024 10:10:21 -0700 (PDT)
Received: from smtpclient.apple ([117.20.113.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af18942sm6763024b3a.158.2024.08.19.10.10.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Aug 2024 10:10:20 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: khmer song and funny clip 855 <limeangkonkhmer@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: [RFC/PATCH] Add fetch.updateHead option
Message-Id: <61283083-8442-4CCB-9A49-4CA860F85DFC@gmail.com>
Date: Tue, 20 Aug 2024 00:10:18 +0700
Cc: dominik.salvet@gmail.com, git@vger.kernel.org, gitster@pobox.com,
 jrnieder@gmail.com, peff@peff.net
To: felipe.contreras@gmail.com
X-Mailer: iPhone Mail (19H386)

=EF=BB=BFHi

Sent from my iPhone
