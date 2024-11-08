Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57029CF4
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731102021; cv=none; b=o+g84O+NUKp8VN1zos3fhE1WOqNyCy1XBdJPA0RAyVKAfEzv8SONQkT0SWh/td/eoj8tolkjh0S745C/b7VXQsPiuCkRQlhy1ecbMMZcPacSKBPw3vC1+tUzRHkK/zn8linbPA8IMCPjAunTw89m+a7e7x1oPnqjN+U/yJCqPeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731102021; c=relaxed/simple;
	bh=oGd97KwWC0SH2j1DaVrtV4TJx6gHnqsHCyKv89p42X4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=a7Kspmv+UrSCN+Gayzr7HqfoxV26GJugy+oTmOaEuCpbV1A+Le+xuYQCrgPBBUg8S8Y+wfJCFX6GpTCXqVTFQxMJtzaxs0647Of+6xYogMF+DJxBmSl/ZrtUC5tF+bPATrrfqsAxpObFafF+ok1EBG0clTbwH2+J2a39ZpIcNkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OezADbut; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OezADbut"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20c714cd9c8so28934395ad.0
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 13:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731102020; x=1731706820; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oGd97KwWC0SH2j1DaVrtV4TJx6gHnqsHCyKv89p42X4=;
        b=OezADbutsHoJ8HGxkfqm/Iw8jU43c7ijJVCSa6JIna5Fjq1t8eObYFrqQGYkwxF/10
         G5vtIgRfto+hMt/GxFcxBeFsor2vZ5BRIcYsB/RpKRaiRegJ6xeaNpdDD4YURZV4GZdb
         udHIBXk2sNYI5j7F4wLQa7LC9TC+hPf9Wq3rPoK8ofG9aZeTQZQgirEm/DpOq+5VHsNf
         NhRN9AHf9Y6Xxf7sWytbZ2io/xzkG9wESg4nIIwefXCDJABA+s8efve6XI+1puLHoXV4
         vCMnxxj/yk8bzQHUbD9rUDu6m0ozStTcbakOe0pUOYRiGwmDdZXbHxqaRvO93eouZuWC
         NOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731102020; x=1731706820;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oGd97KwWC0SH2j1DaVrtV4TJx6gHnqsHCyKv89p42X4=;
        b=vA49CFZY/+mArUKyq7SBtE62om228IAuNLghV9VIoCkf8mSNMs/l1b3EEW4sychN4L
         ycLYyeOdZ92+ZSOl9E4+HkW9kPUn9IwCfeHtorCs3moALzzSJe70agVvfMKqXasjZzvz
         D1CmF4+QNvGkx2opEN3VU7049waj9pJoLE/m6zNMSkw1982qgxrQZYiDKs50REqW9TGx
         +uTnNszvMUIcvt9aL4Mms3CB2nlcs84ZiQ/I6ptOrPrtSgZJD8/kw3En9W8oRDs2R2W0
         ZoaQi7e9sP5naXtq1s37xI9KBaQpYIc6fnYt1XlSPbSfdvpRk55JUEE7uJ6UNa3EXUcz
         awDw==
X-Gm-Message-State: AOJu0YwSRQFSq6v4A65Ka+DApkv6hIwxGh431dd/FY+aPcO7WLmPxPJN
	t/ADEIln4HiBGrjzYmEyqR94ZrntuCRhO+q3VuVwwxITMy2zYZxyleur84zd6w8PpA/Qos2/FVd
	1hhvXOMgfmaPPr4zvtmSeZKZdyI/1yEvw
X-Google-Smtp-Source: AGHT+IFiMVKD9mS9BndtFkkyXKx8UyXsdfx2BMAbslzG3PnOb2AEtL6nQ/mQ5emCtv+TEdzV2pg0+toeIpdsx4e/gVs=
X-Received: by 2002:a17:902:ce8d:b0:211:2b2:2086 with SMTP id
 d9443c01a7336-21183e4a253mr48976825ad.49.1731102019818; Fri, 08 Nov 2024
 13:40:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Peter Kassak <cache.sk@gmail.com>
Date: Fri, 8 Nov 2024 22:40:08 +0100
Message-ID: <CADYnh+Fudpy9kfg8npUMutMjzYNDy-XxJCCJ_9O4kLoB807_3Q@mail.gmail.com>
Subject: Extremely long subtree split duration
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Windows has always been a bit slower with subtree split, but now we
encountered an extreme difference.

The test is on the opensource repository of bitnami charts:

git clone https://github.com/bitnami/charts.git
cd charts
git subtree split -P bitnami/minio -b split

On live Ubuntu 24.04 booted from usb stick, it took about one and a
half minutes.

On Windows 11 installed on internal nvme, it took almost 4 hours.

Yes, it sounds crazy, but it really took three hours and 53 minutes on
the same hardware.

Main difference (except OS) is git version. On Ubuntu is latest
installed via apt 2.43.0, on Windows is 2.47.0.windows.2.

I have tried several different OS in docker, virtualbox, different HW,
different git versions..

Long story short, it looks like since version 2.44.0-rc0, probably
after merging 'zf/subtree-split-fix', subtree split is much much
slower.

And practically unusable on Windows.

Can this be fixed?

Thanks, Peter "Cache" Kassak
