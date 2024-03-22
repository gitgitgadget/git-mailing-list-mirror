Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6EC7FBB1
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 23:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711148570; cv=none; b=ZhGq7fN2NkkxkduzAy0PO5JOAU7/tJmeoK8v6ytogmivlG4ySGTVdlMDe6b4/VC9vuAEZ4hgmlQRJgl1ML+5z+wwkMf3oKRdk1MZKo5vQpqaLGMyxRL0ywT6JBeB3Nt69UjPZKoSFk3sS4xeuikI5DioqK3/mom0eGG+KPyvuFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711148570; c=relaxed/simple;
	bh=9fdVK244k6eP8UVI8fk42FqKL1RNp1UIwOdfKeyPGzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NYL6y3gjKbesR80OBTdt/FNIOSyuPgPhmId8MLjSNLGwG/rMGBjECeVjxAaHAebPChcYXfpB1dV4llbTfjOVb8wDiiNBsGHtR9i5/kR/azZHRLMoAQb13oUnS59lnc9ro5fJej6ZducDII9CCM3O8up6eUBlI47vryGR3ZgZdoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-690be110d0dso17314336d6.3
        for <git@vger.kernel.org>; Fri, 22 Mar 2024 16:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711148567; x=1711753367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fdVK244k6eP8UVI8fk42FqKL1RNp1UIwOdfKeyPGzk=;
        b=vNYqGs9ONrJYzxwJpMiggsGuRd1XNDCkiScbVBspXu/dj1yEnQI9YUbpLyFEPRjqqj
         MpwZQfdv21f6/CmUIlO5jK/tCJm6u4ran0e6fkdrsa7ZtMlWvi1mCvaXJCy1JnyGrLA6
         SHZwYzy6NE4v6jtxZSY2VYvxS17OprqBy6QbX0x0Z6RU3xpN3BereBUizHI++NSB4ph4
         CKMBwir6Wx9IRq3BByye570FZ4WGP6AcFYQW4Ycoa7t1KbolFZgcVgm1XUQjQeQpLkSU
         xswG3i7+5dqEjrX0jbhvmJBwzEtFgVvzSYudt6P9TCSpjXPQOjXxCNHxcm8gF2bmP9li
         Pk7w==
X-Gm-Message-State: AOJu0YwxK/cCW6Esdu5zwx9RElh8JZtwt+fw9tAIdFebFw8cWgZqx12K
	wNMpKOBZnu4J8aYOjEASbnfAS7+HdfOMyqKNNngtuGR1xXzQ+8KUABFDFdseVPAFP82EDiLc/l4
	DQLkBaj1Th1GxTg+M1RnzGO/EoiUK3NJhmsM=
X-Google-Smtp-Source: AGHT+IGBmuJQCnxiAjz/zy0kLrjs1rlT8lR6VOXjeZacOMS4EBtooxYFQb6SaRkKO8+CFzZ9xbeOWtIUYdkQxThKVz8=
X-Received: by 2002:a05:6214:1d02:b0:696:52f7:d856 with SMTP id
 e2-20020a0562141d0200b0069652f7d856mr849316qvd.23.1711148567448; Fri, 22 Mar
 2024 16:02:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322221327.12204-1-mg@max.gautier.name> <20240322221327.12204-7-mg@max.gautier.name>
In-Reply-To: <20240322221327.12204-7-mg@max.gautier.name>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 22 Mar 2024 19:02:36 -0400
Message-ID: <CAPig+cT=8WkxZF1vy-2dgSspFeGOQzUFRk6w+MYVCXyRAsfR8A@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] maintenance: update tests for systemd scheduler
To: Max Gautier <mg@max.gautier.name>
Cc: git@vger.kernel.org, =?UTF-8?B?TMOpbmHDr2MgSHVhcmQ=?= <lenaic@lhuard.fr>, 
	Derrick Stolee <stolee@gmail.com>, Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 6:13=E2=80=AFPM Max Gautier <mg@max.gautier.name> w=
rote:
> The systemd units are now in the source tree, rather than produced when
> running git maitenance start. There is no need anymore to couple
> validating the units and testing `git maintenance start`.

s/maitenance/maintenance/

> Adjust the test to verify the new `systemctl` command used, discard
> checks for presence/absence of unit files in $XDG_CONFIG_HOME.
>
> Validate the systemd units in the source tree, with one test per unit to
> have more distinct failures.
>
> Signed-off-by: Max Gautier <mg@max.gautier.name>

In a patch series, in order to preserve "bisectability", we want to
ensure that the entire test suite continues to pass after each patch
is applied. A such, we normally update tests -- to ensure that they
continue passing -- in each patch which changes some
testable/observable behavior. However, this series only updates test
in the final patch. Doesn't that break bisectability? Or am I
misunderstanding something?
