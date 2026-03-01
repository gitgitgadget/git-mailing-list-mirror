Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF318302779
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 02:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772333915; cv=pass; b=haop4HfxLV2DMhYEknRrjDgHSCiWcAnvOIaoKTRKuVkn1XXgYKNiObSXsa8pOm4BJKIDRAlo1XYI4h+bLc2EFIN0MwK9ud4YU/y3nqbS+Z5PkLNHQtbG9k6DBfzQls9EtY6vPuHX6/FyWxIPSBk/KCExpJx33jmbYyJKczGx7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772333915; c=relaxed/simple;
	bh=NBRph5Gu6wEL8MQbEtUjxUbj+V45IwKvNOeAY7GCHak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EC3PXeTQ6gacBj8xVBH8c/sx99Hovf4zwdYRvt93qb76OXeqmdec1tK/5wHO+VTv6OsNjEOvWHZE9c0dRCXHedcCedSK3vFljB3YHD0/a5/C0ty9+NipyDMdbs3ey/AcRHonCT82dmZaUF+Ue3ITS6mF4GU4qu9C8C5NWbcx1x0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TmuUvIzH; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TmuUvIzH"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5069ad750b7so29443631cf.2
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 18:58:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772333913; cv=none;
        d=google.com; s=arc-20240605;
        b=CYL/oZR2sO36oJygJkU2c/fq1xkiYKb4N2UnM/g8c1fcwDybareGR02zYkrRHjU/W7
         mKk5N1G9u+wlzNqgm9vEZ8ZgOdjME6M6nFxtM8YbCsLpK9LOtWGh5Sdlq6824ib78dEV
         xb4ctWIe9YhFhcR1/J0EnNiQiZ3HAHrThryVBkW1gmBI05ZNn/MY1kPohzELu9R4KASH
         e/+SR+ogtA513F/orXa3kYYt3S79fN2JV3NV2gZ4ykChnK5MukTTCs5Qel60UA10TrnI
         aB1G0unzDluB+mh8tJWS0kSx8sf+3JCXoHFvjwz8ClMcyrhznrxPLgxGbKVtD4GT3jpy
         HYVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qe/uFq4J7KXHEpK6wCyXrnBBux6xH+UiaoQHSsM79+4=;
        fh=MXCjipV1ColVCCEmU6NR2oIXn7IFiugzwBQMdbuDulg=;
        b=inn/icOiCJWddfj7EZCUode4biKo/zvK+DxhGy+3CWKSLKP/p+2felCK4SYVNsidiD
         4QYWjHE8/L5d4BZzbNorF3Wrf6vvAAtazfrhEhfUxKv7i60wLAl3NeaG+Puz/clER1fg
         y3lyQ6KejAwkK+KD9FQ4KvJVlfRzyx7B6vzbBw9lHt2bhyXsmrCh32UUoexdrcaVl4C7
         GsoTXASe0bamCZjB9FjRu7x32ie0ZOJYreuj1DdBslK3ca31Ry9asGup0iN2Fuyrc5ED
         ICIdY4zb/7RQtqq1nZPGw/x8Q/y43GqOGG12bO0eb1tvEhxdaqkmBV0a5KJJb5c/rSv5
         9WKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772333913; x=1772938713; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qe/uFq4J7KXHEpK6wCyXrnBBux6xH+UiaoQHSsM79+4=;
        b=TmuUvIzHxtO5ajuM7PR6BMGFJ61zILbJNK03cx32jwneD1kV3z1Ee0SsXqPlNVSfuc
         AVjVpURyThJLIBrqhHnPZyLUuAJFL3Q6qzChVLsYwdx9+k4N4uLOWlVHYYr0CudQHggF
         lBwkyPs0kC+yFWz7MFK5j6583PPAzcTw+OWW4Jchj0qCAnA1l9PzFvWaELH4SFdl+e/+
         xxZ98MKUbt9GGGxYlDCszH/URoxJM4oES2UTS3ThZS3J1iz/c/9d01Lg71CCnSRlmdTD
         ziQYikQVhtaP4m6AJ0fNe1j0iLkKi11aNM/fNbWQAqh35kpmky3i7P1v5vyn7eZ2tanL
         aTaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772333913; x=1772938713;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qe/uFq4J7KXHEpK6wCyXrnBBux6xH+UiaoQHSsM79+4=;
        b=YV44x/tnldmjy8VKVVApx6ZkEx5Q53DupZ8PWasZbnAjGEMsvuw3L7iRgwkn2ojRYc
         QA2jhLxnqUUoSfa+9rLSrACnLvJrm6iilvkubap0UaoRIwpaSn0tL0kV9y3wt1OcWpxK
         xNi1cyAFEJhO0pNOiCzUlt/GsA4Q1iauRZrP/BhVh5E6/unDpAJRuyry1y+LT7lqkNs8
         PNp6Yrfu2myD37HeqrZtVw66X9Q47WZTE+YjruH04aYjhccYdxktvwU8IMw6B05C300H
         BUjm/l7kjJOH1nJfrGXulORJsezPYnl64JfJLIecnh2YNngooBt+qoEdAeUfW545tdwl
         oKbg==
X-Gm-Message-State: AOJu0Yzq35h+mQ7xiPlaE+mUCzF7kb7AZqFo1ZK/vJE0quf26J6VGU5i
	G7p/O5yLd2vbeBojTQ565Bmos9qNWqe4R7CEei/ZxzlZLLoKRDsiMt59nw7+iUBR4VzEu3AN2Xb
	Q0HvPXJLOshZfkaMDJKaUnoiG7KLytNin6sFnnWg=
X-Gm-Gg: ATEYQzxcSRHJjEWolydUTCCE8HU58M/OaSdHGajbcOYJDVClYOFjXZw2SW9PeE8MMJO
	1N34bQpsghT00WzhZeQiHHUbNzJspIj71l2COTl4DOsojsUM1iS8p7FUn/AkSejYIOGYGbqHohh
	n2fWgw/jyYPZUMlZgfK4FS5JYImLRWOWaiHH3XFuSLp5nC/FV+uw7Vp0fjW+P1EAxtI8YBTsx5w
	8aGIdtppTXbSFfKAXUc5mdTBnvT8qlXT5ALI+eTxSud4uR+Q1hOYSSmni3lr2svQrXc2EJR8Cib
	1GK87VimeC+y8iwx4TKJfK4GFi7rZok+NHc67V74XjZ5xjvSFRfYm+iKUuFmQmm65WPIfMA0/dS
	jhnq9gipoXgE8mIlyUWLJSNx2uw==
X-Received: by 2002:a05:622a:1a9c:b0:502:9972:1119 with SMTP id
 d75a77b69052e-50752763030mr102067271cf.24.1772333912565; Sat, 28 Feb 2026
 18:58:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
From: JAYATHEERTH K <jayatheerthkulkarni2005@gmail.com>
Date: Sun, 1 Mar 2026 08:28:21 +0530
X-Gm-Features: AaiRm50QECUjOHI1lPpppQ_yMeQ7xciFYb6yOS9-A4wjJ8A6f0CJsxNIjLQBV_A
Message-ID: <CA+rGoLdTc2caDUsQedpegL+T4MqwwiA62uuDSFSawAT5vcPvWQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] repo: add support for path-related fields
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net, 
	kumarayushjha123@gmail.com, a3205153416@gmail.com, valusoutrik@gmail.com, 
	pushkarkumarsingh1970@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 1, 2026 at 4:14=E2=80=AFAM Lucas Seiki Oshiro
<lucasseikioshiro@gmail.com> wrote:
>
> Hi!
>

Hey Lucas,

> This patch series adds support for path-related fields in repo-info, base=
d on
> what we already have in git-rev-parse:
>
> 1. The two first patches moves the path formatting used by git-rev-parse =
to
>    path.c. This will allow us to reuse this code in git-repo-info
> 2. The second patch add a new flag --path-format to git-repo-info, simila=
r to
>    the flag of git-rev-parse with the same name
> 3. Add the new field `path.toplevel` as a proof of concept.
>
> This arises from the fact that I didn't know what should be the default b=
ehavior
> of git-repo-info when dealing with paths. Some ideas were:
>
> 1. Add --path-format, just like we have in git-rev-parse
> 2. Use what rev-parse uses by default
> 3. Add keys for both relative and absolute formats
>
> In this case, I'm using 1, but I'm not sure if it's the best option. One
> downside that I see here is that git-repo-info won't be able to return
> a relative and an absolute path for different keys in the same call.
>

Option 1 feels like the cleanest approach.
Even though it means git-repo-info can't return both a relative and
absolute path in the exact same call, it keeps the API highly predictable
for scripting without bloating the key namespace (which Option 3 would do).

The behaviour is different when compared to the command itself where we
have to use --all, but I think in this area this is the right approach.

> Since there are many people interested in contributing to git-repo-info, =
I'll
> leave the remaining path-related fields to them :-)
>

Thank you ;)

> I'm CC'ing here:
>
> - brian, who was the original author of the `print_path` [1]
> - Ayush, Tian, Jayatheerth, Soutrik and Pushkar, since they expressed int=
erested
>   in contributing to git-repo-info in GSoC. (I hope that I didn't forget =
anyone)
>
> This patch is based on top of master 2cc7191751 (The 8th batch, 2026-02-2=
7) with
> lo/repo-leftover-bits merged.


This provides a fantastic foundation.
I have updated my GSoC proposal based on these patches to build out
the remaining path.* keys, alongside category-based querying and
global state removal.

I will be sending that in a completely new thread shortly.

Regards
- Jayatheerth
