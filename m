Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A561018B0A
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761179645; cv=none; b=B0U6A0R8FBeecjVRRMyKw10NSssollQd/ooBSa0XMZ2z++5OEpGhaW8nfZKuZFuA2lsLX0hgY3AH36AKq8ebLe2iLXCq5tIxBHw5oDbOIwsAC0NMSvqe3DN/ItvHsjyAZgX5KMTbCGKO/f7yhdY/t2qSXIebmJZyeUnaBcGLwSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761179645; c=relaxed/simple;
	bh=CrGHENsXZhh24w+2yxqBPhgPsFhtNxsgApG5zdbKl+k=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=jK7JgriOKZrTXcUNt/3/QJ1pTYwAxUKSchbQE7SKT59xTaPfCJ+jjWwW164wqlWdqOYCjqPwC9AaUw4yY9XKtPqGngZtIy8OF4l2FS9hMQ3C0sMB4ifiF23gXeQH+4Cze706vhKo9+Vm/7Bva6+LQ/makxUyq1uTc0AQtfQF3HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lkP2zPol; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lkP2zPol"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-27ee41e074dso1908015ad.1
        for <git@vger.kernel.org>; Wed, 22 Oct 2025 17:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761179643; x=1761784443; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lEHZYC1hXehgoFPjM45jNfAuua3z8b7hi823ldJNHZU=;
        b=lkP2zPolWhmXjfPRWFJaJWNdgbY3gnb62rEtweYK8mmK/ZEG2C1vjifgrmZm3v9RQT
         xUdgWD7pn3yEblJd96qYFasPz1V4dq0O1uxB8O7rGNilueYNkJVJWtAj0DR0AKRSRAqO
         ndKSF+rC/i7mvU6c9PGmSY+8ZXefkHbE+FBwt/jSUtxEQDMtw21KcgqGjPePeXHT3qbx
         +FkMgWePRsC+QdK9dxbPCdL0rJxGOwzc8/zXHdKdPLrrSaIwfF1/00fM1kYyNWL9cDCZ
         jHTvA8fL45p5WL8HCsGSVGF25i4v+b5llNfxDE8qpTePMigU3AoROh5hXUSXjAAeNy9H
         5o+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761179643; x=1761784443;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lEHZYC1hXehgoFPjM45jNfAuua3z8b7hi823ldJNHZU=;
        b=etaQjV8f/QzyZfLmkKnU9qMG9Mev31eKelhFxd6Qt1jflyMwqmH70KXhMIqYpgLMKV
         OUfbpt0r/ySZd05ybX3iZrNZgxLy3pueN9kFxfqdYo6prUvyA4jt0VTI8lTd6BFKhHLy
         QriQAPlmt69gc6HqBnf6RhAMmHgDx8IqdK98ceePoXsZdc8QdAV4UAEz+biSCqjpd4lU
         uVPQ3h3ZAVZheQVCVissHwcV6qu2y2r8pTFqt5z1tjQAnaR4fT2rYdzjK7Wq9SYBZ5xg
         hfyxynOTzQ+z7jskP1ciQ/v55zF13aqAxSBmVEwZ+jLe5dE4DhdzaVbkncwSBTVVnqMz
         hSXA==
X-Forwarded-Encrypted: i=1; AJvYcCWbf6CQy6tdcMNtOnfXvApl3c7yUk5hXIXvwFUAA7twjI4q5Uxt1GhpqHqHo46GCqFUMT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYrqe7DTrJ09pIzqyxaCkQj7jvTQQbXwq/gfP5Nv6C4oNYzFlu
	1k6jjc5wo/jjvRnJlydqUcAP15cA6K67qGGO3Y4CFHKRQuD5iG6dg1wMPYq4v8qoJn4qlg==
X-Gm-Gg: ASbGncu3DY8h51Q9PZfKFboi2JqRGHKJxcW3QKN69luzMDsFTTZ7g0zYaeBEpy5bR2T
	TP/9qadez2hIFNX0yY71TnmgvdZAj0clJdhmaaeZogYyUQBLisR2YuZEmPxT+g0lfqaaiLgk0KP
	P9KPIBvVoIy4bKv2EKlS89KudJgPiGtPkoWe+X18Rcbs3XLwAZXTXvw6EGjpmBoRkhX7BYe+k/D
	xgjcVgpgyDvJ261AgHtl1fO/WjmAcrVlaYj7/sbCAuiePrVTWJ9YYZhCnRslM3kc8MDT8QqpjCA
	wo1GzxkG0T7YTSORLZsaJdjhwt4BwF6kJHzhtnmmGGgVgTwMdiCiBJhT1wyae9fxuQnWMc4x+FK
	SNi9B9Iu1ctCi38PBFJRNTX50bLG6mZxww0sU2xXXQt6rrNXMCVTBJublKKcs4o1p+wgleMt8pY
	NPZf7K+r9nmfbDGDso4PTPRl7rU0tqZFVbdgPtnDw7UgBmSOSIzQ==
X-Google-Smtp-Source: AGHT+IGL1nzfSWw5oL0OlpOZu3s1/2bbJFJyraotDUce3kS563ikR57S9AFKPhnzAdgUzCXqyNLhIQ==
X-Received: by 2002:a17:903:2310:b0:28e:7841:d437 with SMTP id d9443c01a7336-290ca121206mr278630555ad.38.1761179642861;
        Wed, 22 Oct 2025 17:34:02 -0700 (PDT)
Received: from smtpclient.apple (n119237241194.netvigator.com. [119.237.241.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946ddec426sm4016355ad.34.2025.10.22.17.34.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Oct 2025 17:34:02 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: Regression in `git diff --quiet HEAD` when a new file is staged
From: Lidong Yan <yldhome2d2@gmail.com>
In-Reply-To: <xmqqcy6ezvi7.fsf@gitster.g>
Date: Thu, 23 Oct 2025 08:33:48 +0800
Cc: Jeff King <peff@peff.net>,
 Jake Zimmerman <jake@zimmerman.io>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <09150C80-0238-49C3-BAA2-42983741C905@gmail.com>
References: <CACJRbWjwOQwJB13CwTfvhV3p+Hbn4KrNM9AtBanGtUS4V_1MbQ@mail.gmail.com>
 <20251017075153.GA4078773@coredump.intra.peff.net>
 <xmqq7bwt1kyf.fsf@gitster.g>
 <20251018094037.GA1060824@coredump.intra.peff.net>
 <xmqqh5vww7xa.fsf@gitster.g>
 <20251021073640.GB259661@coredump.intra.peff.net>
 <xmqqy0p4wcac.fsf@gitster.g> <xmqqcy6ezvi7.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.700.81)

Junio C Hamano <gitster@pobox.com> writes:
>=20
> ----- >8 -----
> Subject: [PATCH] diff: make sure the other caller of =
diff_flush_patch_quietly() is silent
>=20
> Earlier, we added is a protection for the loop that computes "git
> diff --quiet -w" to ensure calls to the diff_flush_patch_quietly()
> helper stays quiet.  Do the same for another loop that deals with
> options like "--name-status" to make calls to the same helper.
>=20
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff.c | 15 +++++++++++++++
> 1 file changed, 15 insertions(+)
>=20
> diff --git a/diff.c b/diff.c
> index 9b8d658b9e..ceb57d1ef8 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -6814,6 +6814,16 @@ void diff_flush(struct diff_options *options)
>     DIFF_FORMAT_NAME |
>     DIFF_FORMAT_NAME_STATUS |
>     DIFF_FORMAT_CHECKDIFF)) {
> + /*
> + * make sure diff_Flush_patch_quietly() to be silent.
> + */
> + FILE *saved_file =3D options->file;
> + int saved_color_moved =3D options->color_moved;
> +
> + if (options->flags.diff_from_contents) {
> + options->file =3D xfopen("/dev/null", "w");
> + options->color_moved =3D 0;
> + }
> for (i =3D 0; i < q->nr; i++) {
> struct diff_filepair *p =3D q->queue[i];
>=20
> @@ -6826,6 +6836,11 @@ void diff_flush(struct diff_options *options)
>=20
> flush_one_pair(p, options);
> }
> + if (options->flags.diff_from_contents) {
> + fclose(options->file);
> + options->file =3D saved_file;
> + options->color_moved =3D saved_color_moved;
> + }
> separator++;
> }
>=20
> --=20
> 2.51.1-633-gaa2b1236d0
>=20

Do you think we should make a new =E2=80=98going to be flushed=E2=80=99 =
queue
and flush them out of =E2=80=98quiet=E2=80=99 loop would be a good idea? =
I think we
shouldn=E2=80=99t discard output of flush_one_pair().

Thanks,
Lidong

