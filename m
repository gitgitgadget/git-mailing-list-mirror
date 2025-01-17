Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1F22338
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 03:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737083661; cv=none; b=Z1lrQt6rqOErpXarKxx3wOatVHrPm29KGwfOEn1jGax4f/g1ihEb9o9O6S+PsA/+Va9pJtY9ySv7uA94clJa51QzxfnxK5YrLpSSvfop2HYmPG+dh5Ep2URdEbD/iVK/NCYbIaC9p480x/Ild4ESEcOYdQqDN11h5sKn6oPzdW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737083661; c=relaxed/simple;
	bh=dG1HthcVfN5lN1G+Wi08cFDFeVzjgPI+jurO58k5lHI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ce+ulPW8UHrfqv3GIxxYYV0+SeRtlhFrkf/7erCUKOmUnTQydlJmkDyhP4ncLp4dskkjD9iXG/20uc7EZiLC5gEjU04NgljLskuAyjjgvG+LTF72IrKU6V/0l9LcDy1IbNDt989kVUSSV6eIMPWJJT/GXnYV/61BVI0X3xg7o9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6d8eacc4194so2291036d6.2
        for <git@vger.kernel.org>; Thu, 16 Jan 2025 19:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737083657; x=1737688457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+Ak/YrlhNpH9ErPvhHvyq21rYsBq/XdmTChaVy0f0Q=;
        b=eP01+A/mCSQbM0/h3gvFcIC9eDfaHu9EZFKz8Nsu35kNEnHUKmz7PHyb+pb41syZ49
         5uKbtm4kcSe0Cvm8C6opsp67H/+vZ4JyKR6u2lwq7WSVWwbB2niepDNpvteteYv8G922
         uqSFO/SCOI681rU3XisojiXvuc7ZisWgUX11JNebo+mb116VS+joKSOheCV74SvJ9ogK
         YluL4Hx8QX7X/vZKYxs4lDbnKD3A1MJnoEuHpiBrlC+8YiGBhOLV9RoYzRTElQKNbyTR
         aUAOECrfLfKRkWQxPldJnmtx8MhRdI32nW98gza1FQ7eyfz6125hMsshtpKUkCzREmeU
         Of1Q==
X-Gm-Message-State: AOJu0YzqoTgx1DRS1r4YXWz4bcuIGGal9pDa0XbqDOHuUKtfzDY5CHiB
	qekvUZjYnh7S5RYBKawpAgDMaXsyUVCjbEo4FE8omdBKZtQifgxcMSh3ziCX30jV4Pl/vk5yu9w
	wZyg/bi8hVlVKjp23whwGiCZHi4SrK06I
X-Gm-Gg: ASbGncsMgsP9goJDjcOfFxZ/nwG3eTcrbimX791gpU/5xmfnPUuWmnX43t3izaC97wH
	4Bu9PXTqxT2a/a8kAoFDnRM3yiGmQq5juqTCYgqsKxDb0p0BmbkWX1g3xSgO6fEYKhYlL8Vw=
X-Google-Smtp-Source: AGHT+IFaF/EquwxYH0aPFQ7LKi2Fd6Xjp88hQeuLDLcxLksNpGR3c5g1Zfp3sc5Nqg+0IMetfMOt+TWMegN2n6I8m0w=
X-Received: by 2002:a05:6214:1253:b0:6d8:98a4:cc5c with SMTP id
 6a1803df08f44-6e1b19d8eafmr8240706d6.0.1737083657354; Thu, 16 Jan 2025
 19:14:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1878.git.git.1737066042014.gitgitgadget@gmail.com>
 <xmqqy0zanzdw.fsf@gitster.g> <xmqqfrlinuys.fsf@gitster.g>
In-Reply-To: <xmqqfrlinuys.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 16 Jan 2025 22:14:06 -0500
X-Gm-Features: AbW1kvZ2JM8siBnHcqwp0fnNVQ1R5xXl8fIfXAPj5Ffs145NsFgKN6No-gw4CZo
Message-ID: <CAPig+cSKHWm+Xwk8AAeyOdHh8voPc4OBT-bZdsWHBGDG0GcgJA@mail.gmail.com>
Subject: Re: [PATCH] grep: document negated line-number, column long options
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, 
	"D. Ben Knoble via GitGitGadget" <gitgitgadget@gmail.com>, "D. Ben Knoble" <ben.knoble+github@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 16, 2025 at 7:30=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Subject: [PATCH] gitcli: document that command line trumps configuration
>
> We centrally explain that "--no-whatever" is the way to countermand
> the "--whatever" option.  Explain that a configured default can be
> overridden by the corresponding command line option, too.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git c/Documentation/gitcli.txt w/Documentation/gitcli.txt
> @@ -161,6 +161,20 @@ can use `--no-track` to override that behaviour. The=
 same goes for `--color`
> +Options trump configuration
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +When there is a configuration variable and a command line option
> +that tweaks the behaviour of the same aspect of a Git command,
> +the command line option overrides the configuration variable.
> +
> +For example, the `user.signingKey` configuration variable is used to
> +specify the default key used by the `git tag -s` command to create a
> +signed tag.  By giving the `-u <key-id>` option to `git tag`, which
> +specif es the key used to sign a tag, the key specified by the `-u`

s/specif es/specifies/

> +option on the command line is used, instead of the configured
> +`user.signingKey`.
