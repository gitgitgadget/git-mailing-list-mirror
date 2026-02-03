Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D40830FC1F
	for <git@vger.kernel.org>; Tue,  3 Feb 2026 10:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770114791; cv=pass; b=FSFIcsgjBawSLk2mdArzqjdF1rzHYIg6rpSM4hxPO18hozPsRLPoz8BnDT6e+5JPZgqdbpKYI5md9uRlYZizQ9DlJDnGI/8LhEEhr7QI9XCPnTnuhopzS8ADQAadviBcYRQipKg2/muhLMvge8RUUufhcrov0qlZhk+/Y4X9Ot4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770114791; c=relaxed/simple;
	bh=3RCjLD7tYsDRQHhkohxZPqpuOxURgUSlKmgBtWFl7p4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRWYqgJMk595X8HwjOLu06K7P6N2b1BX1MOl3mB4V+gW6YEhpYeGzhGi612rTyvyuSB7xZo0vNOcUEgv8QrzPJt0N/u3FhSAi1Vm0Cwn9xYYACvPOF0Tk5fQd3HehAlneLFDRyvQNrKj1XqwOPHMM7DkOfqTjXC70WwPy7LgliA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E5KxZk2A; arc=pass smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E5KxZk2A"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12460a7caa2so8267170c88.1
        for <git@vger.kernel.org>; Tue, 03 Feb 2026 02:33:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770114789; cv=none;
        d=google.com; s=arc-20240605;
        b=ITVOvYCH1du7ixHLPshmXj1HKNhBYxUz786y5CoZsfOkIcdiqT3cRNeP4LVAV3VbW5
         G8tuYm0wYxuaFfuiv8Fo6Iwiqw9shKMgqKzjXE86r0GanEt7b/dZXaYIl61Ik/VQcUX3
         NQJTgC3JE2/d4CZ/PdOxNJZfZvwyVbGcmOaRXSj7VZ1ib/orcOC466Wel92P46B7McTr
         BlXmj7to0zYi+UyozhHT8OGxNpv5zF1amL6NpSetWWYRR7J4ign7aFEoQVEjmyePZ6On
         oAaniuzVgNBiALKtQkdAO75lEyknIwMLIk+48TAFY2zsiAoy8li/g6pdZN3cLkQkPFxu
         kpSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3RCjLD7tYsDRQHhkohxZPqpuOxURgUSlKmgBtWFl7p4=;
        fh=CMSbN3Ma0Ng/9zgOxaUlTX8hgMiXi2Q+UFWzZao/xPs=;
        b=eyWhl6az4F5BnEOex8zJ5QIBK1NGWkCofudu21AqPSPA+ehvofVa1O/LQKTf/9NaNY
         jQvh+ZI3omjLgCpkp4z+t5qiiR2kj6PJO0uYcIzPx9H41PCXCu7U4Nojfr/bN/3aO9k/
         ZykthhZoWiC44x4jv7cLjW+LO0E4bYs9twU178/d5E81vk0XMHKiE8CU2Un683BgRzCX
         uFec7cpZBPJR9zXLyL9fO8AuJ5r+52WyhH0IEaesdCk5Og0+Dhfe+V2si3MC50ezz9cN
         KNMDMIPIPidQqJ8xogWPkOqJNd3aI13rIMMQ8W6Ne1BdYJLZQ3iECoomtccrW0bRWX2l
         zbZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770114789; x=1770719589; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RCjLD7tYsDRQHhkohxZPqpuOxURgUSlKmgBtWFl7p4=;
        b=E5KxZk2AEpgu/rq0Rt4R8RG24k+c/LWOq/oqmSRddefAbQLJB8sP3z7wZsvsXcU1rf
         ahUXlVjqSQWtbVBhu0r5c4+tAndPBNfzXpJ8cHcOPOBVoTBdKsfT5NMXa7dFZdldHWUB
         EYYYhITfsZvkDAH8sT01FMfCDI8DOfDdK/hmiuEgqKqIlavvBML9WD1RDi0s/N87FFok
         ZeMaaufdcMujhF9Hb4a6wEgZrWqkMaMXN7k9mVyq5Rep3Yol9OW3yaWlA2O34x0Z9up7
         egSekrVUYsXZ4WFBVD9JdYEWg0TegSF/pA9/iwwmgRIDWE7iRrAsCJQClIVAFfOoIOXf
         WFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770114789; x=1770719589;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3RCjLD7tYsDRQHhkohxZPqpuOxURgUSlKmgBtWFl7p4=;
        b=UV+IQXQiTdWxqijmMYVUDFYL8ZvQVyAr277gfEXtdnhNzQCE9sJEw/7q5mu8pRuMju
         pFSvguvDvjCbMPauPyKnhO/MJO/18ZIe9JXC+4FYzZtCQTL2udD30sJF6yRMdE9Ze3O/
         zEW8ma2Qr74IynudxTuBk19wIT6Dd13VyG7IfXOjN+vi/CI1DgIrPmtGVVwe4QLVg+8W
         p1xdC6hGWettYilZm3iQqGhf3bmhFW12qZ1hInxEWSnObjJg1trh32muV8ANBXGd0S3+
         GHzUQTKs2NLdObAz3vrs8x+/VNJSfZE4OfTrGfSLzOtn0/3xBEZlJmgEG944Dtqn4qth
         dxyg==
X-Forwarded-Encrypted: i=1; AJvYcCXYaAvgYp7u8h5fBZWBIedgShW7byhPc3Ez/LHXEwxzs3SXFDn/+1RPfvVG5YdmkHcyw3o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuZjP9IKWrajq2ZDpi1mCjp+++5U0zUXya1GRH4GXyV7lRgOIt
	mnzKYXUdO0VtfiNBfvYPsIEAS1EQ754+hANbMDg9nQzaxkBdrZxNY4sBlrdFkfT0w6AsGc3neho
	uJgNu1e6vIqvHDdVfSpZttTPJQ/D1RBc=
X-Gm-Gg: AZuq6aJfQp1altnKU6/fjXP7Hqj6715VExOPrt71xlSOYTDNjuGFMrdYrS4IQ8/eWbC
	ZKqY0M/rcfShyLMj4r2ON5Ezx5k1ILAdm6n6IPvN8uo5tkSgZvXbF/WkjeizQ6SOHmPVyYJ0BYi
	a7q/zKErKcs79PIDNgWgZZL1IaPPCSjjZfhCbHpzzQd/F6V4L5SEOcWxyVnmmdQ4+kgoZ9/dX1n
	0f3b8kqGNsHv3V7M5/mxnyHLM8vnCRs//jdOOyupb9OnGfO4KU15s9DjUHlEtQbeT3xVdZUy65/
	34y038eIJuGjkpxwrh6xrEZfZHZbbajjhgOzITKErZVCkKJkdWw2LlmU
X-Received: by 2002:a05:7022:2525:b0:11d:c04a:dc5b with SMTP id
 a92af1059eb24-125c1000fbbmr6869841c88.30.1770114789343; Tue, 03 Feb 2026
 02:33:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP8UFD11txMWSfMTvDtcBJuuZA5mKffo6XUyR9LWk2d_N0RRtA@mail.gmail.com>
 <35E56A79-FD65-4CBF-9A35-BCFB9A169BFA@gmail.com> <CA+J6zkSo1LuFUdTU8m6z4vANrJ2r88EV6RDDC_0ZW3bWec2v2Q@mail.gmail.com>
In-Reply-To: <CA+J6zkSo1LuFUdTU8m6z4vANrJ2r88EV6RDDC_0ZW3bWec2v2Q@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 3 Feb 2026 11:32:57 +0100
X-Gm-Features: AZwV_Qjqf3SN_XW7P1b0nSNcPbFot-XcUG22N-PAQSPClBbO48fw4Mx0eRvI_bs
Message-ID: <CAP8UFD15Fkx0t4DYcWjK+WgeZBOzfYNyOePQXGU46Fyf4+pFgA@mail.gmail.com>
Subject: Re: Git project and GSoC 2026
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, git <git@vger.kernel.org>, 
	karthik nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Siddharth Asthana <siddharthasthana31@gmail.com>, 
	Justin Tobler <jltobler@gmail.com>, Ayush Chandekar <ayu.chandekar@gmail.com>, 
	Meet Soni <meetsoni3017@gmail.com>, Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, 
	Bello Olamide <belkid98@gmail.com>, Usman Akinyemi <usmanakinyemi202@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Chandra,

On Thu, Jan 22, 2026 at 3:43=E2=80=AFPM Chandra Pratap
<chandrapratap3519@gmail.com> wrote:
> On Thu, 22 Jan 2026, 10:38 Kaartic Sivaraam, <kaartic.sivaraam@gmail.com>=
 wrote:

> > I would be glad to help as an org-Admin this year too. I could act as a=
 fallback mentor in case any mentor / co-mentor becomes unavailable during =
a particular period of the program.
> >
> > I also Cc-ed Chandra Pratap as they expressed interest to be a co-mento=
r before.
>
> I'd be glad to help as a co-mentor. I think I'd be able to best help
> with project ideas related to reftable or testing, seeing how I worked
> on reftable tests in my GSoC project, but please let me know if I can
> help with anything else as well!

Thanks for volunteering!

We don't have project ideas related to reftable or testing in our idea
list, but we could add some. If you have preferences among the
projects listed there, let us know though.
