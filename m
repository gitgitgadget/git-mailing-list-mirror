Received: from mail-pz2-f36.google.com (mail-pz2-f36.google.com [74.125.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0FC44065E
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 13:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790341264; cv=pass; b=XYwO7jJjM7I87IEvvOVj1g+INu+jNKGfvDkFzKv/jN012eh28X3A8qJSnGlGjQ7tj4wmFeX6BXeYa9SeqsbAdgfzgPCamhfkzAa6czaWbgXamVEcFh6FayNa/2F+b/yeZypPloA9kBHv0WUqkl6NTPpK3k8zXUPyjjVSyN2lEjM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790341264; c=relaxed/simple;
	bh=JGpCaGmecWvptmAfGNDHRZecNWbthr01moaPmnSVVmw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jl2PNa11B23q9ZULif/vwPvPmM5O3OjxldG4ttmL/+IcczdpPkx/lbb48eaTUWv1+Wv6Xv9RGYmSnNaxBddy3Wb78uDdogdG2E5+qxF0G9jTTp1oVLFzdA8s44z66ta03GHfWDN87ApgzcSH9c+cX/mtbZ+1BRvPicUMwH3ien8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SSNNfbDO; arc=pass smtp.client-ip=74.125.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SSNNfbDO"
Received: by mail-pz2-f36.google.com with SMTP id 41be03b00d2f7-cc1cea34f01so416237a12.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2026 06:01:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790341262; cv=none;
        d=google.com; s=arc-20260327;
        b=O1ZeRcPYGIR6HbUotYGHKklV2sDNIh7Ncf8+gnNmudUNXpTwnZU4xrtbunFx6Sas88
         AnMYiO4+3qupOQ76ptn43FmLWXq83IHUDbxfQegtY45Lf9gshOGcWUBme965iREfHLOx
         8AMyJwubMWpxKnhAROUwznZS68pWuF8at/q9XsPaKcEFHYiFVtcW3MDho2WMGDwhqFYw
         9FobU75a9Lf1Yw5ednxkDd7+akHXIGSJEPuZOVZEzXpNHs5wBhMCZ5N5/XPlDQeCZm5c
         nz9aY9ALexclWiBWmIX3J5SQL5MaOQrX8MLmE9zBFyIACz8/149/7tUbyoDAlXdx+1DC
         HEng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=goiqpIbiCab5e7UCrc54xjV6OV/kxaa8XzJyNZZh1d4=;
        fh=3AMi8dGPJTAzSPi16Fl/dIcQWDPUVNCCr8w7cI5PHCg=;
        b=mh2UIylnIKtEuPkg2hkxyfof+r8sPDm+hmddcXAidzhfoGvaxiy0FezEkFxKjjNkEB
         5BZuinKbaW0pMbjrbLfDZPbm+2hI77DOcX4e0PE8EimSj+rJFHpssW8riICwWsThYBXk
         15eE9ezgxidA2DauUkR1Y6his7ROIzSehhCnHxmvanPm5iKm0TPDmkxWw/ZuZNcMRfVN
         cZEHijJ5bGTaAqGeWZEGCDAyQt3VHwUYoLixxjiy1iARY/MrDtg41A2LWkmSVYghTawx
         Vb17R0fQcSTqllHchRNNAy/5AR0+kE7DTOZ7Y6GHc5HrD6VLwNMkEmBjSdE84ge0czDx
         5/lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790341262; x=1790946062; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=goiqpIbiCab5e7UCrc54xjV6OV/kxaa8XzJyNZZh1d4=;
        b=SSNNfbDO7q0EvTYzNjMJ7jwjVG8wuMFm5F5uylltts321NXaggSwjtc/69WHIhfb4f
         H0gp4LOt6XfJmP6xA/jkxLgjjqjhW425Uz1P3dP6nJu+vHU4flzNztIZJtRVQZeIIij5
         OEPWp/SUQn1iBZ7M5wjS05OWdKfPP85woGaqDPw8jLazyJXGxDsZ3CPmnhAcxZL5Wf+s
         brfbDbcHMGqb47lUVl922CnIVZMs2p49RuaL8cMMTb3LKB0g13o8lMkMhAVoCyRYOtzu
         DbSTXKzgiWjC6H3VdmkNXuN6hRhaA5hIThGHGTeyyNqhz4VFZyVUSyVD22YxR8jIzOCE
         P5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790341262; x=1790946062;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=goiqpIbiCab5e7UCrc54xjV6OV/kxaa8XzJyNZZh1d4=;
        b=yKfrFxo+zsCpcVXUS3detoaJlVk9oryjFIgD+WMGFun5VWThaXR5vQnSRPykSSAs0j
         c/XICVxO+Ob2+GkcoQ8n6Oe29JxxX6REIPFoZEnZWtqvTVZfb2Jk9zQa46z+iYz0Iwxs
         nE21xRJxOyDbqkxymzDlfbTYQEQykXQ83SQBk0RyOnmtxw6baJjuJTtpQvjHvtPz1k14
         m0Nyk0a6w8YszwunzV36I8KWXTuUcLQ0fFW7MhEypuPoUDsRBmoOszV9qE/3XYzRyA7W
         Of3YVKez4BpirtgKELh0agUeIG/Gmz6ukISI56GWanqQQX8NoTzhZmRfl7E7i/5NbQOo
         mFng==
X-Gm-Message-State: AFuF++k8wj3xMTuIgr/0/GBwha2oU8wFQjewYrmGdtXqIbsbOiRnJLxp
	HH5u/GsFF0snn+FvXCPGpYZJfcskKwwKH+6SwDnFRQpHpRbEn6D+eAatW7cBWBTKN6tSLDW5Yvu
	61I7xwu1ew9mzWPziFjwIgzMxz+xiHkI=
X-Gm-Gg: AYBFou2OntYAg+wEQz+PNuM2Mgpnw3UFslao/KKsIvl7Z+/81/sFnyp2FHDXa1ZUJcR
	jeZg5d8o9ALjnSE5PW+8GpjYGjeEMNb8RqyoFR5OLL+smPdt8t/FbqHvFykTDhqn37DatsrD2ct
	vRUUD9lltjw1aTGQnTzU4rjbvzwmMirtPpsyhjX5qGGns+uwvcjH4owNYXAnJ3+e4s7tLjUH9YF
	lrlCJhZhxgi4Vytzt3LvJ/6rwr9Ip/rta5vIS/IgvsCZa0kydZiPwj/DvaibcPc9f+vvQ0+TJt9
	/Dfnw40yUH30wfF9fkYCJTqw4gLHIHc41/wRX9rFpinw5gn6+3eJ3U93kcutnBSTc+berId53rq
	pbMV7jLffSHy/A3MwNlpI9oumGIYTxPLP3khXaWfyUkyesL/M0zFv1mkgtrOe2+JTvz3Db9ebzI
	jTAjqT+68=
X-Received: by 2002:a05:6a20:b08d:b0:3dd:a197:edfa with SMTP id
 adf61e73a8af0-3de0e97b53dmr5305260637.73.1790341262379; Fri, 25 Sep 2026
 06:01:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1789853192.git.ben.knoble@gmail.com> <cover.1790168285.git.ben.knoble@gmail.com>
 <e49936ee12aaf5d82a98dddcc618cee01ac3c681.1790168285.git.ben.knoble@gmail.com>
 <xmqqse2yz4y4.fsf@gitster.g>
In-Reply-To: <xmqqse2yz4y4.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Fri, 25 Sep 2026 09:00:51 -0400
X-Gm-Features: AclHuK8VdPdaWSF7DtkWMzNloRl_1vcqVQ0MtqCaYwst4K2kLveXSw58ngJExHk
Message-ID: <CALnO6CBhoBcVjLXidvii+o_Ump_k9disW177LeSS0118t3oGKg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] builtin/stash: merge index in-core
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Eli Barzilay <eli@barzilay.org>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, 
	Adam Johnson <me@adamj.eu>, Victoria Dye <vdye@github.com>, Jeff King <peff@peff.net>, 
	Derrick Stolee <stolee@gmail.com>, =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 5:59=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Ahh, or perhaps the trees are indeed given in a wrong order, but not
> in a random wrong order.  merge_ort_nonrecursive(), which is *not*
> the function you are using, takes head, merge, and merge_base in
> this order, and that order matches what you wrote.
>
> Perhaps the true culprit in this confusion is that the order in
> which merge_ort_nonrecursive() takes its three trees (head, merge,
> and common) and the order in which merge_incore_nonrecursive() takes
> its trees (merge_base, side1, and side2) are different, and if we
> fix them to match, it would make it easier to work with?

Indeed, the confusion is that simple ;) Shamefully, we don't have
enough test coverage to catch that regression, so I'm very glad indeed
you spotted it.

> The new test in the attached patch will fail with this step but if
> we revert the changes to builtin/stash.c in this step, it passes.

Any objection to me adding this test as a preparatory patch? There's
no sign-off, so I don't want to mess up the DCO here.
