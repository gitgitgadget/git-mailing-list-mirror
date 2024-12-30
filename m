Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E940BF5
	for <git@vger.kernel.org>; Mon, 30 Dec 2024 03:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735527788; cv=none; b=Qzc7XDGk8nyV5pKPBIjs8b/7pEpB5DXlyG5/Gw6jQgwHDDufYRG73Od/AzKCp9qwyU5TlfCrwxvD+xkdVL53O3O2Ig6u7QcCWACNInAZppHSyPjD/W1C2Fj7bC1QXU/AsssjlnDvxY6Uvmkata1qN8a63XYXvJg9TEuImhYr3mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735527788; c=relaxed/simple;
	bh=gbxaNfDWAXP1T3uy20TBstp+SPwi1VqXd7G7Eaj2ZDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pjju0Nkc8lC9qXJpJOKMr5a8Iz9Fk85H6GUmknQLZQoMJANsCZ4WV5eEVbD73mXhG0j1FigxaEC+FsRc8DbKNgQXnrZgYGEv+8DJeduHt3Kqq3y6Vrx4RuBwAwmAOak5Wc7hD288T4MyzDT7t37vF7vQR/lvbmmDECFDavg7TzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bed6V5lL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bed6V5lL"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e460717039fso10053166276.0
        for <git@vger.kernel.org>; Sun, 29 Dec 2024 19:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735527786; x=1736132586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oHac6aCs3LOlQ749Yu1vDjOEDQXx504ZVBoPLWmhUs=;
        b=bed6V5lLNg77IZCPqsSbXF1+mheAauD1Kl3Gg4h2QATb6mqOXTMVdjXghTDNsBz90W
         LtgWmD2XgPeh/0G5QAxJoJsFdi6yOOCNGTWVdZdCl5w/kBYRLCEJBWMNRCdMXFmfm1Tw
         ZBR8sO7lKpoJCWkwJ/b9fH0cD54jQ9uFbmICb3SZAh2dNWZ9Zfxd6M+IYCpENo60NxQt
         0MFf/csUJVbKTZ/OiPot5A72MA7IfCY6QYDFTNerkTBH0MiON6GgY+MgcNtQvfG0rXZA
         653sjUKBSFKlj5ZMwLybjZlmiTYyrtGt46RBd/+dAaqti3OkBrIlBs3vqp4RQ6AMZi9i
         RhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735527786; x=1736132586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oHac6aCs3LOlQ749Yu1vDjOEDQXx504ZVBoPLWmhUs=;
        b=qqyxbccyBG74yIdeXt2O1Rez0FWpZVz8PSsN3+XabF7h7XCvmjHKTyZB++0S8Ycdu+
         MHVHmbLVxnAeOr675FxUpNxe/yqQMQ8LRtYhKxTXn9hj1zeNwQjdbRaqN1wSc8clW9f4
         gzaaAZFBJFQZJhAlSI6fpbSoXBf2Q3XinOqaAtKJuolhPsQugmaiE2uP4/IKIcvpG2P9
         n1+sigjA42jSlRv/D79WbBGmnitBvfeK7IQpDlDT29spLW86/Zu0FLQfA1qcw+8upMg2
         rIemZoP84H6MoNU6Su8U9ZQdlbNxXylm9uNQVq3+V1DQWVDoMxOJBzwfKLT1lXuyciJX
         4hqg==
X-Forwarded-Encrypted: i=1; AJvYcCXiar0CrK8Ib1qrnoO4L19u9BNtlGoAvd7McDp4+QpZwcjgvhdAKH1UewMMXrEH1G3aYU4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfapRLrNOhVU8Onyd/t7EDNXFp71ff7kQqSzTyo7LxuZJ87ISd
	W0XgWJr1SAi5vZk2A1wz8zLERynkbpNScnHHuPlcNd86ZzFThcKbEWakPCJqgaJlnmggjBkc42E
	cEE/R6Pw0sD0tAgDftuB/AjBgThtylD02
X-Gm-Gg: ASbGnctcKYFfrNYwKjH4EaxQF5nzrE0AzwIWalj5Pi0y4OLXs6Ji21GIA/4vsWsYLIh
	M6JA0X8cwKZUH+WrQxXyg1iBYx/IwFy1dF/qPA44=
X-Google-Smtp-Source: AGHT+IFdOvJAwvCgHj0n+SX5AeWtuz4bxyJvsOaAEumAEwT7yZXoi7P6//BUC+ehHt0CTteC1KHessKh+qowAiHz2vg=
X-Received: by 2002:a05:690c:6005:b0:6e2:ada7:ab3e with SMTP id
 00721157ae682-6f3f821a3femr226288697b3.30.1735527786032; Sun, 29 Dec 2024
 19:03:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqjzhm7jgl.fsf@gitster.g> <20241228114221.10351-4-ash@kambanaria.org>
 <xmqqy0zz3fxv.fsf@gitster.g> <CAP6f5MkYL8PgRyf_paCYxL-LE5nUa2U1GQMsu2scLzJPSS=9Ag@mail.gmail.com>
In-Reply-To: <CAP6f5MkYL8PgRyf_paCYxL-LE5nUa2U1GQMsu2scLzJPSS=9Ag@mail.gmail.com>
From: Jiang Xin <worldhello.net@gmail.com>
Date: Mon, 30 Dec 2024 11:02:55 +0800
Message-ID: <CANYiYbE+4AsbKjCjEJj+MjA7vxfSW4XWbYZrNaobnp6=TsboPg@mail.gmail.com>
Subject: Re: [PATCH 4 1/1] parse-options: localize mark-up of placeholder text
 in the short help
To: Alexander Shopov <ash@kambanaria.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 29, 2024 at 1:12=E2=80=AFAM Alexander Shopov <ash@kambanaria.or=
g> wrote:
>
> Thanks a lot for applying and especially for the  feedback.
>
> > you have to fight the tool to have them produce "[PATCH 4 1/1]"
> The command I used was
> git format-patch ... --subject-prefix 'PATCH 4' ...
> I guess I should use --subject-prefix 'PATCH v4' unless there is some oth=
er trick I am missing.

You should use "git format-patch --thread -v4" or "--reroll-count=3D4" inst=
ead.

--
Jiang Xin
