Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493DA1429E
	for <git@vger.kernel.org>; Thu, 25 Apr 2024 02:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714011340; cv=none; b=U0nUqHHPvdtPmK3hS2tuviWxvMEg6C1KTZEGtPuVhbBRR6V5SKWVTFtJ9/sgYYMkHL1gdGhSZ4PFAnBPhlu7sAsbxfYec3clxLasQrJrwYXJUe9gZsVA5trPRe9YcIK/fxV62ua3gYl2+GIgA6c4C6W6sj98adDU6J6hZKV8LF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714011340; c=relaxed/simple;
	bh=++AEc3SpR8lPjiZxXN6uI4Q6QuQ8pHWxzGGbA/0AYwY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SkC51GvY4Qnmsbbkl+xj7I9UtgLn5lramkptK7S9fh6dTEH4Q4Eks+98w5978zaaATyvS1lOUnoOKvK6RNgPREns1UCIM92EwAISIX/1J+qvY0evl1eSnfXCfTA09jj+m55PcjaChdd3a7hi5xUz9yUURuUIArg9/5KUw5JnKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78f056f928eso30903685a.0
        for <git@vger.kernel.org>; Wed, 24 Apr 2024 19:15:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714011337; x=1714616137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIJVS1RKvrcjt/gVVr1nOZqCiIYoj7DxJd5Kiy5kJ6s=;
        b=r+Ao+CYfb/hRhBctwdCQhzpPlyYkN95noaoZ33OkXv4AgLmw73A7l18YN+5myq7QuU
         9MwRSg4/MtT9r0lkQiYffxTRACvwoyh6vs5fNUVS5A8CQSz9jT1wDnwKq8xp50t8emab
         qFKmQP4RvtdUJpxZ0kZDwb0RXkTx0kxj+/PI+XDPJIPtN5wYT8FTbKU6j/+ot4Rutrev
         o5sgUy/VyDIZzDCZXZw3LDW4Lpvnw3stu4988MfbZHCu4XElb5TZuCwAek9/qenYjVzO
         GqUsavowEdgMh+GjHRn8Aw4oityPQsr7F9XN3WHnGbTpjqpIvsumoLlby4e6Fh5A0voD
         QcaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUE8MCxfYLHdhCSekLgx6M0Wp5sDpdvTCpnKc7kyp/vQ6EpgumJujcEFstygf9jemcCW111bwVKQEQbb36DZFwNUj2S
X-Gm-Message-State: AOJu0YxygNsEqlW/GdHTsxmNo88OShOtuIjN9EVJM0mPsCAy55junRXz
	YNeYZ7Juy7x3bosiXDazaZkPCyY9YJPhZDrJ8ieiMG5IKv3u4FTJyMDiiS5e6N8kFcMt0NnLqwQ
	vylGP0gpjPUzvFew8NW5J1+hxsjo=
X-Google-Smtp-Source: AGHT+IEOtWhjG2m3yZPlaiDo4ol6rjxSqgyo5TY8hen5IVq90W6u3DAkzhJWlQYmi4nuCbOMhNfclcm2BM5H8uOdrCk=
X-Received: by 2002:a05:6214:4245:b0:69f:f2ae:cad6 with SMTP id
 ne5-20020a056214424500b0069ff2aecad6mr4657097qvb.11.1714011337137; Wed, 24
 Apr 2024 19:15:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4e2bc660-ee33-4641-aca5-783d0cefcd23@gmail.com>
 <6d421c67-9e10-4a7b-9782-38ba8e9da915@gmail.com> <db1d540f-30ae-4d4c-883b-088bcfe68140@gmail.com>
 <b209a2b8-f98f-4f14-a687-9022d30968dd@gmail.com> <20240425014432.GA1768914@coredump.intra.peff.net>
In-Reply-To: <20240425014432.GA1768914@coredump.intra.peff.net>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 24 Apr 2024 22:15:25 -0400
Message-ID: <CAPig+cST4_hUwWg+P_drqT-mv8+eLAzBmuMFXm=Dui14kfYZzA@mail.gmail.com>
Subject: Re: [PATCH v4] add-patch: response to unknown command
To: Jeff King <peff@peff.net>
Cc: =?UTF-8?B?UnViw6luIEp1c3Rv?= <rjusto@gmail.com>, 
	Git List <git@vger.kernel.org>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 9:44=E2=80=AFPM Jeff King <peff@peff.net> wrote:
> On Sun, Apr 21, 2024 at 11:52:33PM +0200, Rub=C3=A9n Justo wrote:
> > +test_expect_success 'unknown command' '
> > +     test_when_finished "git reset --hard; rm -f command" &&
> > +     echo W >command &&
> > +     git add -N command &&
> > +     git diff command >expect &&
> > +     cat >>expect <<-EOF &&
> > +     (1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command ${SQ}W${S=
Q} (use ${SQ}?${SQ} for help)
> > +     (1/1) Stage addition [y,n,q,a,d,e,p,?]?$SP
> > +     EOF
> > +     git add -p -- command <command >actual 2>&1 &&
> > +     test_cmp expect actual
> > +'
>
> I got a test failure on Windows CI from this. The test_cmp output looks
> like this:
>
>   -(1/1) Stage addition [y,n,q,a,d,e,p,?]? Unknown command 'W' (use '?' f=
or help)
>   -(1/1) Stage addition [y,n,q,a,d,e,p,?]?
>   +(1/1) Stage addition [y,n,q,a,d,e,p,?]? (1/1) Stage addition [y,n,q,a,=
d,e,p,?]?
>   +Unknown command 'W' (use '?' for help)
>
> which makes me suspect a race. Perhaps because the prompt is going to
> stdout, but the "Unknown command" message goes to stderr? Maybe we
> should keep stdout and stderr separate and check them independently.

That's very reminiscent of [1]. Although, unlike [1], the output
presented to the user in this case is (I suppose) less likely to be
messed up; only the combined captured output is probably affected. So,
capturing stdout and stderr separately would indeed be a good idea.

[1]: https://lore.kernel.org/git/CAPig+cTGq-10ZTBts2LXRVdPMf2vNMX8HTuhg_+ZH=
SiLX-brOQ@mail.gmail.com/
