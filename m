Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED911A9FBD
	for <git@vger.kernel.org>; Sat, 21 Feb 2026 13:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771682350; cv=pass; b=CZVSmu0zJfps2ET4seIjFWH0z/SWcuCkimEht5Y8yQA8+wrBltaHqKcE1rocfUKOACN6+bHMtoAgk3iXK+4djQBGgauAGD9DyewVawe5kjr7xaGU39cdIfCbGqT74h/ds0EVTNr1M+z5aoUZm+DS2PsEo6P3z6Yxmq005WLLVZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771682350; c=relaxed/simple;
	bh=csjqV/U0nS5MyrdlE4+2vspgbr0cOQzxyVFk2MzmZI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOrOZrGDWFh50DmkasHMpvtjMA7xoRnzJ/BSIVVvDkUjAT6K74SOcY7U5XMA2VygyfOaPOARYNsVfCGRTMIlcGg38JsSrQgy5+LyOAa2/AIOUq1PUg+xGg96g7Hd/G7i/jvkmzmsdNBAwC7ucp1PwQPXlG8d+y+4KRHgCohKXUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LRj7Pn+o; arc=pass smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LRj7Pn+o"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35621da1a7dso1988473a91.0
        for <git@vger.kernel.org>; Sat, 21 Feb 2026 05:59:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771682349; cv=none;
        d=google.com; s=arc-20240605;
        b=X3y+p/k8BjR5B5OIL5m9Caz4+rwvvUkooIXTRGzgtBjSau6ZzxqkJRf1Wd0APt2Cfh
         PTwIy7Q9/+DqXa1nVCqA+XRvYQczz2RWHjMUDzjLtGFY7X7/22mC84ZjbBRh7PVXR4fy
         UqDtf8OE0w30f4n74HTsCkdHyxrs1XcqhonkKKIjpX3o6QRmH6S7mbMnWtmWe6ryyq8w
         DIHlYqpPPsvY8b6a2nrObA+eIrbV8WhfLQyi1KUxYR5VTWiZ9mLfNB2x9kI42V27dliU
         JQ8OZ1SGqBqE1qdj5g+4E+9Q31Yp6RWFudNFL4G2xh/QdOC+wViG4AWjs0ycvjkFwm+N
         tOaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j5Hr240ImnfXtE5J7pxDCNu5wdPo5hZ84cq61HkDCYw=;
        fh=slblncHp9SwgqUQvC1ey0ZTUwLeOmKk+aiIHichXuWA=;
        b=JFJXbl3qCwkGqKVrbAebHqJqUXHc2Eis/x+aRTSQHrD7cEdjMwAQGtWIsDBSSuvHZb
         6+EmWEE/YsBZh98Y+iyyg4c8/brmyCzDkss/eFr0GpYbZB4QRLbSlYTBr5YsjjuonmQl
         b2XOO1lvBPzftAEMEuFfNuyBDrFbWiKeWGruSrrDiOJzaXDx8gE4hfw64U5uqKUCR0sC
         zJvTLrB71imGLphHfSGHoGriSIt0SH/+lsInaBmDQ7o0UZKU1r51Mk/GjX5UMDmgtB72
         vhBiaYm0Fc9PaenXC22mWpObIuCeE205vglC3jHpL7XEsMrSavt2OLJuC1vVIaZjzhvI
         /cwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771682349; x=1772287149; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5Hr240ImnfXtE5J7pxDCNu5wdPo5hZ84cq61HkDCYw=;
        b=LRj7Pn+oV/PecNYHxc8E4Z3g76CFXT13iI71cl/uzpRiYIaXDP+j+uMW1cqKkchEAC
         c41DmIRnJkUoEjsta8sM1/vLhz4Uf7w7SO1x5zHc9yH+YM2WOC0rY7fOFdEeFl1X9xSB
         fm88WTxIagaHEtGLJBpeaJiDMa14KFn3oEis9C61H0KTpmDjFbCa6AHEaSbbg2PjL6S5
         bQlKdgbc6N560kCN/k8FNQf+PU6g12qjhaoNKFKfqLqcv3DhgwQpzG7mSU97d2SMuIiR
         8lcGvta0svlbAsTv5Q4f4sPMKIn0iVYOqJPxVFD5+tb7u/d9SMTiSbYm4aAl+HcyYGFP
         AurQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771682349; x=1772287149;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j5Hr240ImnfXtE5J7pxDCNu5wdPo5hZ84cq61HkDCYw=;
        b=Q5VIjT4pe2SJuKK9r9Ted9GFSGbeS8XygrgvdYr5c8sr+V5u+JWvcCB+LckYnF2dQG
         8zEs3u0UyHMQkk/CzTPLFbW3rC2IHryw3tx68IswyiohNcjCcG/6nlk1E9Q45YUFj9mk
         0+AAkk5/U5XoHd2YKYjTGFHoDpePqGhki/mbPr7OfQFUq3o82lGgeXuLoatCRJPe/SPd
         ExW81iJQjeWzbdeDwB5WhE4p6NrFCAEajzoXUgYUOmzwm5CIuT0UVJpjSFmwiCuBaJl3
         7zlLwUhjfFs+rDu8f59dn1WJJP0X+dKFCO1TOtvCQ70v32XcJWb/VbpSqoNP+IJKZQLL
         K48Q==
X-Gm-Message-State: AOJu0Yy5LMU3C1C/yRpgsYlETy5RXCQlrhXHob9IDx+rywTbkmJWYhAK
	zAjFrFda/A6RoBQCht60V9FoTxMCDkNLV2Gn0XNm+GRb2+ttSCScyHdBp7ELfKjTQ061ST9L2um
	1gfqJ7SeQ9EM8MShZIAqBuOcX2MepXB/fq5d6
X-Gm-Gg: AZuq6aIcJn9kB4lchtA0cnuY54vhH1m6+B39CfF9WCwDFQoFgLe8iVkeecqVazZkZ7O
	TU/mCsO3sBfYXJfMIOEDa+uf681bTj0p8gLbx+cU+9rBFE+9veRqo+4F2+58APK6Xfftl6X0WPR
	uHkUiaTFH1wfcIi4ZkFbnRonTCg2s9rc7/UbeSQrIlxDIotVG0dXcvpzO87o/kGMobjEQvvhDwE
	dKev+3Qe0b2xp+4rSUjMK+My5V4RzuRm4DomQYUfg/SdGpNdXoikO5rXXt5T24Z1g+SkON2rAQJ
	A7ZYaG97WVW1/zKvjvANyoHcF8EjOogX2KymNC6aNqcMLDFCa/17Fb7EmU/mZFqdjRZYFtHTaHJ
	WlHlhFJX0XEZvqcN8cLlu4LrXzQ==
X-Received: by 2002:a17:90b:4987:b0:339:ec9c:b275 with SMTP id
 98e67ed59e1d1-358ae7e86a8mr2961899a91.6.1771682348889; Sat, 21 Feb 2026
 05:59:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <9cdcc9de04f0f8fff657f0474b31c063466ed808.1771280837.git.ben.knoble+github@gmail.com>
 <611a94cd988e3795bc63dba2f1b270aa0d058bd2.1771425395.git.ben.knoble+github@gmail.com>
 <b40e96e3-7e22-454c-a69b-56af45795470@xiplink.com>
In-Reply-To: <b40e96e3-7e22-454c-a69b-56af45795470@xiplink.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Date: Sat, 21 Feb 2026 08:58:57 -0500
X-Gm-Features: AaiRm50MuQ2LHz760FwYlak5Wdlo9JUuczeIHgsGo2vDclKcfkPr2OmjGs1l8go
Message-ID: <CALnO6CBxVS199U+wcgw81GqXW4dv6=+L8TrjpvRNBYXgt1G1Ow@mail.gmail.com>
Subject: Re: [PATCH v5] build: regenerate config-list.h when Documentation changes
To: Marc Branchaud <marcnarc@xiplink.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Evan Martin <evan.martin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:10=E2=80=AFAM Marc Branchaud <marcnarc@xiplink.c=
om> wrote:
>
>
> On 2026-02-18 07:37, D. Ben Knoble wrote:
> > The Meson-based build doesn't know when to rebuild config-list.h, so th=
e
> > header is sometimes stale.
> >
> > For example, an old build directory might have config-list.h from befor=
e
> > 4173df5187 (submodule: introduce extensions.submodulePathConfig,
> > 2026-01-12), which added submodule.<name>.gitdir to the list. Without
> > it, t9902-completion.sh fails. Regenerating the config-list.h artifact
> > from sources fixes the artifact and the test.
> >
> > Teach the meson build to depend on the Documentation files that
> > generate-configlist.sh reads by having it an additional output as a lis=
t
> > of dependency files, since Meson does not have (or want) builtin suppor=
t
> > for globbing like Make.
>
> That sentence doesn't parse.  Maybe this?
>
> Since Meson does not have (or want) builtin support for globbing like
> Make, teach generate-configlist.sh to generate a dependency list of the
> Documentation files it reads, and have the Meson build incorporate that.
>
>                 M.

Thanks. That sentence is looking stranger than when I first wrote it. Will =
fix.
