Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E6121FF38
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066153; cv=none; b=Q3Jr4HUDMgmFnCnzpya8TVn1Dkmo6zPnD8/RggvaeiC5+g1LQ6+3AnegP+YD/HHSNYwEpJM+YWRCQ+Y4GncSyNt32qsaIdfQz9g520QM3DDlv7kLm2ME7nxStQRnXFLaN9sg9ZezCJUFsl0+JmmPjb9ySp9W455SFWNHZLxWiko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066153; c=relaxed/simple;
	bh=cxwdPCALiJUYindUK19jrE91/P0y27v7SSCGmAIHzxs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ojdv/Znz6iCYF5j7XxgpP2HtJKuLqcQKQy99X9WELHRDoNWhNmuJROjGbi9gU2oM43GBSFuq9epBmuKlzykVK6Qa2hCSkLsYv8RiAaPPI+aDTRYkI7FWEN3yuzN7zkaN4412+F5+XC6datnkuSRI2qS9Ktb79m18rxZiROnPlq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QvO6+PDg; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QvO6+PDg"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-409470ad5bbso1753195fac.0
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 13:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770066151; x=1770670951; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RUC80/IaNikJAVDbDg5FcIbVhmdx/IJgPJ15JQ7MXrg=;
        b=QvO6+PDguhXIEQJCiACCx4Gbl0F7ggGHhjRcfF/2S+K/EVx6Us01GP+rk8LcQC/BGJ
         QzqzjfAii09CJX/1J6Xw1vJKW16gRyFVvLv4xOaSe8daS0XKwGZ4FDqXJNaJLgnL/SO6
         eIIoo/4xN25j7k66t3vDsKAtgQd58SjXt7Bv7tarJYlDbePesQoHz2r3XXas9wgsJ00w
         39Y3j6FtlGVWaUK/fiKVCAig/MxCJWZN7XD2nyzmZXS/swVsu46p4uUd3qSDFd35ujxW
         pKeCk01qZUJpNJZ6Ulg3ees5JsAF+kcL944MXTe36G54P1Exat90Y153YXQ4yjT8WSBY
         ZvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770066151; x=1770670951;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RUC80/IaNikJAVDbDg5FcIbVhmdx/IJgPJ15JQ7MXrg=;
        b=FK0NY5foC3pEeNr/UlPAjy3qQA+FInpRy8x8fBNSNGhPL5jIkoDme3fEJDLno1p4dz
         aiAa271yFNdhmqhGkl7Rk17FRn5MH0dmzKqnDWUJyF5RD4jij2FsIZjihQa9U1eoUIta
         ay4nSiRCEa20YmysP4b0tEgEuE0bRZ0jueAnqlpNcIEz6VuDwodvYAMBtcaLuKaOFnRv
         5YZziXifVVsQL3ChxKluZ+lKYpyIiuyykxeN821arueMGXh/mu4AQTrqisOb+l9O4Cab
         /1DbdNtN1myFLCcNBVsxQV8rQfazM9HNZ1PAvByHtsZ8Zfm8lNjhjwtxxvcJPDVGLt2b
         ZxcQ==
X-Gm-Message-State: AOJu0Yx+3riQF1tidIuObWe1gzTRsatpl8fLlCsYh0HgP+Tpsj+WjD2s
	yvV8xpzam6ufyLjjVWupaCeHXaqSViKbE4awA1KhgbSWMVK6ZaCTwmJw
X-Gm-Gg: AZuq6aKblW+lSIhJdxawuJVbAyGbO3fG0yhuZLcX5ArRVxx76tGFlx5RUTqTMhq723R
	R44KqI4qn2iEDDWI6SKzWVZhvtyzbTkPrjAm1f6zGwg7wMn0dq14zwu2iNiBSfYF1GkX7/dz1ph
	9ztcN2sQcpqbwC8BKpD+Q6lqijrTl6SeE7T3Z0iGbXNMG9394wburqWBp8bpec0TdAHlCnbep/e
	lpXrna/YODTcvaD7d4MByqypkz0ODNHlMJ7Vd5aJZbYQRC1EJFVvLrNf96FiILabpLNEq44gcjf
	6nTYORxlzZ7Fs6dWESpsqLnAXtFzfXMndFzJKQlvO+OuVzxQ19jR8vd7inwY2xIjGjd3jsHYNIu
	/+4K8fYHNPL7CexBrNNtTPyvj1/hTs4fMevx+kUOQ6FGNjkHJ4BVXDWW7NQ4PWGj0ghg8nN2mP/
	fj4au/cG6EBnBytqe23zkD6KDf5BuAw0x0k9/YVFEdSXEsa+U=
X-Received: by 2002:a05:6870:380c:b0:404:383f:56bb with SMTP id 586e51a60fabf-409a6cf568emr6531184fac.35.1770066151202;
        Mon, 02 Feb 2026 13:02:31 -0800 (PST)
Received: from smtpclient.apple ([107.11.98.107])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-409571ae8f5sm11823344fac.9.2026.02.02.13.02.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2026 13:02:29 -0800 (PST)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.300.41.1.7\))
Subject: Re: [PATCH 0/5] submodule: add 'reversive' traversal options to
 foreach
From: William Hatfield <whatfield.git@gmail.com>
In-Reply-To: <xmqqbji7yo3x.fsf@gitster.g>
Date: Mon, 2 Feb 2026 16:02:16 -0500
Cc: git@vger.kernel.org,
 glencbz@gmail.com,
 avarab@gmail.com,
 ps@pks.im
Content-Transfer-Encoding: quoted-printable
Message-Id: <1F5D3AAF-3E5E-4AD0-A48B-90B9D545FB21@gmail.com>
References: <20260131214309.1899376-1-whatfield.git@gmail.com>
 <xmqqbji7yo3x.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.300.41.1.7)


> On Feb 2, 2026, at 1:52=E2=80=AFPM, Junio C Hamano <gitster@pobox.com> =
wrote:
>=20
> William Hatfield <whatfield.git@gmail.com> writes:
>=20
>> This series introduces robust post-order (dependency-ordered) =
traversal to
>> `git submodule foreach` through three new flags: =
`--reverse-traversal`,
>> `--append-superproject`, and the shorthand `--reversive`. These =
options allow
>> users to process nested submodules before their parents and include =
the
>> superproject in the operation, enabling reliable automation for
>> dependency-ordered cleanup, builds, and deployment workflows.
>>=20
>> Highlights:
>> - Implements all new traversal flags in both the C helper and shell =
script.
>> - Provides a comprehensive test suite (t7425) that validates the new =
behaviors.
>> - Updates documentation to describe the new options and their =
intended use.
>>=20
>> These changes make submodule automation more powerful and flexible =
for advanced
>> and dependency-sensitive use cases.
>=20
> A few comments on the overall structure and concepts.
>=20
> * We do not want to see tests in a commit separate from the commit
>   that fixes.  The downside of such a layout of a series needs to
>   be understood.  An earlier step of a series may introduce a line
>   with "test_expect_failure" plus a short summary of what the piece
>   fixes, followed by a large amount of code to show exactly what is
>   being tested and expected outcome.  But when reading the step
>   that comes later that fixes the issue, readers will only see
>   changes from "test_expect_failure" to "test_expect success" with
>   most of the test to remind them what the issue was hidden away
>   from the view, in the post-context of patch hunk.  A commit that
>   has both the fix and the test that describes the expectation is
>   much easier to work with.
>=20
> * The name "--reverse-traversal" makes sense only to those who know
>   what the normal traversal order is, but it is far from clear what
>   the normal submodule traversal order is, because there is no
>   "natural" order to traverse.  Any of the combination of "top
>   down/bottom up" "width first/depth first" would make sense
>   depending on the application.  If you are doing "bottom up", for
>   example, please name it as such.
>=20
> * The name "--append-superproject" sounds strange.  It sounds as if
>   you are appending the superproject to something else, but I
>   suspect that is not what is happening; instead perhaps you are
>   leaving the traversal of the superproject at the end, or
>   something?
>=20
> Thanks.

Thank you for the feedback, I will apply it in regard to test fixes in =
the same commit.

Do you have any recommendation regarding names of these flags?

Do you have a preference for: =E2=80=94postorder-traversal or =
=E2=80=94bottom-up-traversal?

What about: =E2=80=94include-superpoject or =
=E2=80=94execute-in-superproject-last?=
