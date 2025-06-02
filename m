Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE12C8FE
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 16:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748883592; cv=none; b=kgN7b+SFR3Z2cLN8EiXjljpfWLQf94aZjG3WS+B4buM5C6CqQeeNJp3n6/W1RDAdbjmfHI8mckrDtC2YYXb3zITAWMwuKo+MR76qHlHWKi/Ej5rYW+oYlj2goVx5gywB9aN9Dvl07vXhGliuyaM4tYEPlYnrxRAi2w2p1WsepV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748883592; c=relaxed/simple;
	bh=Jgm2hCNiWLVHGthKh7RmjS0MshK1egjHHh6bJswP/bg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PWTtts48KyfgPodYsfnuOGotNKCXPWsRuHXq1uewEV0zHYju2jUYFbROd9LKUbiG4pVyavpScMGtM6BmYru8N4LWhvG8PEXgUhusVEPdNTtuNSOoOHQZLapnmyG1xIzwsccNMWuKX/6c+OMXW4xwpi1/eqvRoc6v0i2JQ738zTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7d09a878262so63521585a.3
        for <git@vger.kernel.org>; Mon, 02 Jun 2025 09:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748883589; x=1749488389;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jgm2hCNiWLVHGthKh7RmjS0MshK1egjHHh6bJswP/bg=;
        b=PbugqwCekK+cOMhKS0z3f/PuVzytBb7GlFdYtmxCmCN/VzTH5vAmuz0qCi+iI3dqcl
         TsCsfsLvrors4noGZ2jmiPCJznRWtbp9JJCy2tOHLZcdbnqtIkhMtkKqq6wur4bI/3UY
         b/4UTnSclq0ricc9QgDojXw4kj5opZkBvN7L1U1tnNMtx7WmrZQjSmVZ3T9P+c/noth2
         4gzG8izmxO9Dulw+v+CQQ3A6Va2JzlpdiBf5FtPfhPMyrs+wZwE2qDuca6gmMfVfaNW9
         VjKqTEhGzh6zm1AwDAV7O5xy6TJrPGW0AQRMSAmOL4cIGs8DcuGLBZl7lymHgl2BaT3L
         V0fA==
X-Gm-Message-State: AOJu0Yw+oVAJj21jaR2ODHakeXhlLBUdujdJ/UDhxJBtyNd9tOPGivsc
	i8lM03tUq6L32AI8icO3ee7xI/tlZdKUzNp/g34653fL6ehanYeCvC8LV9q61xoCb50tm8rc8CF
	eQAauMz70RbudgVBENi99B7wn1TgqZYp59A==
X-Gm-Gg: ASbGnctUSVkE2fDA8KmuQs1djiM4yWUIGFbkhLepOn8N01nRoU7Y602dxvtMit2/U3n
	Vljl8ruAZ11DLZVu4iBsYPRANm4zR26pSSuMnH0GQERgfwVq4hyya/G7eF39tyMRLlwJOVVGLMS
	xOp+fINC9EHkoVvMfxhmIleDAgdHyOrIMowdfc4/OIJFbeX4+suqZSjyYxTN8R+nRGoQiEuTWs/
	XE=
X-Google-Smtp-Source: AGHT+IETA0dbge8QMWGqpUT1IUb3dscQWjW7FOwrSWPe02wgxi9u++l5dKPRUjP0GpRMn/XmzMzdvYAqXmO5VCQLw6g=
X-Received: by 2002:a05:6214:d83:b0:6e8:9f7e:8116 with SMTP id
 6a1803df08f44-6faed7b681cmr776096d6.5.1748883589356; Mon, 02 Jun 2025
 09:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-0-903d1db3f10e@gmail.com>
 <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-2-903d1db3f10e@gmail.com>
In-Reply-To: <20250602-6769-address-test-failures-in-the-next-branch-caused-by-batched-reference-updates-v1-2-903d1db3f10e@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 2 Jun 2025 12:59:38 -0400
X-Gm-Features: AX0GCFsy7gxh0z1qYYi-Cbpew1ZvyJzcDkB2ZckVUPtjzDw6FWfExV086prvpgo
Message-ID: <CAPig+cTMDcvwfzq7Pqn+MF7r1x7qZq2k=8pAV3bio0pcnuh4eA@mail.gmail.com>
Subject: Re: [PATCH 2/3] t5516: use double quotes for tests with variables
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, jltobler@gmail.com, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 2, 2025 at 5:58=E2=80=AFAM Karthik Nayak <karthik.188@gmail.com=
> wrote:
> Since expressions don't expand within single quotes, change test
> descriptions containing variables to use double quotes.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> @@ -1421,7 +1421,7 @@ test_expect_success 'peeled advertisements are not =
considered ref tips' '
> -test_expect_success 'pushing a specific ref applies remote.$name.push as=
 refmap' '
> +test_expect_success "pushing a specific ref applies remote.$name.push as=
 refmap" '

If I'm understanding correctly, I think this and the other changes in
this patch are incorrect. There is no `name` variable in this script.
Rather, these "$name" instances are merely illustrative, acting as
placeholders for the person reading the test title.
