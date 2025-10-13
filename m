Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90ABC2FE062
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 09:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760348632; cv=none; b=Dthc10s0EAzRhGuyeRVTlpIWJQITmVnpm0JUTE3TczfJPHQ+0Yz+bSXyhLAkH6kSr4zXqwtZ7vow1uoUIuK1m+TPZ0VzMxGYFCu70jhZt7u+61MXCb4azRlYhIf8F9nmymwtX0fqINA3eQWuYI6XAWa2mxoWEMSvNXfGq+qMxQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760348632; c=relaxed/simple;
	bh=WlpILWURsk10WmboIxkaQ0gsQ/h4yhs3G68+yjymEpk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sX1QZiZK+oTVfkpWlhMUse6ILuw/znwOGVbWGAK9GsD3POc73U8GEhgUQxiq2jXqw4Viqvo8Fds9w+51yWBrNhvEJixaQ/LuWnIKZygHPb1kPS9UDVmqSyeIe6AG79Mp+kIBvym1o1vunlIj1G9dDzvqXv+GqxWESgGDAGdcgvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgnBoeVF; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgnBoeVF"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b3b3a6f4dd4so725654166b.0
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 02:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760348629; x=1760953429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bVHxC8VeVudE2mBmgpNe1RbtLMpyruFou7+CAM1c70A=;
        b=UgnBoeVF4L0b+NJAdm2EgIy5tPdSiZvLlHLZ3v/5EKDOIl0u1DK8kV4XQNuJ1NHr13
         sX1xe22v6qvCkIOf+X8WuWNQJHbK3Op4pyGZZLu7uc/5CoMeeayAM+mdntDHHR1ewqtA
         2zawrsdfgqObJ8AiBk+lh9oVCbNICZPDP77pMx9A/x9bUeL5mbMJhDqzPpBUVhNqvuK+
         Q0GinJypD0LN5QVpMOPEihThwGIkopIIuTMEpPESvepSyEVS+izXs6XAywef7GhbtlBU
         vTl0K/zUNZghSm7mHKfpH9KyQfYDKCe64sKKPFDyO9Qb0gmW2rb1MT6js72uTzBTCyW4
         azuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760348629; x=1760953429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bVHxC8VeVudE2mBmgpNe1RbtLMpyruFou7+CAM1c70A=;
        b=jQud5F/+lb9N3Wy37A9Uh4Cd3z94fSS9Qt1LCgahiUlwunwpjGdtRGYjw4WYV/3kI4
         ZTeGWYc2Xi2RANMRhw5rsvvEtsUO+bq+DrgFxddvxuR4d9mknBolKIek/1NUcgAdVRat
         eJ/qvuK6+PDfADgmSOl0YLW6cg1f3nkZA2ZToCf42ri0tDq0fR0J9E3yE+5MAMjPDjjT
         zJ0GTlHix6bflc8JPDrZenjlc2E+DHul/GYKL5yaWg/P2BxLxG5UUamonY0BPvAeBo7p
         Ypa1bsVCKSG4cUJFE4KJbMB0JWoNrt8hky3mncDbDFBwwB3VcbKdTYJn5Jmqm2YLOc15
         J8qA==
X-Gm-Message-State: AOJu0YwLXbuIAel5cud8/A7UnaomOqnzkIVb87Qw3H0UJYdU457Ox7tZ
	S40HITEFOZKHAWjI5+T3sGX/IpHC5j56Ccnh/HhCj/4Etauyfvfro0AFQ/kc8yCDQ6Z+0Se++x4
	m+PoqlAlgZ31Et9t9JjsiVzl+Cp3S//VvsgAP1XM=
X-Gm-Gg: ASbGncv+3RmeGrUUCaK+EBsCbgFsHy6Z6dY25YW3Ya9cggtHcXxx1lcCwI7pUT8JIJC
	El7NYiWJpBZeMyjeeI7DmFuAZoJ7CrFmSgJN+CgJs2MkXQRTOs6G1PGvp1C9gjQZKi3qFdGDpnY
	VBeT6CYvtAByq4LqaEBoG/5QwcGOW6AuBszlJ8HDozuIg9RKNnft/tH1+ApP4rnrRR9koKNXtB2
	CmU+yHVNtnAIQKAk/lrupbLa5or6zoS87Ua
X-Google-Smtp-Source: AGHT+IEL1UBeYwIwC9d/+2OaK7kss9OiOAjSbFZvuFTAVgDkL2baO/FQxKMb/1Gczmk3ouLksVWjTJfObLQc2lL8yYQ=
X-Received: by 2002:a17:906:7313:b0:b09:2331:f150 with SMTP id
 a640c23a62f3a-b50aaa9bc9fmr2112816766b.16.1760348628735; Mon, 13 Oct 2025
 02:43:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251011093611.62937-1-okhuomonajayi54@gmail.com>
In-Reply-To: <20251011093611.62937-1-okhuomonajayi54@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 13 Oct 2025 11:43:36 +0200
X-Gm-Features: AS18NWA-h8CMjRJQOQBJu6c9Qp80LEpNAIeMhMXPVkyhARNtAvLec7eWaKKsrTI
Message-ID: <CAP8UFD3nn=n3XLRKjrHpMOM4uf3wCFGMjdy13wOp=_vZHTeYWw@mail.gmail.com>
Subject: Re: [PATCH v2] [Outreachy] commit.c: clarify comment describing
 commit re-parse behavior
To: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 11, 2025 at 11:36=E2=80=AFAM Okhuomon Ajayi
<okhuomonajayi54@gmail.com> wrote:
>
> The existing comment in `parse_commit_buffer()` mentioned a "leftover
> from an earlier failed parse", which could be confusing to new readers.
> It implied an error state rather than the intended cleanup before
> re-parsing a commit.
>
> Clarifying the comment makes it explicit that we reset the parent list

We use an imperative mood to describe what a patch does. (See the
"imperative-mood" section of Documentation/SubmittingPatches.)

So maybe: "Clarify the comment to make it explicit..." or "Let's
clarify the comment to make it explicit..."

> to ensure a clean state before re-parsing, which improves readability
> and avoids misunderstanding during future maintenance.
>
> Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
> ---

When looking at your email on the mailing list archive:

https://lore.kernel.org/git/20251011093611.62937-1-okhuomonajayi54@gmail.co=
m/T/#u

it looks like your message is the only one in its thread. So it's not
easy to understand why it's a "v2", and what the corresponding v1 is.

To link a message to a previous one, there is the "In-Reply-To:" email
header. It can be added using the `--in-reply-to=3D'...'` command line
option if you use `git send-email` to send emails. (Not sure how to do
it with GigGitGadget.)

At the very least, you could add a regular link to this part of your
email (after line containing only three dash characters above) maybe
like this:

https://lore.kernel.org/git/20251010233303.783212-1-okhuomonajayi54@gmail.c=
om/

By the way, in this part of your email patches, if there is no cover
letter where you already do it, it's a good idea to explain the
context of the patch, and when it's not the first version, to list the
changes compared to the previous version and often to provide a
range-diff. (See Documentation/SubmittingPatches about the cover
letter.)

>  commit.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Thanks.
