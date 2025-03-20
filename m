Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC732B9CD
	for <git@vger.kernel.org>; Thu, 20 Mar 2025 19:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742499685; cv=none; b=GlZBNQxJZaIMQmxwCw4fXq4hE3DhscRs7XStz1uvRc/SUEShEhG26Su7tAnd5Mn5Ye7wHd8X8emO2Y4+ozRFmPZkbH/dlLqMd+pXbJ7eOUtGOhM7ztwa5xqTHEkJvi1dZqysngWruEtKmls3mvZxGf7CXlx3sl60vidtyKb44RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742499685; c=relaxed/simple;
	bh=y2UQMNUK8l+p170KmbuMjbDfGqz5GQeBrqnwPr48/2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P6KFc2TidDTJNEZCu3I8qJTobDUrpFPv9aE+6Aq5sm9h8pg8/UguRv/JcX9Ri7Mg69V83fw28lJisdTFfPNafVUZ0Yb+Vlc4RKD0hCLvDV+LxoF5DfKKOQ4SiNKxY8UO7y52e3Qd0a4KQ88S6V0OU69C/CTiPfa0disPUYA1vAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7c53c6c28c4so25161985a.2
        for <git@vger.kernel.org>; Thu, 20 Mar 2025 12:41:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742499682; x=1743104482;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C0RpBJQsxC5l/hkpif/R5XLOWii7cqUvdZ+tdYT5qtY=;
        b=TjwTnMZiIUp3Nj1jutreC6iEhT8kc9oeJDkUP94Q4M42ZSZAhqeyTs8UT7yoEsTFib
         gRJ8/HySRLZnhKZsGphchGROiA66S4OkoLCOXbp6cKZ55nh9dU/HeN6BZS5GEilK4swq
         POTROQO/IOp3KEPBQMk9q2X0biSgSJRzc+dP/TDqrvcZVNiSFUwTpJuTsFyFLaJisWwF
         fvAhYu9I3zykA/pqmg9xBa1vJ8Y5HmgtXMf+F9KqNTBnYmYyYS9qmev5sh9GhzK6b3M7
         pRKASFhVE9VVvM738QiixyUgVCNTYGD5dB2SubOZPhn6GHMmPXka3mR0T6gfMe+ne5uw
         NY3g==
X-Gm-Message-State: AOJu0YzjjnyNeUK7vY3+WByPC3DU9+X75gFEbcPrydS6W/x1OA/xqALy
	VbY5kJaCwCbQewqlPsR+Gi+r3VzhvDaHZmp9yjIhl/QNBQ1TN7XDizLvHBN/cSVE96RV2pshjO9
	Yx6tvbRnk9KVd2F6r8O71LOUb3QI=
X-Gm-Gg: ASbGncsE+74+HsN/l7m9/zXZfkvkwPm68rGRD9vmbSZoUxy2ijRZcerEqJ1zoZZuoSk
	7NzUR2+V3s8nJpg4se1pl6orxjzK3U/pWT2B0cl0g35d0AjEh9x8mkQVtRCfFQeeZeVkQV5WSVf
	FUX+S7lNRPy8/tIiJWh3IAJPv1
X-Google-Smtp-Source: AGHT+IFDmkfDJH/5dprdhCb3uoC52uYjSiwVPaDMWWx5zSJi+5JQmLPSYqDQ489gWPZyXaCTxwKgfLFxs1pcvuKkJ44=
X-Received: by 2002:ad4:5cc4:0:b0:6e8:af1b:e70e with SMTP id
 6a1803df08f44-6eb3f347687mr3493756d6.8.1742499682136; Thu, 20 Mar 2025
 12:41:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250320-b4-pks-t-perlless-v1-0-b1eefe27ac55@pks.im> <20250320-b4-pks-t-perlless-v1-15-b1eefe27ac55@pks.im>
In-Reply-To: <20250320-b4-pks-t-perlless-v1-15-b1eefe27ac55@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 20 Mar 2025 15:41:11 -0400
X-Gm-Features: AQ5f1JqkaY-f5DNTYEB75hSpqNCGLakEDKNbDDT53eor0CN4pRHhPYqcnc2-STA
Message-ID: <CAPig+cTE1K6bt-4v9sv9ywF7wwc5Od8s5scnLsvYPFGBU5HDHg@mail.gmail.com>
Subject: Re: [PATCH 15/20] t/lib-t6000: refactor `name_from_description()` to
 not depend on Perl
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 20, 2025 at 5:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> The `name_from_description()` test helper uses Perl to munge a given
> description and convert it into a name. Refactor it to instead use a
> combination of sed(1) and tr(1) so that we drop PERL_TEST_HELPERS
> prerequisites in users of this library.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/lib-t6000.sh b/t/lib-t6000.sh
> @@ -109,13 +109,12 @@ check_output () {
>  # All alphanums translated into -'s which are then compressed and stripp=
ed
>  # from front and back.
>  name_from_description () {
> -       perl -pe '
> -               s/[^A-Za-z0-9.]/-/g;
> -               s/-+/-/g;
> -               s/-$//;
> -               s/^-//;
> -               y/A-Z/a-z/;
> -       '
> +       sed \
> +               -e 's/[^A-Za-z0-9.]/-/g' \
> +               -e 's/--*/-/g' \
> +               -e 's/-$//' \
> +               -e 's/^-//' |
> +       tr 'A-Z' 'a-z'
>  }

Can't you just use sed's `y//` function directly instead of having to
separately invoke a `tr` command?
