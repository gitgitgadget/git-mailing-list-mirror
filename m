Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691077;
	b=Hc76DlgbKNOd3bVgRqvmFvTyygWmr5aQBiLC9gdDtrw5xk9bNPh3+oL0ghXiu5CAXNqP
	 XWyWQUp9Zg936Q0GhbI3Y1lKb+q58eJ+YgLXoI3hKC80SqJW3Qv7whKMPqX8u8QnNz5B6
	 Z4st16MyJ8RefY+9CKSeTeE4242lolQDz25Fr3G2mt8caOQj3bH0kqMrcWSP5jxsuHsav
	 upv5hB4gj+88TNfnv7ZLm6372C0J2LuGDkuSJvWr1eQ7gb6mVJfGTPUgIRonPLx7PeRf3
	 HEZG6LdNuiI3RFO/dMNGrl0dzJdYWF9+56e+ykSSxAeK1NIT5mrrXXkseksXl17jyhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691077;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=/+RhVMv/uTJGMFNvR/ZTNifWtezTBDOFzfbDRZzk9D0=;
	b=2hdV+MzxiPnLwWjf23EXNUDMt5vpgeJ8OBFmNQR/SP/LrGTWAF17yPWvpuuNCW+UHQgo
	 moSfDsOHvzefGLzjiNHN2soWrisrkpY8C9WmHXHjxbMUURolKHvXTxzsTovdMuwe4bQEE
	 vWJ7M5qGcYoMQvS9iNZNyQgpTAp/aahgKbnqnFta+8Uo1Gf+IxdKdgNBNV7ToUq3PLnvW
	 +JwNobD1iH3y1azDlNOROhn8HqUcxGJ93N2hk9dDIEXz+3fX1hieRl3QlmhIt+Ahj8xhy
	 f+k1pLr9qus82NMuNozV+p2jFaQwZLeBmTELsGwMeCdPqS0JtKelIU5GzM+Cz0heezg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jaspermayone.com;
	spf=pass smtp.mailfrom=singlefeather.com;
	dkim=pass header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=cdDGVmBm;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FD1606A319
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 17:44:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23FD1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaspermayone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=singlefeather.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jaspermayone.com header.i=@jaspermayone.com header.a=rsa-sha256 header.s=google header.b=cdDGVmBm
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-8451a619da7so4289a34.1
        for <git@vger.kernel.org>; Thu, 22 Oct 2026 10:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jaspermayone.com; s=google; t=1792691076; x=1793295876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/+RhVMv/uTJGMFNvR/ZTNifWtezTBDOFzfbDRZzk9D0=;
        b=cdDGVmBmBoYk1W5fv3/L6fzBtu/h/3D/ngj6Pnn0XAZ26z7hTyAhj4ZUO+lxiUPpC+
         68BGRkUUgyvAf5loyOgezY0o+94QayiMWW7BGFPQTlqK2RyMZtVYU0DE7n7CKWw9BwTc
         Z9ZKAikWPA64XdVERdCo0DatPN4prWl7aKKgbkkjyk8vCtzGPhpsWUdWYZpeTMGYuJsm
         a93Iv+2eWL5YIvSZsNW23N4nEl8yRBWHMBiAHaHO3m0ElA5uwoXgR0K9bYB+9PpfSeMR
         RSDzinMAukT/+ldnoPFs7NP/dU4Qmu35bviEiT6sUQ1+/fUYMYbWXsHgqM1tAGYq2RYy
         +dMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792691076; x=1793295876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/+RhVMv/uTJGMFNvR/ZTNifWtezTBDOFzfbDRZzk9D0=;
        b=Z7aySm2wCmeCsf9nIdHK883NoycT9+sJqRoCkUxXqj47k2DN1vkErP7KkXhQEv0/iH
         liMca1AFGYU2GDxU9kw/6jt6mNxdSHzDgnkB/IVFO10CC85lOhnQb2dULHMBrtObBk5f
         UZgMb0q1wuboE31AUjHu8fK+3GAY9tQFXQaJvRkHwB6Ug/AK7VzhIts/k08dwDra18xW
         xebkzYmGPLl8jYSllgCw4j6VaMjZurTbghDLR3CoXaJVnLYPzXBZxSR18m/3ZbjVh9bd
         TB4b7Rhwkt9UW0ttXXp+srJtpi135se74ORHlECZu/YL0HyWFvTAjeHRa9tmYCbaR2xf
         iYLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzts5+mr/lVHTArJKQuxbLF+rIkk0bKJkA/2XYWnz+URjD7egi4dXWZA2t9J0eJb9OjBN0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKCmQ48LSewo1VQDPO3Ik/h5jJGCncTAmEHXXe63kDnrL5INrD
	FE/rl7NPZW8MeAbQFg2sGl++ItCuFersiRcVDQv6SCW/XbT4fLWRgpdAD+aieLqW6WQFQmsxJ4G
	BD8fMHVc64GyxKmu+Ecnz0f6wp3Ft5LCTdmhYbBzdGsBurtU90v3HNDjuqRVpu8SlMHIe1rEOMf
	rsj2Vtj7A6gKD76GI/2Dvqe8LTfdvMPfQ=
X-Gm-Gg: AYBFou0LupOxCuXa51lgptERNpPtfPZU8LxW0B4kFQUqeEf2GxGKl+ky4R1qwOjSdKI
	gCVTibm5ygvdSWQa5smz5fXkiBloyy6Gtgk6+bWwA6K8+eQCpChoIi0jdugzAURkgSN1j374L5R
	iBLH5sqDQiIFIDRvyHV+Q6AzKCdeX6GqlV22RgNO+D+sp3O09tM1+OQ3oUzJz0WXVf2gKvKMrM1
	yeq2QVxBPlsoI5i722QcwGofprVeF65GKYh/HCJurSAht56Ae7yF5LQFW/zbFn2TAPMao/v4x6/
	1hOOKBzy8/kcVNII4/Q2nH232TMx9jcJy5EsxR/Iu6bSAT6ptAagzTGHozgbvLmRzZhaPxwzNvE
	L+M+RGoDfSJHbE3/Qrf0dq439A+yWMYCWVu1VXly8SQYFSQ567eW/oxnQR6IotoCgTUduorKPHP
	ao5rjKmesmaajEf6NfGpAexYJMPxN0yx18e8mBw2jKohDoR8SIvLd79tSkCURVZq6PkNDvOh3Lf
	rMbSP8OtpIkBXporbfS3YP7KHq1sJMgYEzh8UsOWmiaN+2WMeyiWQwj5G9deZs43bu7KBZiuJuq
	eagy1JeT2gG8hMiskYgsy0NMyhg8tQATKPLh1F4PFJt3cVn3St+WLsKVA+OdwyYnebP5tzrl2Hf
	WzBZpKrp/nDEn8jPFx5Xpu+uT4vdpCse1S8LqlEQmBd6oBzFgprCFVrVNremTLXpy9T8ecdGuhq
	42v8EMLhlXq+/+59vKFv/WCeYEZ8p9siB/XvmwuSiBQ0mkX/W920hlNTRtlBtcP9FvEfslaEp1I
	+iobnnblLUfddtcnPJeaZQl
X-Received: by 2002:a05:6830:3495:b0:806:9a8d:4b9b with SMTP id 46e09a7af769-84d0890bfcemr4895425a34.15.1792691075979;
        Thu, 22 Oct 2026 10:44:35 -0700 (PDT)
Received: from remus.wildebeest-stargazer.ts.net ([69.43.66.31])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-84f7703d288sm377794a34.4.2026.10.22.10.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 10:44:35 -0700 (PDT)
From: Jasper Mayone <me@jaspermayone.com>
To: haraldnordgren@gmail.com
Cc: gitster@pobox.com,
	gitgitgadget@gmail.com,
	git@vger.kernel.org,
	kristofferhaugsbakk@fastmail.com,
	ben.knoble@gmail.com,
	phillip.wood123@gmail.com,
	Jasper Mayone <me@jaspermayone.com>
Subject: Re: [PATCH v3 0/3] branch: let --delete-merged find squash merged branches
Date: Thu, 22 Oct 2026 13:44:29 -0400
Message-ID: <20261022174429.81186-1-me@jaspermayone.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAHwyqnUWab7AhqJtWkPQzw_dh+OwxiZxt2+1TTC-r+VPx+20Tg@mail.gmail.com>
References: <CAHwyqnUWab7AhqJtWkPQzw_dh+OwxiZxt2+1TTC-r+VPx+20Tg@mail.gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Harald Nordgren <haraldnordgren@gmail.com> writes:

> I'm leaning toward `--delete-merged[=<level>]`. But it's good that you
> are pointing this out. It's tempting to unify it like that.

The value of --delete-merged is already taken by the upstream
<pattern>, and it is required. So "--delete-merged=squashed" already
means "branches whose upstream is a ref called squashed" today, and
it cannot also carry a level without breaking that.

> I like `integrated` a lot.

+1 from a user who lands most work with "Squash and merge". It is the
word our documentation already uses, and it does not say how the work
got there, which fits every level of the ladder.

Since the value slot holds the pattern, the level needs its own place.
One shape that keeps each command line simple:

    git branch --delete-merged <pattern>       # strict, as today
    git branch --delete-integrated <pattern>   # rebased and squashed too

with a config variable if someone wants the middle step of Junio's
ladder (merged, then rebased, then squashed) as the meaning of
--delete-integrated.

On the false positive: Ben's "npm update" case, Junio's new test and
my case are the same thing. The upstream commit has the right contents
but was written by someone else. The squash and rebase buttons keep
the author of the pull request on the upstream commit, so requiring
that the landing commit's author also authored a commit on the branch
would reject all three. Work that a maintainer applied with "git am"
would still count, because "git am" keeps the author too. I have not
measured this, so take it as an idea to try.

Thanks,
Jasper
