Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4D8157A67
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749661955; cv=none; b=rvsC2LLb7F5j5MBlEJbb/4hy5FmRJwvlLdsicnNTozOVhS8FF0mO2APT2ct2Z/KrVrVYHE+6ca6dQkmd6TqAOBNdua5K9XNJKWX8f1byPEOfgpTcpz+wwFcjTp7PC79gh2xb13BmdlyPZGDmpWUltfJk/zoDyyFxAi5H6dDlBuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749661955; c=relaxed/simple;
	bh=kDUNrM6cgZRAKcSjGhnku2ASeMz/zCxz4DNGPwQytgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hYeoEaT51WpV083XNySB/yZ4ZL8NFiqr9awoqaTJXgrtB5hOoxuEqKXmZvBAnXxUbPq5SfXtjuUWpS0WD38unYyQCDlx96J7uY9DHTuI0oKkOWRNuFMtnejrhQawjkXXclh5nFKATlfZ9Z3i70OgLDIELhXR29KO3kWcOf+gTpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6faffb55f68so115696d6.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 10:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749661952; x=1750266752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FMCDkdwVbgfBGJlo6/7uHqj1ghvol1BTUTJMij/hy9Y=;
        b=RUBryToHRkFBOWfxJw5pjb3O2uKs0KB3m/EEvEqK/YEew+sgHe834hxrbG9I12VfOH
         AM7ARiuseJzcXr/wJUHKF7Lh/axaXPChvPVVmrJowkKtuduF7GpR9ulE1oxLDOGyB87T
         Mb8IpAIPPfKvqkOMFvlG4aZaYlkK2cEZDc1TYxTlFsCMx+44z0BbroyLPMwKiGgxpiuJ
         eCKmKEBJGDOQfbZfY+etrLUAoWAltBeDgLz6I/BCwfsn1Jxt1BvRN6xnOJJcoIKlqlOd
         NYBqP/twqTwztBGEX+rLILmNQHqnx9qNQr9zCcEu+7PcU945kDdxLvK6W3xVneEZf8Cj
         yHzA==
X-Gm-Message-State: AOJu0YxlVqaKPrGjvQ2zysLBYE4ZriCOJY2sJKOeUnsjJNUGDNg2RRWz
	qdHd5yU8js3mCNxEwTMgKgCRPcmu8thfnRfgonf92/buPJdAr5Kol2Si4eug7gB4XI7JI7OxfGq
	2GY7acdBUyzWTgG1rmX7g3HxSFbEvx44=
X-Gm-Gg: ASbGnctxk7KN/jW1Oh3jV/Ze4iMUXe7Tr4xmOr76cyYYWho45b8RakLzuR7Kdbe9GF7
	mRmicUwq7RyY97JRUSnqDoTqSOpYNlzJJyTUvD6gnSe0r7P8zWMgS2jaAh2wSX02zmqEBQLPtnD
	euBcSKlO28MM3MKSwGeS1Tr2V8tzSEIG0sK8pyrE3oR2dsWbWzcq6bpqhyQlYp6KCvhrSh+XuSB
	fNR
X-Google-Smtp-Source: AGHT+IH6pHnePEbSYVg00GUX26Ir0egVCZQs0pGEcatJzeOrzsKcvoPkCxI0NOhp9T/igVGAzLe8rvwXKBuX/edoLnA=
X-Received: by 2002:a05:6214:5017:b0:6fa:b8a1:abaa with SMTP id
 6a1803df08f44-6fb2c255ef5mr25154956d6.0.1749661952498; Wed, 11 Jun 2025
 10:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqq5xh6xlpm.fsf@gitster.g> <xmqqfrg6i57t.fsf@gitster.g>
In-Reply-To: <xmqqfrg6i57t.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 11 Jun 2025 13:12:20 -0400
X-Gm-Features: AX0GCFubWAQwK4_VYBf2L5AAKrGyg2A44l1uDeqYrx05z82FrtIlic0SwYkKKLY
Message-ID: <CAPig+cRgUWYGPb7o_9UgeQAuE5WN1mtC=bsOP=62rXOzjXJ5Eg@mail.gmail.com>
Subject: Re: [PATCH 2/1] merge/pull: extend merge.stat configuration variable
 to cover --compact-summary
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 11, 2025 at 1:00=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Existing `merge.stat` configuration variable is a Boolean that
> defaults to `true` to control `git merge --[no-]stat` behaviour.
>
> Extend it to be "Boolean or text", that takes false, true, or
> "compact", with the last one triggering the --compact-summary
> option introduced earlier.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
> @@ -231,6 +231,21 @@ test_expect_success 'the same merge with compact sum=
mary' '
> +test_expect_success 'the same merge with merge.stat=3Dcompact' '
> +       cat >expect <<-EOF &&

Do we want \EOF (with backslash)?

> +       Updating FROM..TO
> +       Fast-forward
> +        file        | 2 +-
> +        other (new) | 9 +++++++++
> +        2 files changed, 10 insertions(+), 1 deletion(-)
> +       EOF
> +
> +       git reset --hard c0 &&
> +       git -c merge.stat=3Dcompact merge c1 >out &&
> +       sed -e "1s/^Updating [0-9a-f.]*/Updating FROM..TO/" out >actual &=
&
> +       test_cmp expect actual
> +'
