Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E0944F
	for <git@vger.kernel.org>; Mon,  5 Jan 2026 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607335; cv=none; b=ZrPDcU61W4Qd3G27cUaEdU+e93mUNql6sQ6akRsRIg9E+PQZGawb1pt1RPmbRZGKublPm3SqKx9gTkve0pschEdva7a3X/zp/ZKdHLLGsEtJamO1s93HswUxmrcxF7XIlYFCRm54Ly4hDh0qZsNfxAWOKlJGYa9l7t/SGOOb/bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607335; c=relaxed/simple;
	bh=4ke6XvG2NclqBUyH3jocc0sWCoQ8MRll2e3cNs5+vH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FIpzR1nIuKePzdgYJ8wFM7U5s/JA5VbqsIieddUydR+jLOLBl/jTE4jqg3YxVPdqREC/uruZyq3WMuFCbga1hIm1vR5HZcfCDlW5FFS8AaqbhQoW6+J++wYx/D/xpwWky/qXdmCYckQ+L97wkhWrlP2XtzTtSB5x1xu2/m4Mz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNk6EWcH; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNk6EWcH"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b7ffbf4284dso1876530466b.3
        for <git@vger.kernel.org>; Mon, 05 Jan 2026 02:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767607331; x=1768212131; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ke6XvG2NclqBUyH3jocc0sWCoQ8MRll2e3cNs5+vH0=;
        b=YNk6EWcH8ynW4IuQOkAXjy733L5bMdnJJig2XvEZpiWflrCnte+B/tJtHauhi9RiIT
         A6+Y5SXLlK9/y1EgVBI2+f8R/Z1VEs6KSXWy9no2x6upMlYXDPa4m2q4tPOGOmkyiX/2
         yz/vVW8Syyx8R1aj7bXShEI13OrRvbXguJoUZscmRjwjrSDXzYhVh/gV5FkkG4kBHNVU
         aUNUTPSQ7LbRzpuEs108gENpcCLtjrwJSOO7GI8pFg7TV8mzQRGy+FVleGXgEi43ZfO9
         Y5jFBeFvYQzf0MGrI5wWGMWlGqieJW8RZ5yQMX2qxO4sWSnIvXzMmQXI3/Y9xvwW3QHN
         7GEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767607331; x=1768212131;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4ke6XvG2NclqBUyH3jocc0sWCoQ8MRll2e3cNs5+vH0=;
        b=EEvezbqCqIJtp2Vq54DDVmFi05TXE5utd6qKJL8UQ8riir3QtTmFlJw2xlHmcjSUfS
         IEWgRFO0hAIeH4+On/Ox+BiSS0VU3fJDwFPOxzKsaFjONxWbg6IFZ593mgz9zkxreDy6
         itZeyp01y5dkwuThg3/4mQsFEgiKdnQOwYbGIGi7guf3OMO5VSxHondwkvjCigKf5h2Q
         vPXvVOdOTlE5tLIqk2EIfSpzbFNP9tYUNglhLQ3Mr/+Pe2FswT9oZugoprtEOSYdfYhy
         rPwYXmjoOmrujpUxlPBRZ4Jh8X/EalG5LpbPefawlYmPmhUCn4Hk/tfiHun2oqamakx7
         XznA==
X-Gm-Message-State: AOJu0Yyfp9n9FRn79jEcXE+DyvMO7rzDdY4pzzCWIK8dxMt3zHNZMVPk
	+C63JeXn3fj453rhI73lHw5sSqshIUUf5SVoYVUKACvKlyOtAfrUT6OAiIvmUAHkcxUh+D1SWxv
	IUuUY2OmC4d5IlJKuz1WeJqOxe8AP6acNejCt
X-Gm-Gg: AY/fxX6QO7w6HXbutBW7lGiqxszpU+wafZnuu6TOAJphRuOD2mVpBRW2Ut5bExKk+eO
	vdw3+lL4nv4MaOxg8BCHNToNdsj0l8zgUGJlQ5H+1QlQFtA+hFo+HTvc0JzMbhQt85gSTfu0p07
	Tn50TDj+T31MaQvVhvY+4yjG7wn4kKjnk8S9uleq2flk9Xhs3qrrv81eoe7xAViIo4uNPiKBZyF
	Xs4HIQnnxdiGryYnYbsSdaDqg7+xUgD9nXVakere3E485q0un/i8p4zgbS/tjC3m2raetoGkpMB
	hhtli4bPU6EkYkGatDDxji59jG3bJNZgHaxBitrYmmQPlLkG/KZpPRl8
X-Google-Smtp-Source: AGHT+IE+ufebZld/hEbkmu/Bky9dMgXTuVDDWpZO+uQZDvW7J9DG5G6sAxXi+2jIqm96pSzViQhLSJpM1Cmz+2vwOpo=
X-Received: by 2002:a17:907:7ea2:b0:b80:2e49:692c with SMTP id
 a640c23a62f3a-b8036f112d1mr4517103166b.9.1767607330680; Mon, 05 Jan 2026
 02:02:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALE2CrQDyN6XcFgkMREmyvywqpuO1_+gt1oehJ8qX3i6b9q1hw@mail.gmail.com>
In-Reply-To: <CALE2CrQDyN6XcFgkMREmyvywqpuO1_+gt1oehJ8qX3i6b9q1hw@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 5 Jan 2026 11:01:56 +0100
X-Gm-Features: AQt7F2oM-9WekWGXzAw2H-WiJEIk4N6X_0NArdu3m84fn1LZue7A7nePM-4SDl0
Message-ID: <CAP8UFD06o=o4WXAODenFFZJ7N374PXZ=UzkSb3X16riBaDT-bw@mail.gmail.com>
Subject: Re: [GSoC] Introduction
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pushkar,

On Thu, Jan 1, 2026 at 9:08=E2=80=AFAM Pushkar Singh
<pushkarkumarsingh1970@gmail.com> wrote:
>
> Hello everyone,
>
> I=E2=80=99m Pushkar Singh from India, and I=E2=80=99m interested in contr=
ibuting to
> Git as part of GSoC.
>
> So far, I=E2=80=99ve built Git from source, run the test suite, and start=
ed
> exploring =E2=80=9CHacking Git=E2=80=9D along with the contribution docum=
entation.
> I=E2=80=99ve also been following discussions on this mailing list to
> understand the workflow and review culture.

Great! Thanks for your interest in Git and welcome to the community!

> Right now, I=E2=80=99m focusing on the test suite and documentation areas=
 to
> get comfortable, and I plan to start making small, meaningful
> contributions as I learn more about the codebase.
>
> I look forward to learning from you all and contributing to Git.

We are looking forward to your contributions.

Best,
Christian.
