Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92598BF8
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 22:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737669662; cv=none; b=anbH4CazBOyOA5gqclWXHVk9xMfWHJuwKWRklwPjEINhEO1/14MiujvV1lqwnW8pC2/EvSbpUXo2h5sl4YFVOdZ0iQSxSdYfLFW7APQv2pRMcwk3HYJLFEggWHpLsxOl/tZPG2xFT44vmmDMGw3Pjxv1gXK6vHyqaN7tH0QBJbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737669662; c=relaxed/simple;
	bh=kUX8mp8Zfva0plRYJpyNdhTLgwfUJScqK3xEa+skhIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GT24oUBojjI+gg4yxUxbcyuqB2l6taicvdW34zBC0I9T02qipCvD9rdKR/AYpRa17cg6LJZoKBJXFDC2tIOlUjlTvOJSAnIqfzaSHDMkNG1TjE78A7R/uzFWPFJXd+SAqUFsXpY/r5ly7TTGleZo8OKGFdao2P9I7MUo4T0j12Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7b6e9dd985dso11533085a.2
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 14:00:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737669659; x=1738274459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUX8mp8Zfva0plRYJpyNdhTLgwfUJScqK3xEa+skhIM=;
        b=duO/J0wDBGwdJ6CLWdHs6hy4/wR54pHe7ub5uTTySI5f1rmHXq46L2VRSNK0hWggOC
         CWcPqNGk1Gqa68qrpvm5h7ahZ3PiSMhRe6Qjiz3W7BCAdCWfnF5o/BzR8HPk4/zmGjZi
         kbSifZtHXVlj+BqfJnkv02YaTbUoij1XwEa9JbYKvxsschLSHEVb0xe4B1buo7zYlfsC
         VtGyLnuZmOPtRVUgsW1sJMN+ZNlQPTVkxhA9ejAqI6eb1UHtWOolPo2Dmwl2nUAi7B+t
         zMHZimpzvTclWlmtMlk06MUcAGhJR4SyYlZhHn86cLNZ9IPRKO7nI9f62Twk7XmaJCaa
         EQaA==
X-Forwarded-Encrypted: i=1; AJvYcCU3G/Mib+onUxb7//e63p126KTruobaq4JtGcO9+TCp9mQsti90c6imOuFca3IGkI73AqY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwihPQzrVuvHpsTPFU7pOWWc2EqcERPlZU/p+hwhdum4Dpdu6+L
	cESahMIzO+XjmrLZ2IROwjf9UdOqc5BbGN5Y8hS/1rYt0oFmLYu93VFs+dKGw7RlBFRZWiGHHPa
	YvVU9eKFgp9ujONCyB/6Wsjyyp8s=
X-Gm-Gg: ASbGncs67SJL7Hw65iqirADpoRiB/wjjM0pErgr35+fijkdE73e72gzqx/WAbrCWO2L
	Zz7siFpxq9v2jy9ZiqBlqQDVwYFRFH7ELEI3UckBTPQ0XARsoF70MSfF3JDp7x41+IY2VdDrbwG
	4EQEenRd4sYtCQauYkI2HJB59d3CSpMA==
X-Google-Smtp-Source: AGHT+IEcnpZwLrGaNVUfIgj6RikQImhfldWaLQYm3nz4twUWEk6kS5xyNQ6cE4aXA36l3XHifvXwCyIankBzfd14kMU=
X-Received: by 2002:a05:6214:21ae:b0:6d8:a723:6990 with SMTP id
 6a1803df08f44-6e1ee704634mr47272796d6.7.1737669657936; Thu, 23 Jan 2025
 14:00:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111202628.0e5894e4@leda.eworm.net> <20250112165125.130400-1-bence@ferdinandy.com>
 <xmqqr04tqm86.fsf@gitster.g> <D79S38LX7NLS.34MN1BWV0HVJ0@ferdinandy.com>
In-Reply-To: <D79S38LX7NLS.34MN1BWV0HVJ0@ferdinandy.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 Jan 2025 17:00:47 -0500
X-Gm-Features: AWEUYZnQiaPF2YGi8mVl8J8WuSa_Y2YUjoqd4ngadQJ637-6kikzxXICWw0Nw-s
Message-ID: <CAPig+cTmtuL1NtFjJLDb-bXDk=h5s88v12ezywr3q35+Zcrqnw@mail.gmail.com>
Subject: Re: [PATCH] fetch set_head: fix non-mirror remotes in bare repositories
To: Bence Ferdinandy <bence@ferdinandy.com>
Cc: Junio C Hamano <gitster@pobox.com>, Christian Hesse <mail@eworm.de>, Christian Hesse <list@eworm.de>, 
	git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 23, 2025 at 4:48=E2=80=AFPM Bence Ferdinandy <bence@ferdinandy.=
com> wrote:
> On Thu Jan 23, 2025 at 22:00, Junio C Hamano <gitster@pobox.com> wrote:
> > Bence Ferdinandy <bence@ferdinandy.com> writes:
> >> Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
> >> Reported-by: Christian Hesse <list@eworm.de>
> >
> > These should be chronological; somebody reports an issue, the patch
> > gets written, and finally it is sent out with a Sign-off to certify
> > that the patch is not a stolen property.
>
> Makes sense, I'll send a v2 in that case.

It's a good idea to check whether Junio has himself fixed this sort of
thing when queuing your patch. (In this case, it appears that he has.)
