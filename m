Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B795114F9F3
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202416; cv=none; b=SKsRMu2w9HchDvwxTjADI93kEUSUFvs3W/xTrgrxYJtZaJHSRhXIW8HFlPY/Gz44kZkOdCKN0VPoOSdSdHT/2c/3cgwkFjstDhTgJ5i2cayOitYM4RmdgWbelGUmvrK7VG+nuHcPhV7o2jyHxuepQUfx1wyNBTyKfzIT3Hd6zu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202416; c=relaxed/simple;
	bh=To2gjqQXCiW3rNLtysKLuldH5r9iDvBl17EBlYfmbi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=ZielwRkfI4PnqpAWhheClKH5HYXd8CjyZwW7K6dUUE8Og6DIRLQqQhC5uaGgyRd0/oEVHphCXN6k3r587eCiTrVJfvCLqrfg++4Mqc4Eie103pi1phWo5RpMwg1es8hbEeQoDvUiuOCE/pICozMo3ejBspjybVNuPXHDyRVpcTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6dd481f6d3aso19735386d6.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 14:26:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202413; x=1736807213;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=To2gjqQXCiW3rNLtysKLuldH5r9iDvBl17EBlYfmbi8=;
        b=fEQscQjynkF5WNvq4OyZU99r5YC7I1NrzvkUx628ywOgvE3vZSReAY4ezkZOKriFae
         wBcUPBdtTL9anlOFmUhPzqJojLakNYIUj4IcBg0f60hYSmQZklulcfvMWUK40GEYd2C3
         Qk4pmQIWb7PiKb7NjMAxgQMqKStOEJ7Y9r8yRuqmNTXJ6mBmo7eHXTt9j0ig7xLW8BbE
         +NG1w4sgwVQXsEga7T5MqzgpNKxYZkfka9+ed9ICDjEYxpipQROvdK+WdrqY4op6n4ok
         X/vON4k6KPMbYW2g465fiQwWtkzpxtKa05aSr7mUiXb6Xo3qNhzRBtZmQgiVTOyFANU2
         vTWw==
X-Gm-Message-State: AOJu0Yy6b4Y2uyU1PUrpj8Iv2SJUKCEfb98uIIco6O1/GeGb06AADHhI
	EGmQPU4otOx+sJe5LgshnlRU1VsvJsBrsAqlQpBqejGCuQdNxRq0rrNNxWd+Mg7iLQe23gXwBQh
	Pj8hRP5ZOhc03xlg27mZ52OSuZ2Lejg==
X-Gm-Gg: ASbGncvetbOwFUGtxEpokXc6izu7QKqYb+pT/RNyZHOYznB1yMxfokMsI/pWQ7tgYtI
	iTZScgQ0UozIAu97KEIlqNUHyPKOxZvyXtsb6Abbzc/DA7x0+JQ70WQ9IImgnQLnb2J1nO/Y=
X-Received: by 2002:a05:6214:3213:b0:6d8:8d30:d4b0 with SMTP id
 6a1803df08f44-6dd230ce2fdmt373716876d6.0.1736202413479; Mon, 06 Jan 2025
 14:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106190855.3098-1-soekkle@freenet.de> <20250106190855.3098-4-soekkle@freenet.de>
In-Reply-To: <20250106190855.3098-4-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 6 Jan 2025 17:26:42 -0500
Message-ID: <CAPig+cQ0cmK_ttjt8tKWEzYpF1-gJMzFS_N0imXH+7rVezk-XQ@mail.gmail.com>
Subject: Re: [PATCHv2 3/4] apply.c : Fix type missmatch warings from msvc
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	ps@pks.im, =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 2:15=E2=80=AFPM S=C3=B6ren Krecker <soekkle@freenet.=
de> wrote:
> Fix compiler warings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.

s/warings/warnings/
s/date.c/apply.c/

> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.
>
> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
