Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5D62DCF55
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 06:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786085266; cv=pass; b=Pf/9UDLLhSTBnqijklGeDHbzWV8qLx/gXbN/+nW2mRSjM/iAsIrK0+HeLw2bdM7E27qmetC3f62JxqOtTBtL3kwhB8mKRZ/maAf0ZA/ye+Aft4KVoEncJH1RDM1knzpS721Wj3AG63rThA5oEnYX1OvwonvK6TXFNlP4wNfQeXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786085266; c=relaxed/simple;
	bh=hotmo/VWzN4hWK6Xl+HXcEW7f+cnRc9bYwrPTIE6VK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bSQ3Ip+ADzhDt3SOcmeCQFIW6qG0PWG//TXyw+P35baqmMKnzih+EAU/sVP4dNhAhivQYrl9LRFZpPmnqJFxEGG6EyR3JhEPK7MF9xioEnFJ6IBz/u8OWNAOvCPdH19wrRLpHP1gb8Ch816DE4DcEB52icEFIhVj1SiQnxOOKNA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxWCZgBI; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxWCZgBI"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4ab89cff9c7so967585b6e.2
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 23:47:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786085263; cv=none;
        d=google.com; s=arc-20260327;
        b=RrzDW+0nL78IOX0lWkwUHPxACWIGBXeULV5RlXBXlIcfEKhha7zRiBo0pEgoBBzMtI
         kIE4xeVpUud99NsL7yx62mj5x9SLXXMdnKY/Dt9pJsAyDrcnzqI/JNra/OfiXBz3UpcL
         ykI1AA11rO1s7Ursb+E30WqAfGXvWE347hv3hEyMdrtZUmxCejS7dbsuT6kVZ/mIj3Yp
         dofHSyvY2nsv+klcCsHscJtCZjrs6MxXCIOBBYo0/80Q1yDH6Xdel/wsRof028Nz47H0
         3VlAB/fzbYzIDBkZmZgWwDTgyh093mFVVRnmozCtrMev1uJyQqgf2c1HstHMYvCOAY6c
         dk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7iaCa8U8FXkc1yw+nUfa6T6Qcup8JipUP4pu4y5CDZM=;
        fh=euL+wxaGGjBW4xTZbmmY4PM5MI9XSlhvJbT45YaBhE8=;
        b=AX5BbTlD1/KVH6RucuUYM0UQC5qcbJSW/M/W4zJkNNMcfxdHIHvzNeURwFTjxOnz5z
         E+zxDU+wGxPcSvIgJY5VovSAOBEDaaTZ9vQa4M+b76tkoAPlT7p8uDFdTMG/O0BldEHc
         b83+yBMjHXPgVefVWdy5TPyRCo71r7E9+KVr7o9gAcAiak0r9OgrAc1IiaeUUvaAayON
         7udI/ms/cRR/bzglCT62NtsGZ4pP9eWDku+3XfRmcP7zY+2P1DBMmwk+Yyc2+qfbyAXj
         Cftm+lts5+F3q7AlxjgVIQExxImEe+a9JsXlUb1VBCMRPBs6Z2lC49ft9/XfCtwdMXoj
         4CPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786085263; x=1786690063; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7iaCa8U8FXkc1yw+nUfa6T6Qcup8JipUP4pu4y5CDZM=;
        b=QxWCZgBIlqzXPU13Gg8AzrHi/jaR2T/wvdAF3uZHJhxPN4IgVSorhLU8DBjMsna8Pi
         hbPNOvO1meKfEajn5SNGjiBdzf+xEcqQlOxNUdv6ARZ0s0Ev1nw4K33xkMd/+gOCfr1a
         w9h6yaNqDLsrkn+m8qk7/9ZfXdE9kclESuo78cHPYh4J4p+sgumunvBn+kZJtRbPaiJK
         ScXXFesziGM006IazZnfwHUSyYfEhkWriCx59PiGBZpUDaox/Hzkirz/F6qooY0F0VqW
         Lfd3w+Mr8ypunq17lphmdLLyn/c5jBdJ8+TqNUhvrLHkJ1jFXM8E8RbQr4U4Kiz/xExN
         vtUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786085263; x=1786690063;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7iaCa8U8FXkc1yw+nUfa6T6Qcup8JipUP4pu4y5CDZM=;
        b=b30PuTj+mOUQjBdAIJ2wuIPMO5JSX+i9VJNraDQHvJftEElXOJLR8KcpvHf4mUUc9c
         ECtb8BgzbX5YRs4aA22EOTMhTBAUFs+/qnYYX9vWTn4Z6WGXzepOQlYpxKw7mDuH5f3c
         iH1qNVUj2Av2wAv1Ft1gOXtUSq/l/FdMuXhHeupW5IscXwuN0SqieVTccOwZed3S9jUa
         c3KFn7HTs5vLs58wf1R5Ax1MzNcVVgBiI7tJ+b+u1CG+es0ujVbSsG/BRyGm4NBuB8op
         ldf5ATmuRnmPfnJ+0oDnH+iDsJUQMQKkrK00avBlZtpfzxkfwMPABM+USDRPGAugqGA5
         kGRw==
X-Gm-Message-State: AOJu0Yw+/Uad9USfotbEyYROwkfqBqptxRmdTn8V3aIXByHzDLA7Gx5Q
	YlUbuIHURIpv20uhIqOMihpO3enyJX+oT7WjL2tShPrtDoiL6zpqKq/fS6xFhX7c7lV4MQ6EVMU
	LXGyCsNoN/BWV5bH8j8cuqWXHe9EPIfOcnA==
X-Gm-Gg: AR+sD13D0eI1NrPJaGHImnwThcVHhaI5xTbriSR1PVE4W8YKJqW1m/XzwjCeUbOtdkZ
	2c4vCZKvZuXr1s7q2FHNmx2bP05PJ25JOLdWrOV526CCe9Ic0vBKGwpo45GHjPwgw+b8pWxvmwe
	LhGwA9eqlsjwk9WDDK3PyFpPwNXPfcDqrMq1F3mREGwEceJTEm2TxexdUZPrr4eEZ1cradesYHU
	v+SJ04LMyYQEAp6rthZG78veQyehUX345L5xkUwX22L5NfYuawn+Jfz92qVAnrqfJBVFiq2ojJ2
	iUWzQjQBF5juhSbeYYJk3HSab3TfKWL1R5JTS7tv93/VBRRxjQleInjj7tQ257MlwZ7OgxnG+RX
	zDW+aT47FY/xz1PY0lgjf7e6i15dURlb6/zCohAHJm3C4kqUvQSMnstPbPiDGce0=
X-Received: by 2002:a05:6808:1803:b0:4a4:c12:49d9 with SMTP id
 5614622812f47-4afadc48509mr11068028b6e.3.1786085263421; Thu, 06 Aug 2026
 23:47:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802212826.1090943-1-sahityajb@gmail.com>
In-Reply-To: <20260802212826.1090943-1-sahityajb@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 23:47:32 -0700
X-Gm-Features: AUfX_mxD3HZAP2ZnYt0baOGNFu670AjrzgyhWtNz-xwFzzwb_oVQXxabEC7vC8M
Message-ID: <CABPp-BGYuQA_ngR3xS-_Mndzf_ubkn7rSc25CJG=UbLCVGdnyg@mail.gmail.com>
Subject: Re: [PATCH] read-cache: avoid sparse-index expansion for unborn HEAD
To: Sahitya Chandra <sahityajb@gmail.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 2, 2026 at 2:28=E2=80=AFPM Sahitya Chandra <sahityajb@gmail.com=
> wrote:
>
> repo_index_has_changes() normally checks whether the index differs from
> a tree by passing that tree to the diff machinery. When no tree is
> passed, it tries to use HEAD for that comparison.
>
> If HEAD does not resolve, as on an unborn branch, the function falls
> back to walking the index directly. With a sparse index, however, sparse
> directory entries may stand in for many paths, so the fallback first
> expands the index before reporting the changed paths.
>
> That expansion is unnecessary. An unborn HEAD is equivalent for this
> check to comparing the index against the empty tree: every index entry
> is new relative to that tree.
>
> Use the empty tree when HEAD cannot be resolved. This keeps the
> unborn-branch case on the same diff code path as the normal
> tree-comparison case, avoiding the sparse-index expansion while still
> letting callers see paths inside sparse directories.
>
> Teach test-tool read-cache to exercise repo_index_has_changes(), and
> add a t1092 check that the unborn-branch case reports paths inside a
> sparse directory without expanding the index.

This explains what, but not why.  It feels like a pedagogical exercise
with no actual utility.  Why would someone with an unborn HEAD be
using a sparse index?  They have millions of files, with none of them
committed, except they don't have millions of files because they only
have paths under certain directories?  How did they even get the
relevant tree entries into the sparse index in order to have one?

Perhaps you have a great usecase and I've just missed it.  Could you
explain the motivation for enabling this?  Or was it more a case of
trying to take care of TODOs in the code?

[...]
> @@ -12,6 +13,24 @@ int cmd__read_cache(int argc, const char **argv)
>         int i, cnt =3D 1;
>         const char *name =3D NULL;
>
> +       if (argc =3D=3D 2 && !strcmp(argv[1], "--index-has-changes")) {
> +               struct strbuf sb =3D STRBUF_INIT;
> +               int ret;
> +
> +               setup_git_directory(the_repository);
> +               repo_config(the_repository, git_default_config, NULL);
> +               prepare_repo_settings(the_repository);
> +               the_repository->settings.command_requires_full_index =3D =
0;
> +
> +               repo_read_index(the_repository);
> +               ret =3D repo_index_has_changes(the_repository, NULL, &sb)=
;
> +               printf("has_changes=3D%d\n", ret);
> +               if (sb.len)
> +                       printf("dirty=3D%s\n", sb.buf);

This seems to presume a single dirty file, otherwise wouldn't the
printing look pretty odd?
