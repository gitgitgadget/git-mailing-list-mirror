Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32F634
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 00:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770838; cv=none; b=Pser1ecWJ1xgzvdZys9ewBxoE2djufb7Sb43wvrOip4WtnhZPNlRawmvmTFD1W4QwHGn5OhrJB0ZhCw+uo2W3grYC1wFd/1aErd6Kccjc9R/EGFLT14FIbcS3s85jD5XOrloS+sNzeaDMvGMyV7jWPHgtoEt+An936hR1rZeOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770838; c=relaxed/simple;
	bh=RImWUmFw9qb5QQ774jIGPpyPR3tcdoWLfb7H9t4OOSs=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=BGU5vetUBKtEbnTjmuWziZZVer08aXeQPyT7VqCPrl3ZHNy7MzdMnK0J3bIs6z2dmdl5aACKnpm7yhCdFY34FS5vfxHeFDSRvR5dDBv7/v2Hdvm07Dj67cGAC7lDfpMryfIXWWCx1TIF3h4ZUc1qjAaT9jD1wuO5L1nZmvHJ9ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKFepqEq; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKFepqEq"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a44e3176120so46380866b.1
        for <git@vger.kernel.org>; Wed, 06 Mar 2024 16:20:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709770835; x=1710375635; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8JvHfdUgq3on1Xah+ZWXDPU+xKF755P9TCUuoUkAV6w=;
        b=MKFepqEquN3wBx28ef+6WAnPe5LdqcxUvTpc4ibEgg2MgDHNtmhvgcNQrmmYP4yyUT
         gRfkWhd6yAF4pm+JeV5AaYZ+o/I0aEMLbEYaAuonvt6lqGwNN3a2iG0qkwlc4L85Rb5q
         ew+uaVe9aJzKDVbMprA34s+xvPULYoJHJCfqGYJjga5THtNwwldWv7pg/0MeS2lSZUb+
         pNw9KdlLmii8xE1wC9/JabC92jNd8JAg8qE2xVzR1Mu7kj/0nKkJtCpPIDJVeij0E4aE
         vGqmid8+PwFRqXNm7dkT+XHWu+fwRQ/n/+wkToXAEF7yew6KyiWlLCYzMN0ZTfPwoxLW
         14zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770835; x=1710375635;
        h=content-transfer-encoding:subject:content-language:from:to
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JvHfdUgq3on1Xah+ZWXDPU+xKF755P9TCUuoUkAV6w=;
        b=swjQPZ3Qt+sF8uvAObc/M/qpySD6qtDN2FUMC7rlxWqPZ1Wa5BHrXBRfzzMPFGcQJr
         ob7EAjxmrjjHcHb6lhFVUwxhLBMmjSeUTHNut6fZEhmRaY8PcyhsBIA/wUeT6b2DMMjD
         fr3E/hf6++2AMVW4miZ/XzXDGvQOv7NKxrij1lHxA+DuVLjzxr1404Ipn55gWIwVmT08
         jLYMD6+7kzgr6W/wLyKf3GllGLV/GUqjKbsLsXGBcAUDN4N40ABuABposuuSKI26H3bz
         xcGFw/y0D4ow45JrZMdSq8zwzoGugNGL96ab8egAHqJ9ryhkGLi+Q7AJ5AJ9SRhcmAHV
         n/mA==
X-Gm-Message-State: AOJu0YxnvyhEmG03wuGPpMAWhtZOocBqClDltP4jntanRpm63X7CiTSx
	uDD6MMHhRJk0qEOrFfItmZ0ZQaxJXrZ6rQljqn0xr703t+OyhrfIojqbTYHY
X-Google-Smtp-Source: AGHT+IGIfHIzdUK879ZFlen5Oy3JIo8UI1sRYytDlNvNAc7kv1TFC/SQgGvkI9AmTU3f6bB3zZtByw==
X-Received: by 2002:a17:906:19cf:b0:a44:1f20:e6d6 with SMTP id h15-20020a17090619cf00b00a441f20e6d6mr11436427ejd.1.1709770834878;
        Wed, 06 Mar 2024 16:20:34 -0800 (PST)
Received: from ?IPV6:2001:a61:a8e:e301:3736:12c8:599c:6635? ([2001:a61:a8e:e301:3736:12c8:599c:6635])
        by smtp.gmail.com with ESMTPSA id af1-20020a170906998100b00a45aa7cb029sm2179440ejc.36.2024.03.06.16.20.34
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 16:20:34 -0800 (PST)
Message-ID: <44a24958-ba39-47aa-a15b-61b13cc8b62a@gmail.com>
Date: Thu, 7 Mar 2024 01:20:34 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: git@vger.kernel.org
From: Lamy Geier <lamyergeier@gmail.com>
Content-Language: en-US, de-DE
Subject: [Feature request] git config - includeif - resolve symlinks using
 realpath
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hello

It will be useful if the path in includeIf "gitdir" uses the resolved path.

For example, in the following snippet, ~/Documents/Git/Wiki is symlinked 
to several different locations. When using git from other locations, the 
following won't get included. I verified this using `git config --list 
--show-origin --show-scope`

```
[includeIf "gitdir:~/Documents/Git/Wiki/"]
	path = ~/Documents/Git/Wiki/.gitconfig
```

Feature request: Please resolve the path, before using it.

-- 

Thanks and Regards

Lamy
