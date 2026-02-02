Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D826387348
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053283; cv=pass; b=NQGgHgk7hkK9EknkLZ3Kgbiz2QDjsWHFZB0M3G+R17loIE64VgonfnHRtcvLTozDjOBkFVZAqVZCiz2OPL70cepyTKqmt4e0nhss2bX4u93s3q5OWUkFtK+ZsLfl5iMshihPc+N1y96MIqMyUSjmZAH0gzioGduXoTEVyRgNWwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053283; c=relaxed/simple;
	bh=cXHX2poR96TLTQvVVK6W0whPKzjTM9fQ+iOOSUuzSVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KJWROWu0m22bRbK+CDqpRDKKs98Mx6kgVZJ7q7dhon81mg8m9xho6N+rLqC8RiM7mIEvTxhkA0jv1NAdO9+ABJS5upvM8K4QTb7TZOnLvG5prOCbx0ML94huj4mCj9anpV2Kv5FgCRgySSSFuB16istKUCZ8NpziGn9SY7gmaLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A9Q7MsDZ; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A9Q7MsDZ"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-649bd1f08acso1655714d50.1
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 09:28:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770053281; cv=none;
        d=google.com; s=arc-20240605;
        b=ls7ZhM80z6Tw8ePAIZvUFxoa009R4YYbQMrTudeIcY20lVGxH8B7rZmtFUCsETL0Q+
         YvUhwWiwyts7ozH9P+6XR3ZbMHdWBwwlM48J6O0rTYByoIJ6I9XnnNrCJJLPpykS4C6h
         H4+RNcUWrw0XMgonTHPA9N95BJvOUzQ++p02T0ZIk6psJHcQlZx0t/m/nlN9A3o5AlB2
         XIg3KCAtQjwG0SPK3+pTZDW3AwVagL48zz1N1Z11gEBGRpKqZtka+oqDD+eUrR2DwqnS
         6DvEYPkyUWDVKY72O9XcImBOewSzbuXzBJyVVtY0f/aHFEmciCOWa1R0SmA5h7IJZg0a
         dVPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=0x1FYj/K8IygG54EzP8mTcPMnAUdBftjCscxeAjBTHA=;
        fh=2WzPN+ztcZisvd3z6A2Xqw1r3++8q21mmsxFUcgUVqA=;
        b=Uqaw8gzI86XrFvghmlEgOUqCn0LqnvQIDryNwpGGUl4Sfsdj+WpbSkA9maLqe5KLFk
         qtBFfqty55cmqi1SuPDrUGkQhGhcYbemhOdA25/dgR4w7fg4d6lgh6V/jAJSRP1EHoFP
         /5ucBTo0ynx/v6rHQC2Q9GuvJxND+MS40TK9fnksKu9wciRVAyBjE9+sUI3d7+0zNTsp
         CxYJ/HjfwIXH6P3iac2Of+ImLa5fhY1Nc0Rt9Zj0VsbupEieHz9MXnVLxONhvtLijkD7
         i2e7BJfgSW9yhfJTXHap7ILNpA5noaF9rM/9Sx9rX02oNsPvZb1RxeDOFCx1+Jb63i6E
         WtqA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770053281; x=1770658081; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0x1FYj/K8IygG54EzP8mTcPMnAUdBftjCscxeAjBTHA=;
        b=A9Q7MsDZrCCXQFWpUnWizJvYTmq1+h2i1pgWkMazG+PV8AOAQHm7bwDQ3MuBVzuloO
         nBkUAZRsylRRKqNpBw5L9MOw8PA1159H8kHNXG7a77fHfhDKIVJ63TsHpc2QNmy0W5qz
         sMsq6T6SXKW5AMQHhJZgxVIkIGCpxKVjO7/twZg+55xykTAxBcSb5dDoEsRHdvpepuh8
         GWrkqjf4fvwkG39Drgfdu3WHjDMPRZEqaozKxTdSFCFDdHeUz65p9wsF7/xQl7/Rbs/b
         /LvQLMC418Mbl3qsJEBeKwggncCW3kWng5TDW7nITQ4HU3H3KRrrgkzmuRhzLPlVv3sr
         JVxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770053281; x=1770658081;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0x1FYj/K8IygG54EzP8mTcPMnAUdBftjCscxeAjBTHA=;
        b=PXSn5Lu8yXW16aACyHydc5cL8Udwfwg2BmGQap+RGfOdNBPogHrfcCLlBm7jmnzyit
         pdH2XscQC3inyINji43amSHfEpgipvgVGQmWPcZ1TCR0KJZn3KZGINbClyW+03b+iX+Q
         SYu/x1umPgD/La81LZJU+kFrR6agVwMJs1vcD6c7rqDLELduaZgcrHRN9sYGB8UtgtFD
         znEqhAYgSp5WVT6P3KjUBS4GktHI3OwSZGNfOfZIdY0sMN7GezL+7xWJNjYGubjqalXD
         ty2lGOM/3k0g9+Gra9g/+IScowLLcvRTg96sSqc0fGJaeiZghGvsQAb8HGkf4Cx3bHvl
         Ey0A==
X-Gm-Message-State: AOJu0YxoMQT6/UOAEXbJY7TBpwrPQ79huPITY2H1vajaVf/r+wtBGw2v
	e55KJDIRLE+T5y6uEcCRwVA2leS+jUphB766WociNcl5W0tfg5ZcHWC7+32jRKlfd+HI4pQ+Kw7
	X5uUMqG7Rh2xpHowCsUGB0OGkjpT2q7c=
X-Gm-Gg: AZuq6aKLQ3PjCWbZjkpXkOaCvbciJhtVTBz1nYYsGOhvjMhFuxygtGVxfZLo5rePiQJ
	JkdNzextH7YHiBsfx5IdZ2RD/PKLjvCi22DY6V7cp6nkzQ49y68i0g47PTj78SfM11JIB2CeO79
	3MXJ1+o3WVqkQe5se1yZoCkNl5JE58sz82i4U1X4sTTEl+5705DNIO5SGIXtw442VjsU8qGOMvQ
	j+Fr5FVPoonPDci9ze0DsGkyTLhvAmcaykr1tYk7ZirCm6OdWqC64GR9VVbV3BFr0v+7swWngYx
	CGGiwQ==
X-Received: by 2002:a05:690e:150b:b0:649:5210:2272 with SMTP id
 956f58d0204a3-649a84b471emr8940920d50.76.1770053280973; Mon, 02 Feb 2026
 09:28:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
In-Reply-To: <trinity-ed0884d3-098e-44be-aa1a-a96f664ce7ca-1770049279182@trinity-msg-rest-gmx-gmx-live-5dd78c558c-fv4g4>
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Date: Mon, 2 Feb 2026 22:57:49 +0530
X-Gm-Features: AZwV_QgzuLEpHzY8INM_ORRFIZnUK7ERDkSIYQhO5aIYEH4t1yt6ERYGxSXM_2g
Message-ID: <CALE2CrR5MS=LmXGYW8VbN_trLzMf1tk3BEkh3wv=hju9AWQbeg@mail.gmail.com>
Subject: Re: [BUG] git log --graph --pretty=format misplaces graph characters
 when -p given
To: lolligerhans@gmx.de
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I can reproduce this on Git 2.43.0.

Minimal steps:

    git init
    echo first >test.txt
    git add test.txt
    git commit -m "first"

    echo second >>test.txt
    git add test.txt
    git commit -m "second"

Then:

    git log --graph --pretty='format:%h' -p

I see the same trailing "|" after the commit hash:

    * 0139218|
    | diff --git ...

So the graph character appears on the wrong line, matching your report.

Tested on WSL/Linux.

Thanks,
Pushkar
