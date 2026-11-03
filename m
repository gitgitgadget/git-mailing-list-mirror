Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793733961;
	b=OcmFED5b1AMUbmA7CJ/dZSkx8+/fVhG/Cz92//rzXcBpJb2JcRmA0GCw6dBWRcgNd1p+
	 yycFbI8FCzS2A5I8uA0Ne8PoF81BCYE6e8CJzXHV3EyiSF09sJLLfJHWj1QXCgXq/613u
	 4Fgkq4SUcJ4AJsyMtqiaIiVYlu/QEidL5OYxARCG3wpLFSFYyp11BWSVATmbqkP2M5xpN
	 UBtW2I+mCrVjsPJV+XAAABRkYkravSchclT89Q6bT6Zq6G6lFenCXELuygySpObXUN+zO
	 mo0ABbMhovE/A4lsDZNuKB8yn/Xe15YqyOVvAVjLicckLId144XuJ/lbTbwH4RAHHYw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733961;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=6yn6d79bnXWJn9cdwOaEqjtKxGDsCo0Tby2hr07GoyM=;
	b=PjhGRvqLpjfrG0V1NWNvpDGVyIu3Wia/+bFJVVKQH+jT9A/xt22y7HKu5UHSy/LUSewF
	 PoGBstwteyNuBMdig6u+Tn23w0RcIfOgASglTARR7x8su1eBGo+IQnVmOUV/rbeHfrvx9
	 62UcEvjd+uMH6O3mEXde3ZkquUUild+KaeSMZuyg/5RijYay8zolzXVd6kEHlQyoSkF4o
	 NHfL4AMAXy7hFaCbmk7AAApU3Y2YE2HY7TqACncXTkhERX14y0cf+/Y1Tc3/QKMeE0+hM
	 /dvE9Q7hYLBX8EIhwlq8wXPwZjvKSn0ic5MEHR7ioKTXd/bgIjf9gpY/Kv0BwO9S4Ag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEaWJRZq;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.180
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A27E606A31B
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 19:26:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A27E606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dEaWJRZq
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so846815e0c.0
        for <git@vger.kernel.org>; Tue, 03 Nov 2026 11:26:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793733959; cv=none;
        d=google.com; s=arc-20260327;
        b=srQuEUNXzyRVjiKSLCCX3XtHRlvsQvNAWp69QDlBP1mHtuQ8mzyX8sCC7Ot7pQ8nH4
         Vty7Z2TVpPk2L6NWvo/9kVj3DwtilMqxr5oYqu+UQIz4w+4Oyk9GwHerha65DS77FGdj
         0X4IFo/p7PqVbaMnerq+9D52Of4tEqQDjdvqL9GWRkFzwbyadmFwIPUULaj7K3sFB0CB
         IB3cCFXW7mTtQxJjWS04R0aoJn+cA9R4hs39isimwbgBuGLBd+W/x/sMqxGMzXEIcSlq
         LQpextdS5V4T2Ln5F4qxwDpLFz04Da2Pel8Rb/A83G5qXne5Ne+koDe2efgAKr7tMrfL
         /w6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6yn6d79bnXWJn9cdwOaEqjtKxGDsCo0Tby2hr07GoyM=;
        fh=NxPyoj3peGTadWyYvWunJU7+R+gYV7JdB58kfkv+gMs=;
        b=QZhOkxpvsX8DVqJuoALRoBFk5WiiKx8D+Q7nitlF2sIh7HzjDnnLQwb2Nr4A2zuB3T
         h4USzH9FiTnaJOfnjnZpZCHH5g7BtlkHX26p2ceLw0PlUWr7PLleHsCg4JmEw9FOou9q
         Z98uvw826cUUx/B5ydQHGIHlj/Yn4BCgx7cg2XKiXyrb1VJguLwcnxQ404ZbzeLnhCUw
         APBftMfgiUwe+qeYKydoQf7vxGp+kGCIGrFeWOH4WDqd5t9X8ggcwwVFi2CFX8W2MFLz
         AWtMqJ0A6mK5jJU153TUpcB0OQkiHVAZNFMXCqHKz7YzzQrfRMdBZInHJnrxA167FEFl
         WhHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793733959; x=1794338759; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6yn6d79bnXWJn9cdwOaEqjtKxGDsCo0Tby2hr07GoyM=;
        b=dEaWJRZq8C/10aR0c1wqNNAidjjvkRpXBvPl/v4jdYiA2dCgJybywLxZbFLb4k85dI
         9QppngaX0zKRG6W8NQEIi7Cw9K6BMRI2WDVSK2mlouOs5vZche4RM4XN9CpQgSvkI2w0
         dHmiLIzHnEvB1EmysMwxYvsMP9PpbVZ3iK5W6KGIG7AfkfpE5ODEJgssf6xb1SusKbpg
         RHxEQWyfSPDy1XGbalpuHDF5oOTCtDIb8OhuXGlC1tWN+rg9iVNm1dZ/VOKNXa0xUoV2
         ORS0jb1miucmzcuWrYYKhe5O1ujdPrN/ZHosoo56akSklaLxn5fT6vI0/rNn1glqOOLt
         TQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793733959; x=1794338759;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6yn6d79bnXWJn9cdwOaEqjtKxGDsCo0Tby2hr07GoyM=;
        b=qIukqdCxE5APGifpdNhGqhXt+oTy4+BhFbsB5M44LRZpPuF2PkGPcgdKtO+rpP+3HC
         aJCUvZRxejQHpl4FLpgNLYFBYQdhd7TH21GkFgbbbehPtVJD8XyqwMSmzKuum3e47V93
         1xGEtaIzbai6GX+ZynMXNvCFAUO0z8Gq7qKSHZABRcIiyd4uAGoDTBadXxFFqpILqAeC
         RLVfoBMgueZay6n/C8SFdNWe4ipLDsQDmUJwYj4QFwUJ+nOtjCkLh6whBHMBE/rYGGRH
         qswKmZiZnCQTuBZ6lxbUrMkKIY7t2pmH0p0586a/piu21ZqZdvoNlVq4d9rAVStUj8MG
         Xr/w==
X-Gm-Message-State: APuU4Z8m+A54/T7+7fjBtjCi/hwsbOysZ1ywBKDL/D6KZ9RhneqKNxca
	GZfuNbfK9kR8FEpCI7AP/623IhtirMdaFK1BhRHuDJZ5pZbd4kVV9JBxWfDlK4uCaC3B5EQE5Ka
	aRsSp493BU29SXuTQs54nodhxVVYhYaCZgwqG
X-Gm-Gg: AYBFou1zXkrkZ/C6SaMovkotlolGHM0fQx/az5VTo7C8unnSjbTuzOpPBAwYeMbxs+B
	oy5PAb+J0SQS5yABN9BNbXSyGmUJ29PD5laG+Q0VfwJtxjdqeVqOfCCBsT++6NDhNarbYNusuJ2
	hmQD0LsflIOevQIFsn2dAM3aluLCImJGmqXLhC6AjZvRIqeizUCWFAo8tvk/F9/IWGXe4ya1BRu
	dqRfuB8ck+SmqASjAd3uBynXi8O1c4wCi6zqpwoUFD8kM5vGZfAeHeSUTfXFolJoe+CzphnaepX
	gf7moQH5zi4sP4u0KY2IZhdFIZh8P5LZXiZf8iZOoR+zx3tZ5QA8uqWIDKyZ674GytuTtthA1jD
	rW/OGondT25QPrvKeL7bePDx4zb0vLukC7et/X25pjMH4VYqCWuZrDP7qa2wAt9GnQGnqRwTH0D
	U52aI7Fii6BZ/8D4xKWeEoekY=
X-Received: by 2002:a05:6122:3d0e:b0:5ea:a09b:39cc with SMTP id
 71dfb90a1353d-5ec587daa8amr5099722e0c.19.1793733959607; Tue, 03 Nov 2026
 11:25:59 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
In-Reply-To: <CAFzd1+4Jx_sWvMrV10gi9400BBNJOUXW0WwsypiM7yCh5x8fow@mail.gmail.com>
From: "herr.kaste" <herr.kaste@gmail.com>
Date: Tue, 3 Nov 2026 20:25:30 +0100
X-Gm-Features: AclHuK_rwPJtywTayl2kcLZYxfreiadPfYd5PXHuyOIcDRnusZDUsljZ9Qfk0l0
Message-ID: <CAFzd1+5s6V+YC3onNjYQmxRPVnsMROpsVi=qy1mg2=LOAnU+gg@mail.gmail.com>
Subject: Re: log --graph draws an orphaned branch with parents
To: git@vger.kernel.org
Cc: Pablo Sabater <pabloosabaterr@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
	Chandra Pratap <chandrapratap3519@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Finally had time for a repro (tested with git 2.56.0.windows.3):

sh
git init -q -b main repro && cd repro
export GIT_COMMITTER_DATE=3D"@1700000000 +0000"
GIT_AUTHOR_DATE=3D"@1700000000 +0000"
git commit -q --allow-empty -m B
git switch -q -c topic
git commit -q --allow-empty -m T
git switch -q --orphan orphan
git commit -q --allow-empty -m R
git merge -q --allow-unrelated-histories --no-ff -m M main
git log --graph --oneline --all

Actual output:

*   40a81a9 M
|\
 \ |
  * | 1d9120a R
 /
| * 5a29a85 T
|/
* f1cd12c B

With --no-graph-indent:

*   40a81a9 M
|\
* | 1d9120a R
 /
| * 5a29a85 T
|/
* f1cd12c B

Regards
Caspar


Am Di., 13. Okt. 2026 um 21:00 Uhr schrieb herr.kaste <herr.kaste@gmail.com=
>:
>
> Hi!  I have the following:
>
> Checkout https://github.com/packagecontrol/thecrawl.git then draw the gra=
ph
>
> $ git log --graph --all --oneline
>
> a few pages down, (I don't have a more minimal reproduction, --all is req=
uired)
> I see
>
> What happened? (Actual behavior)
>
> * | | 03b117815 Changed metadata of `Modelines`
> * | | 30f679f1f Bulk edit
>  \ | |
>   * | | 5a2cecdd9 Initial revision
>  / /
> | | * 6062ecf4f (origin/feat/compare-registries) Add script to compare
> two registries
> | |/
> | * 8f034813a Clarify fatal crawl skip logs
>
> 5a2cecdd9 is actually the birth of an orphaned branch, gitk also shows
> it like that.
>
> What did you expect to happen? (Expected behavior)
>
> E.g. something like this:
>
> =E2=97=8F | | 03b117815 Changed metadata of `Modelines`
> =E2=97=8F | | 30f679f1f Bulk edit
> =E2=97=8F | | 5a2cecdd9 Initial revision
>  / /
> | | =E2=97=8F 6062ecf4f (origin/feat/compare-registries) ...
> | |/
> | =E2=97=8F 8f034813a Clarify fatal crawl skip logs
>
> What's different between what you expected and what actually happened?
> An obvious drawing error, 5a2cecdd9 is drawn as if it had parents, and
> the rightmost lane goes to nirvana.
>
> [System Info]
> git version:
> git version 2.56.0.windows.2
> cpu: x86_64
> built from commit: cc4dbf752a05efdc0e04e71fd3e8110d11bdd35c
> sizeof-long: 4
> sizeof-size_t: 8
> shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
> rust: disabled
> feature: fsmonitor--daemon
> gettext: enabled
> libcurl: 8.22.0
> OpenSSL: OpenSSL 3.5.9 29 Sep 2026
> zlib: 1.3.2
> SHA-1: SHA1_DC
> SHA-256: SHA256_BLK
> default-ref-format: files
> default-hash: sha1
> uname: Windows 10.0 26200
> compiler info: gnuc: 16.2
> libc info: no libc information available
> $SHELL (typically, interactive shell): C:\Dev\Git\usr\bin\bash.exe
>
> Regards
> Caspar Duregger
