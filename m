Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638E15B971
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 06:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750746156; cv=none; b=bkHAeq/JTtC08IQPA1IBM+y6C6HVNxoSBHoZxKxUq/bGEzVOkaDilhzfcd+Mp2YHN89GtbeccCmy25aJCjidQXdaIFMC4FBUz0YgB3xkgIkyZhXReagO9fqGOrX8x3CxGfbK4BfOjS0qqFZE9xd1GCzlpujbpGUUh3CkRMaZw88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750746156; c=relaxed/simple;
	bh=nU45+UC46kbT81PhM7jUOSWO4Y8f6Og6O7YRNcfZuEE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j1kiVsiPVVhC36o1C1MaiABtxXppN7Pa9GoH1Pn2LS6q5Jg/FR8XeUa6+Yb3kTOnP0oKy0b/RRMoDO4e6KB29X8A3+2/U7fZU7v8NuD93FuZcF9Ff6ourYs9d92dHjkE6214Fm1uAEYp/5wxK/qgulJRFG3RpQ7ZTwNMQiO0/k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d20ff236c5so144183785a.2
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 23:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750746153; x=1751350953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xLWLkCSVz1a3smGmIyNL/lUDfly4LZeZpYdwpfVYkmM=;
        b=KZvaHFWSXFWLtSvzILEjjS514JiIJV6JNo8hUzKASswD86RLzQXPbLCy2cX+yprdUR
         1B7qRQI5/KdPvbmj44OTCt9rh0w8WFR4btJ5kX2IdhA/UpeS0bQt2yMoLbE7xKQTs4nR
         uwmqoKqtLMwZXHXeUCLcLqQiExIE5GUfWaoKdrs662o6pp/sUGNN0/LYCVpcMtqIuJyT
         4vBzEkN2pujhRg1JRYoI9iVLRaL2WL51EAXl7SuvXbXw/JrGk5UCqoTYtM6klVb/fXoh
         0l3Fa3ksvZughtdzYZl+jcTRf81Oa2w1zQCJq6t2k4oaOABCkfFah4cGzc8P7ge+4HXx
         vcxg==
X-Gm-Message-State: AOJu0YzQ2D+QYvn4/tGtVI4Rcn/jE0IUhh6hF0QMAKhCuTwIJ78UJf/H
	Xb4moksNkRittaKoZgNWE+Biwsa/I4zWBetMkrox6qM1Z4WAPalxT7hA+q1oFrFwY77vdUTRdPT
	6r2jNyYl21Oi0Fh/CkXtIZEVt30MiWwd44jNq
X-Gm-Gg: ASbGnctE8W7h21UeEMSicbxkaYqD9R1XiXQk1VgZQhizWCwKlGyBAVqUYKbEXA2D/wx
	tPfc9lo9h8EAz+vGW8xClx7sm9I2SZ7xuXvtTF8brntDSFs6T5CQFHLAQOFIb8+lJOkf49j5/qm
	rdU7hhCiecNmzN6ZiHHeSo7TX/twxDRflwOmuNatuHBuggGU0M/7l1UD4Z0Wqf2cHj5vlir9DKJ
	Osl
X-Google-Smtp-Source: AGHT+IGzZcrRhLTAJgyaxy6hNqPiWTwKyqaLsk7hM4BFHtAdUrmoxiVgW1cSbeW2DOb1jHDAlEztj4gejhhdtmvAIXA=
X-Received: by 2002:a05:6214:4007:b0:6f8:e318:f9dc with SMTP id
 6a1803df08f44-6fd0a44b78fmr88001426d6.2.1750746152704; Mon, 23 Jun 2025
 23:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250623105516.GA654296@coredump.intra.peff.net> <20250623105625.GB654412@coredump.intra.peff.net>
In-Reply-To: <20250623105625.GB654412@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 24 Jun 2025 02:22:21 -0400
X-Gm-Features: Ac12FXz4l4-ZOhz44KC5NkPhYxq2VqxOwylqK_5p4s0wpmQiSvWZSWkrkuG_Lo0
Message-ID: <CAPig+cQNWVd7M5pe0te9os3NRrjfBSSaUZjUXKX8RUdTk50SFw@mail.gmail.com>
Subject: Re: [PATCH 2/2] test-lib: teach test_seq the -f option
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 6:56=E2=80=AFAM Jeff King <peff@peff.net> wrote:
> The "seq" tool has a "-f" option to produce printf-style formatted
> lines. Let's teach our test_seq helper the same trick. This lets us get
> rid of some shell loops in test snippets (which are particularly verbose
> in our test suite because we have to "|| return 1" to keep the &&-chain
> going).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t0612-reftable-jgit-compatibility.sh b/t/t0612-reftable-jg=
it-compatibility.sh
> @@ -112,14 +112,11 @@ test_expect_success 'JGit can read multi-level inde=
x' '
> -               awk "
> -                   BEGIN {
> -                       print \"start\";
> -                       for (i =3D 0; i < 10000; i++)
> -                           printf \"create refs/heads/branch-%d HEAD\n\"=
, i;
> -                       print \"commit\";
> -                   }
> -               " >input &&
> +               {
> +                       echo start &&
> +                       test_seq -f "create refs/heads/branch-%d HEAD" 10=
000 &&
> +                       echo commit
> +               } >input &&

I had suggested[1] an effectively equivalent change to Patrick for a
couple tests in the nearby t0610, but he rejected[2] the idea due to
the pure-shell version being significantly slower than the `awk`
version.

Pondering his response today, I wondered if it would make sense to
replace our pure-shell `test_seq` with an implementation via `awk`,
however, if most of our sequence vend only a small set of numbers,
then the startup cost of `awk` would probably swamp any savings,
especially on Windows where process startup is extremely slow. Taking
that into account, I further wondered if we could see an overall win
by taking a hybrid approach in which we employ the pure-shell version
if vending a small set of numbers, but fall over to an `awk` version
if vending a lot of numbers, especially as in the test above or the
tests in t0610. Anyhow, food for thought, or not, if you're not hungry
for thought food.

[1]: https://lore.kernel.org/git/CAPig+cSC3zdur1fCsa7RMNZDcgUK4pUGKb22tpgdA=
NxR6OxNMA@mail.gmail.com/
[2]: https://lore.kernel.org/git/Z-FUNgmY9hTsnzds@pks.im/
