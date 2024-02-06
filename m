Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A843612E1CA
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214769; cv=none; b=fubljZu2mXsaFwVoosH+4YwqsxRozdcXV9KQDxGF8cZbKBBb5TiUsMuJqGL1bSacf5YsxQuymLgas5H9KcYgUwB3mUBsUsOObg2BJs/Zb7sQrref/XKWaa51+yjUWhLTVixuWt3/gCNk4mlY98PChORnsKVjNsT+XZ+HcI4sF2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214769; c=relaxed/simple;
	bh=pI5sdZxqbPlBQipq4vr39g1LH6AKhA9YV87ZzYw3/VI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=tFAEa1E0LRZXU/raYPwF1NrraYPodYYa9PMh8ccLD+wXjE4fqdo/M/ePMZfDqceZbyVTIQhRBzyusy7uO57FJCjh87Qj9apbAiSxjYjtmsG0YGADRLgHOfIkzbKDFRUypXeLlX4q8DtoOMWcs6olZncFbtiBdcvEN8QibQ9Qr6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnerqjYp; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnerqjYp"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55ff4dbe6a8so4679875a12.2
        for <git@vger.kernel.org>; Tue, 06 Feb 2024 02:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707214765; x=1707819565; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pI5sdZxqbPlBQipq4vr39g1LH6AKhA9YV87ZzYw3/VI=;
        b=MnerqjYpYMj8pNjyM93toW0+jszX+QTEl8U7tx65Df6CRQWjpWTYPglM4u4kgJXRqv
         r1W6+JW1m4FIbEQkBirLDBS1ok9ilWlYQiEiYx3bBX9IIS/jsx6PUKnaVsdc7obh+ndA
         a8M3iGwJbAt8soubtoqRGQRyyTWy2Yu81DmOI9BvV1eFCRwbuE1lRLVFwDH4JIDMm7FU
         3/jkNT+0Q+8TDbruqS5429SMa6kXu6l9/2mK1fWp1nlkRKLDIAtYuOJ756TSfhPK8uqB
         h2C4mwMs/H9Udp94k3bA5LGFjwwc3kHFdOPueC8m1sr+yPNH4qhZ0AiwiyISvJra5zCn
         43Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707214765; x=1707819565;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pI5sdZxqbPlBQipq4vr39g1LH6AKhA9YV87ZzYw3/VI=;
        b=MuMgWbnqVsF+itZM9dI1lw8jkZ2IsP7bgn2yvCxNibrVOnhFGAAmAo0BDCa11vtA4d
         adY76UZFLTIq+VnNDDCIT4wPR6St81NGiMSxt9jB2FE+hNyu/ULLRdyJxx8MzqWt5fer
         R/pSz/0fgOg3L5Rj5gLkXTfkPF7YDtWSFCwmflRVwFnPpK3E0dRKYlfCH0a56c2ZGp1f
         Q+6dCgeKy40QCUQF+GHlhZpUtd9NFsZiig8UIIkn7VND8Ff7PyWSdck0TsT3rFRqrHk7
         jqcm3RM7uw/gMbIRMY7WoFiQbBNcokT6OnBj3OrBLUdvC3LIEtJKViNhH3TaIgvEZymw
         14Rw==
X-Gm-Message-State: AOJu0YzaJkqMsJiDPiHqEgkGiMwJSDJDPOAxJ5f/kPJE92T5ONXRs1CC
	aqvSzppYdDP6XWg8ZX6TB9Dn6Md5z3Pbz1aEo6ry5OXznE3/bTIRQkbmWLHYIfYIB65kXiG7E3v
	cHoSqxXQLEdB2ysaihxo4os3RaPwuctJN
X-Google-Smtp-Source: AGHT+IFjdbr4Aip1wsbxGoC6AVRGTOz34iBdnSFj4NU6qVaiylzTJbQmR13APeKH71cHUSvpW2gTxnwGf47J3tHbCac=
X-Received: by 2002:a17:907:392:b0:a37:7fd:9a18 with SMTP id
 ss18-20020a170907039200b00a3707fd9a18mr1152166ejb.10.1707214764905; Tue, 06
 Feb 2024 02:19:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Tue, 6 Feb 2024 01:19:13 -0900
Message-ID: <CAC4O8c_PW5Ni0UzrbkqDK+XXmWrxCDvHxjrMG93V+fd8ZPEADQ@mail.gmail.com>
Subject: gitk view Branches & tags field would benefit from globs
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Well something like globs but for refs.

For example when I have my_branch-v1 my_branch-v2 my_branch-v2.1
my_branch-v3 etc. I'd like to be able to see them all without having
to go back and insert every one into the list in Branches & tags.

Or is there already a way to do this?

Britton
