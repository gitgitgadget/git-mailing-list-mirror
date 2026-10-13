Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3C553C3A0
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 19:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791918051; cv=pass; b=a74zWbyT4loOabK6floRFgUhGrcriXsR+IZ6wRVrczRFY0XWl1FkJaDx6TC3F1n/1+Z4y9B49PWBU8C3rGUpAYG3NKaqNynzyZxsnTMwA/sRDxL6EHCcvngCzbKDBbmyr89V3ncxLPkkk2Aq1BvZsKHL63iW9JcljNrGhTXWkS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791918051; c=relaxed/simple;
	bh=qOvXXyWz9mJRSNNTarT+UAaGWNpk4THa6j+D/5zNVqw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=h4qjhr4Rv6v4cJp6mA7e+rfQL5nUDlV22mEESB9WRa+i2XIfLhyIShW9hNdkVSV1AkmZVVQL/6IS4EtylV4oK8540H5i6E19RhOl5wf3ZqsXOm9MM0+WN5SqCOVjceCrRIQ9fEGp+2/7uHYMZ0khJX5WQK9LjPEwfniA1rYP4HQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VHQTr6cA; arc=pass smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VHQTr6cA"
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5e9488480cfso1002996e0c.0
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 12:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791918028; cv=none;
        d=google.com; s=arc-20260327;
        b=rjbMOD73G8fiP8aWn80eow9D27Bu6k6tdBsesDsIwMoh3HhkIa+c7cs89KjmqZoyX7
         eXgfOw5EtsdRkIbf1N/YI67dIWQIhWBiW/WAhZudgl/qSS40gpDYDHv2mjRJjkFmvtVU
         spsuQpV1tL9ldRQ6bDEN7J5ljbQS9ucV5T8L3UsUi4+QgZczrQGkhl70ADIfKhcEGXgN
         czhmo+3EppeFIifEIghLvBgN127S4I0Wab5r3nIZShTbvbTOuoPc0l88Z2LtSoYttXz4
         xVO37EW3uVNg0lrR557s6NFxXuycaDDWFdyn45vwIu6C8kOoCIULC3TZCuWf7tgmr4yH
         ux2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=GBz4R2/RaiEtTlfhp+YCZe5V53FfgP4XEr9NdRMrb0k=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=Cf5imj/S7Ekg07AOz8fI/vlE4rchtwxyu3shdZZopwWKH9Tjf8Pjqy/goCR2s4pvAJ
         dij1djGR0fMmvJ/sSLsrRuZ6KrRrVevwj7ib5eg63atw7T6lL1cPHJneTFGuGtpX84jp
         uvYiBEQwwCplkFRWY5oK2ACshDCDTb35Aobsls9nRXuacEB+05JnBAWlMvx73e+r689M
         s/uGizZo9VS6fX25ZkD4kppPn8+sqENsB5MWpIdF/sedP+fczpvF4J7wAeJ8b9oXQgj2
         dN2RlDwxpR/waqvv2XONuMp+jbrXU8S37MCvmLz7fT2Q+kkFDRiJ9qe3GMbE71vBghvc
         yjfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791918028; x=1792522828; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GBz4R2/RaiEtTlfhp+YCZe5V53FfgP4XEr9NdRMrb0k=;
        b=VHQTr6cAJ7ZsEfBomcRgMD9vS8PAppraRoRl2TlKDatdKoQj8ghOWz8+ZrGlHoJtuB
         uPFzB++mb2VLXaSqIsKslOVeoXMiBArdqBEIU821Ht6h8K6LSvMiPEMsyehYNfEyqkXQ
         GYWXD7DGp+AOkt7BdToyEniSZ+7CZJ6kfSgs/x+ZHQ5orwGGlW2QE3/kM55SUKCUqrXH
         f5r9gzczrwE0BHi884tHO8QLoIeP9qJ6FoHw95ecvO4cV6qqccWZrMvN+Pv11L2xOYln
         TrEWvidlX20rOfJlueTcW0X5ijyN7NguzhevTm8g9+D70MUxuvSwRVlHtDblFTlpmXGy
         a0ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791918028; x=1792522828;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GBz4R2/RaiEtTlfhp+YCZe5V53FfgP4XEr9NdRMrb0k=;
        b=yPbyJNEBPf1d7vqsfERKgw1Js4r/f+b9QeBcrxRE58IvGkyuom5GxlraK8Lai4SufV
         lXqb+bdTGrAf9ejgE2I8NCN7JeVw+R8A5CR8JGMNjXzpebXqYqsIOpD+2Hyznj/T/qwI
         EVXc9p8Zuc9VfbgXCmYLsb/kxUUcBBeWuIQr0xy5rjzK7TTFPlBWyiYnZOrHNYx+OOr3
         jrkjnlCHXJzvjACP5h+OE4tkDjTjB88cKPKg4o9PzwJIuqrpFIczH9G+OIsPSna3PdHs
         fhUW2tGkCxrXDEI9V4TbVYstFaTV4AreOxjpMDEOC7SWkjzNOZ70xd1KUp1LExZpSm4F
         m3Bw==
X-Gm-Message-State: AFq9FYL1+592psITl+VDQLbiKyNoNINI3gV0FBRL+Ui/OAj5hv35saQS
	8fZT58Xzf7Ns6lfW8JCxBGAo21AgsJzEbUjDjtNTIOHqAORDj1VZbHHXEQNjDEc4EJHq4RnneWh
	uC7oD1QDCDFZ15BkVp5dhDV+hgHeqtH8CJDCFU8w=
X-Gm-Gg: AYBFou2dxk6j3flr1TSShTM2/UGF5/PNhYgjvgPERVI1jZHlF7hNkU9JQEQLOIWl7gY
	s1vMRD427sL4YcX+m/GlwQ10S/BhHGWFEwb5tcjXEAvQiCtqbJDhuJcg58hrBltaAPDuL30ODl+
	q4j2Vk1pTF7ngcuFc4rarD35HZBMe9fr8gZn9Z0BtXhSd4MKa8LYgaLfOZN+SsGZDwsIfSKs9Dv
	TvWiJTyf0ThUDQXMWVnpxc3E428R2zsdZ3YbciCkzV0Kxrdjfin8+c2LSn2kC6NI9ivNHudSQud
	PCVRZ3PUMR7qePQBGMmk+jKl1Zh64/PuxOQdv9QpoAOE/wPMpN40JdGf5dkrldcQsSA3ksy7pud
	Q8ggY0yb85HUTQCS5IFSwDqZ7OvgMh5o4/GvoUGObZnD1c8FhM/GJ
X-Received: by 2002:a05:6122:4f9d:b0:5e1:c1c8:9ff9 with SMTP id
 71dfb90a1353d-5e91f28cd89mr4812364e0c.2.1791918028027; Tue, 13 Oct 2026
 12:00:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "herr.kaste" <herr.kaste@gmail.com>
Date: Tue, 13 Oct 2026 21:00:00 +0200
X-Gm-Features: AclHuK_1JLnjR9T4C6isFBfYQpWqR4_HD0qEfkBmknQMyycgH0lHPaUA58ryEA4
Message-ID: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
Subject: log --graph draws an orphaned branch with parents
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi!  I have the following:

Checkout https://github.com/packagecontrol/thecrawl.git then draw the graph

$ git log --graph --all --oneline

a few pages down, (I don't have a more minimal reproduction, --all is requi=
red)
I see

What happened? (Actual behavior)

* | | 03b117815 Changed metadata of `Modelines`
* | | 30f679f1f Bulk edit
 \ | |
  * | | 5a2cecdd9 Initial revision
 / /
| | * 6062ecf4f (origin/feat/compare-registries) Add script to compare
two registries
| |/
| * 8f034813a Clarify fatal crawl skip logs

5a2cecdd9 is actually the birth of an orphaned branch, gitk also shows
it like that.

What did you expect to happen? (Expected behavior)

E.g. something like this:

=E2=97=8F | | 03b117815 Changed metadata of `Modelines`
=E2=97=8F | | 30f679f1f Bulk edit
=E2=97=8F | | 5a2cecdd9 Initial revision
 / /
| | =E2=97=8F 6062ecf4f (origin/feat/compare-registries) ...
| |/
| =E2=97=8F 8f034813a Clarify fatal crawl skip logs

What's different between what you expected and what actually happened?
An obvious drawing error, 5a2cecdd9 is drawn as if it had parents, and
the rightmost lane goes to nirvana.

[System Info]
git version:
git version 2.56.0.windows.2
cpu: x86_64
built from commit: cc4dbf752a05efdc0e04e71fd3e8110d11bdd35c
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon
gettext: enabled
libcurl: 8.22.0
OpenSSL: OpenSSL 3.5.9 29 Sep 2026
zlib: 1.3.2
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Windows 10.0 26200
compiler info: gnuc: 16.2
libc info: no libc information available
$SHELL (typically, interactive shell): C:\Dev\Git\usr\bin\bash.exe

Regards
Caspar Duregger
