Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECD0823AF
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 17:02:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707325367; cv=none; b=YuAF9m2s/eEBwS3s+LskuRY1UWLdSmGvgpKyhkT2g8Yv/Vm37EUT0DWgprOc2VEiJYZkrlAMKUMGwlRY68XelKKeWvmDjkutEqiYOPSZZr+gCjuXGkykpwem9aQSoIOCYb3rXxTDa1KyNWPJ5pZ5Qmwhkb5ddhdlZ6yNHMRi2pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707325367; c=relaxed/simple;
	bh=4DTJJXT6aUDjQcxeStBslwg1HaSIzSN7Bo8bYOLNobQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KCsEPIiltuYSTmBN+GQtI6YCssj35QBywi1iE0JuytV5RXwBK18fiqXlr1vtsZSaxcnLu+opSRWcGqMNILavSnGeUh/1XLBTYX9AR440A+vKU9czfiwv4/6Z5ar9C1f4jcSbuzkpY5Y9EK5Rwz2UOejJOpY+i3JpEb3R7mdPnIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-785738e94b9so34994385a.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 09:02:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707325364; x=1707930164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vW9ttwme0rN5rmOxVbW+QyVJH+EdUve8MAh6KFDOz+c=;
        b=IvzMzG2yBl4phLsqEjuQE70iaLQ9Upt+zGJcpn3oy2vr27na4au2dj2yma5YGsOcY7
         79zRWgrmWZpC4PkE95561HDtgNZgfuPsPZWY7ERbTcDlBppp/08Rx5FTcEYA1S4T6FaP
         ddXHk3J+LhaEkzMvznO68P5kGMbW2f62uAW/JYuN/SmAHn24get0ojeCD1k3GvuIbANz
         3RfnzU4Fc3uLYm4U/IEv5sDwhFUJTafhT3FJtipG+FZjgrcesZrofangsZsl9eey32/o
         8jP/krsi7JEIcArfeqaYIGJoQqxMIuYXBuPT7oviYGQ4+NlfAK0H1QL2VNLpGsMaLv5q
         o8xA==
X-Gm-Message-State: AOJu0YwEWxaIfy2DbKqXGyf1AvdNC+jQNRF1VeaHMWWS0hIbQTD93Z9f
	9aQ52bEChuTm/nPJDiWc32YXXZeT6J8SRlYkUIRzBe8VyZLHcOdNYJXkC6VrF4RAtv0P7Kxi4Yk
	l6oFQf51ryPHsNO3hoAFsVETwIBU=
X-Google-Smtp-Source: AGHT+IGERlPiWZBY2JQ7t+TKWxPlGuLRHmiMn1UDXIUYb4Av6jgdBe75Ik9BRa1WtIvnp5pMbqdEl7qlYmNgIu7VkOw=
X-Received: by 2002:a0c:db0a:0:b0:68c:36bf:29f1 with SMTP id
 d10-20020a0cdb0a000000b0068c36bf29f1mr5788139qvk.12.1707325364574; Wed, 07
 Feb 2024 09:02:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1651.git.1707212981.gitgitgadget@gmail.com>
 <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com> <01dfd66568c1818819e81e001cc189f9066d0cf0.1707324462.git.gitgitgadget@gmail.com>
In-Reply-To: <01dfd66568c1818819e81e001cc189f9066d0cf0.1707324462.git.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 7 Feb 2024 12:02:33 -0500
Message-ID: <CAPig+cSs8MFkLasTULh7tybrFm7SwaT+JeR7HnXjh+-agCHYMw@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] merge-tree: fail with a non-zero exit code on
 missing tree objects
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 11:48=E2=80=AFAM Johannes Schindelin via GitGitGadge=
t
<gitgitgadget@gmail.com> wrote:
> When `git merge-tree` encounters a missing tree object, it should error
> out and not continue quietly as if nothing had happened.
>
> However, as of time of writing, `git merge-tree` _does_ continue, and
> then offers the empty tree as result.
>
> Let's fix this.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-=
tree.sh
> @@ -951,4 +951,14 @@ test_expect_success '--merge-base with tree OIDs' '
> +test_expect_success 'error out on missing tree objects' '
> +       git init --bare missing-tree.git &&
> +       git rev-list side3 >list &&
> +       git rev-parse side3^: >list &&

Isn't the git-rev-parse invocation simply overwriting "list" rather
than appending to it? Did you mean:

    git rev-list side3 >list &&
    git rev-parse side3^: >>list &&

An alternative would be:

    {
        git rev-list side3 &&
        git rev-parse side3^:
    } >list &&

> +       git pack-objects missing-tree.git/objects/pack/side3-tree-is-miss=
ing <list &&
> +       side3=3D$(git rev-parse side3) &&
> +       test_must_fail git --git-dir=3Dmissing-tree.git merge-tree $side3=
^ $side3 >actual &&
> +       test_must_be_empty actual
> +'
