Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F239FF3
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 18:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873501; cv=none; b=p/FRF3NclKNos2r7MaoSJH8Xq5wf3dGJxXm/ZBbbuYeWvUJpCLBXHbqUkqlekeDH4OimGzbBA8Rij61FEqSqXF9ZVP0Gb/PCYIN0H7IRUMOb22lMDWQVRbcSAp4Bxjw2PgHLEjBsW+mH50mFCQbOVEAwYisVJZP8c2KM1auWNp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873501; c=relaxed/simple;
	bh=tHxQHghmK6RSjCKnhx/EQEKa0CIKUGCwnM6/m8GHC1k=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=RbgsVbLlqfkHNyC8UrT3QsyfjmU/bdbsex8rnVRVY3TXldYpBWD2fAcERs8RF3Fk2WuVdiuc3HyF2opG0MgPpRkH2F9vT0zsf1XgH1bqPClOk2v60Glq6C1WI21RGmps4Qe5tBwJTZUNmwqgcjRcWlfeCJn8CW2P+sZvxveJvhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4CIy9nY; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4CIy9nY"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dca3951ad9so39373065ad.3
        for <git@vger.kernel.org>; Tue, 19 Mar 2024 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710873499; x=1711478299; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U9nZFAo+XYPVK/1r12m+9x96xaMk2g9CLt1SAFJp7Gc=;
        b=i4CIy9nYgQSNKiR+ed6AQFTnfrUZyUoAbHl4RsJH3E7GR5nvJ2OLTcd8G8kZbUsJel
         4CorVGPXmXXxJ0QCsqFFrbS8druX31qyHW8SN4GuTc0o3D00iWKZr6oT05l+Dl/1/ivE
         SpeWueICuWCdVU/yB16UX7m7Rgfyc02GwNkRytg+s7u4+ZO9SkqiupRaEIgCWOep/fGH
         pSYxiGN5an5W90DN1lDtN79uMaTbHqGkfVkAyvkCa0ERfmfNZ2WkEhKqyPaAMExOFDNO
         PG05hPD59dSKJvAaZ1P4eyk1amZMQKyV8mHKGAJdfAKomd3DdCM1+smNtsK311Lvvhcc
         vgyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710873499; x=1711478299;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U9nZFAo+XYPVK/1r12m+9x96xaMk2g9CLt1SAFJp7Gc=;
        b=iMjfiJbaGK6B8QLmttAtIPcR/S23U7Rml8CO58o3G9gNj9Nzi3JVjCrzFV9tV8fiEr
         Tqgx7dP4LAfkM1eWtNCPa3lLtVs1r+0EU8Tvf0xwpNLwxWiYsWETXBhtYGX3he+mba9Y
         VlA3vDCqjL8tFxsYkxe19MWZbd/ImkspRtfc4gPDMPEVRSzvoDh6j+BAiLX3P96lsL+V
         nC1pjeD6MUAynqHdf2VsUoR1A1f3+iohvp1pF7OpK7t5rXnRPD7ibBF5mIiEPbHAM+ei
         Ov3jsn2etqDxQO/Fvtt+/iTCJMQHF+XvrfUUVRCYHbFxriIS/XzlRaVLizww6fEnh4Q8
         QOFQ==
X-Gm-Message-State: AOJu0Yz5FmwkmuKnp7vvp+vYvC2wHc9PaYo8MkOFEMrjU3JEBHwNt8Rq
	/kz4jI/FFom+RHeBVfQhhntxLuyuy6VvKj4Vv6R0nyJhrSn348rx79H3na12
X-Google-Smtp-Source: AGHT+IEStxKzfLme+GJhAyzJI5Wrj1OKjvKSki5NSNDtS81WvI3Y5NpSCH7LJyy9eIy5jqouUK0dxA==
X-Received: by 2002:a17:902:bcc4:b0:1dd:b77a:d825 with SMTP id o4-20020a170902bcc400b001ddb77ad825mr3726475pls.28.1710873499419;
        Tue, 19 Mar 2024 11:38:19 -0700 (PDT)
Received: from [192.168.208.87] ([106.51.151.98])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001db5bdd5e33sm11752174plh.48.2024.03.19.11.38.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:38:19 -0700 (PDT)
Message-ID: <5a9f7338-e6c2-4db7-85b1-4519ece73687@gmail.com>
Date: Wed, 20 Mar 2024 00:08:15 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>,
 Patrick Steinhardt <ps@pks.im>, Karthik Nayak <karthik.188@gmail.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] To the contributors: Note about limit of project selection
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

To all potential GSoC contributors,

Thank you very much for your interest in contributing to Git via GSoC. 
It's good to see many interested GSoC contributors actively contributing 
to Git. Hoping to see some of you become long-term members of the 
community :-)

We just wanted to keep you informed regarding the limit of projects that 
the Git project could mentor this year. Though there are many project 
ideas, considering the bandwidth of available mentors, the Git project 
would only mentor up to 2 or 3 contributors this year.

This is not a hard and fast rule, though. It may change if more 
community members are willing to mentor in the coming days. For 
instance, this may happen when a new project is proposed and some 
community member volunteers to mentor the same.

We have mentioned the same in our ideas page too:

https://git.github.io/SoC-2024-Ideas/

Have a good time contributing and feel free to reach out in case you 
need any clarifications.


To the community members,

In case anyone in the community comes across a project that they are 
willing to mentor, feel free to let us know.

-- 
Sivaraam
