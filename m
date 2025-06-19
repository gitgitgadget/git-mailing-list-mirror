Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4689030E847
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 21:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750367340; cv=none; b=N1sT3V4zlup09aBInOtEp+dCmjSJCQpHVec/s0bIW2SJE1riQYclGkcfZUW7sxgqqcTa55D3t+472cbEbms0uSmYx950BKeK/7Nz3TGWvdVWLjJKZns8AQC4+Xq2TtCB9bw3LBDxvRwjAx5Z/yyWuhRoRygvw0ite0Xv8ead/Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750367340; c=relaxed/simple;
	bh=/02Cr+ZT+WWUzTmU3Ng11U4jlUvBsPORVA6Y1mwWNTc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=B4bKBN1zWnA7tbwdDyTWj0PcChyxbJ5fyHWvPPK2DLkkF8fK8m2SiSPaP4TDo90G1qpzAvrdlJPBT64CdhYVu20PuOEcBw62rRVVNBOjl96gzqbzN24B8Ly3S26GhU68iC7b6SUuPnvBS0DAS01jVzlJXUsPMQDxMIcnpXJx9zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaDCJhkd; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaDCJhkd"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2350b1b9129so8828495ad.0
        for <git@vger.kernel.org>; Thu, 19 Jun 2025 14:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750367338; x=1750972138; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/02Cr+ZT+WWUzTmU3Ng11U4jlUvBsPORVA6Y1mwWNTc=;
        b=MaDCJhkd8HxxWNUEJrxUreg7KBjUtm3zTo7D2E1863hXNpGl/4EDlKKt1aefgyt4RE
         F7d5DSjafcnny0EnSzEPq6m9WIfq+VmI3nRGjk6S2DYDE5g+Z6efCVAOE/XNrH80dK5J
         Rg9jz7uwL8WrOpgrq9ynKaDuJ9Xd6W3nZm3B5b2vcaEoktEaXim4Vi0crIblXCXjVfl3
         jVnwJhx+wA+wDn8a4a3g601D7spjx1ePsPR9R/STeMC7NK4MhwpGHnjBg6zAjt2bWwqy
         LZq6xCt6+SYSKXo8mw6ZbTFBZdTzml7XmsFLlaWrZRYZMA9Ovadep0aztver41NbEs3n
         nxIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750367338; x=1750972138;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/02Cr+ZT+WWUzTmU3Ng11U4jlUvBsPORVA6Y1mwWNTc=;
        b=ZYB/4o7yl1XWUItFTeJb628VVXHefxjqAD75QNl+wxEjmuVoTlLo3l5w9d9r4GEH+b
         Szx3nwX/e/nK8aBPlftcQp/Oryo45HUC8j/LSjrSCq78q8APfOiSrHZIFFRK5PkwqPRB
         pJTUNrgwrqILD8MPwSKFNFvZN4TgfLOROKLlKlTCjlIY9Q4xm6BUo58TLg1F4aev2G3z
         PJQpUFeL/M0LABrfVPKQk7J6RlS7zIKcnE6hiFPka7rdgFzxZsOctnQtSadxEKPhmVaG
         21POE4DobaniVNjvlCY9OsoRB5mxPZAWXf4JFxCGcjpjCTin6lb8xOrHMZoel7f1DSFm
         WeXw==
X-Gm-Message-State: AOJu0Yxj8N43Eu7bxqUt07BaeDPH2tMU09z7WXmIVzA++nqE+GIqVhyL
	y7zuNmWVMoiys9/uk/Oc5bE6wLAZAR751HCPmwLhtNgGaeBErrjqL9yyApjnLQ==
X-Gm-Gg: ASbGncun+Uam7PU4SCpilw+We56SYE9yYLlT3XvPASDWZ/vCuTjO/IsoR83VT3My8S2
	mOuwEgJInb3IC8j/ytEkJyll5YSYDW5pddK1DMAgos8jvSicy+MyVrnUnKEMznjin46rlrsQhBk
	KnWy+u+vmADz3EkbmmxKfQczsM/f3wH83YA5XOpgld96DQj2HUY8IlTAYz4FCZWszWKIKPx8rUZ
	1CXxd62d/HteTg/4yLz1nHxgawibROIW1eEmA0yWnHrQNChSfmVJb8NaLcL7T/yzykelo5c7Ev+
	zzbMElS4HOz6D5epE9rTrbkwyIG+Pxn6LtFSlugP9M8qLgUAwZvY45cF41TU+84lGSouctk1oBl
	DmDG81jVKMQrTOgnV4mCgVg==
X-Google-Smtp-Source: AGHT+IE67/XRtsYEkUcN2QWR9k2z8YEbbbL0GlHrn2PvZ1a5XgsQe/MPHejRvpMcC7ZfYeRQA+b0YA==
X-Received: by 2002:a17:902:da47:b0:237:d25b:8f07 with SMTP id d9443c01a7336-237d9a00d6amr4266925ad.44.1750367338535;
        Thu, 19 Jun 2025 14:08:58 -0700 (PDT)
Received: from smtpclient.apple ([179.100.18.48])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d860b761sm2282535ad.139.2025.06.19.14.08.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2025 14:08:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_Blog=3A_Refactoring_in_order_to_reduce?=
 =?utf-8?Q?_Git=E2=80=99s_global_state?=
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <CAE7as+agjJm=taLgeracuApiGR1YgP5ZQhoHroTk6=Z0E9ww9g@mail.gmail.com>
Date: Thu, 19 Jun 2025 18:08:43 -0300
Cc: git@vger.kernel.org,
 Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
 Christian Couder <christian.couder@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3079AF5C-CB54-4674-AF5C-24CDEF3854B9@gmail.com>
References: <CAE7as+agjJm=taLgeracuApiGR1YgP5ZQhoHroTk6=Z0E9ww9g@mail.gmail.com>
To: Ayush Chandekar <ayu.chandekar@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> Hi everyone!

Hi, Ayush!

> I=E2=80=99m a GSoC contributor working with Git this summer

Me too :-)

> Feel free to reach out if you have any questions, suggestions, or want =
to chat.

I see that you want to get rid of some usages of 'the_repository'. I =
don't know
if it is in the scope of your project, but something that would help me =
in my
GSoC project is making the function is_bare_repository (environment.c) =
not
dependent of 'the_repository'.

More info here: https://lore.kernel.org/git/xmqq7c1genyp.fsf@gitster.g/

Thanks!

