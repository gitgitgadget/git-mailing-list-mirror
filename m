Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD9520C017
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 14:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736519217; cv=none; b=izkaf3mvRCPtmYBXHfiiOHRrhVrYYbXsHK+6JVE4bH9gYSPDK6xYUbNn00sEKjp5L4nMSrKuQHKqKXleR3N+LNJCq/QgosmuYMxVKNFdo2YyhlEjEdF+WqpTK36rhNt2ywKUvSWwTCpmJoFQYyK7+M6mrvmZg+BYtnnEdi99qHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736519217; c=relaxed/simple;
	bh=SrrOOb+prrArHSKKnKUJFBcYLDHeBVqisBRsgoygquc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pB4yx4jiOYj1RP/GL0L2tGW1bet8rFbM87lEu8Tfuo+sB01pb+yfaHxiONfSgFOl5dJ5Mt0g5IaAiSvJ2+7v6/RFYOVK80Afcnw53//LTeD7l40KGwTt+XSNMDKo/DbmFvF3FpVAvI5SO9V8fsbrWQvhwlPR3tt5ciMsaJKT3eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DkoUO+c1; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DkoUO+c1"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-aa6b4cc7270so322314966b.0
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 06:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736519214; x=1737124014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fbWFlBMgO79luOLA/Hrdr2l6+F5xJQP6Yc2Hmf0ztO8=;
        b=DkoUO+c1/KDB5Fl7bJwthbyTsr9i5Lhx3Sz6fx79TwDFFtnxS7IWvlpSJ5Nxbc96hV
         5Pf4zxTT1RucO4jciqBIRhZl/9NVgi5MQqyNqzc6738yQNofUd8vYi4a41buy6BLKEN+
         1qZj48dO2JtpLEeOmnRh3fIrQ9J8IMGT1yHfOLZkiNX5YN7Vtx2rrqJg8DWKA6A3fjnu
         yYfg2crP9W7EoyqbwTIKzb3m9JJI23A53DpaRbVj5a3Tc9ehdbDSFZ5Ad75FtRPZTrSB
         bFe30GbHWlM6ZxpcMDKbWnbGw+gQaIfa8LQmK3fGGD1w7AZ/4D3cZNbuOlD8q1q8Erdo
         qcNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736519214; x=1737124014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fbWFlBMgO79luOLA/Hrdr2l6+F5xJQP6Yc2Hmf0ztO8=;
        b=TgIwAFu4fW2ugKjgnclbLtYTc4b7mT1JV/dOswWOeLfYHUq0sWHoH4qlMpThhvOUfJ
         8DF7huiQYk7AhKY3YnynDIpTfRlFJyGOJeR6em6ELfam+adthzy6BbWJT7QZycCu6+Y0
         Zq4yjSUG/wKVjeqOUFpjcfLoxjRp3ha6xkV6BfQTyXPvN+u5ZxxpKB6B+35yab8sHUa5
         43zbf3rx2SIBphdmGlUHAdHlVAT3IhkUCadmmE62f9KspSoFyF311+C0CK5Yt7rpOT3P
         al/uqvl0TtKgXX5xaCbuOAakO0i5YVdD78hpGw3nfeTVhygxdnd3MEz1VXFjgMQdYXc4
         42Ew==
X-Gm-Message-State: AOJu0YwfbxYwZLNApTVOkoOS1GTBWmrk07PtfdQkmLiVuVjYGMre0uN1
	nh8pghzded5Jiyutz5kdIZ+ijefiYAnIsp0JnqejmzOi9vsJv41XDv0psyfyS4HWT7Z0VwPejdU
	oeHM5HFtjZDsg55Yubm7vU2MEbDFekrSc
X-Gm-Gg: ASbGncslWO2r8gP4NrVm5PVL9/oNyqVOZzyZrEeyVghT5QePVjAw/oohgWgXUviWC+4
	UGpwpoe9wRkf+qMDQzB2lf1wAwRbxHgK5KbYiUPgY
X-Google-Smtp-Source: AGHT+IHOtv/acBYyYSRysxbepMUf0y316aRV8haLySOXFzVAiVcmSRmnMazX2xaYh7QfghtTqPVh26Quh06TTf5n/Oc=
X-Received: by 2002:a05:6402:4405:b0:5d4:35c7:cd7a with SMTP id
 4fb4d7f45d1cf-5d972e0b20cmr25107342a12.10.1736519213717; Fri, 10 Jan 2025
 06:26:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20250108183740.67022-1-eric.peijian@gmail.com> <20250108183740.67022-4-eric.peijian@gmail.com>
In-Reply-To: <20250108183740.67022-4-eric.peijian@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Fri, 10 Jan 2025 15:26:41 +0100
X-Gm-Features: AbW1kvawweqneLzLJFco10YqUaXp4y_MSZQTayoabPlCzrPF5xgv7allo9nrXmQ
Message-ID: <CAP8UFD1U3P6ef9x58MBvrhDhdMn_3qe+Pjmf1L=Mi8Q5Ge0EPg@mail.gmail.com>
Subject: Re: [PATCH v9 3/8] cat-file: split test utility functions into a
 separate library file
To: Eric Ju <eric.peijian@gmail.com>
Cc: git@vger.kernel.org, calvinwan@google.com, jonathantanmy@google.com, 
	chriscool@tuxfamily.org, karthik.188@gmail.com, toon@iotcl.com, 
	jltobler@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

About the commit subject, maybe something like the following would be
a bit shorter:

t1006: split test utility functions into new "lib-cat-file.sh"

On Wed, Jan 8, 2025 at 7:38=E2=80=AFPM Eric Ju <eric.peijian@gmail.com> wro=
te:
>
> This refactor extracts utility functions from the cat-file's test

s/test/test script/

> t1006-cat-file.sh into a dedicated library file. The goal is to improve

s/a dedicated library file/a new "lib-cat-file.sh" dedicated library file/

> code reuse and readability, enabling future tests to leverage these
> utilities without duplicating code

s/code/code./

> diff --git a/t/lib-cat-file.sh b/t/lib-cat-file.sh
> new file mode 100644
> index 0000000000..9fb20be308
> --- /dev/null
> +++ b/t/lib-cat-file.sh
> @@ -0,0 +1,16 @@
> +# Library of git-cat-file related tests.

s/tests/test functions/

> +
> +# Print a string without a trailing newline

s/newline/newline./

> +echo_without_newline () {
> +       printf '%s' "$*"
> +}
> +
> +# Print a string without newlines and replaces them with a NULL characte=
r (\0).

s/replaces/replace/

> +echo_without_newline_nul () {
> +       echo_without_newline "$@" | tr '\n' '\0'
> +}
> +
> +# Calculate the length of a string removing any leading spaces.

This might be a bit misleading as leading spaces are removed from the
output from `wc -c`, not from the string.

> +strlen () {
> +       echo_without_newline "$1" | wc -c | sed -e 's/^ *//'
> +}
