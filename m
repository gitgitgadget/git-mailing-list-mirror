Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67155318BB9
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 16:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771691321; cv=pass; b=VfeHxSUXFLI+Hqsie9nLxVLhaYrL6hfSLzbeMjCd3tmcP9vyGWzAvM/vC/d1M8Os7PCC3Faf0l7cAHT5HAhD5EqsrZb9r/TYVIF7GJ5v2TwfULprBMAcE2NDeANUV6xOFfYM7tVsrVs91Sr0sMJt549XpgO0u3GjjHh2XGqwBj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771691321; c=relaxed/simple;
	bh=nmkerVrxzPdYTVtJpZq4jZyiVKLB2usKWU+Br/4zK0g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o7ktgWwEXK45/J/EscyptzcK4ioX47AocKsJPG+iAgiRfh71OgeLxHbjo7WUxOaAFJ6Q2fpn+eVHELpIgyOUNmPjeQHTwPGqURhyF3wCuCrPJZJZdHE5HvZwWiz7BJsdo+RjNAt9tUj6bKAOZD7IFDpG8JHjk7gaxa+tZb92qCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LpxiJd9n; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LpxiJd9n"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-79639c2d2b5so24550057b3.2
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 08:28:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771691319; cv=none;
        d=google.com; s=arc-20240605;
        b=aQLOuAH6dXiK0ZcWAdTnDhzPZHun62nNDJnt+K+5jP25C3NfkzvW0vEl2ddVg5jV9r
         oZ8O0g9VYZFFZ5gL2Rh+hes72lmpbtU3jWFTpYUYWGNLX86gaKOeoxxvZj8u2Z0mAgwT
         2WST/bu94RdLgHekoEOsAZTLGjO/ZGIQobdP4H14OQZrnhZpbdVfVOMR8SOQ8dtDrzzk
         DFZl6l4F5PWYjwjr+jlI1Hy4AFSLAUXkm5FQnsl80U5kJDIY9jYPJVXT9/JSKbwyRajM
         TC2YT1T4sfdTmSnwoqqYszNZ08wE+NZ0a2Ip5E2Am3IEMCfWpeROPcLk6O07B2W1KnKO
         PNNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=QrUsDRZzxXZ1K6NZwOv8l693pe5WqTShIEdIumm9BkQ=;
        fh=RJRPxWyrU64VNsuotaC6zvtv6r3085k5B0lFV7F/MWM=;
        b=ijsnj0hWNlPUTI9J3mHwM6DiUIFHqESxoZ2YNzt74jU7wifgDtAQSAhewqZwnwIdf+
         qNOsNTuIJSafBl36YqItYZHWquAQbqcUuqoFxu+6+CUwDbDt2NK22ebiPbezTZCG/DDz
         eVo3Y6XCp+sJybCxREPxD3ePVgBhA5P9BBhCLjC6P8CDtGdVYMRChfdURX5SP617WjvH
         ACqIpiR57YqbjNRENRvyw2+2WoRHu9mNGPPrHbm2vjckLDUD+ruHqbHPv4AwX+eBpUsv
         mRd98FleH5p626pXoVRA0A0a3mCjVpZ28N2+oqYcv4+9GqHzdkscBe3myJwetZXqS2OC
         S8uw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771691319; x=1772296119; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrUsDRZzxXZ1K6NZwOv8l693pe5WqTShIEdIumm9BkQ=;
        b=LpxiJd9n9XLzbxtVd1zMdtbIqg94WH8461rCNKz0BAl9F+WXYF9AcvbsAKXSv/n2JI
         IJtEN35QWnCqAD6nqdjrR/13++Ovf80pxdIGv+qfz+IOZUDWzWv8lDxonH3nlZUigwms
         e/FoSPYRm1t82loI0X+3ZerJLLu6Iy1D94udJMP9pUljFia704UcFeSKLbIR34l9gUA4
         VmzhQlZaF5kdmSX7bnSJROF+zcwNhZnGYNzS9xiKTEaulVe+EWxbOWrWyKpUV6GfKTyf
         P+RKy7wMj1c9g2gHgW3X8qp9d0MUpr0RKJ/swCzfZfDOUEOiD3nv3CQrEJMVtExBuRIA
         TwbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771691319; x=1772296119;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QrUsDRZzxXZ1K6NZwOv8l693pe5WqTShIEdIumm9BkQ=;
        b=S8YGcSSuzmdBiBwRaSgW4GO1t1UVcMmPJSFMl9x1OB/69imLUZeQFxHd9zjg550wcp
         CRHdEybJmn/8Xa5B0xpvMDyGNJkzOxLHLMSv0RrE8On6oCnXFAfUFEKwjSmWRM7gM4D2
         UmnCkPQLYxK27TwdHeAFdfuyfenWpzYmfBaX4Uv3E3vrs1Q1OK0J6GvJFVOTIxSnmmYe
         wzCIg0BTeFA9X2Q7ppZs9/BaL0SjVLzTBDsuAH6IIkGr6T/d17Fw6UDfsSXdPZkKS+Sb
         o22upohjnDDaT+55zIpQz96DjAuqbo/57xq3K1FMnCqAhD21RS53vlC3Wa8s91s5jg0Z
         UTJg==
X-Gm-Message-State: AOJu0YzyLMYkME/Uk8kmUD8uvZuSb6kcKXQ/637OLJWmifXTeSzhpEZL
	mSwIPa3aEgJhhYr/OMkZ8pFT8KWiHYkzl1KX6gYjsqCei7fMQwhJUWcUGhdbEA4CVNr7R04HCoT
	GQtf5vyY+SELT00h3ixfLIV61N/B2Q5c1ThuZyxI=
X-Gm-Gg: AZuq6aKDarJyO0L0kJJ4Yk9xIepib1Cd/kW0F+myFWC67cVa035yl5x69HhJW+96U0h
	DfcNpIzMibjw2h+F/xWgqC0D2501Rpsvn0ktgQxRCevmkdpEKqx9divxaCcuI2v/PLlSSW3Jnme
	Fe6hJV5hy7ntuS+9NKcmuC3kJm/wYBDmJt3lPcwxTG/9WR+N268C7UymY8Tq8hdwPgZeTpwh6Ha
	ebjwnWq9zm23ttcvB3awlypi5kHZeCoqJcfXmtARgjy/fnlN+gmrpwdbhSW/xT5xy3IWWOnorDX
	jWbsY3Ym6yDQP/p/ycBZgkj5M7fiCD89du45pA==
X-Received: by 2002:a05:690e:13c6:b0:64a:d444:816c with SMTP id
 956f58d0204a3-64c787d4d9emr3218540d50.17.1771691319306; Sat, 21 Feb 2026
 08:28:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260212041017.91370-1-amishhhaaaa@gmail.com> <20260213033729.50208-1-amishhhaaaa@gmail.com>
 <20260213033729.50208-2-amishhhaaaa@gmail.com> <xmqqecmpnu3g.fsf@gitster.g>
In-Reply-To: <xmqqecmpnu3g.fsf@gitster.g>
From: Amisha Chhajed <amishhhaaaa@gmail.com>
Date: Sat, 21 Feb 2026 21:58:28 +0530
X-Gm-Features: AaiRm51tK-yQzFCoLl1IgPSKl9IvrvaCl3L9WRV7HaVtfUpbbp1a5AX4LBxKb64
Message-ID: <CAPvEtrf37yJ2T2EsM3sgDodO=kdu_C5eXT9dmvcepzZwhAMzWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] help: cleanup the contruction of keys_uniq
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, stolee@gmail.com, peff@peff.net
Content-Type: text/plain; charset="UTF-8"

>
> q> diff --git a/t/t0012-help.sh b/t/t0012-help.sh
> > index d3a0967e9d..0dbe6dd46f 100755
> > --- a/t/t0012-help.sh
> > +++ b/t/t0012-help.sh
> > @@ -160,6 +160,24 @@ test_expect_success 'git help --config-for-completion' '
> >       test_cmp human.munged vars
> >  '
> >
> > +test_expect_success 'git help --config-for-completion' '
> > +     file="$GIT_SOURCE_DIR/Documentation/config/add.adoc" &&
> > +     test_when_finished "git -C \"$GIT_SOURCE_DIR\" checkout -- Documentation/config/add.adoc" &&
> > +     cat <<-\EOF >>"$file" &&
> > +     aa*.b::
> > +     aa.b::
> > +     EOF
> > +     git help -c >human &&
> > +     grep -E \
> > +          -e "^[^.]+\.[^.]+$" \
> > +          -e "^[^.]+\.[^.]+\.[^.]+$" human |
> > +          sed -e "s/\*.*//" -e "s/<.*//" |
> > +          sort -u >human.munged &&
>
> Dedent "sed" and "sort" to the same level as "grep -E".
>
> > +     git help --config-for-completion >vars &&
> > +     test_cmp human.munged vars
> > +'
> > +
> >  test_expect_success 'git help --config-sections-for-completion' '
> >       git help -c >human &&
> >       grep -E \


had to drop this test, as it was working for a while locally on my
machine because i had manually
added the case in documentation then didn't make clean so the binary
had it. Unfortunately i wasn't
able to find a way that rebuilds config-list.h to test this, noticed
that this topic is actively being worked on
in https://lore.kernel.org/git/9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com/T/#me826da3b6a128e1ceb7215d64328b7d6aa2b211e
