Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3953225A2
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 22:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ckeQ0nh3"
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DDAD49
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 15:35:16 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-507a0907896so3180769e87.2
        for <git@vger.kernel.org>; Fri, 03 Nov 2023 15:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699050914; x=1699655714; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6JRTQu1iG/3s2pGnmMk68oQxenE/aV8oszUY4OBUCo=;
        b=ckeQ0nh3Ab67nolNaWwyx7OUqH58zL+HiuDPEpne+1Und+w96ZJhrgTpjhjGlzveEE
         DQ3x366geYvhxpeXlsffSaAvvhNqeSZ2ExVqU8i76TI+XmvWPNthmIvj1hChOSpqxoQV
         6v1OXoWrJufuWD+VG7FfXWVlUK4QUlnXZGG05O0BYLvsbXgmVFQkH13D62UG5DgVfme8
         YsUfCD16MfmW+KeQIAjyQvJ4+BkZNECpi1yeWbbo/oSUHo0PXB0yDdqOknaMR4a1K8Sz
         Evae8FNmJR6S8DmXQeOnbR01KmvGCbrSp2qydLRoN6d8R5rKpS+q1dK8A2Fv0yyUyL9X
         OzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699050914; x=1699655714;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6JRTQu1iG/3s2pGnmMk68oQxenE/aV8oszUY4OBUCo=;
        b=PbjnlKyQBovkNhGm+tdRdAwhkAtETUw8bDmzY8ifEqviOYSBjJi/9mkmXLuOxClztu
         oicETZCsVmJajO9NYuu1J/RMucCUzuLqdnzDj8koTXuaqHKmsx+XNwlvE6kyF0zGuIIZ
         FMTPNk08FnoUQUwtuNv4jN50g+sAWNaJn4EpYNi3LDyd+8sDj8oDWCiNhnpEWFR6tRca
         HQjvyR0l6uiyq2KeB9NHj9VhgGYMlQYXGQo5Jg971SRtvJZ/TyaE+0N7GNUvMDQd6hgE
         RXWtK5+gRbU/Ujn7Vw1DhFz+3IGLt97F03WqC3hYC1CQ6L+fdIvBpmIFEIQ1CBEYn9yN
         rLcg==
X-Gm-Message-State: AOJu0YwLrIVRLcVNdv4vKE8AJSLjTEpskJ82SUEBdjAltZdjji/C2/yH
	qlxVKsDTcwZiYRDe1kn8gMewWBfLc3Cv/WTtqs7VhvzN/DQ=
X-Google-Smtp-Source: AGHT+IEHpTSB1jmOZ9VDK40UgWYewppCUdg7nv9S6yVVmPVj3lAvtC7L2By5KZhg9pcko4bYexGk+DjMn1PVwpjh3f8=
X-Received: by 2002:ac2:5488:0:b0:502:ffdf:b098 with SMTP id
 t8-20020ac25488000000b00502ffdfb098mr16216221lfk.6.1699050914190; Fri, 03 Nov
 2023 15:35:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1698305961.git.ps@pks.im> <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>
In-Reply-To: <4a864a1d174f7d4d36202a375302d450fbe9f2a3.1698305961.git.ps@pks.im>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 3 Nov 2023 23:35:01 +0100
Message-ID: <CAP8UFD25O9D1WL+CAQOcdqwuPsgdd6qOMNWuVtAw18U3RccYZQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] ci: split out logic to set up failed test artifacts
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 26, 2023 at 10:01=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> We have some logic in place to create a directory with the output from
> failed tests, which will then subsequently be uploaded as CI artifact.
> We're about to add support for GitLab CI, which will want to reuse the
> logic.
>
> Split the logic into a separate function so that it is reusable.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  ci/lib.sh | 40 ++++++++++++++++++++++------------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
>
> diff --git a/ci/lib.sh b/ci/lib.sh
> index 957fd152d9c..33005854520 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -137,6 +137,27 @@ handle_failed_tests () {
>         return 1
>  }
>
> +create_failed_test_artifacts () {
> +       mkdir -p t/failed-test-artifacts
> +
> +       for test_exit in t/test-results/*.exit
> +       do
> +               test 0 !=3D "$(cat "$test_exit")" || continue
> +
> +               test_name=3D"${test_exit%.exit}"
> +               test_name=3D"${test_name##*/}"
> +               printf "\\e[33m\\e[1m=3D=3D=3D Failed test: ${test_name} =
=3D=3D=3D\\e[m\\n"
> +               echo "The full logs are in the 'print test failures' step=
 below."
> +               echo "See also the 'failed-tests-*' artifacts attached to=
 this run."
> +               cat "t/test-results/$test_name.markup"
> +
> +               trash_dir=3D"t/trash directory.$test_name"
> +               cp "t/test-results/$test_name.out" t/failed-test-artifact=
s/
> +               tar czf t/failed-test-artifacts/"$test_name".trash.tar.gz=
 "$trash_dir"
> +       done
> +       return 1

Nit: I think it's more the responsibility of handle_failed_tests() to
`return 1` than of create_failed_test_artifacts(). I understand that
putting it into this new function means one more line that is common
to several CI tools though.

Otherwise everything in this series LGTM. Thanks!
