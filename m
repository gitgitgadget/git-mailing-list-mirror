Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED2C16EC19
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728254910; cv=none; b=M65eMRA/7cbGjzjOxl11l8/p5Id8jYNHQrwaq18w2B4aR4Cv9ljNXADr+UHU50XNzOzpy7ImYguxvwLTi6tzvIgQDoOEB8ObcvjhfuU6sWkTR8XCSerJ2zfx7zHcIWwk+c+21ZwaUIwPZSsDQ0cre6bg4GokjWbNlPTh9ExsJQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728254910; c=relaxed/simple;
	bh=RYofTkoEBd9/TXQuE2eZRckerufubXubpl+Kw0kdv9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYI/aqku4ZSTBRDA1cbIgl2W6+VHyCXvx3hm9vd3DU8zsbQvVNkMYl5AKYMb5yMdCuZlQVe81SjqBcctJZw18rJb+7Tw5A9BY/E1JUZfZo6SOkAvKaqLPfYimWaSXHFJO+HoGns1fCh+mqYQpQ/sN++ZWlGYZ51iwEkkv+fGVDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-6cb2a273434so4726136d6.1
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 15:48:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728254907; x=1728859707;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RYofTkoEBd9/TXQuE2eZRckerufubXubpl+Kw0kdv9U=;
        b=En44jCurEWW7CHXl2p5tqWI77g5x7bjr1vlm6nOx6zuQcfepwid5IRmNSaR+CcamZd
         M+0ab8NiOW+6J8NPCI5H10OHknX6oBx0pXkfKdVfurNO1cRjmddK+yCqUhT+YN7mNlb+
         ialZaf1eKkxpu+q0y/qMwmTQszs6EE5tKCJtj21fBD0W+wsSDu6+MubbhghANOlViGSm
         nzmZlPunpkJhtMi9L32C7+cK4zNQUF0fr1gTtSmETF+P8UjV1sCxr8Zi2qVVIENJSVFc
         syKPNTr99ZCENlU0lYTnFhu6AboC1VHV4b/g91ZzDHUqA8VbmnVNiDhT+vHsDwQZNNKW
         d7Jg==
X-Gm-Message-State: AOJu0YybVaVtgTH3XwWT+kGi1jRnqOi0cjeuhtP3gjAEM0PpdC2Ig1w8
	fqtP6OVbX8lo5P88G8IdJDhjGo8WOxSYrHB8awV90H7fq2ErKhUe0kyzFr9Dy/6BWNmvNO6W4MC
	DnuLH7/rQgghHkpW9gwb3O+oJSbtytA==
X-Google-Smtp-Source: AGHT+IErNbkY8Ldj7AlPF0X+IfadFtHflBZvnjOFb1d8wrb5m2AZVohIfpj4lXnfco23OWsqW3bTcxvTYGcKfIhbLR4=
X-Received: by 2002:ad4:4707:0:b0:6cb:4fad:5215 with SMTP id
 6a1803df08f44-6cb9a1efe41mr68920076d6.2.1728254907527; Sun, 06 Oct 2024
 15:48:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-4-cdwhite3@pm.me>
 <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com> <YYay6Jp5c84h3Tx-LViX4teN5KSBX5PL3_WcOFRzUooFrpJpcBD2SRWf1EQjvrMZsI6zkKyPd7JbWt3Ed3OIxCdkg17fY2qvmT4-B6a0RAE=@pm.me>
In-Reply-To: <YYay6Jp5c84h3Tx-LViX4teN5KSBX5PL3_WcOFRzUooFrpJpcBD2SRWf1EQjvrMZsI6zkKyPd7JbWt3Ed3OIxCdkg17fY2qvmT4-B6a0RAE=@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 18:48:16 -0400
Message-ID: <CAPig+cTKjebbpuy-SCLWd0QMKfHhRyJ81oESNjsUoPDLLNpNWQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] worktree: sync worktree paths after gitdir move
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 6:41=E2=80=AFPM Caleb White <cdwhite3@pm.me> wrote:
> On Sunday, October 6th, 2024 at 06:12, Eric Sunshine <sunshine@sunshineco=
.com> wrote:
> > So, if my understanding is correct, please put some thought into how
> > to reorganize this patch series to ensure that the full test suite
> > passes for each patch.
>
> Yes, there was one edge case that broke and this patch fixed. But I
> understand what you mean about the bisectability. I was trying to come
> up with ways to split up the commits and this seemed like a good spot as
> it just introduced new functions with minimal changes elsewhere. But
> this can be squashed into the previous patch.

I haven't yet pored over the code in-depth, so I don't know if it is
even possible, but it's typically very much preferred by reviewers if
you can present a series as smaller, simpler, easier-to-digest patches
than large monolithic ones. So, it would be ideal if you could figure
out some good split points (especially since patch [2/4] is already
uncomfortably large for a reviewer). But sometimes it's just not
possible to find good splits, so a large patch may be the only choice.
