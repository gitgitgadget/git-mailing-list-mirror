Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1CA3B8D5C
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 07:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780556850; cv=pass; b=esUzJEjlSe55EttnIuH8S0HPFJMSYQ1aglK4FAA3GOWkZVgD9Vce9A1Xi4oGhEqpY+gz3yu2SKMCIUUA28WZw5ynLuU+zhnLkWtyVrZciFLdzueZ1TgbPjIZiBWbcY4fiV27Bfvz3pl0DrJug7yOy2WdXPBpeJ5EWZoOpI9/7SM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780556850; c=relaxed/simple;
	bh=nThxfXP8YvwDHpkLu31BgA7xOzHaxu/ASiK0Xgf/Gss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QjI2oT+aix6PHX0VuwrmZDf8PT6/asj+H7+ODICm4dtxHTkCCSryAPaeQQhQPyaB06J53TZI40Bd727eH7A7sDbzZEsFtNSXeMpfr8q93NS49v/dsapN7VUmhT3NF2hz6YQvt8MCORJh26Ge7UObEGFwRts3XnwFaDpw0+s60c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWV6ZA1i; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWV6ZA1i"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-68b482888c3so2168526a12.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 00:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780556848; cv=none;
        d=google.com; s=arc-20240605;
        b=VUiaJjm4u/x91qZPTwvDPNvKMK9x0MKSHqkDvtGnWc8Y6VZ3RHN1RCzSahRG65pjc7
         9FfYCuoLBJjc2BQlRvKqq0FKqtQXx+hxUbWQvjtcetav2TFvuryTN2H6O3nmypmM2M+L
         NY82wIUDDZtKs5MlTdIQ85leXg3dBe+ovdn0DlZVcoiGKMIYjcd4VAWWUY7MEUcRMzTS
         /+gfkpWeGqoxp0S2FOArKLI/RhoCvK5t3GFtFszAm7PrNNtnSwwjUsqxV+8PhpYGJmIV
         fuOOgM4MO4qigpvmFFtPqZLWXJVQRUjov4Or7V6wIgbLHQJI4e+0X0lqNvixAhRX3EYP
         BH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=l72vxynMqWgqiAiYb13ZKixEv5PoxYZ5GB0VNpjOl28=;
        fh=4hUh9JY7xezPqTKOGUMx2v/2MYQM9QnRXBzY4g+0uOI=;
        b=DCUSFOH26uh8q2IJfpgGy7oUsH8KNc+gHThIdUOWgwKC/+861u0+Xw34OF71dWmssr
         6lk3YRxV4MB+izbhUidEnB54cEXVN2is+m86ES92qN1c+rSbqN4e1yWZe8lWykTydb0t
         zPcuAMhIbSIs2h6wP5GQLOzp3YLgMyN2c/CBspIG9q7eOjqmF0jR7h/nm/OIW/lowj3F
         8TH+oHa7tl+Za6ljBgI0S/D2oWRjgjToJvIEt4uYjbBZG7lFuZ5rAoSoinNMwOKkNX8m
         DX8cOCuU9vhYwbGZVaYfTk7c0LzcWwjhE2JpxZAZVuJ/9QY38Q18YBLhAcRAznSHZ2gI
         g0Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780556848; x=1781161648; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l72vxynMqWgqiAiYb13ZKixEv5PoxYZ5GB0VNpjOl28=;
        b=rWV6ZA1iTJFaC6d8YOChPJGchYIo3h2I7G1+WtYW7DC599Hy3Dgdc9AXXwXTuZQdwe
         axgy8M00VjIdsK145V+nMJ73JqlqURrzLxgXDGTb4OECFr5JgVKaPXnAnbdO7O+dS0z7
         eHWvgd+4AJqE8XWStgRUPf0g5h6HaOHRTZTps4qz5RyWS6PmSm5hQK2zMvi3ji7rwG4e
         lpU08gej9XJAs1pIv5ffm2mVWmOvUg28VNUbgUGGb/lpJ77plhjpCEDb7iy1CNTa6YBe
         v8/A8MZMRkRn3i88T0me6DvA6UgQ7DohOH0CGBMPhhxHE2z1fISvLsniSUdqQF15KL0K
         uepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780556848; x=1781161648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l72vxynMqWgqiAiYb13ZKixEv5PoxYZ5GB0VNpjOl28=;
        b=gOVeoUJfl0WJgHnsOXWqKCoL9NG4x3U9tTtWjcVb7iF7lro3xgbEAYX73T1wgY3Msm
         9H5JIheZS/y16wjJcBfal15PRnd5gZrnC59FxzDQqK6ioHSEZoA80lVDEjs6EEI4QwLi
         Ba4UtOfaxKD8cCu3o3HM8PrcGP2si0xSP8RSP7Q8ISZ2gEihuCorxOZsQXEhue+8F/Y8
         paDWFOTx/eQ3Lv1tbDGS1ZAjjGqMaY2+A9mYpZdq4fQKpMqza/H+ivgbfmSn6NwCngLw
         AA0BRVdMAjaVb1WFkJEf8wMylnnBo9NTckwtzgBSGyuwhJbxGrpHTxDtLplfpI0sODqN
         EB6A==
X-Forwarded-Encrypted: i=1; AFNElJ9c6sEK2piw92LTGcS3/UVTKKqUzGmrOPRkJtDkHvHFqi8jSRlJ3K0Q9yezjWEdoQAogIg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsoQh9v2GNhOUO2MVfVN65nFrs+RKsCMic3NmRZ7m+vcqtaq9k
	RS9g08ih37uXDGfUGDOpmTf1Sj5d8ES22sVCXW9M/pIZ1PN+vCwH2lYbRkUnTFYXtqp1j52rE9K
	RTFDLjTQRfnkMwU6HwjkP0/HW0K5CGvI=
X-Gm-Gg: Acq92OEQWR465C0aTAVdm0vR2XxhuouRORTvwFvYZ4iEuVoTFUX6D4DRzr3dvojgL17
	p889h+tgyW01TP0/tJujDGhRs+NLx1deIx0eXEtCyr/9ArhQknBJlvLiVJdwnpwTCkChxQ3/mjp
	oT643O9agp60Y7nZ3LTgsrIs0eZ4BmLI/1Pyhx4wpUlx4Wu0yzf+fHbaE6j1hv6f3uYuKdNliV8
	wBn+ZxFGPjBIh1VDHJiiwgnX9ghhOh0ICw7JjyNLDNAg8uUqYSO+d72v2s9cy++ZbrH6ofiZ782
	7rlAW9kpPdnHPkFCRA==
X-Received: by 2002:a17:907:180d:b0:bd5:1605:e1c3 with SMTP id
 a640c23a62f3a-bf1d159be66mr120387966b.1.1780556847613; Thu, 04 Jun 2026
 00:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2314.git.git.1780269406949.gitgitgadget@gmail.com> <xmqqik7zqh4p.fsf@gitster.g>
In-Reply-To: <xmqqik7zqh4p.fsf@gitster.g>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 4 Jun 2026 09:06:49 +0200
X-Gm-Features: AVHnY4IOtpVnJpl3Mke1pEKLEmIopAcA9m13hFntZYvHyUiyX9MLo9b3E1Oq3CE
Message-ID: <CAHwyqnV6uh_yyO9FcUiXKfKPt15ojR3GOmRC06pW55f=KRu=Zw@mail.gmail.com>
Subject: Re: [PATCH] Makefile: drop duplicate %.a from link recipes
To: Junio C Hamano <gitster@pobox.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 4, 2026 at 2:33=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
> > -     $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) $(filter %.a,$^) $(LIBS)
> > +     $(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.=
o,$^) $(LIBS)
>
> I think the reason why the pattern to use only the .o files among
> the prerequisites and then use only the .a files among the same
> prerequisites (both filters $^) is used here is to make sure that the
> linker sees object files first before library archives, so that by
> the time its left-to-right scan sees the first library archive, all
> the missing symbols in the object files are known.  The above change
> depends on LIBS being a strict superset of all the library archive
> files ($GITLIBS in the current code, but that can be updated in the
> future) listed as prerequisites for the rule, but there is nothing to
> guarantee that, so it looks brittle.
>
> Exact same comment applies to the other two rules touched by this patch.

Hmm, there are other constructs like this that rely on $(LIBS) being a
superset of the archives, so the three rules changed here align with
the trend rather than introduce a new trend.

Not saying we shouldn't find a way to handle the overall brittleness.


Harald
