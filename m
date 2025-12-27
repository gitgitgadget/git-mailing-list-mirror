Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00371C3C18
	for <git@vger.kernel.org>; Sat, 27 Dec 2025 10:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766830484; cv=none; b=MwjOGxzoSY00bmJghB3myQsIeDhNZIaH166fyspKezUX8YqVJ72wrmTCfjAhEQBHpkfWpH3OfOc71KiiB33/hqDzQHwvMLYzUVxIYxrV1fY+nv0ahGqhSHb93EwsupC0Oq9dSDZbxnSCN7CC1CBpsMSyWYbDraRfM1bspehHQyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766830484; c=relaxed/simple;
	bh=5wCeA47nsM7RHwQ1rHyiG3XVzADrvImaBclxS6WlvMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WBFDJCUYrP9KaG7cNgU2cq/tPRyO6YDSfb9UbGMff/uogYCTm7ervMdfjIXmGUnz1My3116F6WwgqobxX1Gub+e3cea5HZVaKG3F6BskRVpuQACxAsgE83NrbVIADPKU0sxZoP6NtA6noIDuCEh5daEwZvnhOiSjnWHkkqQ4Ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iNwUrRf7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNwUrRf7"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b7636c96b9aso1406624766b.2
        for <git@vger.kernel.org>; Sat, 27 Dec 2025 02:14:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766830481; x=1767435281; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5wCeA47nsM7RHwQ1rHyiG3XVzADrvImaBclxS6WlvMk=;
        b=iNwUrRf7eGMFohMB91PCF81HMw3ER6wYjJ5IaFY7+EHrjgjDAsYnlztEpDL+TwRDU7
         sl60nfITvJnglUibrVpBO2C0rA7vxUBgAtJWBWspUyVVd4UvSUZAhwFMHpq784nCWUxB
         74actBRnOeCBkuOQuOkC05kv9adQwqV/FHZLyl1q3w89RCeaZpNt5faopjbxdW1Prr3g
         8giBf8BpNl5ytHhXM/Dt7iuY02I2PwUQB21adou2ttFhRuX2K2VMLqJb4DAFEsnWe9iC
         T8lSfvf+WCuSKQ5ijnflc5rpzwNQPA8z9h7QtLIN/3Nv8rJbwFJOXhxGxz6gUVATvowL
         OWHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766830481; x=1767435281;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5wCeA47nsM7RHwQ1rHyiG3XVzADrvImaBclxS6WlvMk=;
        b=JVEkfCQa50K7GDM2YGXYUiMwJRt5GR1wCOeI1Pv52PlmngGlPpEs/BzsTr2O8NzKXK
         QDsuL/AFrQRWPkYU2w3tZhJUAW3hqe4d8sVFxOTIXN5mpc2cd/7SYnK5YoRF+p4nVTIo
         mz0/pfmszpHOrxBmWOj5N5SknFTE8XB1GI9Oct2OHw2STTj9U/12tRzVbX2MmFuCl23J
         dlJb4UMU3QSdSXTtZq/ZevDZ2Tv+/eSnlFYtU7EvXKSop9q2yYkadEA+2b2T9PN0VfPA
         UOjqTmZDFJpGFmrCfvDmbC2vm5K7or+WJcw0VBDUYcpJ3L0qJrIlYLOC8v//62wVz+aj
         Tk3w==
X-Gm-Message-State: AOJu0Yx9IeGjbCgmtTK8gKnO79WEeqiYihB9Xajz4zmpkAWEjDuaDZ71
	Lod7j5vY7qUOAnJr2/TTMaBq4i59zDaljOWpKFsf1C+VnHukdkircf0lONZ90nRgQKOIBORgZpJ
	eeDk02+IBaojmW/nlmJYKwBuvoMEwECEBKWLo
X-Gm-Gg: AY/fxX7RdZrlVyDV9MWB2+3i01HkYYAi+59qiR2BpVb4JlHRLzJbDHr6PU3i9przudA
	XnRaN+BUgMznWRHEo2B9GvzFEytItxtu8NoiwcYpV8nOQKWzYAsgEAcj0+BXSAwjTIMBJIqGQZU
	ena3Ws68sdYPYfyrXdU4Psu9UFGZ0bxnoqXKkRuaqwzjGOjwXdllcqavbdvYWEVqbpS0bN8KZ/F
	xtnZ7U5chwTbBe/Xke1yHZ2xH0gzLn7Fo8kOWyqKcBYfrQO2Aa42IlQPkWffH0CQwb4XuaBXuQk
	gFSKjUmIBLXhzChxmj8SRLdCel0/25bQG/1t6JIKNnaK+jR5HB5pc/SA
X-Google-Smtp-Source: AGHT+IHufchFzBLrHSydQGbjbvXXCqEK9UYK2Ohj1pocsVfosNNH+oj9GoBilWpg+pXvb7VSx1HO96EQ1k8uKJRfKvM=
X-Received: by 2002:a17:907:1b13:b0:b73:8e7d:4f87 with SMTP id
 a640c23a62f3a-b80371f8f3amr2426251566b.45.1766830480946; Sat, 27 Dec 2025
 02:14:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMQGJGT+BYams0dxXYd33A91hiONCSAoUiomv-2_XqOZidYSwA@mail.gmail.com>
In-Reply-To: <CAMQGJGT+BYams0dxXYd33A91hiONCSAoUiomv-2_XqOZidYSwA@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 27 Dec 2025 11:14:28 +0100
X-Gm-Features: AQt7F2olORnXPtoilicxnydkC25hI5qvXojelH7KZj7Ab2TiRnNXABYixz88Zpw
Message-ID: <CAP8UFD2of-qANoGzqCMLOzuuuSK7c0bnC4P=FjDZrFfFh6qHiQ@mail.gmail.com>
Subject: Re: Introduction and early interest - Ayush Jain
To: Ayush <by.ayushjain@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ayush,

On Thu, Dec 4, 2025 at 9:35=E2=80=AFPM Ayush <by.ayushjain@gmail.com> wrote=
:
>
> Hello Git Community,
>
> My name is Ayush Jain, a final-year CS undergraduate from India.
>
> I am writing to express my interest in contributing to Git for the upcomi=
ng GSoC 2026 cycle.
>
> My background is in systems engineering and distributed infrastructure (A=
WS/Kubernetes/Ray). I have a strong interest in low-level tooling and perfo=
rmance optimization. I am fascinated by Git's internal plumbing and am eage=
r to learn from the community while contributing to the codebase.
>
> I have read the "MyFirstContribution" documentation. I am currently setti=
ng up the build environment and tests, and will look to submit a small clea=
nup patch or documentation fix soon to get familiar with the workflow.

Thanks for your interest in Git and welcome to the community!

You might be interested in the following pages if you haven't read them alr=
eady:

https://git.github.io/Hacking-Git/
https://git.github.io/General-Microproject-Information/ (I think this
is what Lucas called the microprojects page)

Best,
Christian.
