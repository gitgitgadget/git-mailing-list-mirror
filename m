Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDFD80C08
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 16:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708534135; cv=none; b=RCpm2nSdXQ6nlFoNhIiWCQQvn3tAMZjj+gwgLJBHGoH8eTz+/2w9uDPveft3KP9YbhMJraXKLI3O1dmnxhG9zqpcjZ9k/2ObkIt0+1lHp8I2Q23mLbKVAEYUBw+IoVLr/le9XzVsHkrbWxrjxc4ggILbCOVa+5lJ9OMAM0qlE8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708534135; c=relaxed/simple;
	bh=KUrYHkiNrULivmKhvPWNYCrUX8LofhECf+JK371R8gU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gZ1qJxS1+Q0RBeX+cDM3AbQ6/soK/dTIN/g7YDyWj7uEffGnG7sGRyY53ZhgaComcwfz5VNRi3DhgVzBvnRONrl2neUdDZpDpiY9scYOtZaiGWGHbWEc8iSfYbdUlzdD35Qta0QrymIwkNAnVyMdR3Y3CIFqtCGyJfC4Xyq/NWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7875dc24ecaso253385585a.3
        for <git@vger.kernel.org>; Wed, 21 Feb 2024 08:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708534132; x=1709138932;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=csc4SyPR3uRGSDFE87MX7LyYIBqoFW3HYd+nhGMChvo=;
        b=obEr5fe6qiFrN7fVa3MvDRh2htZwgZER6VIYeGke9U0ePB93WafjC0GtgvlVgIzN48
         6Tw8rTCVhUgIalgOYwoy8A1zRBZOtejyu30pQWgk1wTgCuW/RJMtfEm5yk8jb0frx0d7
         AhdLgI9FRM2SxdOq/aoWSsj4rL/lLw/tIEsSq5WNUjC0imP3s2SZa8a9g3oqwzmZY+ly
         VNMCLmq2QJpXpeMvehIN1sBA+G3AyLiQHIVvnUpNBaUj3NrDYs/8Rib6d6QuPVpmSU+c
         EGKedYBJeZHuEV9WoogLvhR9b5vugD9OjK9tllydatXYpycGp80FWvsct7LBzDI+vhoT
         kwFA==
X-Gm-Message-State: AOJu0Yy2luc1s8daz3H3u3ZSrCswX7HKNqx85PtBWlHRBnnboOKDNO8t
	2dT+ppZemJxNYaio/+sR0Giu9f62Y+2VaBh4oi2VopaX9fi1+aeANrKLoC1b1/3bsTLGiE7EG5D
	hcxODI5wJeQqn49A6iuZnHHwjJEI=
X-Google-Smtp-Source: AGHT+IGLG8/Aw6XEg1QK9vFW1m7kJ+eJEtol32tp53R5A4kyTQBOI0q/Hizd1NjwjPD4jTrHhjgj+jBeb2A68bRFdFQ=
X-Received: by 2002:a0c:f084:0:b0:68f:a250:7a07 with SMTP id
 g4-20020a0cf084000000b0068fa2507a07mr2517220qvk.19.1708534131721; Wed, 21 Feb
 2024 08:48:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <cover.1708509190.git.ps@pks.im> <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
In-Reply-To: <0fac6ebb098c7e8cdc87cb75f2dcffdc4b1ccfaa.1708509190.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Wed, 21 Feb 2024 11:48:40 -0500
Message-ID: <CAPig+cQff2LUnsXf+NMuAczN0sVNbPU9fOSFapeMSDBpMYkedQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] object-name: detect and report empty reflogs
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Yasushi SHOJI <yasushi.shoji@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 5:03=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> [...]
> Start to detect and report empty or missing reflogs in `read_ref_at()`
> and report them to the caller. This results in a change in behaviour
> when asking for `ref@{0}` with an empty or missing reflog because we now
> die instead of returning the object ID of the ref itself. This adapted
> behaviour should lead to less surprises as we now really only report
> object IDs to the caller that actually come from the reflog, thus making
> the user experience a whole lot more consistent.
> [...]
> Reported-by: Yasushi SHOJI <yasushi.shoji@gmail.com>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
> diff --git a/t/t1508-at-combinations.sh b/t/t1508-at-combinations.sh
> @@ -110,10 +110,31 @@ test_expect_success '@{1} works with only one reflo=
g entry' '
> +test_expect_success '@{0} fails with empty reflog' '
> +       git checkout -B empty-reflog main &&
> +       git reflog expire --expire=3Dnow refs/heads/empty-reflog &&
> +       cat >expect <<-EOF &&
> +       fatal: Needed a single revision
> +       EOF

Typically, we would use <<-\EOF rather than <<-EOF to signal to the
reader that no variable interpolation is happening in the here-doc
body.

A simpler alternative in this case would, of course, be to use `echo`:

    echo "fatal: Needed a single revision" >expect &&

> +       test_must_fail git rev-parse --verify missing-reflog@{0} 2>err &&
> +       test_cmp expect err
> +'
> +
> +test_expect_success '@{0} fails with missing reflog' '
> +       git -c core.logAllRefUpdates=3Dfalse checkout -B missing-reflog m=
ain &&
> +       cat >expect <<-EOF &&
> +       fatal: Needed a single revision
> +       EOF

Ditto.

> +       test_must_fail git rev-parse --verify missing-reflog@{0} 2>err &&
> +       test_cmp expect err
> +'

Probably neither comment is worth a reroll, but if you reroll for some
other reason, perhaps consider them.
