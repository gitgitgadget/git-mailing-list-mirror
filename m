Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743C19D080
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729602306; cv=none; b=By+EA++X0VdZSQURsLYP/4EXnBNYTsbAJA9xmFlj99jJBkWs8y+RwnZRIvItRIMjZQ9uiXY0zlMd8MobQEDVEfIPlHf+G0zw4pyb784aGjDKcLGRvL2uacTeXpwkGyL3qceBZDvU5uJsdYGVzziWiWSKL3UNzkxvfafCkcUPOnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729602306; c=relaxed/simple;
	bh=6xLa0yiB59fCnNMe+iz393gqK9xXj0FaAAa2IHBQkA8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MZtLUvJCj5tKy00JxF4rXt4ORXn8nMxaFYfzDRb60BGzSfAciReZa/suqrRUNtZVC+d3AZxbC+iK+SRmwmnzCbSUF2HqMenYLjsct2/JHRSPPdGaluQejrzVutifgx0WTEbciB7Df3S1XU6FTwNNnkiUB3DbWBIIACx8cf/k1HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk; spf=none smtp.mailfrom=fireburn.co.uk; dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b=aObtVWR6; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=fireburn.co.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fireburn-co-uk.20230601.gappssmtp.com header.i=@fireburn-co-uk.20230601.gappssmtp.com header.b="aObtVWR6"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-7ea12e0dc7aso3548598a12.3
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 06:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fireburn-co-uk.20230601.gappssmtp.com; s=20230601; t=1729602303; x=1730207103; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=mXTj9yWy0CzYHAvm9Oi9r/rO7BKaQjPq8ULqxQVQmwY=;
        b=aObtVWR6AfYAitFS8qjq8I7FAyrkwjmDtVQ8D8MO5ky2H/DS4GwIOliCsfC2ViCgDJ
         wrfbaSxi75YDXKZ8HBRERaS9mOl1FnT5f+lgfHwZ17onujpkq1fUJwadUflewSJUcinE
         q6FZdPlyIYlOPGPzCZmEC2Bh1BOeR/IOn8vVq19dQdLqU/syCsb2rfHHxobiFbxpO+0u
         OCTHV4sdRZOFFhh9ax9A2OWNPyBZyr00oscESiHfNspVCmHf5z6HNGMGCunEmYkayiPc
         TRdG54486+9b8NbdKlX2xhf8Tazdzwyyr2I7FrvQVppqV0UbXQjsuDVBfHb7b97AypDp
         usOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729602303; x=1730207103;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mXTj9yWy0CzYHAvm9Oi9r/rO7BKaQjPq8ULqxQVQmwY=;
        b=uWFR/7Pe+m6tK75g1x/X2/oOEsXYWqpJAku8a2zL18z/7sEPjarM8QP6/mdak/aeOy
         /yniC7ZkH2K5A2NkprBLDUa9snH60Z2U7HMVhpzt64mNGNVkJiuUCmMsb47azXOEOUKq
         Rvst3HbPDgdaLF8FxU9K4vlg9odaj2PIW1AW7nJH1wyh8quErmzyxLN7/WU2FmJzmMvW
         +z9L77Co5U54K9HtmNP+Ws/9btZCxybSnaCNoAw36ifQ1Yb64Uh3VvE0kFLq3tX9DhDq
         Luxin2yJ5ShXRQpVMf+nGVD7ZTfn6KxVI4V247aswC9qAIHLqe+RXiBWl1liHPNerujK
         6JIw==
X-Gm-Message-State: AOJu0YxKFeLOslJBRxdMszyS5cvgHOOQnzni1KErslSawkA7lJcI51Ru
	CMD9RTp2GV80oIIrbXsUUgDS/la3zcjrbxGeajCWm2nOV/XkQE5YceZws7BmP+61hE+97AR79Ko
	VOXJkr02M0sH2d7jLNtzfUn8vOD+Xupd18KOb12RwCx2N1NmYDHFb
X-Google-Smtp-Source: AGHT+IF76yLG0ckUkh0WbJQD/WQGQWpZYSp3aBBCZhA1HxMPdjk9kouJWspny4+OPnCzaytRmQH8hFzsXHns2yPTGw4=
X-Received: by 2002:a05:6a21:4006:b0:1d9:13ba:3eef with SMTP id
 adf61e73a8af0-1d92c50d4b9mr20275422637.26.1729602303414; Tue, 22 Oct 2024
 06:05:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mike Lothian <mike@fireburn.co.uk>
Date: Tue, 22 Oct 2024 14:04:52 +0100
Message-ID: <CAHbf0-GMV9VS7BAjvZiNENNOdZqV3jQ4+0k1kTZLkQhFT=6D-Q@mail.gmail.com>
Subject: Build failure on RHEL7 with 2.47.0
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi

I'm seeing build failures on RHEL7 when trying to build 2.47.0 - RHEL8
seems to be fine



    CC t/unit-tests/clar/clar.o
    CC t/unit-tests/unit-test.o
t/unit-tests/clar/clar.c: In function =E2=80=98clar_time_now=E2=80=99:
t/unit-tests/clar/clar.c:274:18: error: storage size of =E2=80=98tz=E2=80=
=99 isn=E2=80=99t known
  274 |  struct timezone tz;
      |                  ^~
t/unit-tests/clar/clar.c: In function =E2=80=98clar_parse_args=E2=80=99:
t/unit-tests/clar/clar.c:543:47: warning: implicit declaration of
function =E2=80=98strdup=E2=80=99; did you mean =E2=80=98strcmp=E2=80=99?
[-Wimplicit-function-declaration]
  543 |    _clar.summary_filename =3D *(argument + 2) ? strdup(argument
+ 2) : NULL;
      |                                               ^~~~~~
      |                                               strcmp
t/unit-tests/clar/clar.c:543:68: warning: pointer/integer type
mismatch in conditional expression
  543 |    _clar.summary_filename =3D *(argument + 2) ? strdup(argument
+ 2) : NULL;
      |                                                                    =
^
t/unit-tests/clar/clar.c: In function =E2=80=98clar_test_init=E2=80=99:
t/unit-tests/clar/clar.c:569:26: warning: assignment to =E2=80=98char *=E2=
=80=99 from
=E2=80=98int=E2=80=99 makes pointer from integer without a cast [-Wint-conv=
ersion]
  569 |   _clar.summary_filename =3D strdup(summary_env);
      |                          ^
t/unit-tests/clar/clar.c:573:26: warning: assignment to =E2=80=98char *=E2=
=80=99 from
=E2=80=98int=E2=80=99 makes pointer from integer without a cast [-Wint-conv=
ersion]
  573 |   _clar.summary_filename =3D strdup("summary.xml");
      |                          ^
t/unit-tests/clar/clar.c: In function =E2=80=98clar__fail=E2=80=99:
t/unit-tests/clar/clar.c:692:22: warning: assignment to =E2=80=98char *=E2=
=80=99 from
=E2=80=98int=E2=80=99 makes pointer from integer without a cast [-Wint-conv=
ersion]
  692 |   error->description =3D strdup(description);
      |                      ^
In file included from t/unit-tests/clar/clar.c:838:
t/unit-tests/clar/clar/sandbox.h: In function =E2=80=98build_sandbox_path=
=E2=80=99:
t/unit-tests/clar/clar/sandbox.h:138:6: warning: implicit declaration
of function =E2=80=98mkdtemp=E2=80=99 [-Wimplicit-function-declaration]
  138 |  if (mkdtemp(_clar_path) =3D=3D NULL)
      |      ^~~~~~~
t/unit-tests/clar/clar/sandbox.h:138:26: warning: comparison between
pointer and integer
  138 |  if (mkdtemp(_clar_path) =3D=3D NULL)
      |                          ^~
In file included from t/unit-tests/clar/clar.c:92:
t/unit-tests/clar/clar/fs.h: In function =E2=80=98fs_copy=E2=80=99:
t/unit-tests/clar/clar/fs.h:446:16: warning: implicit declaration of
function =E2=80=98lstat=E2=80=99; did you mean =E2=80=98fstat=E2=80=99?
[-Wimplicit-function-declaration]
  446 |  cl_must_pass_(lstat(source, &source_st), "Failed to stat copy sour=
ce");
      |                ^~~~~
t/unit-tests/clar/clar.h:89:49: note: in definition of macro =E2=80=98cl_mu=
st_pass_=E2=80=99
   89 | #define cl_must_pass_(expr, desc) clar__assert((expr) >=3D 0,
__FILE__, __func__, __LINE__, "Function call failed: " #expr, desc, 1)
      |                                                 ^~~~
make: *** [t/unit-tests/clar/clar.o] Error 1
make: *** Waiting for unfinished jobs....

Have I done something silly or is it just too old?

Thanks

Mike
