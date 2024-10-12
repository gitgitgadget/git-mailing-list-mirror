Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899D1946C
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 05:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728711345; cv=none; b=tM4MlbBYmzfe3qXrzVEsSCIm2Pdpo54dRgsLQ8DkhLgMSHON18ZvrkpDUGpCTWoZ5yzQ2tsHOkPov6nEh4qKOG9PpZKuwEfc3jC+8f8NW6qOBgz/8sGAbl6BzJww19bO+7vmn5qHvwIsNZDNfLOIPMBLLOYxQltQ1GzfQyJOogQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728711345; c=relaxed/simple;
	bh=yZKpDWsZ/EwQvBBoQ+HA3llBP2Q2Eq3J7AHAXXsTfJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pAg9lx7pm3lTjj8Bh/BKqCmbp1E1ohvCkwCcBC5aZ8Wemzzu3xH+CmD1xDlBbsPjfDH7mobIDP+uhlbXxYJieyCHF8DSHZJXAnTw8reyzzIIawcEIsQW7gHHhL3WnbsGMY6IkS+jKZKThLr7P9tyqXIP2OgbWk5Jur84pyKIXJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-6cbe53e370eso3061936d6.2
        for <git@vger.kernel.org>; Fri, 11 Oct 2024 22:35:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728711342; x=1729316142;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4hTeRGL7iJEEu4it3qHg5ml8FQ8CvH4j1zmGB7c3oY=;
        b=cX/zh1Su8y3XDLJ5mmKWQroZNY+TdcJSvmS0ANx7DgwdQg8uX5rMwdWi49asrLVKs8
         FUURw5wsJFJFggxQ2Cas+cRCnG6v2IPB4I80sPoKkolJ4k8BkSFFO00ur19GRodPZi4B
         QrclbHM4ObvfCgCRVP7O5pczO5VhAIM8bCGV7MY/PWC/n4pGL+ZWx5/wSHnYLzVSO9e5
         TsPsSxO0yAX4nz0LMCFP9W38J1y4A62NKdThuHbFZcFBz4UUldbm59SQlm06x6Sz2Kra
         RPe8AUOgn0dYs2tfvI31xxx7Qht46+uiYf+GXL+GdrUoSCyTWRVbUESLJH8BEd0pqM3K
         7gIg==
X-Forwarded-Encrypted: i=1; AJvYcCW+4podNgmMlcQ6KD89i7auJHol4LukshTW03aPIXNQoAHwNPktWU2vLSFFdM1lr5IQGMM=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHg2L3yPEI9KZ3xn73J083IBLtUJD8k/XsJSHa0TpOEozZmA3
	rg+Ja4SxSAfpult7PWVVDDZyXCkB1/SLMohAKPv734It7Vyx3yISHRicyaIgmUmgJGtxhqfHGox
	DZ12vX/u9dQSHLLdoJoPtgTNBDFU=
X-Google-Smtp-Source: AGHT+IFtNyIF4G49cRwEhEYtPdWmhS4Pqlnr4o0WcW/uVmGPDG+0RxYIi+jZi0gGf9+3JItMnV9z/CgVnppexEoElWo=
X-Received: by 2002:a05:6214:2b0a:b0:6cb:e8d3:cfcc with SMTP id
 6a1803df08f44-6cbf0044bc9mr30850836d6.10.1728711342479; Fri, 11 Oct 2024
 22:35:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqzfnaedh6.fsf@gitster.g> <20241011235959.596136-1-chizobajames21@gmail.com>
In-Reply-To: <20241011235959.596136-1-chizobajames21@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sat, 12 Oct 2024 01:35:31 -0400
Message-ID: <CAPig+cSRJXoZfXdBmWt8md78t-6c2NBjeR=PK=RaKqLoCjxXMw@mail.gmail.com>
Subject: Re: [Outreachy][PATCH v4] t6050: avoid pipes with upstream Git commands
To: chizobajames21@gmail.com
Cc: gitster@pobox.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk, 
	ps@pks.im
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 8:00=E2=80=AFPM <chizobajames21@gmail.com> wrote:
> In pipes, the exit code of a chain of commands is determined by
> the final command. In order not to miss the exit code of a failed
> Git command, avoid pipes instead write output of Git commands
> into a file.
> For better debugging experience, instances of "grep" were changed
> to "test_grep". "test_grep" provides more context in case of a
> failed "grep".
>
> Signed-off-by: Chizoba ODINAKA <chizobajames21@gmail.com>
> ---
> diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> @@ -344,7 +374,8 @@ test_expect_success 'test --format medium' '
> -       git replace -l --format medium | sort >actual &&
> +       git replace -l --format medium >actual &&
> +       sort actual -o actual &&
>         test_cmp expected actual

Although `sort -o` is POSIX, it may not be supported by all platforms
on which Git is built. Moreover, as far as I can tell, `sort -o` is
not used at all in the Git test suite, so we should be wary of using
it here. Therefore, rather than introducing a novel use of this
command, which might possibly break on some platform, instead stick
with what is known to work without problem:

    git replace -l --format medium >output &&
    sort output >actual &&
