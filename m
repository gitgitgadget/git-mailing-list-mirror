Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2D94120B
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728192819; cv=none; b=UrFy+H8D4K7cFBujKWW3S1OwAXI0Sww0ryBZGSTSUJvlcwP1uRUZQXBlWQDIypYfh8OzkDaU10yuEb6geAf+3Pwykd2ycvGak0cw1OVV9LY1BMGkrWLW/rYdaJeOJj0Rlb6UXg5zAf35qeHIXO6Irfndyku4iyUEQZhUbtcCrL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728192819; c=relaxed/simple;
	bh=Y54At509K5QWpis0SoB3GgMxmpAefzrYCo14HUUmypQ=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=FqL/GeeJKnAxMQlmeXi5O9i+EmTQg9IXfAmn4JWIuJ9upSGjUgNauoCngtmI3raxZR5ciRANZ6eylOQ/GBfRpxwfAM0gp4S2DZYGpCcike36G1XHMIZ24dlBf3ChvYSVW4dcQs0UiDCZ0N6GzQkFl6bbna2mYtf9Yz3u7rj9NWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fhOxjzTD; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fhOxjzTD"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a8d4979b843so461362866b.3
        for <git@vger.kernel.org>; Sat, 05 Oct 2024 22:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728192816; x=1728797616; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=bnr2bxZqw2alVMd03b/mx8cTP5YyIUujD1A43XRfg94=;
        b=fhOxjzTD0lrDhooxf7jswdQcrmiWAiLTb2q3E1Dl1O6T+s7y6MR5NWMbioFK+NX9Ln
         NQ50drc2zHmJaXyWE5qAFtlfuayCYwNTgtAHtdq1DZC3MD/Wd9l1n3EXcEm7GlVJBK2i
         WBaSCVEkn92rTixFbakJFE9IQZ+y4QGc0Pi2/RZfSf6Fs3zRjFS0vsMEZs1jf1coTKv7
         VSVJcjwJEpSs8UqHRWaNFGvt1Xo1zPsnHJI6Gy/eD3EhZ2tHXmLDPuWW/2Go3iq8Z+pV
         JLBP6HANSq4xKkqU/vy/q754E9CgET8W+sN4/zazkyeVZGkK/kXqrf8zfSyG430/2z1z
         60Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728192816; x=1728797616;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bnr2bxZqw2alVMd03b/mx8cTP5YyIUujD1A43XRfg94=;
        b=glJSileCNj8l5lDEZ/+FGUamjKhwZozTF2mQnIn60kxfBcxY3J/iB9B705nNMn62Lo
         oGyHmBFgcbwCTKFOkdjLpbLevv/fuoWjWke7ZFHVEXnDfom6uO2Ar3aEEBnrMz3onokK
         q1eds6ie7IRKgeJabiqo7rdmnFHwFqjfToKItmdebVNIBWOpc9S2H4IdR5lgwMeik0EG
         MCrtyxgO9HDvx91ROJxDxT/Y5bq7iPSVwvcQCEZthKp1h7lT+o7GirOACKPtL7g/TKVI
         hpw8k9MHvOSUAVGssFx9b2R0rcqzMsx9fykIeTLmuUmrVRBXNNQV4N1/gqQkdEhvTEx4
         zKPw==
X-Gm-Message-State: AOJu0YxLFB7WAoerWYey8joe3XnhhwSjTEV10g88SAwCSvCfWKdGDPYG
	/pky88+Td7wkWWzDrgsQsURj/zs3CTvNQwCRd9S9F9sp5/5smUUH3AJvwQ==
X-Google-Smtp-Source: AGHT+IFZ4N/pL8KRBWK43ubrheG44BlndDoOJUdT1Nj/7g+tpQGpD82Yi3+byBMZGp+2IBokkK95KA==
X-Received: by 2002:a17:906:7956:b0:a99:45c5:339 with SMTP id a640c23a62f3a-a9945c50440mr230782866b.32.1728192815820;
        Sat, 05 Oct 2024 22:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a992e78757asm216189566b.102.2024.10.05.22.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Oct 2024 22:33:35 -0700 (PDT)
Message-Id: <pull.1805.git.git.1728192814.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 06 Oct 2024 05:33:32 +0000
Subject: [PATCH 0/2] [Outreachy][Patch v2] t3404: avoid losing exit status to pipes
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>

Changes since v1:

 * Added "tr -d '[:space:]'" to handle whitespace on macOS

Signed-off-by: Usman Akinyemi usmanakinyemi202@gmail.com

Usman Akinyemi (2):
  [Outreachy][Patch v1] t3404: avoid losing exit status to pipes
  [Outreachy][Patch v2] t3404: avoid losing exit status to pipes

 t/t3404-rebase-interactive.sh | 71 +++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 23 deletions(-)


base-commit: 90fe3800b92a49173530828c0a17951abd30f0e1
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1805%2FUnique-Usman%2Favoid_git_pipes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1805/Unique-Usman/avoid_git_pipes-v1
Pull-Request: https://github.com/git/git/pull/1805
-- 
gitgitgadget
