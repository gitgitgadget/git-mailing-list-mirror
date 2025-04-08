Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887CC15855E
	for <git@vger.kernel.org>; Tue,  8 Apr 2025 21:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744147733; cv=none; b=LvaZPfu12UVYaYpynfasnwG9wpx5pRWhCjMJI0cDbiz1fbV5RXcrmUUE5t5xuSvI+Bv3PkZHQ3AbWQ63lxwQGtFHdoqP3+F9xwl/jby1/ZBmGWWIl4X8ui38b12Ln/x9giN+uReN7vi66HFoGDWitoqCsjgHn69SVSjlR7mZHbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744147733; c=relaxed/simple;
	bh=VvnZ9PMZyBSlYnBlRYrjePpKDLJ1KtBL9WOzpjg23KI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O5GT9H9jp8Lq6OCS/2AbUSConz7WYFCuWC1IM+m1YtcA1OP/BU2uhnYq80mn45guwGvdvSMUT3HmBE5I83glllkOSE3WyDdcdBroIUWs0B8crezN/RMHXFkw9qj4AonLlFcA+6CFkjJ6dbpJx5sO3g4gUbc/jDQB/9c+QTcorSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6e8fa2d467fso8913986d6.2
        for <git@vger.kernel.org>; Tue, 08 Apr 2025 14:28:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744147730; x=1744752530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1bkahJqCY4z840/dlix/bi2YE5uBpc9oPY3CCmjSiOM=;
        b=YSWaMEDBQo/QbRUkUIOt0zUaDNpgZQJ1w2CbWPAnzMoqPJ0J09l3XhRo+DlPMB2EL8
         wZ4L+CkkID92T3FedEjNClJkhtk7gVl6tE2z5h5Kwe5TwpUggUnDey7NdY4w3jFq1Avg
         t2iMjb6Iz5WrKRr1lXcRvrQSSQbCpUSlArymxVLjyyqsGZFoOXtpUDjGWJn1oZ+afouy
         ajLecglTXdApRuvmxT5k9vYv4HlT+npFsDsB8S5UDmj7AoKNYGs6Hzu7qPntDYHsNK7s
         SyN8lHFzltF3i4M2yAzPcc1GYo9OEuz3HTqx+zJLbeqUK7nAc/T31s82P+vuVko7Lrm7
         eDRw==
X-Forwarded-Encrypted: i=1; AJvYcCXitlEhkxkNGW3C6pKcfbxmb449U4IEuoeKjqMdm+PpG73mllTUJZIsF2YUDonQCjGeUVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfYzt7QB5GsD7wmRlfL1Z+2ooTtIqaUl2WY95D4KPT3BeSCbMB
	6qdx7R7kfciY1KeRpk5MC/gSabUtI+a2Drs4nKgYb2czN5pUu/ad860SCZQn7RLU5i+CVmO4g1i
	qkHM14oq5bCIG7FzjVLsn4FizvDc=
X-Gm-Gg: ASbGncspzyiUYKQJiAiJhKm/l0d7/YwdDXblQItvZhbzkHNnU2z/FkU7kuSfqJrXMhL
	CS/bzjN72//KlOG8q1vBbysJHBWbDcyv1gzUX6mbcAf4fZ749R/WCT65gbu8/3STCsf2NbRfzh/
	s2MH8uOoFyFHnf7Y8YQ+Gmwyaq2RduL1FkLsVOO/TTzWN4pRN8NCcYJOUq+j7Pk0oEML7FPw==
X-Google-Smtp-Source: AGHT+IGHAf5f4X8mTxy053SSjpHkyvxVnK19Ge97ts3qUfsauvUSt7ZOT2ZrHRJnbIJbIrYCUjpk77WwVb1mTjI9KoE=
X-Received: by 2002:ad4:5767:0:b0:6e6:62fb:3504 with SMTP id
 6a1803df08f44-6f0dd120778mr297996d6.8.1744147730122; Tue, 08 Apr 2025
 14:28:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250405103718.25160-1-anthonywang03@icloud.com>
 <20250408114841.58592-1-anthonywang03@icloud.com> <20250408114841.58592-2-anthonywang03@icloud.com>
 <xmqqbjt6wdrk.fsf@gitster.g>
In-Reply-To: <xmqqbjt6wdrk.fsf@gitster.g>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Tue, 8 Apr 2025 17:28:38 -0400
X-Gm-Features: ATxdqUHol9wCq4Un_rf0JFk6Vd5vcMB-nuKBkcV2eu9ikHgvCtMDpLvAUh2jJw8
Message-ID: <CAPig+cSo2hPpA0DOn7Tr3pcYfN6jxyyo+n0Y0QetvKvNVoLqbA@mail.gmail.com>
Subject: Re: [GSoC] [PATCH v5 1/1] t9811: Improve test coverage and clarity
To: Junio C Hamano <gitster@pobox.com>
Cc: Anthony Wang <anthonywang513@gmail.com>, git@vger.kernel.org, ps@pks.im, 
	karthik.188@gmail.com, shejialuo@gmail.com, christian.couder@gmail.com, 
	shyamthakkar001@gmail.com, Anthony Wang <anthonywang03@icloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 8, 2025 at 5:21=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>     t9811: be more precise to check tag creation
>
>     The tests grep tagnames they expect to exist from "git tag"

s/tagnames/tag names/ perhaps?

>     output, which can be fooled by false positive if an unexpected
>     tag whose name has the expected tagname as its substring.  Fix
>     them by using "git show-ref --verify" instead.
>
>     While we are at it, add a negative test to verify that a tag
>     that is involved in earlier tests that is not supposed to appear
>     in the result does indeed not appear in the resulting
>     repository.
>
>     Incidentally, this would also correct the problem the original
>     had, which lost the exit status of "git tag" that was placed
>     upstream of a pipe.
>
> or something, perhaps?

Yes, better and much more illuminating.

> > -             git tag | grep TAG_F1 &&
> > -             git tag | grep -q TAG_F1_1 &&
> > -             git tag | grep -q TAG_F1_2 &&
> > +             git tag &&
> > +             git show-ref --verify refs/tags/TAG_F1_1 &&
> > +             git show-ref --verify refs/tags/TAG_F1_2 &&
> > +             test_must_fail git show-ref --verify refs/tags/TAG_F1_ONL=
Y &&

Do we still need the standalone `git tag` invocation above?

> > @@ -208,7 +209,7 @@ test_expect_success 'use git config to enable impor=
t/export of tags' '
> >               git p4 submit --verbose &&
> >               git tag &&
> > -             git tag | grep TAG_F1_1
> > +             git show-ref --verify refs/tags/TAG_F1_1 &&

Similarly, it's not clear why there is a standalone `git tag`
invocation here. Does it buy us anything or am I missing something
obvious? The originating commit[*] doesn't explain its purpose.

[*] e71f6a53e2 (git p4: add test for tag import/export enabled via
config, 2012-05-11)
