Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD1D0145A11
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 22:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736202464; cv=none; b=SS+Bf8LRpcD1uXj8IvcD5VEFwfqzWgPZasDlmGnNNxEd+kX0+WcNq7jLtoObUMu/UYX8DByJZIxvitMsIAkXatvxwzkHokGqO5rBJhgVRohdRnVjuhTLDQGVf0mK5hti/dH+O8hrl0+IzN37nsugkeFTQvNCrqEfr6JR/y97xEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736202464; c=relaxed/simple;
	bh=sNSMF2BkVPm9lyZkGYk145p9mKXkiQpiogF7OHXjD9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=ZHV6UUlvPUwMnIwA9EvREL5r94K+jdJprEX9JcRbz/RjBLVu2xDqHBmhGhL85gppkTUCElo3lyC4IDT6MW04gE4xWR+FThUeLZgFvZrKJRY6PgrlYj0G+GFz5cmU92VVzVpUf0kU76+Ys1+OoN8WSh6bZjOnKToq8M9jHNhVOrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6d8eacc4194so15120156d6.2
        for <git@vger.kernel.org>; Mon, 06 Jan 2025 14:27:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736202459; x=1736807259;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sNSMF2BkVPm9lyZkGYk145p9mKXkiQpiogF7OHXjD9Q=;
        b=RG7EsgG8H4ModOvaGC/jGM6Bj7HQJYdURrfmQ7t2d3TNdsNt5TAiCYtW6YcETVNjn6
         vnk6aZ/2kE51P4wKG2Z636CXNRdJI3oYTs5ca54yhMzHWDroHusrdm9K27+cCw+J3Db9
         R/9048go+6rnsB1k29g0wU2uQz+RPy8X/xfcZckMtKz0tgWizF5M5UpRTeO9GC1XzVoy
         vxpsvByoXc0OKgwTemZs3yQIkWGmIKBmeYRXwdPrUO1kwFc2QTewkjDvJODlCtSlGZVp
         CbsIXLo9nH1n/AhH4hw1wWAn5wyLSMao29hznqYHlZpwOmngW53UMPZ4xMd/1bu4K8+1
         hx/Q==
X-Gm-Message-State: AOJu0YxPggRVO3s8U5D+lnMGQFcafTR1gZmFy+sWtEZfqU/+hxciIjnp
	n4gWJboWVTphgfpasSDOS4RMMvii1rdEDA0p8agjEACRtd3UywERrPzUmY7BUDW2xf7noltWkJ3
	HWrEwlPVfqzYdjO38h3UHIpmiVmuaGryq
X-Gm-Gg: ASbGnctWY6YQYRQnavkT4dYwG9+mDOS8MOm1bqNrligAiHM+vhMlMOW7Jrd0yUO4+Mm
	1J5JiGJOEwOkpcgvpR1PQvDqhkYTFM6oAJ8zUftZ/t4lwW7ZkgSC4zEKJy+FaM88+ogNNW5c=
X-Received: by 2002:a05:6214:3008:b0:6d8:a5b7:6581 with SMTP id
 6a1803df08f44-6dd2331b533mt340453676d6.3.1736202459411; Mon, 06 Jan 2025
 14:27:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106190855.3098-1-soekkle@freenet.de> <20250106190855.3098-5-soekkle@freenet.de>
In-Reply-To: <20250106190855.3098-5-soekkle@freenet.de>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 6 Jan 2025 17:27:28 -0500
Message-ID: <CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com>
Subject: Re: [PATCHv2 4/4] commit.c: Fix type missmatch warings from msvc
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	ps@pks.im, =?UTF-8?Q?S=C3=B6ren_Krecker?= <soekkle@freenet.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 2:15=E2=80=AFPM S=C3=B6ren Krecker <soekkle@freenet.=
de> wrote:
> Fix compiler warings from msvc in date.c for value truncation from 64
> bit to 32 bit integers.

s/warings/warnings/
s/date.c/commit.c/

> Also switch from int to size_t for all variables with result of strlen()
> which cannot become negative.
>
> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
