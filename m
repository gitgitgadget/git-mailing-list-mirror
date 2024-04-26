Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7BD4685
	for <git@vger.kernel.org>; Fri, 26 Apr 2024 14:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714143129; cv=none; b=c0/1N8n7tV1OTzLOdO7yIujEBb2wWVf3P3UxomVCmlWQOq4VWzzMuFDaDCjWUJoCu+jYUZ0wI3mTLiPOClOOZBTRlBXoCbe6/dBbrrIrQ5pqEv5nSOKQHVypPK6tlbRPdiIF+kG7Mz2QMfxEJyPO97+HMI+dNT/18Q41IsrZ4nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714143129; c=relaxed/simple;
	bh=yqzmbLi3Gr99xo4NtyH1mNbHn2OtLLUuBe8xkPNI0gc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZsuXWNHn+oHW7pQdbfv4PzxLJFZxGbNK+QOJbM1ihrX6j718NgOEsyJqbBqJhRo4rjscUnql/QVGZ09CVzo9tWZ3L/TVhpizv3mVu9tJdYjaZ30+5ZhMYaD48tbr8jpbw8SL/Hnuq0S6IN+FlqD/tQ3BiXdKkp4WuldF7qHzy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jnlhXFjF; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jnlhXFjF"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a58bd410f92so242623866b.0
        for <git@vger.kernel.org>; Fri, 26 Apr 2024 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714143126; x=1714747926; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K1u9FjIsJe7DkH2WXzXNBXDUcn9BX0YNzffB3ZUriUo=;
        b=jnlhXFjF9+lvKN1zQbnKB75v0uPT8XgwDVbWsewnI34c8bsZTWwQyByhxZ2MImKMSp
         yLc2fN8slTEV3TZCZrF5EE/bZg/PkMQl/1aLa+TUIvjmjwrU3NHqR7gCMGLoea3hvRTT
         eyT5/9Ht4p8TZHRflQiMX89w0BCTMv3UlqM73i1MFuluFcnQAog51TX6rfSBCk1XkCIo
         iCfVwBurGys42UrwgjuW1xihWWsUCR4tpwwCOrqHtjKm5AEGTPnx0VwDGPxgp3+xwhwJ
         PccVXec4cnhokl6eVlB1OK21D2xq75TTXnYcWwPBfLtJ/U2x27nkyp1Ca1nN0UlC5O3L
         5+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714143126; x=1714747926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1u9FjIsJe7DkH2WXzXNBXDUcn9BX0YNzffB3ZUriUo=;
        b=c8zv6CMVhIMiAg34M2ShbV816RsF0ElAMv6KrgxmQz8Cj3Uv5eJ3N0+BgC/laqDIlr
         AmT3PQTDoz0hX/Ewlihe1d0isx5bfrrLwHn1Srtq71450R4id5ykdDvYHJ36tuaEejG9
         z/jjQseNnY30APrMKQwA33QlIfrzSlZTo/oM3wCsm9bdHRy0Ou6FEqiB8RHdqeEHYDpg
         ECeit/mMImeevkkDp6RxAC3XNraXNPrLkNid7lo1NGasFt8sU8pKv/6HVHpj5CNzDyml
         erbCSPF1QKrEZGdgTGUan9unErxaME2DaLQUniBla4o92sKSq0sQQXCochBLdWiVjVDl
         DMwQ==
X-Gm-Message-State: AOJu0Yyf7od03KnVEXk+n7F4P9DmeikEVvpv5C3Cs/tVTA82X1lpsLZi
	t3hvdrJOlwF5FQlVeKM8TiuE6iW0pPEz+3pvHI24MBxIVFEf/zDagMin+Q7fibeKI0dHsMxgGfz
	kvIVwN7aDbScsriynBUqBFk1YtxQ=
X-Google-Smtp-Source: AGHT+IG0uktGTvMldOXMN4cTDglGGBsPZ3m2BjuT+UgymZI5Zul/unv3S/vUK8yAcxgVuud6cALONCWzBtXXDLHAIfU=
X-Received: by 2002:a17:906:370e:b0:a51:d522:13d5 with SMTP id
 d14-20020a170906370e00b00a51d52213d5mr1968885ejc.40.1714143126220; Fri, 26
 Apr 2024 07:52:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1696.v2.git.1713504153.gitgitgadget@gmail.com>
 <pull.1696.v3.git.1714091170.gitgitgadget@gmail.com> <4ad0fbbb33cab9d5841689cc5660befe6921d515.1714091170.git.gitgitgadget@gmail.com>
In-Reply-To: <4ad0fbbb33cab9d5841689cc5660befe6921d515.1714091170.git.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 26 Apr 2024 16:51:54 +0200
Message-ID: <CAP8UFD0ZHpo7US6dx_WK6F_1JYsBdHunBaW86qM1CzOKaPC-aA@mail.gmail.com>
Subject: Re: [PATCH v3 02/10] trailer: add unit tests for trailer iterator
To: Linus Arver via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>, 
	Josh Steadmon <steadmon@google.com>, "Randall S. Becker" <rsbecker@nexbridge.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Linus Arver <linus@ucla.edu>, Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 2:26=E2=80=AFAM Linus Arver via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Linus Arver <linusa@google.com>
>
> Test the number of trailers found by the iterator (to be more precise,
> the parsing mechanism which the iterator just walks over) when given
> some some arbitrary log message.

s/some some/some/

> We test the iterator because it is a public interface function exposed
> by the trailer API (we generally don't want to test internal
> implementation details which are, unlike the API, subject to drastic
> changes).
>
> Signed-off-by: Linus Arver <linusa@google.com>


> +static void run_t_trailer_iterator(void)
> +{
> +       static struct test_cases {
> +               const char *name;
> +               const char *msg;
> +               size_t num_expected_trailers;
> +       } tc[] =3D {

...

> +       };
> +
> +       for (int i =3D 0; i < sizeof(tc) / sizeof(tc[0]); i++) {
> +               TEST(t_trailer_iterator(tc[i].msg,
> +                                       tc[i].num_expected_trailers),
> +                    "%s", tc[i].name);

Nit: the members of struct test_cases are used in the (msg,
num_expected_trailers, name) order, while they are declared in the
(name, msg, num_expected_trailers) order. I think it would make it a
bit easier to use in struct test_cases the same order in which they
are used in the TEST() macro.

> +       }
> +}
> +
> +int cmd_main(int argc, const char **argv)
> +{
> +       run_t_trailer_iterator();
> +       return test_done();
> +}

LGTM otherwise.
