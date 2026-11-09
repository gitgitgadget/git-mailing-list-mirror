Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794227784;
	b=nhFB4mfsQKbiP5nxdWgOVCq5oDKIFccWHMFF0C8TogPFi3XzwT8OT1ds4yv6az37zeYP
	 +V3Da0kktGVD3zIiZfsD1OeREudJHCloCBFgwpoxNj7B5m2CWgBONYxEHcpWrSqPPbhz9
	 YHWe5jxIOjf1l9AYH3u3+5x4oOTx5msrisRCXrkowYuFFrPAI1uTwMRdwt/7tZ+8mIAmG
	 rMiHQpEQrFTXZ672W9QEUA+HV73s1FDx9kP9/g5nW5Pn/gOidQxGX1Yx/0PTp5EPPDWQT
	 KuH2XKKvbrC/0DwaVnsIX+vZkiw7xbz17HayBDNS59dvBAwsYrDMcdjeInf/FRBJOcA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227784;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=chDV5dUezGqIwxNtk1VMTLfpnUbFdG1HVy5UOLKJOt0=;
	b=zuIjfkKmSQbxTdMAL6PZj5iPl19efw0Ph0iRBfy9cF0ZgZ0++drgDflD0/8VGHZxqtuQ
	 hgQt2dl/QrF9edSPDiGCB+6tELNwKS/++uhmITehZVfm0VHiHIIUwWqzV/kLftc8NNSFq
	 EBZndh/iDxrByTftGXBEMHZJ0cfZuCPyNjTptyai8R7Uj0R2h67GpfKEu5MXnde0qoghK
	 nU1VCzl4UGb/VbMllo6zlIr/D14ZwqfCd0gpEbCA8y3n1KQ7VriB15JseIq6h3UEnX+oE
	 H38Fpo2srOhI5B3TJe6BOwJopmWaFaxHoPQRDYYZ8t2NFFONB7vEgbdk7lB21lcn/XQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPLYTv6T;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535C2606A321
	for <git@vger.kernel.org>; Mon,  9 Nov 2026 12:36:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 535C2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPLYTv6T
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b09a65c76dso535626a91.1
        for <git@vger.kernel.org>; Mon, 09 Nov 2026 04:36:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794227784; cv=none;
        d=google.com; s=arc-20260327;
        b=r23X5FR8WWoog50ZtJZh033skK0Dq5c+3yKTcHX9TWogVvow0PjPcCs56OnTA9B3Oq
         pHZhfY0Va82IwgHy3v9dpdzD+DAOcKtzl2ozjSj1Oz7/Prsv0Kpc8NBKpPwZo+dJArG7
         OgYPl3bMC4FOE7iq6sFdyIGAPenh3dAUzX5P4von4ynsywtiSLpYr+YD68y6K1853+8F
         x/D4SQOKoYXaTUxuQmytS4cWArwIKbeakaVWv1KQ770Ij5lV/d4x3ZJHTK2hQxxb2zGm
         MSRXmjj7Sto1YShL5ygv/kmoPkIDpRiiwLNMUsA+xornOnwUFqJ4Ar8/f0xeAmJPwckA
         7Dkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=chDV5dUezGqIwxNtk1VMTLfpnUbFdG1HVy5UOLKJOt0=;
        fh=Eypp9F2eIGM8yjcBouwCobaTySGdLfhs1xX9Y38NPVU=;
        b=q+ijxQM3YECFpKHp4SIibhMcRG9wDBz5FyFSUNtm82sLgMWgACCHkFsy0oMQUtKaPS
         YVpQV7Re7pCzZGZyt5Kbtd1wTItSzlJPdA6Fksmu6oLAm6zzoJSpvucq9vd6Yie0AnkX
         LGSUXEPGLqEBFuCsjYpGrUkApp6TRVgEGOl1zBuCJ9fj9mID2etGAfUYch7vA7a+4FNe
         6VNNaqkxZWvZNTny7Lk9f2mJBkvztcQTWvV45zGITzBlflOIrcmiG2vNbYc+UAOrh/ay
         wxEPvU1zXBCtDc1BaBAnxxQ9mVNshcRnjA5tHqabP7SSbu/KccwYOLjIK+qH2QPf6waP
         6tYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794227784; x=1794832584; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=chDV5dUezGqIwxNtk1VMTLfpnUbFdG1HVy5UOLKJOt0=;
        b=SPLYTv6TU+OlhsM85KbA8QHunolGKsQpWN0tuI+gi/Ftje8xOLASFB/82/ccrAZVBH
         COeQdBF2DtVNzYrQZAKVIPoEPHbPnGdd/fGG6jtOIVaqdGdJ7FDAi3qvcVwtigoc4R7Y
         EtNPnjgk1qBn7HOmgl5UZZ+1jbg4XqC7bFJ1Kp9WhNcR/kAvuhU2KbzlVL5e9vatlCGh
         GkuAI9nx1il17V72VsNBE0rAw1vQSLYlnZKdgClALI8T12BU2OgpZoPkDvwddjgOJcwy
         hjoyVsbHY/d/civtUiIyRJVuZ9PeSCw27ncoDxGbHrgADIDWUZ5IaVbk26flxcthorAM
         G7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794227784; x=1794832584;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=chDV5dUezGqIwxNtk1VMTLfpnUbFdG1HVy5UOLKJOt0=;
        b=Dxu5EYculg5n9REgw/e3QV5jmWkJfFbmK6BZHSQFMJbUs+KqE8nwp9hbPr+mbvt2Pc
         ddRvAvkc8L1xgyTaZKPw35Ltm0gUDaZa64pfmfWFrmDE2CvNqsSIWhYP3V7BVHFTOckC
         FMBSQ8eP/jRrTFPKkZmPhJWWBDC5tn2Ydcq2fS6o9W7fZwWE/9X7Guo1DZGDhpmJjNaQ
         l0znXqvMcMROfAhYNGzOHZcRwAcEmy8W8vC1vvYWwTg9cklXEpCGFmxFL9jq0JNE/qB0
         2lsDhuagmRHYtQONspJL1Z3u3aOHJgfIs029Zlu1R03SfEAbwAM1ZJDD4Wqlo1HW0rdK
         cBlQ==
X-Gm-Message-State: APuU4Z/BdqWQZ1y/uwwaO6d0R2BJ6UyeHJjHKEu4LJNEX836l6skxJGQ
	ailrgd3QkbPUug/PGDaS/w6RIlywR01/CeJElUtBn/F3QiAkPYtL01YQpEJzOJwfiZdxfQWrTcL
	YVmSHM1Yv4hN4QpcaP+W4kKTScksShx4=
X-Gm-Gg: AYBFou0XAyAuZPEzj/dWBkLZI5OzAc1srOnza0uRsTZCDj1bOITuIaBEBepLupUMZ1U
	Gmn/vOEW6VdntvfQUeWkFN3ifz4XROVbyk6C4XYpFLyvo+xW1xLiGpEtC+PJ6kxDUstVOA6y+8R
	kJvSgV+S6B8zYXGfm0Lyx/szypdDeDpkytU+nDMpA1jCG/O4ZDMQ+WOKjP71tJqhW4Le2sE/1dO
	BF86lBpfayBexbIg/6Wjg9yrt82DrTWsaB/eWtjC15sfcV7cILtVTeWSiNf4J3bsrsHzu+tn561
	FcoymqJC1t++cvPia7BhwI2rpRZoDOmezOu//7fNB/MVKdUUgCnHEWc4HxU/89pmPeKdcw4Efs8
	VYpzFscec9KrXewGR6WrL/YNxWrfpB3pXOnepRqqUTlaaHRg7gOGhEKf5Pk+ihM4SVxP34S6Jt+
	G0Xk6Ec5z9S3x19lG/y1K3q48+5WlnA4xQCyYZmNoGUXYkGe/I1rpVJSuPYjl5+34BgI4ehkz5e
	Mt83yXxjcsdCg==
X-Received: by 2002:a17:90b:2648:b0:3ae:533e:7e40 with SMTP id
 98e67ed59e1d1-3b12d3e707cmr3205858a91.23.1794227783585; Mon, 09 Nov 2026
 04:36:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030142137.54750-1-me@jaspermayone.com> <20261102182930.3511-1-me@jaspermayone.com>
 <20261102182930.3511-3-me@jaspermayone.com>
In-Reply-To: <20261102182930.3511-3-me@jaspermayone.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 9 Nov 2026 07:36:12 -0500
X-Gm-Features: AclHuK_c6g9RrkxdgqMPHZ6X6cWOfY66yj6LRTHJEILgYCA-SNqma7ZHiNP8QJU
Message-ID: <CALnO6CAjWNsj=X4fp5rst+yCTo2FNVH6g=xt4V=b+pwG68gVXg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] doc: for-each-ref: say how to read %(worktreepath) safely
To: Jasper Mayone <me@jaspermayone.com>
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com, 
	sunshine@sunshineco.com, kristofferhaugsbakk@fastmail.com, 
	haraldnordgren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 2, 2026 at 1:29=E2=80=AFPM Jasper Mayone <me@jaspermayone.com> =
wrote:
>
> The path that %(worktreepath) gives can contain a newline, which
> breaks a script that reads one record per line. Say how to avoid
> that: use a quoting option, or end the atom with %00 and look for the
> NUL before the LF that ends the record.
>
> Also say that only one worktree is shown when a branch is checked out
> in more than one worktree.

I was under the impression a branch could not be checked out in
multiple worktrees due to possible races from each worktree performing
updates; or at least, that the porcelain would refuse to create such
worktrees.

Has that limitation been lifted recently?

> Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
> Signed-off-by: Jasper Mayone <me@jaspermayone.com>
> ---
>  Documentation/git-for-each-ref.adoc | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-for-each-ref.adoc b/Documentation/git-for-=
each-ref.adoc
> index a7b31e8aaf..9247737aa7 100644
> --- a/Documentation/git-for-each-ref.adoc
> +++ b/Documentation/git-for-each-ref.adoc
> @@ -183,7 +183,12 @@ but if used together the last option is selected.
>  `worktreepath`::
>         The absolute path to the worktree in which the ref is checked
>         out, if it is checked out in any linked worktree. Empty string
> -       otherwise.
> +       otherwise. If the ref is checked out in more than one worktree,
> +       only one of them is shown. The path can contain a newline, so
> +       use one of the quoting options such as `--shell`, or follow
> +       `%(worktreepath)` with `%00` and parse the output by looking for
> +       the `NUL` after the path and then for the `LF` that ends each
> +       record.
>
>  `ahead-behind:<commit-ish>`::
>         Two integers, separated by a space, demonstrating the number of
> --
> 2.56.0
>


--=20
D. Ben Knoble
