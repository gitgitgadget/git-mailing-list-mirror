Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6212519CCF5
	for <git@vger.kernel.org>; Sun, 15 Jun 2025 21:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750023723; cv=none; b=GG6qXZw3izLo/9gaDt0tTPiwubjHp32tVJbCftixGb1xxrZf5loBrH6XKZCAla4ySS0HKRMgX0d9FvEuyEC63VOfiRe0BQwmNE39TCJSyFTPcfCNHdeP8RiP4hBnqzgI8Z9NVNFwQESYJHW3iKr0yiugSV4wvZkRnkCZ7WIqTwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750023723; c=relaxed/simple;
	bh=Uko6OCbkW747rFL+BTDJoxcCNdpNPufQZkmAAX/avDk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=ZdNXfwAXoSfrnGuxzaEgSV2x5RmwT1yFsl1ZOh8iiPIs/q+QuHjUIJ42QxxJSoDwCBX7EchwoevXjP22Ym5ziAgd3BePyaiG+Hk0dEFpSFOHfiEmjmsuM2w008FcwYabi+yBKT9oXjtQV6RhI2H7sWtPD+sc4VS4Js8oo+wALmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6d6Xore; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6d6Xore"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e64b430daso37896517b3.3
        for <git@vger.kernel.org>; Sun, 15 Jun 2025 14:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750023721; x=1750628521; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Uko6OCbkW747rFL+BTDJoxcCNdpNPufQZkmAAX/avDk=;
        b=Q6d6Xore9+bkR1lvDTWACmFscWgOWuZQL2ghWkBDBW2GD/FI9Net2qqt6SsnTwt3Hs
         diKsK7EC3TeHD2WKNFfqgAWCIL9l2krQ5KGayuqtPoTTkCgZjG/gN4lT/G5y/iHOwwJ+
         YBf7CUs6m8PPP6xosZQNymjmFMCLcpOP7U53Q/2PNGZ6fvi6gbBX3HgFQFshYGh0B2Tz
         Ri+SnDwH4tGhdxRV/32QQe/f1caz2L6K5ElfeDA+oQHPCg/Bhc5K9HeqJqq9RMSwcgUw
         ObEzwRi9/65aCEzDWpRdGx7EBB6qX4EUubm7SImiibvBnhIkgZ1smwv5ubKQU1Pk3hPf
         Gemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750023721; x=1750628521;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uko6OCbkW747rFL+BTDJoxcCNdpNPufQZkmAAX/avDk=;
        b=d9sgXNJ3SHw5G2ngpFzyV7ACFeKJiDZtbY5OshU8YoCJE4bNft9pfvPmZxw5RDHs66
         sFUPVPdGkbCpYttBr8+sQdzIeiF5ONXFzW24SchsI4PTLXmOuTvqMZ2kkANBAJEHR/Pj
         X+gm4K9P+wpf5sJWiWat1QwtbitqZ2eZ06Zkr5CSOVF4U76aBfpPLwLMAkea5lbmZ7MR
         fi7KsMYaZPE9jC0CUoqoTTwVY97MMhNc//VbFXnU4J/fCSvdtTeK3YItQy2fICXa+d5/
         eTNFsH/95WDiyj5z3VHHTFboX7gMLDA/lxTcXdYM30HWpVnyEzF/S9amdBJKQTbrtGjG
         g1Sg==
X-Gm-Message-State: AOJu0YxtD3JBsFFAl8tC6ELTQ26+pPoJPNVOA/UDgocQtxjH/I+GHhfB
	zn+MJHJezihjgBItdm+ByekJnhPNz+zkCSOF0AjM04NB89Ln41wH4E7tdMDkEwYo80nQXeqacQV
	nudNNyc56nHbFsgoPq5igKdF03cZr8GWerOSG
X-Gm-Gg: ASbGncv89RB92dKA17Myqcl9XaOPUwYJoWKv/2lN1bJPt3C8/mjlCzTomFrCyqcB0+s
	XyuYnVD3XmVGtHJ7I+7f7rEI5e7xTA/1EKDXQHtHJ27qUDaexE5E5PEbtMcDNn1GcAc+BGg6Z7P
	8xGM2Myeu5LAaWB6+nnqjisTrIkdd/gboD/7XFqfL1g/Tv4jneQFB6/g==
X-Google-Smtp-Source: AGHT+IF3sA2FdTnBsGWYnUD3RZorQkRiCLwo5lSrqgT+S+5WtO9w8/7Yo6F/ZR0ohSCxwKN6+kLGXOD2bGzSaSTpJ3Y=
X-Received: by 2002:a05:690c:5506:10b0:711:94d0:a873 with SMTP id
 00721157ae682-71194d0a8bbmr4973687b3.34.1750023720930; Sun, 15 Jun 2025
 14:42:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Juri <juraj.sojak@gmail.com>
Date: Sun, 15 Jun 2025 23:41:50 +0200
X-Gm-Features: AX0GCFsZhdKVAyHanwMTpGk2j-XblnI8vhjdBp35rBsaG3waSCkUudvSv64lEYU
Message-ID: <CAKn8H7qa_b==1LqPkJ-dmH0UNNp4Z4xbewN+LgcL6-bBPM1boQ@mail.gmail.com>
Subject: Git gui webclient info
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

Will you have a webclient version?

Juraj
