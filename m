Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A709149C41
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 18:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753382993; cv=none; b=dtXnwym6JrKZ7JPEapNeTfaWcbvckYCSFc5k8U8Tlqn4kv81K7DGv39CbhYLeGePExtBRB81Ul+BJtDsGyBCu/NJyDR75pW1bgT3hziViIie9JCm0FbnXpX/AQ4uwO5BNGhyT6NcB/F/SChVoib629D290yAd+BnP3QYk+nVNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753382993; c=relaxed/simple;
	bh=81IQkZ6rb3iirtM/h3mKlBbpSh3SfPNCUKh0/hJLThQ=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=GsQFzfvWZ0e+gUr3jlJTBQNtBtjg6SLGQBafpOC0jP1K1NUvkiKJ+z55hAQXGQmo8vi5e2Cf8BGP2ULCGgZnwvmqRQtg4rs2MxVgnU659crIhGgFGJKJvRjOwyKeMPJxLOlaXpuD+k4PJLC0oK44yOJfH4ln5texVkhGCZ20Dsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6mRH+oq; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6mRH+oq"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74924255af4so1252096b3a.1
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 11:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753382992; x=1753987792; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2W56Y08BwUkgALHsuNjnomkvLJWkDEFIoOzKqSAiR5I=;
        b=m6mRH+oq4v8iLyX8Nwnns015b2/LRWIyfDRFlMZDawQMetBOQOMA/edQh/aCmWnKge
         u7my7yeyhyrF3yRQ8onPWn8s0gHQzjjfhCEoW231m6a/rY5nJXgRljvoUV2iSFFcS13f
         txfIDthJzVoSRlU4zF+192m9Q8Bm9nU0pWEnIyLU/ir84aPgb0tHlDCTiq3DoANrYm2b
         2zVF5TIGqj/LFdqvFSrkQ84SL6iUADe78Syyl7adb4mVPBlGh5KxycwWR/Sm/lL8KzPW
         zbLDnQyUqShbRrEaWN/Tqy5oP0M5Bb6vNWtx6yQmjniVy9EcL4R8gcfCvTgNfjh1Zs9Y
         Km8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753382992; x=1753987792;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2W56Y08BwUkgALHsuNjnomkvLJWkDEFIoOzKqSAiR5I=;
        b=X3uVx05ah5+wswfMqo/pLi0zcaWo9EuKOOoiV3Ganf2lbP+pFItRLSKGlRHpFLQJBo
         AxByDJLOmiIBuVtFfdF9NvX700bUuIz3xcWHgcA87UseCHbHEeTQVco49+vsTmXsA3Op
         XVC8ewLVlNAAthebvmjjrgrIrpiOA8gBEmltSkJ+MfV/MCxtl/LyD/CDIRAH+InfFU3I
         zMDovI2GWDeBd9hzxL38uOP6OVqKkBJ24VP81xrZGcol3+7KFLeKAkiKvpO07P1iIVSI
         js6NyyV1puZ5RKQBduqTRjC0C3v5hXiREzATkw7YIF448OS7DFr8bobuXTVInl3J54bg
         j+OA==
X-Gm-Message-State: AOJu0YxBiPgqZUq/cM9eldD6doJyAHV33YERS8QnoCGua977hdlQ9Nzm
	uV7NgCE4fDGjwQBIfcaKytkG0zxLyqIC3EBF1eA/IAVTP3AiP3eFEbRuTe3u0RlLwGA=
X-Gm-Gg: ASbGnctKxGmkHrq9KiVm5j7zWfgLe/jbityt40vilc7SKZj8tDtI8bQdlnqWML4eZtH
	oUm2BYibv0d4VbSPvWbNU0RmuhmU3MEl6FUtgb7CMnqY2UqRgTbZFDUCw+Bf2okc1UdI99AARUm
	k/9ZD/fny5Xwf8sBB6paber87dHxHAjCnF/ssGYiNU6FBfpw64yv57SYweZ1HGpXC6tn5dEYxmm
	QQEqHMvSSvYtqt3L9W0X/+pRerevtnSreTwtz0+4/KbgVt+4ILbrFRLjrFpx5+YxOb/5TIxtyNW
	0ZYLNbidz8Y57s0xobdmMNA7sZhbU3TPW9DRQFDx/UDoGhIGhL60inC20mp984txLGYxV8OhlAb
	3i3Gd8aFhXHQzHN20DN701Fuuip9/D/FbGoXZrpS8r4LdlRz9yj1rpyMkrn8U5Drw8mhSBp8=
X-Google-Smtp-Source: AGHT+IEeuFAbqFOzmCYwzn/ZcCDVeBGE+tlUq5QJbCwWrOHntrqK1kNvxziBikGGh/XCQV/xbLbEgA==
X-Received: by 2002:a05:6a00:3cc4:b0:740:b5f9:287b with SMTP id d2e1a72fcca58-76034afcf04mr10699246b3a.1.1753382991742;
        Thu, 24 Jul 2025 11:49:51 -0700 (PDT)
Received: from ?IPV6:2600:100f:b06e:4b24:ceea:93ef:4772:f302? ([2600:100f:b06e:4b24:ceea:93ef:4772:f302])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-761adb7bbd5sm2222134b3a.9.2025.07.24.11.49.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jul 2025 11:49:51 -0700 (PDT)
Message-ID: <f4b40536-346f-45a1-84ee-99b1200c022b@gmail.com>
Date: Thu, 24 Jul 2025 10:49:50 -0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git@vger.kernel.org
From: Daniil Iaitskov <dyaitskov@gmail.com>
Subject: [ANN] git-phoenix - repository recovery tool
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Git List,

I would like to share a tool for recovery an unpublished Git repository 
after accidental removal or file system failure. VCS usually implies 
backup feature auto of the box, but due to Git decentralized nature and 
developer's laziness source code sometimes can be lost. Recently I 
accidentally deleted all projects, including a few unpulished POCs, 
after infamous rm -rf * typo. Work on them has been interrupted for 
quite awhile and rewriting them from scratch recalling all the hack 
intricacies would be terribly boring. So I decided to invest my dev time 
in a more creative way.

https://github.com/yaitskov/git-phoenix/


Best regards,

Daniil Iaitskov
