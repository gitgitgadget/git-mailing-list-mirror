Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1AC30C373
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 22:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763590414; cv=none; b=BBEBR7QLDhcEMwVwn6U3zM+2z0ZZNpEtIoHhANlgwumK8Gao8FQ39t2ZgaY/+7OEEC0uzynjgg1SbRI9TCpXafT0VRv3M3ijv6r7GpnTPwnWB5aq5naKqeN+C1wdXwY1v/laUpOqkNbX0L+PZjN9Od6ontyGwLwrNtQcFhrf3t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763590414; c=relaxed/simple;
	bh=f6J2EKIiqAbOcqEiVlUQV83Bj0Zhjc6TA2GJn3FVZqw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fCyIfO2wV3JO5oV0zLDMMVel5JckooQN+eUaZMesXgke8n3lxtDYlPppzZw9evfhBuPVcBXUgWfCnryxmYdX6nnSX6dNRSn59dOjYDs2QBWOZtSOCrCd6Jh/qnUoZhTfVdWdgYDkgmB0BUB3OkHc78TcPo0ZE5Q78vPxOqx0k5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88243296031so323376d6.0
        for <git@vger.kernel.org>; Wed, 19 Nov 2025 14:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763590411; x=1764195211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lEhlC8hlluMH8ZrtnC1IHggE+wewb/DuNICIT5ACfvc=;
        b=BFRUrYj4q/IZ8x2j+3ZJMOGPGIL6AfO70CH5ae8qyLFlsw5VCOAiw1P+yTxZaQJP+L
         1ZlocQM4/cASBaK2JTL+uTKI6ik46SY3hY4SCAsAOP543xv9wh4mJQsptR5XAbr36xUn
         2tfZGxUtx2zDzCiwcDItFa2DdHYYCeyNAnZpPZizKQJ4NDg32eJhwSfkGXXohtq+jUzO
         szsCHCTyR1x6BTItSAQvz/cPm5UMVL+5I28fMYaMUSEW0qqzj+CR/xW9zX8B4l+4uxUH
         jJTPgvWgnaZyitEujpsKd6KuiKcAsofeCR7YWVAK7P2RwxRuD1//pXTfr7HLWbxfczm3
         nFog==
X-Gm-Message-State: AOJu0YzBi5j5kzQMiSg0JAaGmVHzfPmeOkTzUZ8KczJEMYxfP1cM2kBh
	yC9a+cpOAHLITcMX1/5cVxIZ2wuyRKuElWIolQOBw+mUb+SMqO7Co0QBWfmhC5aiLMfgMa3uh+y
	Gq8ymXepiH2muo1rUiAI6ElL4YKiOxSqSyR+e
X-Gm-Gg: ASbGnctCcmfIdh6JytFkVkeWDnbUKovWcZHMM1AjZHfLa89KmBGCzQ/2eJxjxs5df3T
	ziYsTNB9NhR8hm7Om+Toi3UJ6ZDGjKWagC+ypHRsuLJdUAM93RdVSCoHELD0bJ48/9CNNFCxR0x
	XcSg52+mb5X4b4XENxZXutA70F3Dp6sAv3DMiNfeOOMJKNHcMH0aCfBgY+rwP+HnOKXyQXO5pDh
	A3EfiAGEnvc9VZKjVc3EnQ/7LV1d2FNxuMOLP7gmpyO6ZwbkEnGA2jcnN/33//cue5Yq+l+tHIK
	jMtbVwOFgYJ4JhuFpAM3138G4Q==
X-Google-Smtp-Source: AGHT+IE4+RUinJBUtGKcgvb0bCuTOH0kRC4eXPgtMA2CHDdLn86z/PfEicBK8U/4WxO9uiJ8SbOnExnNK1xU2wX21SA=
X-Received: by 2002:a05:6214:2302:b0:880:4954:6af5 with SMTP id
 6a1803df08f44-8846e1a1b23mr10293986d6.7.1763590410697; Wed, 19 Nov 2025
 14:13:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251119-kn-alternate-ref-dir-v1-0-4cf4a94c8bed@gmail.com> <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
In-Reply-To: <20251119-kn-alternate-ref-dir-v1-2-4cf4a94c8bed@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 19 Nov 2025 17:13:19 -0500
X-Gm-Features: AWmQ_bkkJFC9fyiuAwPYOxTMAdFpgEEag9NTdL2eILSQhHeYYVU2oiqZeZjiuxM
Message-ID: <CAPig+cQ1nF47Rvvm4gDks8Bzj0htzUkfR24WB8UdnJtcQTQwCA@mail.gmail.com>
Subject: Re: [PATCH 2/2] refs: add GIT_REF_URI to specify reference backend
 and directory
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 19, 2025 at 4:49=E2=80=AFPM Karthik Nayak <karthik.188@gmail.co=
m> wrote:
> Git allows setting a different object directory via
> 'GIT_OBJECT_DIRECTORY', but provides no equivalent for references.
> This asymmetry makes it difficult to test different reference backends
> or use alternative reference storage locations without modifying the
> repository structure.
>
> Add a new environment variable 'GIT_REF_URI' that specifies both the
> reference backend and directory path using a URI format:
> [...]
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/t/t1423-ref-backend.sh b/t/t1423-ref-backend.sh
> @@ -0,0 +1,109 @@
> +test_expect_success 'empty uri provided' '
> +       test_when_finished "rm -rf repo" &&
> +       git init --ref-format=3Dfiles repo &&
> +       (
> +               cd repo &&
> +               GIT_REF_URI=3D"" &&
> +               export GIT_REF_URI &&
> +               ! git refs list 2>err &&

Should this (and all other tests) be using `test_must_fail` rather than `!`=
?

> +               test_grep "reference backend uri is empty" err
> +       )
> +'
> +ref_formats=3D"files reftable"
> +for from_format in $ref_formats
> +do
> +       for to_format in $ref_formats
> +       do
> +               if test "$from_format" =3D "$to_format"
> +               then
> +                       continue
> +               fi
> +
> +               test_expect_success 'read from other reference backend' '
> +                       test_when_finished "rm -rf repo" &&
> +                       git init --ref-format=3Dfiles repo &&
> +                       (
> +                               cd repo &&
> +                               test_commit 1 &&
> +                               test_commit 2 &&
> +                               test_commit 3 &&
> +
> +                               git refs migrate --dry-run --ref-format=
=3Dreftable >out &&
> +                               REFTABLE_PATH=3D$(cat out | sed "s/.* ${S=
Q}\(.*\)${SQ}/\1/") &&
> +                               git refs list >expect &&
> +                               GIT_REF_URI=3D"reftable://$REFTABLE_PATH"=
 git refs list >actual &&
> +                               test_cmp expect actual
> +                       )
> +               '
> +
> +               test_expect_success 'write to other reference backend' '
> +                       [...]
> +               '
> +       done
> +done

Something seems amiss here. Presumably, this nested loop wants to test
various combinations but the `from_format` and `to_format` variables
are never consulted in the tests; instead the tests just hardcode
specific ref-format values.

Also, if this is indeed meant to be loop-driven, then it would be
helpful for the test titles to include the values of `$from_format`
and `$to_format`.
