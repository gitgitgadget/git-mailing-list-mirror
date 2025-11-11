Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A0033ADA4
	for <git@vger.kernel.org>; Tue, 11 Nov 2025 13:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762868206; cv=none; b=sOgVzKzy/KS8I3lUBjH8Fr1wvBqxwSrbLrHyV/NTeeZdMmnwgIYP0e+hmfstZPdOVT8pIMiJlBXHlSJ9SzT7PUv/9nTpaknYCApVUqKhIE142JeP/ym9+wQe5VAiVpr/Q3jJrSFOgSI58jwP/rgxy43OyyocYmsRJDsgcYRtozU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762868206; c=relaxed/simple;
	bh=zMmAk9n3oB4i7CMJh44GZojiYAD5vBEgOt+bV0VeGbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hmdLx+9KXig0UKS8fBcgi8RqR7IOA4ZVSzS7Lt4sZa668C7a7tzQ7yIkT0myckz1zGV297VDaEt6IQqEhpMIavxnBDzqd3BqYoGRK7n4k2LqNG707OvD7JVhzkQOqsHS0O5UNz97R+mlO560lhdulhbMdlwqXKL4wBOe39/yR4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DWm7SBvC; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWm7SBvC"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso3746640a12.2
        for <git@vger.kernel.org>; Tue, 11 Nov 2025 05:36:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762868203; x=1763473003; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpcv5oPQWsz8mSbxycVehRFUlatBatx90hX7yJN3JMI=;
        b=DWm7SBvCTlaYmnjIm0ZhYu0jBEOIIdg0N8rozS5NWolj8NUXJEVGwT0yYoLtLRPAuz
         9oEDzwb03snzMrgSwZ4j1ODTw6t38oUR9K1DiEVO7fV0hJ5Xtm1X5XovxqMlp+MZa31C
         HTXjK5mqg0DO9Ph6LGMTz6bgMHivJ/eNsYr33B1IFneGaZ0Jr/8bUCs8MU2iP4ctXq7o
         FgmODMCHTpGUYlQvJAJJeOwYiBylMM0aUmwbz50Liil4zIgpsqUsJPPI7OxUdaSrJAu9
         +LWufWGGVR1DrOdykWpPxiF5mXUjkFJAp01VhlKIK/3STy3F+UAe8CiLWtZSkZmHJBFu
         POHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762868203; x=1763473003;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xpcv5oPQWsz8mSbxycVehRFUlatBatx90hX7yJN3JMI=;
        b=YIafR0m67+1ZniSE1obDdDdjtlBPcadrGR7YbHwppk85hYmvnv3pV/2RNyshsUhJzb
         K/c1jU7J5WrJ6UlXEtE0WhJyQ3hnvDaGJDv9rxjqIa+9aDXl1CS/OrIcLIN/nIf49j7T
         Sc62LBLKnN+PnbNcv59B+jSRQV4ubnSB0KVBtNiJqzHguGWPiIR3+E25Mi20PkyKZKBs
         qLmwGEM2zFZnA4w5lrzB6pcvJey5c4ynGj0mGLO1dZKsYbDCVBdNfVyeqyIJKKnL2vCr
         JR7GBc3JMpWyzHXrErxrfRDjtWmOmVYSYfy8V0aBGCdnk6F2qYa3nX29ctxbdQ7tS7Hf
         K9iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX2K+NypYspuaN/wSXMrfn13I55lzB3a80+LOl06RhJI5kicaRJm7kbNmRAYqOYxSVQkcU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4Cm0YmOlorwQ21Zj23xhqZC16xE8LbOP52MSlnMRRWKn9GD95
	x6L+l9DAY6XCjCjajPzZnaEysuYyIxoX0Xutg8B2Ft3kpwQNmP3BJdz3krg6npTFCa+wQwSK48p
	I8nVCZ7N9bLRTJhEx3uR1WdXXkHJeXv1kQgD58iw=
X-Gm-Gg: ASbGnctAqDKQjebRw8gNKkc8iz9DELvXQI+NcweyzKpiPtV3Ae1AS8uIhgznLGMPvNP
	oZtDFC7+QPcSZ/JcTTnNg+mWKPo7wBsEFQ0p+RXIJBq+19DJOOcxe+aKmKIVQMl5Cu0zb6gVkct
	Ec28sc+bYYhs9Au7ryEpadtYTtQdnN5lznQNvDg50rZNUdUw5x+Fo3UGIuQsUwyYOYjQtVjLsqX
	Rr8G6REliB2q1/edd6tGV0pjIYlrXEIsOsgTg80pA7QWA+HSpbpBBeJEUl26g97dzx9Sh2J7J8t
	7WL4pdvBJY0u
X-Google-Smtp-Source: AGHT+IHzf9YmWzWQ6fasrZn5RzragRDtHFuHUGNQ9Wxf2zMqXnTugzCJxp4UZZRpW8ty42pgFVjiVySSbmyxz+LCgW0=
X-Received: by 2002:a05:6402:34c3:b0:643:d1b:41d9 with SMTP id
 4fb4d7f45d1cf-6430d1b4603mr941182a12.17.1762868202781; Tue, 11 Nov 2025
 05:36:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1997.git.1762683774166.gitgitgadget@gmail.com>
 <pull.1997.v2.git.1762793782815.gitgitgadget@gmail.com> <xmqqo6p9zo8f.fsf@gitster.g>
In-Reply-To: <xmqqo6p9zo8f.fsf@gitster.g>
From: ZheNing Hu <adlternative@gmail.com>
Date: Tue, 11 Nov 2025 21:36:31 +0800
X-Gm-Features: AWmQ_bnp9id8_pKMBhzAjM9Q9xHRIKIaAerHmZhYg49jZ1K9z1gpJpI7W08RdcA
Message-ID: <CAOLTT8SDpVfk8XqOJDL1=ASJwLf8EYtCo05NS3M2zZUx9JV6fA@mail.gmail.com>
Subject: Re: [PATCH v2] commit: add --committer option
To: Junio C Hamano <gitster@pobox.com>
Cc: ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>, 
	Patrick Steinhardt <ps@pks.im>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2025=E5=B9=B411=E6=9C=8811=E6=
=97=A5=E5=91=A8=E4=BA=8C 03:22=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> > Co-authored-by: Aone-Agent <aone-agent@alibaba-inc.com>
>
> What is this second author and how would its presence in the author
> list interact with your DCO obligation?
>
> How did you make sure that whatever is in this patch were not copied
> by the "agent" from somewhere that we cannot copy the code from
> before deciding to send this patch?  The "cannot copy from" may come
> in different shapes, from "their code is proprietary" to "their
> licensing terms are not compatible with GPLv2" to "they welcome us
> borrowing but we must give credit to them", any of which we should
> be careful to avoid.
>
>

This was automatically added by some code assistance tools.
I indeed forgot to consider its impact on the open source license.
I'll remove it right away.
