Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8945945
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754957819; cv=none; b=s5tsC8iOm8breNBDCcZvMycagzccfcqMzjExDfUp7qEibpAshEwG+uJR1ClMcPa3NKmtrWTAJYfWIfLbnjjNIIN1kFHh3UiAfGdgD5rolD8rO+xUCM6B6EluuikLLAqrDIvwJkp9SDnwz2s79M1rn5yA8hBS5Yc1yuxMfGhdXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754957819; c=relaxed/simple;
	bh=T9eK69E2P9BhAOhp5gzQvtBXYTLdlarYCadt+3wyS64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lc4l0iJNn/CMVd2GpIdtxgn9z8d/jJZtkavcprfsBrVmzHaSzjbteHaLRuGhSz8OeUIXGQt1N1GkUn65iAWoCb/zDYl7Wh29Rv1hrUnflLeHMfhTZy5sqH1oOIKBMVBY0lBpikFHOXzvz+DQMFxMtc2qbUvYyjscR51br5WSrts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4b061c12155so7365361cf.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 17:16:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754957816; x=1755562616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PljHaIufpxXRIrPFo9nf7sBt4RD8jy0ZxMMi+/dyX0A=;
        b=dHb1Vma9D1BU4qH5bHGFodj5t7qNs+Eo4682BfQnqIaVlW3/rUWRaiK74ClC/RcO8G
         p/TUmbcZOUnJLb3rE5VC/+2GSZO1aNwlokrG/yQJiVRi8mpy59803qdy7sA7khbbo9+T
         9AzA+O7RfKVjVSdsPk4spRiksvl+FmRkXpbXFVysYDPGK3BTn3phpK0NwwV2yMHb96oI
         khvgwfco88hBMlqGTDaGfoaTl82RrQ9fwnsHV+otF2FSRYYOR3iPqT1s7Jeeia8mLhHI
         1+//+XLswfeQvVjYGHyuyxuDS9KByT6KTxEEnoXw7y0fxx1ve0JGL4uvp9De5L5ae4d8
         f5Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUHk+FjWLZMDe1iZc0WLqU68WtjNb1uhCFPFu5vzZoSE9qjXkcimygsRte9n+Q0uWJc94E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwskBUMJ9beJXsFXV6LrtbpArda/wZSSwzbKJFqokDXJsiReaAF
	QiiwXA4bp9caKumGgkxHl1UKsMCowv+ZR5cFxKikCKz4aeMODTe1aAn/hFktNcHS9sxEK6cBxof
	sW7k1KM+gltwEibhFZvHyMH6uOzS4lLY=
X-Gm-Gg: ASbGncvVr88XKq+jwhmuDabHnO5TM+VEiFjLBOxnZh7NqjfbUjn/fZdSqMoCfu7CE+T
	i1gBYPEN6YRGI63bIYc1DoXGq0yE5aQI+NigaP/f3FDBd0AjRgFXh5qVdJ3v8lgnGf1XxmhmOm1
	rvtwjSsn9vLAJxxjXbaOSKtuckgk7i2z7Yqcfq95mKfu8agXp+SEILhr1jVHYR4GBtzuS9r+73f
	BIQownaUHCBgDnXEFocNMkM7Zsez4p2WRRvC7s=
X-Google-Smtp-Source: AGHT+IEZTNMVpADYtvo2TVpcc31LbmgBxCI8R5+LLShqVRuy17/VWBsAu7rcXTMwBY639Ns9J6F7uVE9H9d+7hpCHW8=
X-Received: by 2002:ac8:5a8a:0:b0:48a:80e5:72be with SMTP id
 d75a77b69052e-4b0bebf823bmr84469571cf.2.1754957816388; Mon, 11 Aug 2025
 17:16:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250811221706.67168-1-ben.knoble+github@gmail.com> <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com>
In-Reply-To: <6BCA1E93-7409-41FA-81FB-0CB75A3A55FB@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Mon, 11 Aug 2025 20:16:45 -0400
X-Gm-Features: Ac12FXyKljVSpkTvs3yQ1Avc3Tc9PE_RmQHiT2UfKHcNSf3Zfd60HnSLQFo-qHM
Message-ID: <CAPig+cTpMFfg8iTncgekq6wyfHOPidhHposLi11D3fXyfnNQRw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] clean up some code around editors
To: Ben Knoble <ben.knoble@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 6:59=E2=80=AFPM Ben Knoble <ben.knoble@gmail.com> w=
rote:
> > Le 11 ao=C3=BBt 2025 =C3=A0 18:17, D. Ben Knoble <ben.knoble+github@gma=
il.com> a =C3=A9crit :
> > =EF=BB=BFChanges from v2:
> > - shuffle setup code and use more helpers in 1/4
> > - insert 2/4 to stop abusing --exec-path
> > - improve environment-cleansing idioms in {2 =3D> 3}/4
>
> Some of this shuffling turned out to be unportable, which CI caught (but =
running the test locally didn=E2=80=99t??). Fortunately it pointed me at te=
st_env and I=E2=80=99ll either use it or go back to the subshells.

To catch it locally, you can run:

    make test-lint-shell-syntax

in the "t" directory. Alternatively, `make test-lint`, `make test` or
`make prove` would also have caught the problem.
