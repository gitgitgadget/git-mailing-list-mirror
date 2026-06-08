Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 885803B388A
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 22:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958429; cv=pass; b=D8b+qCQCfVkdj1wPXKub4U9uNs881H4QvkKuwUF05D86djYyhNOUC0k34QjpRQ1DttS8v7HzJEgE9mrfmXjk8bC/MmE0D+62D5+u6HRBMLqgKW6ELg9fcWTceWuWy5dWHOiS7z1vsY/tQv1SOuz9JZy/DtTmGSZ5UD+sxBgVdzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958429; c=relaxed/simple;
	bh=Hp0xrHUT4tCCKyBD+cnD/j9RYr68k22PCltKIgYwrWY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H3HOffPfD/UTwe1S3Daxuf8nARgEzhikYXb44lwMYLK/eDONwtYkG1Y8dIti/BF2286Yp1aqrrg9gVN0jxs6gajLjQn2x4dJlK8pHEmyUaosAnCJnQdQnyUAc4aHnF8iLg3B7RfCR545d6rWcBMfAiEflPAq6T0tj5aAAP4T5JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EvtfOnVb; arc=pass smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvtfOnVb"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3967620ceabso46619661fa.0
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 15:40:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780958426; cv=none;
        d=google.com; s=arc-20240605;
        b=WJA68gXd0VsmkLiRSi0HchWAgtY2p63TewIpzb9FtmSmlym08T5jj0b310W1c/VK3p
         DhyS4XxmLIY874qrueDVG/o95Sfln/WEUI7lnSVZvfOZrs6lTbjIWayUMlOKeuAZbB3f
         8vpcAIUaK01RQzmjkYgkqJUIPi84jms5PEyXUnqHI8Q1r3JsEwxxpKYyUj90KwkEiv1k
         xh2NaPc+yMG5B9qfLszbpqA9VpGHyy1mx8pkRh71dHYVE0piVri8X34he0dTIF2CpAMj
         5P8kUcMkUvLo0wkBwI4ERpZcv2hREZALqb0Z5tffYDNHlyF/15wPIMIYeodAYFPtNnz9
         eOFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2l0w6ICj6LhxQmPKTpn1O2gSCoNZAmK7pZAmie9k1l0=;
        fh=R1bAlF5VdnvJt5/NXUejOLHVy+/9DwNUFwVCeF+KeWo=;
        b=JLPaYX/hTpBJQXSfuaw3v/eDjaWW/DyavrSiqDOo8WC5nybVNCBvVAsNhN65/oKJWG
         duQKe5/ZyZI3oqLoJz48OH96bcMC1oiAV252U5i2YRTcwJa2fSNXK1+tQSb+BkVrj6Cr
         er0E+UvnstKl/XSQnUyOJkqdjrcLuGVxCa9rFinw5OQ1k3k16DQpc1Mj4wEvjHCtxUQ5
         mnTca+xCoIXYB3j8SjphizFz/yLvR3HYAumkv0/qVCrh8gu7gTolMVBBYRqBwR4W5CT7
         JJarmTGRyIM8uudtI9mZ2Dy5N7xw2bORCkP5YEFtWCQNhsTXhcc8P39JCudwhHToOmMB
         0m7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780958426; x=1781563226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2l0w6ICj6LhxQmPKTpn1O2gSCoNZAmK7pZAmie9k1l0=;
        b=EvtfOnVb0YPOm9+es1Nyx1G1LvSQxjd0R2jlBzHHYBRWP20m/BAkS+TS/7jMlhi73W
         mvc4zYj9rWhNYop5ODEAfqP7h8Fvp2/Axa3wOS/i56DNjFGBVfsLEXiz6YOvHHdwTHmM
         VWNwxjtDMeb2x7j4c0sc8+NE4t1riJ/gUpM1YeR1Y0OTm/uh37s2zCEJaLDPGrOiFMWa
         dF97tmCuuefhuzSthGF5W/3vmi4l5Nm3ARO6C+rL+vmq0UYYsY17HxPE71nD7iM+6aw+
         ozrQl3sf3XHcUW0djCmSYaeISe0kh9yW7aPs/DpgsIOpcu1uoOt7TglbwHzWpi0X/VzU
         iwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780958426; x=1781563226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2l0w6ICj6LhxQmPKTpn1O2gSCoNZAmK7pZAmie9k1l0=;
        b=BLU07tgA+Y3e4zpp7++AL5/G/jQ7f42mBxckhTTVrCfXBpUzvcUK1/fxBWKLEGaPtx
         9rvjfW/8RzHf9pGn5lavpNa8uRhngccBdHI+dHCebcdoULHeT3zryOJcJqh30667wcT9
         I41zWhwz6G+H9vwhpnxeu0u1zl2zMdqfdlY9w6M/QlKefZiGg+xv82SpTWuXQ5M4bu8z
         PliIjRPtunFVQjgmjrfh/fGEJmnkqy8Ni6wv5q7NCt6HRicsE+0o89H8VxgzePn22MND
         1JFGw5Y+sB3g7Vwjg27zFy5FN1GacL4f6tBITAqz+bromUfyfWUrEU83IDopClYnzQg5
         53Eg==
X-Gm-Message-State: AOJu0Yy7+39SqsQOnor1vbdLdUEgKkQjKVWSOID7x6wtX8ThF7BkuLX5
	hRdFgeZRLfHE3hlF6K56AkRaJiIOhV2X2lA0oz5kGAMrvDItl6qJVB2OH1ORPM1o8wI6XAbMg9V
	pM7TvuL3Q+pTODF2DBQ+Pl5pUs0TwauQ=
X-Gm-Gg: Acq92OHMRM41MZONxv+iOUgdLw0T8l/eMuk1rWRDrez4gCKfWkICGai+e/tZqiPYdLH
	V5hIIrL7gkfkyy4Yh+DULAZTpmeCrpEs4uODsbsveUTBqXkuUxLhCVK+CI66JmmYNYhiXbOif6F
	OBUdhsSEjMimzH9lvFOxeddtGgzYFqMpGoVA9JChFL/Gy+xhLBphWcje5MbVp67KPY6wfsTtyQL
	lO+2R0djHtJ4Z1nnpLbuht9DZB8obL9cd/oz1eHvOKi4RvZpmtoE8IJLRiApy9mqds481q56nwP
	4Z/J8QfImNDV/Fg45oXBXnGEwI6zfTgOh8tIbWg4BbdVo0HQ5sKn1lrHQfITKTKU4FP4dEcqi11
	IEwOHyjFIPBXRa89fkghCC2sO/EyzG7g=
X-Received: by 2002:a05:651c:890:b0:38e:58c7:cca with SMTP id
 38308e7fff4ca-396d094cf1bmr45464391fa.13.1780958425467; Mon, 08 Jun 2026
 15:40:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com> <xmqqpl20vhni.fsf@gitster.g>
In-Reply-To: <xmqqpl20vhni.fsf@gitster.g>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 8 Jun 2026 18:39:48 -0400
X-Gm-Features: AVVi8Cep1KIgbv04H456enPc6FmYDQv1hDNOyCNK_YLEHKm0z306Z6LU6_j3m7U
Message-ID: <CAJ-ks9m9gq-=JB-gqeKaL4YOLSfrP2Cm0DytZjuC3OetG-UVbA@mail.gmail.com>
Subject: Re: [PATCH] ref-filter: restore prefix-scoped iteration
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Victoria Dye <vdye@github.com>, ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 8, 2026 at 2:36=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Tamir Duberstein <tamird@gmail.com> writes:
>
> > diff --git a/ref-filter.c b/ref-filter.c
> > index 1da4c0e60d..2388a57b39 100644
> > --- a/ref-filter.c
> > +++ b/ref-filter.c
> > @@ -3315,19 +3315,31 @@ static int do_filter_refs(struct ref_filter *fi=
lter, unsigned int type, refs_for
> >               prefix =3D "refs/tags/";
> >
> >       if (prefix) {
>
> Below, adding an extra call to get_main_ref_store(the_repository)
> makes one line unnecessarily split and harder to read.  How about
> doing
>
>                 struct ref_store *store =3D get_main_ref_store(the_reposi=
tory);
>
> upfront here, and then use that to replace these two calls of
> get_main_ref_store(the_repository)?

Yep, done in v2.

Thanks for the review!

By the way, how long should I wait before sending new versions of my
patches? I have 4 outstanding at the moment.
