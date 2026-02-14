Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A141C1AA7A6
	for <git@vger.kernel.org>; Sat, 14 Feb 2026 16:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771087816; cv=pass; b=gLklFKH6oIDet/PZ1RoMM2tNaDUZI2NuTxYAtwkRwe7ZkiTJMIX+KWgRYchyqfbljyB/5I7pKG5xUgWyuOR9OJYbiUSARSZ0FgDodb8758XWTQsf3IWm1cYcB9b378sI86gGN9bG6xpAUBetD1M7OuE4yZ5wyqKC9HtnfMb+c98=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771087816; c=relaxed/simple;
	bh=9E7iyoU5rU0473dk2MssuGPC2xuETBXqn5QkNuhM+dU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N19XfF0Aj/VnS73L11pigai2DfqKWAqXtdEM1pBuDhiU/231LZUjMrlzeMii/bnfuwTE9MGQ/HMLaTRiHV3Ir8zXlCrseIORjoiQqocok83I/BJo3zbF/o9PJ4h24K0KpOmES5Oee+576In2FQn3LASHtsX4InsbK12npBhoKsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5jnTf20; arc=pass smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5jnTf20"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3870df2331aso31640411fa.1
        for <git@vger.kernel.org>; Sat, 14 Feb 2026 08:50:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771087813; cv=none;
        d=google.com; s=arc-20240605;
        b=NfhHu9LTNxPG6yQ2CF6OUdXdcjxk998aXEpoTNqSgmRIKF1+jaAzavvy9/2R33Y6b2
         1jPAnGjvNZBjxmTSLiHB0JEs/vhZb5lhEPh6evFDQS87nmwpqs6jA2G0eK8bTGjdr0Sw
         GD+sOWNdRB6yY7KL7VOLs782vlzPp/rXFbDR/ItmPwPRrG1iH058eyTVWbRNlpWMWi8X
         V9oN7oA0QqlpE5vvoY20sn20uRC8b9E4L7efTspEYmPjjAjPqozlzssUoflIXxa67sU+
         5h/v35M6x4S1oeFRtnjM0K0tfUXn0qS/TcyP0FXwsOSbHQltKgiBEdHZYHOaqZU3Gzut
         NsMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EN0W0m3rxtpOkuXunF6rr0jaHgXiqdcRZSHo9Q7BqtM=;
        fh=V2m9a5jGMgYlM90uz0b1m6stuFGrPJdB3Z0gC2OAg2A=;
        b=PoRrWswSN4+VUzGF6ZIIU8c+sByix39PYH/haiZgLuQnnvbf+Z5dbf+raFV7q7lif9
         8eBtnJJp1+LhtIGV66zGjnj2ImhyXw8M0UViWJhMGo4hcEGLU2+odhL+qoifYGlS5VcU
         IOe/Nb9NlZWwEoumRb/V7XE+Q/U5d0mFri86T/Cg8XrcfouyI2D5H7XqjNFSBcKSG1hR
         SBLwGS0W9SDuJ6n5iEv4YytKG5l1bkrAI5RflQpz6e2jEw4OzWuW3kR2+4uTZl/qlNLL
         44eaaZIT2RQ9Y0S3eXF2LpLExCEKe+NPMbLjP45ggYFdv1TfocuWcPyT3PszX1AsR8Xr
         1HCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771087813; x=1771692613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EN0W0m3rxtpOkuXunF6rr0jaHgXiqdcRZSHo9Q7BqtM=;
        b=S5jnTf20LvT59t3JrpYL6w396ghIFvMW8NRiXqQfXzxSjPRoGOgBC5zag3Mb8h5Qwy
         HxhM48/XR3Fw9EVRALsRkEIbzmw7lpLX9+eW9AwUpcHzhQsa3eCa7cJ6AzqGW+2ENN7c
         aMU+RV/bp1Jb95a3lHSOYHM8qOQ3SIemI3skoCWyaxZ536ruuIvRw49ID8ar1VUR8MJr
         KyMO3VZDxLSdNt6sHvIQiJl2w718GEOT9FRgPHcIHzehDl23Tm+WYqDdmOW1S7flC7cl
         IIvRXXSLm2ygRX5QJErdAXuF2OmTXWD4XU223KGTRg+uFQ6Er9Tit2ThvvX/+2AqUYvs
         O3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771087813; x=1771692613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EN0W0m3rxtpOkuXunF6rr0jaHgXiqdcRZSHo9Q7BqtM=;
        b=nD/OnK1747ZxL6t+5TnoEhLhokuBoW/ZAO3b/LnrWTWAyWUd7Tgo0Ew/b1e3VAzAdY
         X5PE8ceyUTZRrzOVZo1IZcaQrnj+DSp1r8jsLR7WVUamfRIbAoOLynKJItI3eSCSYyEp
         OpOSGh/cfRuAjBCh9OLPDXGTn0FceKhlKgUGTWUUFNZM5nYVmxbZsGlqwRBCmOb6jyUb
         yW0Nty06n6Oly66ZUwFMal3AZcJBSpjBP7W6HV0NvagQZvturTm165YnBc1NZtDLw4Sd
         bydjleUdavnlu4IEPcaBzZsX6FNWjZw4WYY4S9hUGvhY8QPv46+7IJkT3Yaj49rEzYP5
         YCfA==
X-Gm-Message-State: AOJu0YxW5uEpFxhO2hvc9J2cdbYrjFt2+sK8pbSpFEEVJOi3wjaX2U5J
	Z/o0ki+wbrEgFwPWJ+4SDElH8IBAHEpZdRfcVToy6hG1QLi15jqVsvrKOVIHHo3wPn4a0peERz8
	N5bbp2gHC/rx+OvOFfRpvuqOPiQ00G1PFpg==
X-Gm-Gg: AZuq6aIW6JlR0WwWDqzdRTO/HP5QKZBkDSZS4y+3aupngrXTBr+vCU2CHa/rY1jgBzi
	CRF9B94ZcnuNDqNprBxGqkr/vEo8IT4eCa8Rm6XVW/c0/ibut5VnwV9hcu0ZBz4MzllwwPdzYuL
	yevPxTUXsB+7AZ3Ksf8IPw0WBjcLiTNIzbS/rg43gbk9lIEjXT89Fb2bYw/v+IGEOapbM30fd/C
	Z3SZuERlaUZJSHnjiRtuxeJbGNKLkfWLZVO7NWJUjYYz2C3oX5ozxRtBNn89dNoOpJngX5jueO8
	JcVnCd4Pk8uAseJw3dY=
X-Received: by 2002:a05:6512:6514:b0:59f:6f4f:547 with SMTP id
 2adb3069b0e04-59f6f4f07d3mr692717e87.3.1771087812392; Sat, 14 Feb 2026
 08:50:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213124656.218396-1-integral@archlinux.org>
 <CAPx1GvfsnZiUkkXJSAtt4HECT6f+zb1+vtiT+UikcAq0WuFR8Q@mail.gmail.com> <e2a5c920-7f15-4ea8-9390-cf42ac33082d@archlinux.org>
In-Reply-To: <e2a5c920-7f15-4ea8-9390-cf42ac33082d@archlinux.org>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 14 Feb 2026 08:50:00 -0800
X-Gm-Features: AZwV_QiynSKcjXUr8BZtemJGavNlnUQYv8VTkCUOba8TCXVLGptdz89GpbBwHS8
Message-ID: <CAPx1GvcdFN5gn97xxuNLRBy2sV2gK3Wm56Pw3tQGENN8_+BKnw@mail.gmail.com>
Subject: Re: [PATCH] copy.c: use `sendfile()` for in-kernel file copying on Linux
To: George Hu <integral@archlinux.org>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ah, more importantly, FreeBSD's sendfile only operates on sockets.

Both systems also need fallback code for un-handled cases.

Chris

On Sat, Feb 14, 2026 at 1:22=E2=80=AFAM George Hu <integral@archlinux.org> =
wrote:
>
> On 2/13/26 11:36 PM, Chris Torek wrote:
>
> > On Fri, Feb 13, 2026 at 4:47=E2=80=AFAM George Hu <integral@archlinux.o=
rg> wrote:
> >> The `sendfile()` system call copies data between one file descriptor
> >> and another within the kernel, which is more efficient than the
> >> combination of `read()` and `write()`.
> > sendfile() is found on other systems (notably BSDs), so perhaps ...
> >
> >> Signed-off-by: George Hu <integral@archlinux.org>
> >> ---
> >>   copy.c | 17 +++++++++++++++++
> >>   1 file changed, 17 insertions(+)
> >>
> >> diff --git a/copy.c b/copy.c
> >> index b668209b6c..d4b7cde764 100644
> >> --- a/copy.c
> >> +++ b/copy.c
> >> @@ -7,8 +7,23 @@
> >>   #include "strbuf.h"
> >>   #include "abspath.h"
> >>
> >> +#ifdef __linux__
> > ... this and the subsequent ifdef should be based on the feature,
> > rather than the OS.
> >
> > Chris
>
> Hello,
>
> Although the `sendfile()` system call exists in both Linux and BSDs,
> their semantics and APIs differ.
> The Linux prototype of `sendfile()` is:
>
> ssize_t sendfile(int out_fd, int in_fd, off_t *_Nullable offset, size_t
> count);
>
> While FreeBSD exposes:
>
> int sendfile(int fd, int s, off_t offset, size_t nbytes, struct sf_hdtr
> *hdtr, off_t *sbytes, int flags);
>
> George
