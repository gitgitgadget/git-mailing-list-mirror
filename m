Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58D13FCB0A
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 10:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782727782; cv=pass; b=VY62KC9TyxUjwH6nT7GTSW5CYgFLKITcsTXlUfnHI4lQ1WQmbqB0k3aaHSOqhPIYH4pfktmmN51L3iKj06YYuFQBSiVdndqilpGoBKVKzkkI4hiXWCaxK+AQXKyHspChsGabRnWLc0PNJuE4xxfUZzKvw6sPStR9UZjFY3SaoAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782727782; c=relaxed/simple;
	bh=tsQzSgKOyqX5ekIGwbdwtspL+S4KMp79kItffX8TBTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EYK1ZQs+KPlFp1vF3iHLEOaxCWyV8bWOFzhzdMu6wHpQxqUnPI04cF8Rpjf7iQteCD8WefkrqpbyZfrQO46zL/DkTvwv/hnvt1zkKJe6EC+QE7ovolog+wIaiLDLCvo2iaqMlFont5JxNLwL8aNXa+/aJazAOD0pNup4ZJjL46A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Nbd2iGIQ; arc=pass smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Nbd2iGIQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-664a09bc459so2763059d50.1
        for <git@vger.kernel.org>; Mon, 29 Jun 2026 03:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782727778; cv=none;
        d=google.com; s=arc-20260327;
        b=Oh8N25+ziagTlOJ2c9ErTuuzceYudxFjrESCYfZZJBEdbGjtx0uB/NAsmTBANXGNCx
         +hv57BB0aauNCZeMeCjogMHu+ZH6qbvc6JxiMjni27WW6LaD2WJmaWYMiMlgEXK84Mkt
         /BeoozzmEvI3cMUYzbnNI3vrdGIQhlylOI3mQ8MkUYSssbD+NhehDzzzYP9cUb/mL2NT
         VSdhxlozJ+3g+0pKw+stlYi09ufT7oKYRN2V9ve8N7KivCuWGg/fWpbitPAURIshrhp2
         yXp+g4fUq2kQb2ZZJrdORLnQscNDUW0r2NU3rY4CpRZVfw/ezFY74qnzJb3MkesA2n0s
         m2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wPVwTsjUgtXotKrLZv+juxhY5JFbJ0MUl4BnRdvGDts=;
        fh=fClg/pnLcDIdwF8qY1rmMokykJoEfJm8OplWhmnw7vI=;
        b=sa7N4RhI478uEk6QLEB/KXFFaJaSa3QNc4f0Sa/eAopWLeMHX1IcIkpoB7hTEsTXS2
         5315aweUgh4UnlCDsP6cu1BLrdTsWTj68Xq0QP6IIQLPI1ix8puBqarogpiegP6F9qai
         82xFMf/uYW0sKI20u4uMQKKbzyLbRbFdptRA22pETWAZFY9J8qAwmTzbb47wbnie6Qp9
         gso0JhdCFGYKSlNX9GubKSIDx2VjgkbcH/65kVAZIUrTC3LYKKb7vvWmeJID6Jiqefpa
         6mdT/Ybkseko68ydIyzeJ+jqAlQ5p32j1BqjxczWYc7juR7KkBkk7BqvWrYJdFzGfhFP
         Wq4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1782727778; x=1783332578; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPVwTsjUgtXotKrLZv+juxhY5JFbJ0MUl4BnRdvGDts=;
        b=Nbd2iGIQ7+FoxEtGleBIpcVao9mPCp5dw5zQHKAkxcshsn4lZH8rl8Tqo3XpKQ6acb
         ac8OMGuZSe4rDF8PfFGwSKquSGfE7oBSs2aIWJuugjnWmByFR9ayp/LP/WWmgmRW29/I
         YOZkZIX83y4mucgNog+7c6yBqNOlUCR27w6GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782727778; x=1783332578;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wPVwTsjUgtXotKrLZv+juxhY5JFbJ0MUl4BnRdvGDts=;
        b=CeppOAK43ChV4v+SqqhdG5xyY1/rFYIRRSOQV44X8TJI4NTPIKpV5MLsSTJHJ8JVJF
         KpIgdjJ/k09hDFUVcZ4g1p89qQXMMnLLa7Ux8i9Pt+UYeElNPw2RNAVejyYS0VLh1TCd
         pFVRw+x91z/faQcS7wnNmZsoOU3rxOWvvuAclISJrcN8M41tuHtIW4rU+8stdv0qU7fI
         Tpy5CVXmpXnvDlgEM7GojoasPuG5eAf7ITcsZZWufnB5aFIqZkplKtCC3A19nmdFl4MW
         nlmCTA+FcS9rgQrXHQorziTJOAyM/4Lv0PdbjF+mdDiX9h/eBiLzE+E7o1I9sc7aPh09
         3j3w==
X-Forwarded-Encrypted: i=1; AHgh+RriJ9Sg+AkaEMFGRHxSSNEwjN3AeIdZGF/EXP9TR8KU52rIRkUdkKE53KqKw4gY12hlwbg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+9g9gsEqVf25U20SVpHrx9bTApjbNirINoX8uMdvi4fkS0i63
	E6UYhRIY6Ywnuxg++9owOASi3ijqsXciGoO5espdMhou4S64cbjDmOFgmS5GEDsgXoUyEYWqBb5
	hiD8FZtsUNG1D8//rf31yU2Xhds80c4fzmV1NjfceMQ==
X-Gm-Gg: AfdE7cnd9lnihBZgUrf4GWOx4CuPp/hXblnuoQoL83OPY4k6DSTNUQw407hTO4Gn+Wd
	4eBhYLf8o3HTRXfjOaGkkhoo85tbcehucb5QpL9bMCW1A3osPjNr+ZtgRLmmMMCyDY2kt0fVU3u
	yQRk78fu8Ycspv7yMiSRQOagN/rsxosWcZT48AMxvd8qCceoCI9R1W/oPF+rg/U06bK6w844Pcr
	bpHvswW8o9lQ37CGsRGdSoU5iy9zRlYmB//d2L7ezKF43lm0ye0qCu6eOjl75mZynls30S91p6s
	XwQ29z7U
X-Received: by 2002:a05:690e:1913:b0:664:c281:a100 with SMTP id
 956f58d0204a3-664c281aff2mr5466349d50.40.1782727778536; Mon, 29 Jun 2026
 03:09:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.v3.git.1782479286.gitgitgadget@gmail.com>
 <pull.2149.v4.git.1782649547.gitgitgadget@gmail.com> <4db485b48aae810eeba28ea4feb47401ab352e88.1782649547.git.gitgitgadget@gmail.com>
 <akIBvWT7nIWntCNT@szeder.dev>
In-Reply-To: <akIBvWT7nIWntCNT@szeder.dev>
From: Kristofer Karlsson <krka@spotify.com>
Date: Mon, 29 Jun 2026 12:09:26 +0200
X-Gm-Features: AVVi8CdeSqHt_7tHS4jX5pmcMqHxmTwJdHOq6C2VGUZ6xcKG-ZkhhRl8THNZnlI
Message-ID: <CAL71e4N92t8170UBW3rMA6B-rEUeOm-R_HSioB957mUKOpwRyQ@mail.gmail.com>
Subject: Re: [PATCH v4 6/8] commit-reach: remove unused nonstale_queue dedup wrappers
To: =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Derrick Stolee <stolee@gmail.com>, Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 29 Jun 2026 at 07:25, SZEDER G=C3=A1bor <szeder.dev@gmail.com> wrot=
e:
>
> On Sun, Jun 28, 2026 at 12:25:44PM +0000, Kristofer Karlsson via GitGitGa=
dget wrote:
> > From: Kristofer Karlsson <krka@spotify.com>
> >
> > nonstale_queue_put_dedup() and nonstale_queue_get_dedup() became
> > unused after the previous commit. The core nonstale_queue functions
> > remain in use by ahead_behind().
>
> Please squash this patch into the previous one.  Since the last
> callers of these static functions went away in that commit, it can't
> be built with DEVELOPER=3D1:
>
>   commit-reach.c:91:23: warning: =E2=80=98nonstale_queue_get_dedup=E2=80=
=99 defined but not used [-Wunused-function]
>      91 | static struct commit *nonstale_queue_get_dedup(struct nonstale_=
queue *queue)
>         |                       ^~~~~~~~~~~~~~~~~~~~~~~~
>   commit-reach.c:82:13: warning: =E2=80=98nonstale_queue_put_dedup=E2=80=
=99 defined but not used [-Wunused-function]
>      82 | static void nonstale_queue_put_dedup(struct nonstale_queue *que=
ue,
>         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>

Thanks, will squash for v5! It's unfortunate that this means the commit its=
elf
becomes less clean, but I don't have any other good solution
-- and having each commit compile cleanly is more important.

- Kristofer
