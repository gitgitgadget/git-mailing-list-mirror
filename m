Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20334280CE8
	for <git@vger.kernel.org>; Fri, 11 Apr 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744406967; cv=none; b=Oxe+eWp+RNa4m4L2gHUyTixW9siHcrXR0KYiSp5a+SENbOQboYqtY1alONA2kkVlrXxf09WeTFCAptyh5UMRr01/1/9WcVnHDMMsTdV4ZPbmfDaX/p+XYg+UR1r5/9OJn3uOdWIfz/w2qxpiXoVV448eAIyGioDscwikwjQEra0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744406967; c=relaxed/simple;
	bh=JUdaIGVvM387Z2xhDYYtzF+1dyqhlpOxyFwTiG9ZAKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IitnhrhNilTO6RD6n+osCl0YG0A6GXsmyHORwox5y1Kqjb23nxSblEm16yznJFUEJ6jb7YU/vE0gwfPhBZcE4In7Df2p0VP5lWCYHQiV1VrpYz58jOlkK4RBe1h8Sgc5C+QdByT3OtbNY+l2HbpM9EWjnYagOp344eAYUAFOm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c5f20d512fso40414585a.2
        for <git@vger.kernel.org>; Fri, 11 Apr 2025 14:29:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744406964; x=1745011764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JUdaIGVvM387Z2xhDYYtzF+1dyqhlpOxyFwTiG9ZAKI=;
        b=MUIbAOzZx9BnC9Zq67NB0AQeKCyJcO9rvI9q9EDm2KQLckWHk9OI7EsMZdK97SIM1l
         BpuEuO1aiXjf8WP8y8VGjZ49csxTT3NNNv66kZNYuf8NCCRiHx4/ZX1JsdX1AOcaA+F1
         YULKKYVhE+SiaVsVlG8WVZdAvkPEnlXbyX6mu7SZdT7jzaDI5Gu4nakkONEBR0E4Drxm
         j+qIeaaxs4D5D8hPvRlr8veGkZezLmi38trY/p/ykpxinN6QuLlxzCtFbXI95aG20lNT
         a6M6dCptUzfXeeCm48KxCA999Jh4gNFepF0zQlnSJpgiidjiumUEjulGKNHnoGg+I6Zv
         8k3g==
X-Forwarded-Encrypted: i=1; AJvYcCWx3Mxr6r0tC4C2trxCl1GevLYQGgEGL4/Cre/g91/wsPeCKhNp25wFHBFt2eHrisAc29Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0oNY35LXST7hUedhBsIJxchxyj+NAHSW1tFy/vOgyuMqdl9I5
	EPPs1gzwYzatBciH/w/JeHQNTfwJFZ8MIrPw3sDKya5MZ7OAoSMKCEcKdNc9RR+dKdzUyveaE21
	Sb5/4OlavBfIybNMK5cL2N9pKuLw=
X-Gm-Gg: ASbGnctod6bbStXo+mtQHqKJWjG2h7GbAQl2ez25vgnp85qFrfV1U7uxenDlplMH9c0
	TyQwf/7LIb6VUZ/KYlpkwGG4sLibdwK0tB0Jdr/PENiclyoyg54ufqAS1QEBynv39Dc34BZUIfL
	PNzuQ1zzuMHFBGaT4AiDq7LwAhFZ+/1KjxdUQKEh1JJZyWDDxhJknqoDc=
X-Google-Smtp-Source: AGHT+IHWaLK2j05EnAb8is/KTWzLW6bPVGW+ghtTHBo7qepjV7/34BO8C/NW/dE569hE2MQfzhkOBNSuVf802jwDts0=
X-Received: by 2002:a05:620a:2456:b0:7c5:8f40:3316 with SMTP id
 af79cd13be357-7c7af0d848dmr240314785a.6.1744406964049; Fri, 11 Apr 2025
 14:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250411-pks-split-object-file-v2-0-2bea0c9033ae@pks.im>
 <20250411-pks-split-object-file-v2-1-2bea0c9033ae@pks.im> <xmqq5xjampdc.fsf@gitster.g>
In-Reply-To: <xmqq5xjampdc.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 11 Apr 2025 17:29:13 -0400
X-Gm-Features: ATxdqUFk52Lp1UEVYbiuw5_HukULUKmtrE9fYpxsr0Uur0hzccCHHoX2uylbeWc
Message-ID: <CAPig+cQ5AEwTaK2LYkV39yrZppnF_MMMnB2V0nTGWZ-PcptVYA@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] object-file: move `safe_create_leading_directories()`
 into "dir.c"
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 4:10=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > The `safe_create_leading_directories()` function and its relatives are
> > located in "object-file.c", which is not a good fit as they provide
> > generic functionality not related to objects at all. Move them into
> > "dir.c".
>
> It may be debatable that <dir.c>, which has traditionally been a
> collection of read-only operations (mostly for exclude/ignore
> processing), is a good place to host "mkdir -p", but it certainly is
> better than having it in <object-file.c>

I probably would have expected safe_create_leading_directories() to be
moved to "path.[hc]" which already houses functions such as
safe_create_dir(), normalize_path_copy(), ends_with_path_components(),
longest_ancestor_length(), etc.
