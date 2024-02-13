Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9164D17CD
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 02:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707791059; cv=none; b=bDeJQhaEqQ0NAuFRdAMNYUV3PM2awWUaXsDbnsM4XORYRFrMnOUCLmn3vEv/nskgQtgcWedOGvtNODCS/4vRZ9wJLd9GFkbQAiDtiWe6x+9yqfJZvEyVo4RZzRmpBQoXQbX+ytGi3RHaniPZlJ/gNXtXy5DnKYtJogB9ZmXkViE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707791059; c=relaxed/simple;
	bh=VRDF12S/WmvinvQYjVEO8ZAW+7vEK0HA1LM4HPzyQ8Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dOt2WNzPDaxsHZ6PFxhu0sTNx9FMYA0TngZLJhCgpUtRQhjenH4Opp2wA+R75E0jiGRRc81bCcfJWhJsyWrlbYQ/wapm8tClwgarMaDrr9UZCUDoTU2ZFjCNdgBFwEyqVZcN8pSxY7GabIol9EplWoc+2XIz0at1RA386goE6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hv+KQECs; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv+KQECs"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3392b045e0aso2639534f8f.2
        for <git@vger.kernel.org>; Mon, 12 Feb 2024 18:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707791055; x=1708395855; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wQw8xGiYCwSmEJDjeKW/KgiaPX0LsjocCKtzjDnZNr8=;
        b=Hv+KQECsDaghS7bK4J54JmsyN6efCo2STPLDaAju8tnIXQT3jk8SSmy1Km44p/uy0Q
         iziyuucxRWDJgvuYtQNpA8or85loijHIfPgteahTCsrc79BZVXYDvCOcmjldAnm266Fg
         glUSzJfInHK9BkDXVPXxsygqTLD32EWlgAHGDHaSR6Poye+bLjVulJrkOYjfeZnxag/l
         fCKgsIqntf3f+9Ms1+b8aI33+MwY4GmFztY4wrRXJAH5BHfMegGMksWHovidR0WWcBla
         +1HjkDDVy/MQdk6S6JWdNWaquqIXpVoy8w0btgfu6D2ijjYuxi5DTjhdFmXc/KPIvl+j
         bdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707791055; x=1708395855;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQw8xGiYCwSmEJDjeKW/KgiaPX0LsjocCKtzjDnZNr8=;
        b=VeYyxL55qcRT9rObYdWpcPgLdnY9zMoXgXXEDTEXZvaASsO6Rj+/CZ58QZXRIFIhKz
         07ycGHK89kvLtGz6R7HUidhHd6Z0qp+9arH4l4/bFbq9ROAhjwistC1WaAtLiC/I58tV
         RNUwKELeWsxOx2S1iqbair0LxHOSsGuxDedLq6aMLzRWzKKhQUoOZCvoD6lREdK3ZLoK
         47AaiwA1lEmdUwKClEmdUKdxU8yyCdkY1k4URMT6MaKpC6ypgQvuMQpAmQpaSp3MquE5
         xI/P31gk8S/09Tu/VQggZ4IlrrsF2+LeIzUFrYLm4vlVggoPBEg8NsbopaMpL24HizY6
         y4FA==
X-Gm-Message-State: AOJu0YxYcfyJB11ZXoTT2QzLXHLULL4+/Lxe1BzLKFXt0OQISR8RANcT
	l7QRx6R3F1+Ep96MC3jQi3snf5vQ1nG1mmdMeMmDS3XBJLTG8A7L3Z2ql8uYUqZWB/GKbkSmuC1
	kogu0re01PNqtjsowooM8lboBfy8eZKjWTg==
X-Google-Smtp-Source: AGHT+IHj+CmJwk9qOn3KRUfm8owhX4AQIehd3bRu4MPewXtb5ZslmpeVdggeMbzSOQQzjoDuc9PRFoysRN+oqOzhXg4=
X-Received: by 2002:a5d:658a:0:b0:33b:366f:f816 with SMTP id
 q10-20020a5d658a000000b0033b366ff816mr6605200wru.67.1707791055418; Mon, 12
 Feb 2024 18:24:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Groboclown <groboclown@gmail.com>
Date: Mon, 12 Feb 2024 20:24:04 -0600
Message-ID: <CAEfaiTSX8kh1WMQDtT0XFUC2o3Ldu9r75F0kB9qUuby5VcrZcQ@mail.gmail.com>
Subject: Possible bug with 'diff --cc' report
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

While testing out the report parser for the gitleaks go-gitdiff
library against a repository, I encountered output in the form:

@@@ -229,4 -229,18446744073709551615 +228,3 @@@ Comment

The '18446744073709551615' value is interesting, in that it's a uint64
value storing a signed int64 -1.  Along with this, the number of
changed lines in the output was actually 5 / 0 / 4 (as opposed to 4 /
-1 / 3).  I found the '-1' value as the first, second, and third line
counts (the code only used at most 2 parents per commit).

At first I thought this to only happen on some 0 line change
instances, but I also found a diff result that looked like (I added a
' mark before each line to make the spacing obvious):

'@@@ -225,4 -237,2 +225,6 @@@ Comment
' +line 1
' +line 2
' +line 3
' +line 4
'- line 5
'++line 6
'++line 7
'+ line 8
' -line 9
' -line 10

The reported line counts doesn't match the actual output.  Based on
other examples plus the documentation, it looks like these are also
off by 1 - by my count, it should be 5 / 3 / 7, rather than 4 / 2 / 6.

System information:

git version 2.43.0
cpu: x86_64
sizeof-long: 8
sizeof-size_t: 8
uname: Linux 5.15.146.1-microsoft-standard-WSL2
compiler info: gnuc: 13.2
libc info: glibc: 2.39
