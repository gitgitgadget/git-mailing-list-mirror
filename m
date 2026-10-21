Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792566354;
	b=OOFuZvPRceyfGXV+mOhBs2OMQW5npVLOJ+XD/1NRkmuWkfTrmmMfpR78GohgA53NU8qG
	 mpC2Nw1VBPTq+Kqi87oriZ+LOGKjbERRX99zf5+E/LiHvK5pNEVPe/quvQ3/leTrbvX3M
	 jlXjOTVUfNicRYS9MuOhD/6F1musE6UQYuOsHTOyPkRVPB96GTZZ3XihemBl/TbF5YbmM
	 o4VjuF4Ouhon6jUvjC5DlLsOyNCYW25kTcf5un3LAhaCvrzVH55RYe33In4rYVX9gvsS/
	 oVZ4Cb8/KRvIi2CIg2wDo7cSawjgAmN2NdIAiizZA9QmYK2Q0wf6WFUrZks08q8dprQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566354;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=TF3+eJTbvFIGKnpvXlr5AhmAW7zlnFWzLFyYOa9iPGk=;
	b=PB8e41/PkvDVCen5T90QVDzGoTvoy3vVDacL9TwpP42sHkNp/L3wpkJTi2969yaU1z0F
	 86hOmHHZk8MkANpAee54dHbH0rOXKBu8Kh6imdJBjzj4gvzdTVaZpY5LY3SqUzyiBZy6I
	 on29CeNyBc6N454wEBo68vbDxNgeTqMFncG03d+eCpkl6asptymsbggPjXMzGwn9A/1xZ
	 ca/P8793x0inV2kDWyRji6meI62fYqxOoC/t3itN5bZihuijqMeIrFPglT3SXvfrjH6Xj
	 RDoaMakHPoj/f4nsYwi2uUg9VuWMLKkiJPJBqSbQWR/e8MJ69NsNh1cy8I8lrUu0R2Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PWhged50;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5365606A31C
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D5365606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PWhged50
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b1aa2848d2so311404a12.3
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:05:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792566352; cv=none;
        d=google.com; s=arc-20260327;
        b=khU5+4vZID8BH6/XzusQ7Y7LoDMlp+2p0Emg/OMqndWd5x6tIXU2JPL01AQXjuRmsI
         IAoAHBsbinK97zto+lE3/RZPYJ7xDt1WV2L7ovEuEXgRm2YcfYrD+pbSU59AQVTkjB0a
         gwb9KAntebeqxRWBFmFUenwiNjEj9KiKnasmsCCAj1/8E24RQtgm/D8qqmsouGGaCM2W
         XSGjLrzDics9oTn195OiYuQxulaNHeMHD02oaZ40rV7DPjbTW0p7O1Xwz1jsJhtANhG6
         zQINmAcGhS8fYVaI65IgcaKVQQrofCGtcCaif9zKTFoeJ4/4HvvgKq9DKQE1Jy4BVu4U
         cF7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TF3+eJTbvFIGKnpvXlr5AhmAW7zlnFWzLFyYOa9iPGk=;
        fh=cPmF+JSQEONHpuiVJ6kO193FH48HlEv0pA06XT5cXeA=;
        b=UPYfiUKKqMHaUahWbxi3S6LwJl7GiZN4WdhKZV1yOIZNkJBuLRFboVhRHWFjcRzjtT
         t1oIN9pQbPx06GvDbCGcfK+Rsz/uY0P6u2VB8KgW9vdThTAPk1SogxXlTRuMHejBPMGy
         ddYdyh0Ayo6DXYapKQ1UgeVt/buwJLRA4w1IauZA39Oj25pIUzFH0wsRQsMhq6H5S7Qo
         mN16r7R/zuU7doPNO2miNfEb0+4tRlJg2ph1SHxM0fMsEDwIXf6qsiy8oC1MgxiFdH+5
         29H3JGXQCEfDK6YZLj0A6t1BJ+agpOjelaRvGe1qtIDZ05aziBAEqycyGdzMkgWHd5M/
         TVKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566352; x=1793171152; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TF3+eJTbvFIGKnpvXlr5AhmAW7zlnFWzLFyYOa9iPGk=;
        b=PWhged50rwmMOk3GLj0FnJSnel2dVnrv0rvbXThYakArCdn6utzDqJ8a+4b+XnKrGc
         JjQFL3Ol6ilYKkxfXypZC6RLdelC4ZXMWi6m/0u3Qd9L6cHY0QC3WIBjmCK19i5JIkVN
         r7ulBpU9rP8Zt5zsRa6D4DRcwuwOGW42ABQgLZRH4jQ+/e10YDIWwgPM0VAySTaOb/9v
         m+SjdkFnay9xrD6tlSGrClkc7zwOSmY0aybZhZt1Fy7bZo9dneyYnKGjtej/u+JywfR+
         ue5UiLX+TXEgedQJ3eTdKgwKtBQTfTOFyHvmVSxNAgNboA1FS0MqG3BV24KNSDcP3WGt
         eCpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566352; x=1793171152;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TF3+eJTbvFIGKnpvXlr5AhmAW7zlnFWzLFyYOa9iPGk=;
        b=hd+UpLyq47C2WccyQdna6UTEGVJFSboHQQel/FhugQX2/aiyYpxdSaEzInJNvbEjXJ
         SqGsU3ccJ0nso65iZfnK+lzl7c2Z+okFkDi5OUq/qkd8oi5PcO/eST8DPbpn7CVxbnpa
         qVGlXw+lAm9485y8mqeUxvY1aqBz+Pc68cV0e3TICupdnrQphgTxPApT2hwVvbt2+mLS
         pobTJe36SrI4v3/wBRn2LbmyuoIOghz0hkiyq+YI7lnRo1X7GUpN4EqM0eOtOIOJYG2I
         xE4xNJyxraXEqfA05rVrAPS5AoWniRiFWGIhUILCItx6/K4fRFN/gGXUVvO52krOe4/T
         IheQ==
X-Gm-Message-State: AFq9FYJibVHpo0RUF7jM5hk+StB6ET0bV6pPApkDzgMN7t9yUtok+uT/
	/lyuetlCHZHYqSbfrvjaPpQMmzyPLna32b/lmyT0Z/2fUuHuxEXP1ICcHMej5v/9uJwk7mr7f4x
	b1p7w0AHeZe1A+1+UjYT5ClFXBQhv9Uk=
X-Gm-Gg: AYBFou18Xs5IQx9y3sANOoqcrP557SVQODp0+pdKMKpSaFapkCFxEz/7agduXsRr4bj
	tQsUIhgC7KN1XFfT7N/SkLV7RTUFANbpWbTLOZIy3xf5WGfY2l+b8wAV3jm2YWclSWh7ICbHxki
	6ExolWxxCftpsvxS/WlOr34Tz4gGO/FlX/bZrshm8ifLX23SEpFthLN5ghoxliAf8cuARuOEy11
	1oS8YNnYyodNIXFmF3C5Oks/TYMlYxgjSq0Hc4RX2mfbjrYuH168NbNJ3Mw2VYldQgXf6g2Pn+C
	NJOIIPGnaPgkYDZCVbKKV3B0mu2BuzDXXAik+Gn5lhoWCvlN3RdwuiJOs5J3JypOIADTgt8JViI
	ENvdNqxWP1InnPlf4iMZRIR3tzppDQi0fsnFv
X-Received: by 2002:a05:6402:4493:b0:6b1:8818:1090 with SMTP id
 4fb4d7f45d1cf-6b408ead3a2mr639691a12.22.1792566352052; Wed, 21 Oct 2026
 00:05:52 -0700 (PDT)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
In-Reply-To: <pull.2268.git.1792458904027.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Wed, 21 Oct 2026 09:05:12 +0200
X-Gm-Features: AclHuK_u714CfZFMDxuA8CAF9OcwsdVzQHMvu9zpt9Z3RCW0cTh4z8fOgd7fTMQ
Message-ID: <CAHwyqnU-eQBPTht3eHJceyWMehtQ2GAyEyZ8ObmVru0Y9EVkdQ@mail.gmail.com>
Subject: Re: [PATCH] branch: strip refs/heads/ from the --set-upstream-to hint
To: tsukasa-ino via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, tsukasa inoue <inoue.tsukasa.4@gmail.com>
Content-Type: text/plain; charset="UTF-8"

> When git switch fails to write the tracking config, it prints a hint
> with the command to set the upstream by hand. For example, if
> .git/config.lock exists:
>
>     error: could not lock config file .git/config: File exists
>     error: unable to write upstream branch configuration
>     hint:
>     hint: After fixing the error cause you may try to fix up
>     hint: the remote tracking information by invoking:
>     hint:   git branch --set-upstream-to=origin/refs/heads/feat
>
> The hint says origin/refs/heads/feat, but the correct name is
> origin/feat. Running the command as printed fails, because the full
> ref name is not a valid remote-tracking branch name here.

Very nice find!

> +test_expect_success '--set-upstream-to hint uses short remote-tracking branch name on locked config' '
> +       test_when_finished "git branch -D hint-local" &&
> +       test_when_finished "git update-ref -d refs/remotes/hintremote/hintbranch" &&
> +       test_config remote.hintremote.url . &&
> +       test_config remote.hintremote.fetch "+refs/heads/*:refs/remotes/hintremote/*" &&
> +       git update-ref refs/remotes/hintremote/hintbranch HEAD &&
> +       git branch hint-local &&
> +       test_when_finished "rm -f .git/config.lock" &&
> +       >.git/config.lock &&
> +       test_must_fail git -c core.configLockTimeout=0 \
> +               branch --set-upstream-to=hintremote/hintbranch hint-local 2>err &&
> +       test_grep "git branch --set-upstream-to=hintremote/hintbranch\$" err &&
> +       test_grep ! "refs/heads/" err
> +'

Would be good to test the full multiline hint message. After all, it's
the point of the topic.

Right now, you are asserting that the correct form
'hintremote/hintbranch' works, but we want to make sure that the hint
actually gives that.


Harald
