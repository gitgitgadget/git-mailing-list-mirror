Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4672417CA1F
	for <git@vger.kernel.org>; Mon,  7 Oct 2024 09:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728294336; cv=none; b=kxRTew2CR5m3rMcXdkH3YWyxTNp96YloDVJvWLbmpCbEcMqFYAnf1Po1uxAzNRDM5vvDcfq/4iXwybdIIFuKHiwGZZNCRW5vmHgRu3ir0RbLXW366luriQPTyV6jf+2CVl8w3tjCKVzaG2lu6VAIi1hH1xoJZaA1SmWMhlJCuAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728294336; c=relaxed/simple;
	bh=t3a6OVO0Ms1/TSv/TJ0UeKfKRkxuAhi2RyqNs6dMIKs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aAUp3S7vwZ/E1F0mEPxO9KSCV0gjuNmQhCIVYye4UegeTz5+46PrwbLlCUyyh6qGgy7ZfMmq/A2m/CNuOLr9KzM+fMjbO0E9qO+kzqmG3nJZdDm9qynoCMNjiKuM97TdnhBuHFJC7jJ4MrfLb00gQ3tFGLYfF6re97p3VpP7DXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net; spf=pass smtp.mailfrom=gree.net; dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b=EAyrvs7U; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gree.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gree.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gree-net.20230601.gappssmtp.com header.i=@gree-net.20230601.gappssmtp.com header.b="EAyrvs7U"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-6e2e4d1c992so10536847b3.0
        for <git@vger.kernel.org>; Mon, 07 Oct 2024 02:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gree-net.20230601.gappssmtp.com; s=20230601; t=1728294333; x=1728899133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2gz1L294BvEJz+KgvypI7m0BDtk5OmlW+Qhqei6GoR4=;
        b=EAyrvs7U+LHoHeBKaL/kwsnElYSo4qU71Li6NoZC23CcW3NZdyR1WwBFQb71wDdc0M
         zcfIUTRhESS/cj2Lqb/nUv0dM9QZi1myJf5TsulUCuCQLhu5yEzq5KXwf5ZGCfhMe+g0
         ejM3JKJ7CSbkldeZaQXVdoz0IwFcdLah3pG03i+Dbt/D7i5Advea9bPkDMCct3oql1TP
         +1tOp6Zg2gM7IRYPdMEl0018qH4uWTaC37P3bS4rTqo5W7Ssadu20QtMJPxCluFye6ut
         jUOulqb0gh5DuAEF80Dm5q7MrgebsmtY5IeERaFgt6NAw2bpfztr1JLhYq1ySfH9Ev4T
         g+9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728294333; x=1728899133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2gz1L294BvEJz+KgvypI7m0BDtk5OmlW+Qhqei6GoR4=;
        b=sRVPyTuStPFWk+b+1N+iGWnfKu5J+9V3CnhtlN4fm+6QOrRgCqTpQfDW3R5Gg/azya
         2IFT4O9Gz6VJfmOXO8XDw7NudYPCNIZWr3r11jf4ChOypKJR+WFB8LMlMIwjJi4Yod8i
         dIbny2Atcwpm2lpxlESsrOrPsv41W4OO2Cnbyh2dDbkD66lJEr6xZ2a+Q2ayFUN46qim
         NXJSudNFD5Czr8VtIUt+O4a2cxwKOn2624KE4jA8Hsxwz7xvUTxIYvy39C6HNTfbD1ta
         hxqtE/tD2BVgwt7bEBYukv7RrgKf5c9LzuprrpVSO2StY3NVFS6N5Klm2ci/syauk6fo
         tMzg==
X-Forwarded-Encrypted: i=1; AJvYcCXRuY/NxHRxvN2nW5VmdL6qplgHEAPrPom4YE5A1G6tO46/sBI+G8aJ8YrmNvMQL2tamm8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7exEUrQMxo5g8Jrhkyj+lyPm+kKugENxsLG9R7/9zJ7u2KIN5
	ATf33u8BiT35uE9gTKUFlW6iT8LVw0IRylopmsFXwHl1J92HT7ERus4qH5mbcnjXnbaGQCDqNuu
	0H8N6e9ol4XIwtyVeHe2wjbetZdsnma13uvK7YoJSmNFF08U2bvxZq28ac6T5aLg/rGrzdTvfFG
	T20ZsUYNfoAc7dHvQa++ubCN/1kSZuam8Wg9d6Ui7LKn2e46yP5BfXKDMGn8By4Y+qlTbDRXhG4
	lERcTbGrKqL74Xm0DntCqMI+7r9UZJT6yI7oLZur5U44wx4oO80G6/mTk77NTWtEPvf8w/txlrJ
	fUnbD80CBz4=
X-Google-Smtp-Source: AGHT+IGkGAvKuVNUqPrjUEUnE6XeoAmuZP5w/FB53llxAUCFzWr0XGKwGGl3UaM1FgNUQq8cq7QYjQPYhhHfBs2+AxM=
X-Received: by 2002:a05:690c:f0d:b0:6db:cea9:6ed9 with SMTP id
 00721157ae682-6e2c7beb946mr75391157b3.4.1728294333130; Mon, 07 Oct 2024
 02:45:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1804.git.1727862424713.gitgitgadget@gmail.com>
 <20241007055821.GA34037@coredump.intra.peff.net> <20241007060813.GA34827@coredump.intra.peff.net>
In-Reply-To: <20241007060813.GA34827@coredump.intra.peff.net>
From: Koji Nakamaru <koji.nakamaru@gree.net>
Date: Mon, 7 Oct 2024 18:45:22 +0900
Message-ID: <CAOTNsDwwikiX3u6DG=+4hn+mcgfXzzDoqR3ZFVEdGi=mPGQbpg@mail.gmail.com>
Subject: Re: [PATCH] fsmonitor: fix hangs by delayed fs event listening
To: Jeff King <peff@peff.net>
Cc: Koji Nakamaru via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 07, 2024 at 01:58:21AM -0400, Jeff King wrote:
> First off, thank you for looking into this. I _think_ what you have here
> would work, but I had envisioned something a little different. So let me
> first try to walk through your solution...

Thank you very much for looking through my patch in detail and providing
another approach. I agree that busy-waiting is not smart ;) I utilized
it to minimize code modification and not to worry about any new
deadlock. Your approach is more natural if the code is written from
scratch with the problem in mind.

> @@ -933,7 +949,9 @@ int ipc_server_stop_async(struct ipc_server_data *ser=
ver_data)
>
>       trace2_region_enter("ipc-server", "server-stop-async", NULL);
>
> -     pthread_mutex_lock(&server_data->work_available_mutex);
> +     /* If we haven't started yet, we are already holding lock. */
> +     if (!server_data->started)
> +             pthread_mutex_lock(&server_data->work_available_mutex);
>
>       server_data->shutdown_requested =3D 1;

Is this condition inverted?

On Mon, Oct 7, 2024 at 3:08=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> I just checked your patch in our CI, using the sleep(1) you suggested
> earlier to more predictably lose the race(). It does work reliably (and
> I confirmed with some extra trace statements that it does spin on the
> sleep_millisec() loop).
>
> I had also previously checked my suggested solution. So I do think
> either is a valid solution to the problem.

I also tested your approach on Windows with a few additions to
ipc-win32.c, and it worked correctly.

* define work_available_mutex and started in ipc_server_data.

* call pthread_mutex_lock(&server_data->work_available_mutex) before
creating the server_thread_proc thread.

* define ipc_server_start()

Shall we adopt your approach as it is more natural. Can I ask you to
submit a new patch?

Koji Nakamaru
