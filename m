Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97822762D0
	for <git@vger.kernel.org>; Tue,  8 Oct 2024 15:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728400495; cv=none; b=ISKFezcAd64PWONhaV27QTxWedgr26sX5W7HpdDuv4Iw0nc5V8ZXbYJB/1CQvzW4V5tl9tn65gLMcmOns1VElS/yKp8DAlaifJUcCPcoh4jGoxB/k0u4JjCXwEi0GoznuphZ0iqC0ggvYBpqge7axISfEunNC6eSPbP/5WCCwik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728400495; c=relaxed/simple;
	bh=KsDGLDMcd/CqIoDXUv/wqjLsU9rhASUajqLZ6HlkG6Y=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RT4wV8FtiZsj8JX36Eat30jRgCwSD7Bp1LtP3b8XbdPb7NkzK1KYWuoet1s0t+st/4HzuSpRxIWXlO5CCxtaiVnxHFjytRyGiZtp3JLC32Dzkx08yZ7ypl+fFwMqGe0ULIeng4AdAb+d8eWRZmACS15p4RQ0Vi6d3ONklnbE+Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUUHQhsk; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUUHQhsk"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a994ecf79e7so351713166b.0
        for <git@vger.kernel.org>; Tue, 08 Oct 2024 08:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728400491; x=1729005291; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0knWRIB+wfDAajqkaHwRj7mCSzX2OF4q59WeX/hzSQA=;
        b=cUUHQhskMcUPbrhrcirfhiNhS8Gs9pWzYTu8DpRgGxYdN1EuL0RgchbS/DH4PN1C2W
         BP9qc0HaCugb1i3SkvyERF7QdXS/3bq+LDl1JukCZ5V0mI+siIYxZ77zX7gttv4U9ibU
         n6Gkkqt+9s5Q1ASzPuLYdeLbRod9Y8IbGlg4kOwsuREFsHvVO9YvHVGphwAaDVkCAdK8
         Auqitu/mwHDJwnreXsYr7o0O04OxPv1zF9V3h5fBgFHeIEGPqzApK5WMGqOme8bGlGCg
         N80/cBg5uDhRy2haL6BI1Ezm+/1F/+KVkawH8AArdbFhlMfSPUTGLWQr5XAkkCHTF23W
         8Xiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728400491; x=1729005291;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0knWRIB+wfDAajqkaHwRj7mCSzX2OF4q59WeX/hzSQA=;
        b=iy5MapB8bRmWunaMiyBja1I3Sa5E+xYfyAbtYDiOuF1HBzgkhRT2ozhErsNa3L3xUf
         L2u/R79BPuZxDE4FdBPXKRIxRRriAuj98xTUhBMu3OdMoTLwk8RaogufREU12+gGiWtC
         LzA2PSM5xd/Zp301pjIuFcR3Xd7PYY5VAPVSyeW67wEwyJgJBJp8oxNOmKG0i2ataVf+
         VXU3H74m4D5l2/r2ziw2ihYwA30j7OvSRHWSSmxN0FvFYdv8blywpQ+ImfEGG3flnN9r
         orzD4UCJtPUZ0nebPrFxwhus5qqJJsekwIiKqM0BkFZY6PfzJR2zCmBCDNqQiR86vbzR
         2ynA==
X-Gm-Message-State: AOJu0YzlvGkafEZ8cqgFJzx/qfG7O+mmwYJWzs5j51KYOwTv06fwSf1r
	lLfPlyMq2beTbEgC/q22qe0yELw1euI3ozcV4+owBz//zdJOHeAm4jjf33mk
X-Google-Smtp-Source: AGHT+IE5WAti2dKbOKE8iVYCN6PAxFKgWJNAknZB6CaOusb+G55eJ5tfknU3M0ukZsUJb9H0hV0OLw==
X-Received: by 2002:a17:907:ea0:b0:a80:7193:bd93 with SMTP id a640c23a62f3a-a991bd40f79mr1694622266b.25.1728400490838;
        Tue, 08 Oct 2024 08:14:50 -0700 (PDT)
Received: from [192.168.1.102] (host-188-15-132-105.business.telecomitalia.it. [188.15.132.105])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99325c5c48sm514030966b.170.2024.10.08.08.14.50
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Oct 2024 08:14:50 -0700 (PDT)
Message-ID: <447ddc34-ab3a-4607-908f-64b9cc0268fd@gmail.com>
Date: Tue, 8 Oct 2024 17:14:49 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB, it
To: git@vger.kernel.org
From: "Alessio De Marchi (GMail)" <alessio.demarchi@gmail.com>
Subject: Remote git server dubious ownership
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

I'm using git v2.46.2 on windows, and I have a server linux (git 
v2.45.2) where me and other developer push our repositories.

If i push my changes on a repository that is owned by another user the 
server git respond:

fatal: detected dubious ownership in repository...


So I can push changes only in repository owned by myself.

It is possible to share a repository to more that one user? (I remember 
that it was possible untill some years ago)


thanks

Alessio De Marchi


