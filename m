Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEBA483BD4
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634881; cv=pass; b=I55nzVHG3IyyJarjLUwTDzmlSw25RO0yGPwuA8eZL9/g2uj7ORYxQQdioIVAySco1Iy7XfVHixr4HafTtL77b6swDr7f5Pi9rsFuREUz6XWyQoLGdrWAQGhuuQ3mQ4t4k3fIBhmiBVjQm7jWW5A9MvvnHLZTinnbfR2fa/qXKKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634881; c=relaxed/simple;
	bh=sT5V+jQpbsNZm2L2euEv3DVtIwKQdtUdSB233fW3MqM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhZaf9FQhTduVOI8a8xW+uWEDeNTjLgg2uYeHxVloK9cjFXapPDBcRtDvHS/n7/c3PNjVuaaBvzUX5y1PUii1K8uyehMrqKluoHGsT/vz6QfhGJOyIco5ZfJwkAMYY7ruSyg152qhzL2otLB//0d2ApMAO3AVm4IjCW6NpB/Vow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtW4XLqh; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtW4XLqh"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cbb8b54fcf8so2090547a12.0
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 08:28:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786634880; cv=none;
        d=google.com; s=arc-20260327;
        b=WYEYTjUCzX0pafppUnuiLXeGjGjYp+/iLRBDd4RiMsqcT3HOpNisXkgSLmfCsGWh6k
         UbCNUGM3nNziZF3ha893EC4PDaLdD9Jr97jDAOVC5TA7V6HA4VXdtVZnONmY4ufGwOFI
         y/ZTvQx/Udcb8wgxrQ3QFrFzGjhQRiqZXIv31vEcD6J/q4S4BRS12WtpfyDe7gTOdncb
         0PaeRII+GEV6QJvhmc9t314Q1laMBRB89c82GzoK3j1JxewaKMDWtImpnMh+fgMeNZZ2
         ekK5zHSGwmZ5cMACUC64SyMEZ6uhqB3M+WTYvecOU8Sx3+906OFJBaxfmmUx22wAOwn2
         T0Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sT5V+jQpbsNZm2L2euEv3DVtIwKQdtUdSB233fW3MqM=;
        fh=ndQWtZYC7u/lMhZIYoPd/Q/2j2eAZNTsEvTKVYSFsQs=;
        b=MLrDItCLTxpfsqJyErHSu18bvu9MYByPzFyJwR2vZ46XSMY6m+yeOz+i1O4bDed3Kz
         K9ApBilXjfJTN3kvUb/kP4JxD8ZfTq2mdbZSLUsnxHhx40QnV+qc6SHzbnSSGu/evFUl
         /vCHqF/8Y5CUkbRZJj9gL3i5SeIhXOZdNIuyyiTn+YVJpPmp4D3iD63az4kcl9PsyqSW
         HiRjYbRkhiA59VootphurxeKlRVfxY6Kyt8XziFefWq8AYh0rvmQmJXLUoWkdeC+Z3TX
         XwPwwpLhU906TMY9joXypl2vMapBEN0b3jzp4TKzZrGWXCIhXpqYKqHJcOo3eTJBZchI
         mAeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786634880; x=1787239680; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sT5V+jQpbsNZm2L2euEv3DVtIwKQdtUdSB233fW3MqM=;
        b=GtW4XLqhnfRZnkhhWKgMKuqFCgSBsjFbSkzViVRNZK5rltYc61zsSuXD/DoAQVtJt4
         +MDHTvh0j3vjFVt4Y4ngl6BRKIUw0bE86sGNu1VF4ZWgEdZrdLO/vlYH8qAjgxwBsBxh
         56dsQScgiPGcRfRFUxMOIIg94g2yJV7aMR2jd4DU3LNr5Romm46hqq4iAf/ZJ+pr9XjJ
         ilRe8PL/vkjJl3mIGtWKRvX+dsisgUaHRjnw6hA4dRM7kK1Ga4gqosFNj79QbEcYJ6hd
         83N+yaK2zBQLIQe+No1y3psraK1WHvCG7DIkm4VuX7SwASXAB1kri2f9dXj+HVwRvAmr
         jSeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786634880; x=1787239680;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sT5V+jQpbsNZm2L2euEv3DVtIwKQdtUdSB233fW3MqM=;
        b=B9rJniuXtrxPPMYQhMBEUbC23EwTUglHE9GWUbWfYtNe0hkvOTijABj1pKnZ58BqMP
         CJUySX5t6ZxejZ+WJY4ZuOjVyweUVAqaUKeIiXJc8j2pbmc1gOeFFTaw5s0SnoApz4tD
         Y8b6JMfzxX7ZV0rVHqtTXYi6ZkhrM2m6eqDou701WzPFeNj92HFKMyhrB3B+HbRGKxK3
         WcWzFsKR2l2TWZANphUBZysrJ8F96ux6IV8Ifq3OrSyj5Uvt0cwqm9XD+J98MDlHQdcp
         kTMZ718zRGBB2VYBqLGgaR2EB+grYEpiIOoHF0cUWbTDXF+zBVIii3E5vBWdwWrogVZc
         K3wA==
X-Gm-Message-State: AOJu0YwpXPoPHzPOv8lXyC11ZwZiJ+Opk92iLb1cdGbf0X/mY6/rx46f
	yz0GBooWP/o8OYDzmqzt9hhmZ/srHE/mRd3/I/kyH6VemU/ZMPoz4q2+4F80PIbzZX/MzeGmk1p
	EFRAjelr5q8IQ3/uWEOnDEmGLgJhWC0yk3QNz
X-Gm-Gg: AR+sD11YvvyeMJr/nIL47rsPfx5b9WgcIl+oWKK/S5BNDEvOowNSjUIbIzvtQ6yVMTL
	1UW6SwwOrdaZyosIb/eaaQdA7p33jh2J/xeZ7t+I72aD0w+QAmD8XsTyZaoGPKO9uvOaCRMM8FY
	WlmiEX3oWqYtPxFQjiPGiA0Y58RTXHwzhIoqMk1/SA/7U5qQeTN7NZQ0M3XpFXuIY8tMNq9Ea/a
	RWBKsg6fl2JyUIWRXzz/rOuczML6bt72em6yDK1ZletC/otMG58x6ezuG4h4fUfbGp75MDjCKSo
	QbgdDrHSKsIyJD9rzvI8wl5jhNP1KAx+u/6uflBchonWeage4TNJNTyK3J07caDa8Fxowd191r0
	gB0PDe/RULDH2IaJXp86IntvgLLEZ7xO5BI+GoSI5IEFrNw1w7rDmQFZRCSGaidGMFMY=
X-Received: by 2002:a05:6a20:728c:b0:3c1:fbf:1e2e with SMTP id
 adf61e73a8af0-3cc550e3a2fmr8135063637.10.1786634879519; Thu, 13 Aug 2026
 08:27:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2199.git.1786516783909.gitgitgadget@gmail.com>
In-Reply-To: <pull.2199.git.1786516783909.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Thu, 13 Aug 2026 17:27:47 +0200
X-Gm-Features: AUfX_myN5vVs7YVlD18luXvGH27_bNB1igMbMeR6e_f78h4kjbe2QoO3buAfeHU
Message-ID: <CAP8UFD0+iXC3VxWmuuuB7La-pP6hdz58tr6vaEJSKpXJ_4ZH2w@mail.gmail.com>
Subject: Re: [PATCH] serve: reject valueless promisor-remote capability
To: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 12, 2026 at 8:42=E2=80=AFAM Elijah Newren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Elijah Newren <newren@gmail.com>
>
> d460267613da (Add 'promisor-remote' capability to protocol v2,
> 2025-02-18) added a receive callback which passes the capability value
> directly to mark_promisor_remotes_as_accepted(). However, a client can
> send the capability name without an '=3D' or value, in which case
> get_capability() supplies NULL and strbuf_split_str() dereferences it.

Yeah, the original code you mention used strbuf_split_str(), but since
68a746e9a8 (promisor-remote: use string_list_split() in
mark_remotes_as_accepted(), 2025-09-08), string_list_split() is used
instead. Anyway string_list_split() also crashes when a NULL is passed
as its `const char *string` argument.

> Reject the missing argument before parsing it, and add a test covering
> this case.

Yeah, the fix and its test look right to me. Thanks.
