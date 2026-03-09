Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06463B585E
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773063982; cv=pass; b=TFeM8K+cHroI0o27coZMQmUdHny2u8mCAVnhKUubiNmDyVttVrhF7s1dV/WdPRKgXX4tgCAy1p3k5E15wE+hG6oVwQDjdV/uADFAyGkWLJ5XuIuTQFHudqco+WaTxBvbL5JzoeBS/+/NYPhsKKTpX30tOe0bK1XxeVjXDjYCjc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773063982; c=relaxed/simple;
	bh=ylzFnDAZuB0OdRuSbPxwyxD9UfIjWWl1LGkpNjKjqfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pGFPVq4OPnkd1zMS5yjuuMft+7RSsOCYA0RHl+s42d/xFt23hM+xhK/JXF103aXH9lpQRUr1+J7BKphTjwMdwgLfTaMVBnc/zVOAElewfAUG607msXV/1i0j5N3uZRPjbyBMsKRMy3DLGFiTyLPAnrZh4krHw9kepxbriNIV5+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dPCCqWad; arc=pass smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dPCCqWad"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-4094b31a037so4466223fac.1
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 06:46:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773063979; cv=none;
        d=google.com; s=arc-20240605;
        b=TLK3oFs9vEUbhFvLPQZOnHdc9w51yNImrXtnKMBbrpL4AJfHY0UaakPVnYdZ5rgxel
         BNomLU7wKlEYGnqcf2aDjzsXsn2aCTb0kMpbCD7XiRlnTVRFfuaPECiUzpqdP/KW2LAB
         LbFpqwlyozMJa2K9aUYnjZrwkJqA0oGkjz+0ONGBUFCl6lGkPuLBQ0GZKSiSESbQG4j+
         DkyvPr66QZ6moCT4Qay+HTIP1dfX2o2JNsMU+rNQoFUmzWUbsRpNjXGtW0UsV6c+9yYt
         VsxDCV8aG+nEgfE+7qBXdDX5AaNK8x5tZZ693aSq20usRVG8wce7JWEsOiJabUbTXRZd
         f7rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ylzFnDAZuB0OdRuSbPxwyxD9UfIjWWl1LGkpNjKjqfc=;
        fh=/plLnf0iYB2jUKmKx5zzdFfzrLcMAzuIidbw4Nsw5bM=;
        b=k4zy8mN3dDHd2TqLQUFB2Nri6HUhiFE3xrIneHOOyVwkwVmejxPHewFS29SrpDUZCk
         EKsFNEbnCLzYTWiPuJ81WdbYLqBjVC0yh+yesBnjBZXS7ONIwuaqiHQ+fKDmQAo5Zblo
         G7ACWtmKX+cXUNciMvHTN0u/E807QI4fGD2R5jjh1FdVSKABYAjpn1pNKGioG9fcsmpW
         TZMfRqh6AtsCSkIsjuqGEZExJUvLICQXq6aVMAfuwqEk2dTI5xiqmQb4JwytFkIkUphv
         VtEC3zdT815U1z8I+m3qq/G9DDkuX2R3gNcrHZuQkTtTMyLsQMizXOaDIuN1xd0nVYt7
         0MPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773063979; x=1773668779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ylzFnDAZuB0OdRuSbPxwyxD9UfIjWWl1LGkpNjKjqfc=;
        b=dPCCqWadIbbL7nJvS5dm/HS3FGsclj3ivuFE+Feb8p9gRCRg1cmo0PWVvy7I5Hz38d
         Gd7Yf7bH9M1SDooBB5ssHnxQonjq+SgLakIrt+5kYhgnTLC9lXLuEmK9wvvS9PPm5pBf
         TPl/XIFA9gR6NgBrsArWPZzdnX0QA323sOMZJRVlS/2/3jppk5k77QOSNGEc9MIguC4m
         bOJrHY1LaOpNqh9iIUS10Cdppa7T6fhCtLYl2vY7LtMDMe4CYlGsJBTxWYnUXKQ1qYs4
         XVpSQ9XQPDDQDvqvMUnWac0OF9uTxq0vVLiOKwR0rprxqDgxRVJPrYmjhC7i1OYP7R8k
         cyUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773063979; x=1773668779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ylzFnDAZuB0OdRuSbPxwyxD9UfIjWWl1LGkpNjKjqfc=;
        b=a1W/cYVoBR1jea3MeJXiTlF2P6btYfYpygCHykKkE9aIb77v2ktpK4YP/3f2iHcM/V
         HWW3bT7KrnI+3Q3X0tiIHy+AiRw8YZNWVLYfQQ7gzIl/v3WBExWMDAFlHza+XpL0NBYS
         B9DDYgITTsb0B5LfCT6eKH9OCK0eUTsVsDg7BjVrdZUIZ5gxbhN6js2N/X5v80PXbME6
         R30vHFXmIMs/lbD+ry45GLRRGYTmsbKBlmE1/6AovJOOsWbF13T6k2nSLM/KQ5seD630
         8Jgcv1KHgASGI++Ulm6aQPVaUoDfhb6R1dOqNpxQuTliDFzUvTei0ntNVNazJTYBfrw4
         qZGQ==
X-Gm-Message-State: AOJu0YwtDZBApbNW7drSTSHbiVkgxkE0PltESIZqnbusxxrLXwh9lg/G
	D7KCYmsATVMMz4dNMy2qdOVoeR58GzjHS5r5e/G+YJ1MgYy2l9Jprs3LJOZVNWN9Utm/vcoUoup
	Vy8r0sfVXNIcrcvXG2HW190+uu45cplU=
X-Gm-Gg: ATEYQzwwIeNctYMdBJHfepHpL/0BXvofBq7Oepkmapt2quW1m7Qyh5gVlMwsm7zoijt
	qOkudfOJIGidAM6/UCgS4B9HvZbQAr2knYLGZSbfpHbE6Of6jw9Vk+4sadLwk6XJJqnPkon42ql
	7Q4br2vlGUmMApjO/GyxuWlH8PYhaPRkAvDL2foqkgSza3FK8AAW+qeu9tHOO/ad79tMGXKQ11D
	N11XnHSHbmn6qbZBfh+FcCC+xHoq1OC5WNWVO/IHTCVbX8m7oU+cmpVBNJJ5t9VvwTljVSBcMIe
	J/n4BPZIAG4thtYJVq7uXZgGc4nW9VnfqbgTM0SkC225zr21N7gMOK2xcBkljG2MXLcE
X-Received: by 2002:a05:6870:478f:b0:409:8169:b413 with SMTP id
 586e51a60fabf-416e3eba247mr6241348fac.13.1773063979510; Mon, 09 Mar 2026
 06:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
In-Reply-To: <aa65h6Z_TrpJbmkj@ThinkPad-E14-Gen-6>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 9 Mar 2026 14:46:06 +0100
X-Gm-Features: AaiRm53lw_v14-AipbSP5s-OPZP_YTLGMUmQ88LPHEdU9eUVulzu5_5Cxv8J6Xg
Message-ID: <CAP8UFD3sicsPd903FU8bsj2B_4Q1DE1xB+--OxryY_jhL=sHdw@mail.gmail.com>
Subject: Re: [QUESTION] Improving disk space recovery for partial clones (GSoC 2026)
To: Yuvraj Singh Chauhan <ysinghcin@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Yuvraj,

On Mon, Mar 9, 2026 at 1:14=E2=80=AFPM Yuvraj Singh Chauhan <ysinghcin@gmai=
l.com> wrote:
>
> Hi,
>
> I'm interested in working on the "Improve disk space recovery for partial=
 clones" project.
> I am studying the codebase, particularly promisor-remote.c, builtin/backf=
ill.c,
> and the partial clone documentation.

Thanks for your interest in Git and this project.

> I have a question to clarify the scope and direction of the project.
> The project description mentions that git-backfill vs git-gc vs
> git-repack vs git-maintenance is still undecided.
> Has there been any recent discussion or consensus on this?
> I want to make sure my proposal aligns with the community's direction.

I don't think that there is a consensus on this. It seems to me that
someone said that git-backfill was likely not the best command for
this, but I don't remember where and when this happened. It could have
been in a private discussion.

Best.
