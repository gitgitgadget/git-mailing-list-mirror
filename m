Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A6E330B2E
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 15:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760716679; cv=none; b=K4r6gQ+/MXvd+ntH3LjWIF2w75fG4IzOGyiSQVkl19foXfMGw1JQ4dtcUglObmUHoTK9nRnq1pYCudAVaz/NgDcDJ1wmsi7kiYDdfRfnDsmGLqZsumvirTjV6KvSoO3VmWyv59dhyHWOkp0BHHEPQFWlzNSLeilyWJITFAXESEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760716679; c=relaxed/simple;
	bh=IXEuGzP5fm1u0EUhrcBcufzuvO/6j6TxW+m0cP8KPkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JSYQKlgb6jtMAbpvtnPlg0syJUS+bVdOiTxclMJbXg7+veiVSsa4qrfq+mUoMwKpJ1Gttu2z0NR9kilD3wNyJpLveM5CWN2bXwSsHKjVP+hMLp6qQZI7bIYHmNrwsnAIGxkMG1WVcPQlI1tnGKNtITsc4SdHimrKlh3hk7LDKjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samestep.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=samestep.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8901a7d171bso240359785a.1
        for <git@vger.kernel.org>; Fri, 17 Oct 2025 08:57:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760716676; x=1761321476;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+oIuryjzIxOba0uWCbPCdYeHHw+DBl6nS24d6e9h4tk=;
        b=A4usGzNfZ5PmCAtTNKGBa3rCC7WpEEkmuWPVfvP2aa69HCQ/z2Bf2ZO9QT6/sCyVoZ
         cLBcgOR0a2MJ+JYF/JekdB7AJpqpCmm8+eIeGg6BHf21vSztS00H8wVC90rnTyPfgRtw
         i3QZSFy9/o7Fn2bTGm8NTVfUzpV1/KzuXTPGX47OGiubpkxtCgrdujLdv/5OQ1wY5yU3
         /XKOCBnMh53zMlRjbHKVM8gq7x/pO8nqJgnD3Ar4YtbMXLkxxOaaVF3wzrzn2aJoSUtQ
         w1v9ARCHekV9mCfTK+jLP7GOVz6xhhwEVMDnN/vT/O6jZX0cIh9vk03XGuakjlFgFTkz
         P+og==
X-Forwarded-Encrypted: i=1; AJvYcCWCWe6DZnvAg/M5vu5u+8FZY5M+t6OYzaBUBpZ/Sru2dQ1KRRckdJ5gnNoMKL5f0LbiaSw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4SyM74pArTPpQSY4AevWWHu24Rz1dsHIH0TBwVCVXN1bEUyie
	Pm0ZFShsIwfFwdEGqhx9Qb3f+jrj74UHto2DhIpaQwVAv8MbSnEW6E6t
X-Gm-Gg: ASbGncuagZ72Mac6Ho3kDpyl+aTFBzUdDuqg//9xSLLRapHhCxJpksxBGriGiZxmUWL
	SN7qNHYJKb41IZQoWq2rO56zd7/dO6AKP2rcTEfSdtBWTQreGhtU3ijZurNJWi8BiUvNmCEqFxV
	lcM2ygGpLIldsByu25hF9obH91IXpIG6KpBoJRTnE0grVjs8E/wJZ3ISlLVN0oPyy0huW4T2JBu
	FIG02rtgokXtSEHbRSJ33JxmapJZ4NSZvakY2SzZBtWleHFGb8nlTuG26r+PXVXyWpx6/cpw7Ks
	vciMoaj8eMsLY5cVkVzQTcE2flmJb0UtYpdfbSCesf/BmnvFm+SEe7JRFVHn+xlCX4oPPVvRpOj
	P2haBVfd8unYbBDRRs/nQGLMALryu3tODk202bluwg+wWivndaFoz0pp0ilWmhxGb7GPrtib6
X-Google-Smtp-Source: AGHT+IG7ITnuf3qPgz1x0yaVuKAv7VjH7BBarWfmwBIgoeRncmDptTOmYyAnWvK4R20fVxdVsGVVRw==
X-Received: by 2002:a05:620a:288a:b0:858:82fd:cd14 with SMTP id af79cd13be357-89070aeb4b8mr566667985a.84.1760716676298;
        Fri, 17 Oct 2025 08:57:56 -0700 (PDT)
Received: from nixos.lan ([2607:fb92:1786:ce96:9d2b:ba86:8638:36c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-88f37e4b953sm451363385a.29.2025.10.17.08.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 08:57:56 -0700 (PDT)
From: Sam Estep <sam@samestep.com>
To: jonathantanmy@google.com
Cc: nikolas@applied.co,
	diamond@applied.co,
	git@vger.kernel.org,
	jack@applied.co,
	jl@applied.co,
	newren@gmail.com
Subject: Re: bug report - BUG: builtin/pack-objects.c:4310: should_include_obj should only be called on existing objects
Date: Fri, 17 Oct 2025 11:57:54 -0400
Message-ID: <20251017155754.1425091-1-sam@samestep.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <CA+ODqj34b2DsvjxGgVb=jSaTUNYRh_nNtaCzCx8QiJ8QFsRecA@mail.gmail.com>
References: <CA+ODqj34b2DsvjxGgVb=jSaTUNYRh_nNtaCzCx8QiJ8QFsRecA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I hit this same bug today: https://github.com/samestep/npc/issues/6

I'm using Git v2.51.0. As Nik mentioned, the issue is flaky, but I have
been able to reproduce it several times today on both x86_64-linux and
aarch64-darwin via these steps:

$ git clone --mirror --filter=tree:0 https://github.com/NixOS/nixpkgs.git
Cloning into bare repository 'nixpkgs.git'...
remote: Enumerating objects: 1403208, done.
remote: Counting objects: 100% (1204/1204), done.
remote: Compressing objects: 100% (1164/1164), done.
remote: Total 1403208 (delta 70), reused 273 (delta 40), pack-reused 1402004 (from 2)
Receiving objects: 100% (1403208/1403208), 550.95 MiB | 19.74 MiB/s, done.
Resolving deltas: 100% (71770/71770), done.
Enumerating objects: 1, done.
Counting objects: 100% (1/1), done.
Writing objects: 100% (1/1), done.
Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
$ cd nixpkgs.git
$ git fetch --no-show-forced-updates
From https://github.com/NixOS/nixpkgs
 - [deleted]                 (none)                 -> gh-readonly-queue/master/pr-452910-91484645881d96272b133ad577cbb314c3af446f
 - [deleted]                 (none)                 -> gh-readonly-queue/master/pr-452916-93e25250a9459a0d62e9156f06d9ab66fa081ebd
 - [deleted]                 (none)                 -> gh-readonly-queue/master/pr-452934-9347aa5ba848ac348dd123e5c6b28a5e69ebebee
 - [deleted]                 (none)                 -> refs/pull/435349/merge
 - [deleted]                 (none)                 -> refs/pull/452910/merge
 - [deleted]                 (none)                 -> refs/pull/452916/merge
 - [deleted]                 (none)                 -> refs/pull/452934/merge
remote: Enumerating objects: 228, done.
remote: Counting objects: 100% (228/228), done.
remote: Compressing objects: 100% (223/223), done.
remote: Total 228 (delta 5), reused 152 (delta 5), pack-reused 0 (from 0)
Receiving objects: 100% (228/228), 123.31 KiB | 17.62 MiB/s, done.
Resolving deltas: 100% (5/5), done.
BUG: builtin/pack-objects.c:4835: should_include_obj should only be called on existing objects
error: pack-objects died of signal 6
fatal: could not finish pack-objects to repack local links
fatal: index-pack failed

If the error doesn't occur immediately, it should eventually occur if
you keep re-running that last command:

$ git fetch --no-show-forced-updates

In case it's relevant, my Git version is built from Nixpkgs commit
82c2e0d6dde50b17ae366d2aa36f224dc19af469, and I have this in my global
Git config:

[fetch]
	all = true
	prune = true

On Mon, Apr 28, 2025 at 12:23 PM Jonathan Tan <jonathantanmy@google.com> wrote:
> In any case, the fix is probably to change it so that
> should_include_obj() returns 0 if the object is absent.

Does this still seem like the right approach?
