Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A651D51E
	for <git@vger.kernel.org>; Wed, 22 May 2024 19:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716405613; cv=none; b=ttUJiSQSvu5wA6zDqSKv+Af6eolrtDLhyr9bKAFOceiWHvidnRwg8PWkUP/dOSothmTd3IP+GQG4EqVTNf/Nl+h5Zq70qQZbUMeYJxnI8hmGkud4UZm9jGWxHqxI4URoCLJxupVjwAsvoJXmxNp9q+7j4ByyNEWd/Bsd3KtZLgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716405613; c=relaxed/simple;
	bh=TwLS2NHRKj78D6+nq28MCgo+JRBpMKVoZRzZu6JDYFs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dXaGxpfjKJnxSsZlIuMRgvvQ5ErUCHcbNflFzaIIaHCOXQwZZJeCLFQYk8QIODcl2BtiIY7pfXkVAsnJmwOeDdg6xsC9RmG+njEoQ3LiqTsu1tdjPftV43PERWzfYc+psSbNpYniOO0VAbCsuIJ1GZWC2ZS+motgKL9gvJiDInY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df439e1056so1905881e0c.2
        for <git@vger.kernel.org>; Wed, 22 May 2024 12:20:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716405609; x=1717010409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eRSPmJN579TNYGI36R6AdwYNq4q1/7+WeINmKKDPuRg=;
        b=o2y5ks20LalqZ/r13IZEW3Ob0FK5+2NbqXnaIzfGZHmJsobl6CPQ94g/niRn8jw9Td
         QJhtwyPWMf5wBw0XFgxdd3tpr7LfRyAtvbtjcQEqvY1GXp04IrG0jos1Vlt5WsPG/btm
         mU1GbxMYw6RWkzz0GLs5oIMe+/xgfmqxRVEMR6Greg2xQosaq39oGwfY85nHGMqmXB6K
         VuXmxcQvMdHefXmigZvapGiqj48OjQCJk0l5x0n6m4H7plhi+WVDP4MCnQ0jGzl2ZHTC
         FDSKtnCfqokGhXCjSvybVWAUCcOhTMnGu7EvKzwBtqFVRaNpk2onqnDOb0c+PNtxAJx5
         Ifdw==
X-Forwarded-Encrypted: i=1; AJvYcCWwLvuAMp6RxBSZO8ZwECMaDxGCot6a2CXiDB5YKTuxcDUl+t7qkFRCSl473k+yAoK9xlgFrJqilPGECXMeOkKkGA9+
X-Gm-Message-State: AOJu0YzZx6eUtYVHu/1y4S4weNhd2mMMs/aferGvlSpdDPP8HghnNuvy
	a8YmgOuwQcrWlIJOLfB7xS7a0KI8Wx3MOxDCyYqx3jLFK6TiF8da2NgYjk60WTYZ6ZJkIf6o42i
	xtNQoQFqNBbw6hQNSNzpWMFUITvs=
X-Google-Smtp-Source: AGHT+IHmsEBf4mRNp8dxhr+ve/lKeFHNYUGRsqfwMjS1nh+RJZW3gKAggfM6DnyBJS2y0IgRn+k1C3i0xvoR9h184OY=
X-Received: by 2002:a05:6122:990:b0:4d8:79c1:2a21 with SMTP id
 71dfb90a1353d-4e2185243bamr3272634e0c.7.1716405609153; Wed, 22 May 2024
 12:20:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqpltd4rfu.fsf@gitster.g> <51e30846c62a1605dee8fd5b9d096222@manjaro.org>
In-Reply-To: <51e30846c62a1605dee8fd5b9d096222@manjaro.org>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 22 May 2024 15:19:58 -0400
Message-ID: <CAPig+cQ7bq8LKxnmjY3FQ9MRpM0GMep1Nxyp7jasB8yJvTV-RQ@mail.gmail.com>
Subject: Re: [PATCH] blame: do not mention obvious default configuration values
To: Dragan Simic <dsimic@manjaro.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 3:13=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
> On 2024-05-22 20:44, Junio C Hamano wrote:
> > diff --git a/Documentation/config/blame.txt
> > b/Documentation/config/blame.txt
> > @@ -1,6 +1,6 @@
> >  blame.blankBoundary::
> >       Show blank commit object name for boundary commits in
> > -     linkgit:git-blame[1]. This option defaults to false.
> > +     linkgit:git-blame[1].
> > @@ -14,11 +14,9 @@ blame.date::
>
> Frankly, I'd much rather see the same "If true, ..." twist [1]
> applied here, rather than just deleting the descriptions of the
> defaults.  To me, such an approach eliminates any doubts, while
> not stressing out the actual default value.

For what it's worth, when reviewing patches on this list, I have
multiple times asked submitters to mention the default value when
adding new documentation since it saves users the trouble of having to
discover the default either by experimentation or by reading the
source code. So, I see removal of mention of default values as a step
backward.
