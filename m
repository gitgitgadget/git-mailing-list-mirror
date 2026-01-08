Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45382ED873
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767893362; cv=none; b=kSlvAfH99qFFwKRjm1gTZZ84cb4pPQYNMSN/7+djTzKtDOcqTVxKpgtG89U0/atJkUcoJV0s85uX/oEvxsdRVx1A5qJtSn0bdc7QWgjZtVidPVx2TbBILodYOipOYevlOgug1c9mfrF46wjtWPveupPoJ9I9w2j0CkX5mnpJlNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767893362; c=relaxed/simple;
	bh=vwyydWyYrtH8JEF1pqTbwDUdjdDuTzkb0lF58PSlpgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFOVrZMXx/h8piiLHhutp7+tC+luor17/Kxsk0HIR4hXx6YOFWE7slAaKRh3LhJmpJRx2+OpaqyCC/thNI546DU8iK0FGpNjXxiMas2C5c7BFyN9WqyBuTbj+RYT7zYYN4+wLn+OYcEobJ3kYrH35vm8it7pIJzCfDVO+u6cK4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7K/MkAh; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7K/MkAh"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-34f63ad6f51so1174349a91.0
        for <git@vger.kernel.org>; Thu, 08 Jan 2026 09:29:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767893361; x=1768498161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwyydWyYrtH8JEF1pqTbwDUdjdDuTzkb0lF58PSlpgU=;
        b=B7K/MkAhk3cA+Txb1hkoJfKNZl7IhkcyOg6SJJm0eyDcYYWwZAKK3wuV44XCC17mg3
         q8ZCFCRAvXirm36IcBermxPbEFo879cITdeZDCgn2zB2xnRPngqYQ6CdMAf4KCEZPgNJ
         vVp4u5hayzvT910dGi8snfcvVE2BSPPV70aKppMOa3ph3WNOkifuZzbvj+TH7PZcEu6o
         tgcNdbo5GFSENPMMMpcterxqfDaF5ojO97JRlvloG2wgjBAqpnJqMca5LHI60/lvozVw
         qOGqpQDT67nD1XihIoV7auT1W7suPhhvwq5N8LRgLjJhwMIKrS7IL9OKHRGhvMvFaaNv
         hgmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767893361; x=1768498161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vwyydWyYrtH8JEF1pqTbwDUdjdDuTzkb0lF58PSlpgU=;
        b=qKQWdwnHufsZ2zBxI8Z8+xYooSWgZB3AQRla3cWNilqenryV0pgRnvEb9qw4GWRCa+
         xA7NVsImcILsK7aP15Bke4YO/87FIPfyjV45uOR2bLSaKfLOzv5+ERBNnC3405b1SNzX
         Y6pAe4vPeTb2ZeUlHIcbAoRZjBoiI7flsxgZRAD8fdlZS43seYSFOK0WKmTyi8F3M5GA
         nPAj0UXcWJij38vERieaMjzuN7oADutoySmK5J3zNtiddRm/a+3u6FNR/wHrydm3YXZ+
         2VPbhl+fKEEgOKbGfEE/Dv3mY4OVNkSe58+CxgOsaAQFoA6v3MHr02Xnn6lwqIOxQek9
         782g==
X-Gm-Message-State: AOJu0Yw+l+3C3jcYLDt2Yo8uBwIWkI9xftZSLQxZMy/a5cxTI8nuEb69
	r3U8xLbAsaV6L0Es9ux6zzXL8xJ/kpawWBvv6u4qeSMTpYkvspP7m6N+DwNMRKU5dzyoNKvQAq9
	sD3CE0hW3Km1e4YFxe+gy9l5ZAczliaYoYb8E
X-Gm-Gg: AY/fxX7hKNj4kVmDzgK0+lqvvJYyE+CB3hnquFYYHlg29UCd2zlHLVv5edbBgCvnZHx
	VhQeL0qXZmKXK64RwEk44WHiTqJHpa+PhNQmTQa4L6u5oHT1Z9mYiePHRLDiK1QjORcIa8jymyC
	9o3P5y5DRMPg5aO4inXhTYuZKmG+NF5jiNuXaKPM+o/BTE4hp25ykCtJJ4UQkOCf1AidIBqaJrd
	EGlK35nHvQf3Uf4xYnE+eKkKyy2ivbR/nbGlKX7nT8bU8Lmlq1Gcbu8nkNUo5jk1S/yh8GAl6uz
	TyHrPH6D62RlHu1UWzDtAk+8HZP3pg==
X-Google-Smtp-Source: AGHT+IFtbOrgV+a0smERSXlQ6CDJ/V3piAhQgwomEDwk5ilYoc3wWqO/zOKEV4/zlm+HdZ7o0Hh2V3HcsUHa9rrjFg8=
X-Received: by 2002:a17:90b:4a92:b0:341:194:5e7d with SMTP id
 98e67ed59e1d1-34f68c01e51mr6812374a91.24.1767893360962; Thu, 08 Jan 2026
 09:29:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DFJ7PJVEVOYG.377TM7121KCQJ@kernel.org>
In-Reply-To: <DFJ7PJVEVOYG.377TM7121KCQJ@kernel.org>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Thu, 8 Jan 2026 12:29:09 -0500
X-Gm-Features: AQt7F2rkhPAkuNjryntrg4g4F43GyBRCr_9h3I68vLRUcRNQD5bq8lLgoinZj7g
Message-ID: <CALnO6CAGHuu9zBNRD1PV+2ej9pSq=2agP76hA3ZWXxojo7FJug@mail.gmail.com>
Subject: Re: Improved Rust hunk headers
To: Benno Lossin <lossin@kernel.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 8, 2026 at 10:34=E2=80=AFAM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> Hey everyone,
>
> Recently, while looking at a Rust patch [1] for the Linux kernel, I had
> an idea to improve the hunk header for Rust code. The patch's hunk
> header is the function defined above the addition. To me it doesn't
> provide much value in giving context; it has been a while since I last
> looked at that file. It would be much more useful in this case to show
> the context `pub unsafe trait FromBytes {` instead. This is because the
> function that's being added is added to that trait.
>
> In the general case it still is useful to show the function context when
> the contents of a function are changed. Ideally, it would be possible to
> show both the `impl` block and the function signature.
>
> I have no knowledge of the inner workings of git, so this might be a
> tall ask. But would it be possible to implement having multi-line hunk
> headers and have a more advanced selection algorithm? AFAIK at the
> moment a regex is used to extract the header, I think that would still
> be sufficient for this case, if the `impl` block header is searched for
> after the function signature.

I wonder if an empty hunk (that is, two adjacent headers) would break
anything? Just thinking aloud.

--=20
D. Ben Knoble
