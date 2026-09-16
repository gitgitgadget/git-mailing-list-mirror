Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B356F314A65
	for <git@vger.kernel.org>; Wed, 16 Sep 2026 14:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789570548; cv=pass; b=cyGTW9ovHGxEgOqQtovSBNZS8lwK9/KF1s5evaXOkBUuyNuuoi8USN9iAsv5mKE1BLbBd/tuEo2rflwIm4Z0gsCDdVzLmnwBS5/MYJNMcP8cqJWnO0Vzg+H0bXZdr3bEVQqqNFSMmYf7eAOrwlr/Zp3orFwa5OfALxk1bA0xtBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789570548; c=relaxed/simple;
	bh=DuKicLmeweBCkp0n2XUsPCsqiKz0rlNrCUqeS6nm0m4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IWUn1ZKLKoMo8IZRJFGQZCbXPmILQ5htX5H6MC4HnTGmEHNNHMY96P8weBBCeVJlEatYFWx+6L21alV4aAZPEmgD3JawqttthyzEtOGOCqKhMFNnkV8VDtNp3G7WhV7j3Cz/xFfMc443N1AuZUIekGGfV4UOkCsjnFfx/3GAuNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com; spf=pass smtp.mailfrom=spotify.com; dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b=Df2TljGl; arc=pass smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=spotify.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=spotify.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=spotify.com header.i=@spotify.com header.b="Df2TljGl"
Received: by mail-yx2-f43.google.com with SMTP id 956f58d0204a3-67109935888so921218d50.3
        for <git@vger.kernel.org>; Wed, 16 Sep 2026 07:55:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789570545; cv=none;
        d=google.com; s=arc-20260327;
        b=hxIGM6H0Ysn8NoeP8MqkmhXECpGdrPzAw/HsHixReasp5iF8SPefTciK4nASi5oCtk
         X0zaUtpDrRQRjfbGLCIu3PDv+TJ8rzgGEv5BjJWl7gB/mzeCDoDnBTNtDJeHnS5GSSBg
         K3SgMbmtnN2x5C33UaygCmOOJD2+QbByV0KbAL2uGg1XaVFM/BnaA7/U4nFgH0IntosY
         C5OrGxeCanqhwzAaI2Tyu1uQTsEdYMrtrmZLl9n1gFSlG0Kr1/DEmjP1KGrzRh//OZ+3
         nPmpw+GQTT222Q3LuqGVQ7saXrF2CMOsDkC/1/s5Tmjc1yVcyBJ5CqvdWk3vBt85+DSt
         jvtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=JSrvedWdO+/kMgrjMUMjEu484S68RaABb6ClZ33ZSEE=;
        fh=GOPyqHvR65W7w/c+jMlXCg/At6sIZ9LtftFB5OH3X6M=;
        b=rt7XOs0N5P+zl3WdvhjqGIjnyww/1s1mCEWxgfP2mL+t0vUSszo+ezJe9KfKRg+eQn
         rUJygozAr/38v/+19KLE6jQIMXh8dqZmCWFys7KL3+bOSEYKuc/VSpQakgYVw82Myja7
         ENsknn8EZk0wzLCormv/21RUcKqJ6JIiyuPkQ1bSlvYaNW1Tq3Dp+1o7oxC74jcPEAui
         x3FYti+hn8GFfZ6c8sOfppV/QyZqZGZRthchGK14rWmkVyIZfj+dS7Z0MuP8EklojBnt
         I8ovONNONDvNPhOC2/CIc0Uvs3/Lh3MJm2WpAJEEX/D1kCvF0/5xr2UivH5w3jWdMeMy
         Fjzw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spotify.com; s=google; t=1789570545; x=1790175345; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JSrvedWdO+/kMgrjMUMjEu484S68RaABb6ClZ33ZSEE=;
        b=Df2TljGlafosucPOcTjYEFOG33r4CSC8vdAmrxgbVlBs143eTfLNm1tAoe2Hm/8Lxv
         q/5JQTtpmQNS/A56O9vfftOYLsNgJfuegaGfLtULv6TEB5v8K9eFOWqDZtjkMG4dlVDt
         tcEsNir+dR3GoA2UvrGBZexjRawE0htXIWOZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789570545; x=1790175345;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=JSrvedWdO+/kMgrjMUMjEu484S68RaABb6ClZ33ZSEE=;
        b=PHLzkdc6i6REBII9YwMgFivWwGtv2xUyHgKFlun2nHdZD6ucNuIniV5ZWixO2J33o3
         Gk1XFmKbSPWgKp2WTu2EkSmNuRLZvA/HE9jHCgmClYLL1rYbYFYFzFj0IzphPUIfSpPl
         qrOaQkQMJHYldV786DtM2EXzcx3lcotFYDXZ+k5CIVQw2XQhakH0gF35n7ca/RJ2UeV4
         3BI1nIURDm92HbGk7mnyHmOeLXc5ozUjkzCL0sKSJ5qLTY8doGoB1sUhNWiroVmiZvma
         KIriXlOhzPlB3OxLbbmJSZQuadvxbilWXyrV6p38z++PCfRyzpvMGdbqx81AW1CY8o+L
         7/6g==
X-Gm-Message-State: AFuF++kCMTsVKHepNyQ+izxN4fEpBYWytPKj/iHDyA8gPIGHUTIcZbIY
	20F5JbifnGpXH0uiYztAp5uqYNSZF09lrx0Onqfx93oeJeAMZWoUZSJ8yqbSp4vNwCp2tOC2Onk
	cQSG1NQ4b4fcBvg70cZlqCgCp3Lf2HzV7W8BLtgxn/Q==
X-Gm-Gg: AYBFou1bHnIr/mi6Df93Jh3BORYVflhE0JNUMzc1uJaVj+uQjyPQRVdClpYFcvaOchO
	RYMF5QvOrZQSykF6DvVPOK2GmxyoeNo1BTPi51GYQ0YkX5lOCGyDdbJ6k9z6Tr3adld29Vl/qGi
	3S/Hc4kY1IRbTnnr7s8xwhEmS1SUin37Held/+vwHPlFe/n6qLYWQg+NMV9A4juw/RUOXFA3DYi
	g9Py/5cVS631OkPEST90P+ur5nMjnjFgXhwlOtCy0iJ4UbhF8M1ejHVG9dNB9PeNuqiGCdq9IFy
	hdWXzmcMmgO1kn+egfq+/2CHGCsusJ9ug/L79uCz79wZg3INsVeXMFo=
X-Received: by 2002:a05:690e:d0a:b0:66f:c1d8:19db with SMTP id
 956f58d0204a3-67163300f53mr1450560d50.51.1789570545389; Wed, 16 Sep 2026
 07:55:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d3241733-d015-4646-88e0-06e56a04e77b@nutanix.com> <20260916134632.1424829-1-orestisflo@gmail.com>
In-Reply-To: <20260916134632.1424829-1-orestisflo@gmail.com>
From: Kristofer Karlsson <krka@spotify.com>
Date: Wed, 16 Sep 2026 16:55:33 +0200
X-Gm-Features: AcwNN1Xmio16d-1Qp4nu-wEARLwN6WtRrgYJ4tdfxxQjs9RxAEF6Nr5XKQRqlXQ
Message-ID: <CAL71e4PRqawd=2DfLELLXR2g0PFz2ehXf05uLXJKF92WiztO9w@mail.gmail.com>
Subject: Re: [PATCH] commit-reach: parse commits in the given repository
To: Orestis Floros <orestisflo@gmail.com>
Cc: git@vger.kernel.org, Florian Schmidt <flosch@nutanix.com>, Patrick Steinhardt <ps@pks.im>, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Elijah Newren <newren@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 16 Sept 2026 at 16:00, Orestis Floros <orestisflo@gmail.com> wrote:
> +test_expect_success 'setup for commit-graphs in superproject and submodule' '
> +       git init commit-graph &&
> +       (cd commit-graph &&
> +       git init sub &&
> +       for i in 1 2 3 4 5 6 7 8 9 10
> +       do
> +               test_commit -C sub "sub-$i" || return 1
> +       done &&
> +
> +       git -C sub checkout --detach sub-1 &&
> +       git add sub &&
> +       git commit -m base &&
> +
> +       # Write the commit-graph of the superproject while it only
> +       # contains a single commit. Any commit-graph position of the
> +       # submodule is thus out of bounds for the superproject.
> +       git commit-graph write --reachable &&
> +
> +       git checkout -b side &&
> +       git -C sub checkout --detach sub-5 &&
> +       git add sub &&
> +       git commit -m side &&
> +
> +       git checkout main &&
> +       git -C sub checkout --detach sub-10 &&
> +       git add sub &&
> +       git commit -m main &&
> +
> +       git -C sub commit-graph write --reachable)
> +'
> +
> +test_expect_success 'merge does not mix up superproject and submodule commit-graphs' '
> +       (cd commit-graph &&
> +       git merge side &&
> +       git rev-parse HEAD:sub >actual &&
> +       git -C sub rev-parse sub-10^{commit} >expect &&
> +       test_cmp expect actual)
> +'
> +
>  test_done

I ran the new tests with and without the code change and can
confirm it reproduces the bug.

The code makes sense to me.  As a bonus, this brings
commit-reach.c down from 17 to 11 the_repository references,
getting us slightly closer to eventually dropping
USE_THE_REPOSITORY_VARIABLE there.

- Kristofer
