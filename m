Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9B15025E
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 22:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709245156; cv=none; b=YP7atzoAlVQlkP2dK7UdBouYB9G8ik3gs6ws7cYbrTQeJrYwIOUwi5KsSZ24nhxGPkOBzKdo/wBGEcO7n+ckni1aaf2Cja2yuVVkq0kScu/RxhBi2C82Ev94/iAjicgccdH6X35OeWebDRDoEEu2NM59xQV7Hjg3d28hEneZ09E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709245156; c=relaxed/simple;
	bh=1UurJ3Zf2TzyCF0Dh9+ASNABR6I/5/KLN9DlWRVXqdk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3z7jG86VbjdzxsUv/L9NE9PVZaswV1aSdO3XbvOOHhSma0361BJBZxtQfljPHNfIxc+REm+XtbK5RM40mSs/kfIfyqh0cIT70Q4fPxGrhMUCdhKTwxc8W2anNFP6/pJVNH05Gl575Vp5USlesLuTnaLmsEEtuQ1yAs/BlOaKzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6901a6dca63so8673556d6.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 14:19:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709245153; x=1709849953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4SccEe1OhLYyEMgN8Xb0pt5SvdbU0dPifT4BU9ELdQ=;
        b=K+3/DV5/tlGfo7S97VivtthQyrnb1B+YqtAln37dn1c7pxxUxFRWJ5jN74UB6K5x3h
         G+uk3O4VIxNft/XvOF/gz+v7pfsb3aznxdzAf6gTCEi2GGy85QnnfZNqzgu/CrTZ5gVR
         Ml/T7F2ABkgc9/t7gj70MQ/usjazaG205RuwTfTTVNyvN4dhV3CnSlFX7rJlsc/sSGs3
         3TPN6c8AKgGIgvUg2ORaNpcb8sVLcIglq4TLTcBgPFPofoDe2wsSaCDn8h9SHrH+ltCL
         k4U+fL+Zgw5CJ0sooa/y3wi69m3TlaJbUB4dLLDXWfQRRdwVXFlESvfOI0HaZEM1v1gQ
         W2mg==
X-Gm-Message-State: AOJu0YxFtprrf5+q/fjUa+607gZqXQWgw1W1OT0/SK3JsHfOWbMs0RrM
	GVCRsKnn3XRhFUqkFbNnnrB9d2hI+qGSgG+EcU05njtRQlfYCLO/rfpwXKbUlH+YWP58srKaFpm
	IGaJB4ndWj2emOOq9IqabNV7Bijk=
X-Google-Smtp-Source: AGHT+IF7w6XYlQZW1CKT8ETA5ZgPN+WI0G5ZUMEgepP8Mz2LjBuHK8sQD2iAtNIkWweuYAf8HbVrKB3+0YT3MfXiKCU=
X-Received: by 2002:a0c:d989:0:b0:68f:36bc:7183 with SMTP id
 y9-20020a0cd989000000b0068f36bc7183mr3061202qvj.65.1709245153651; Thu, 29 Feb
 2024 14:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1675.git.1709209435242.gitgitgadget@gmail.com> <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
In-Reply-To: <pull.1675.v2.git.1709243831190.gitgitgadget@gmail.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 29 Feb 2024 17:19:02 -0500
Message-ID: <CAPig+cReJYnKBg=CV_zho3dTTJ8rQ8HLHFz5_ogFYuobhU4REw@mail.gmail.com>
Subject: Re: [PATCH v2] tests: modernize the test script t0010-racy-git.sh
To: Aryan Gupta via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, "Patrick Steinhardt [ ]" <ps@pks.im>, 
	=?UTF-8?B?TWljaGFsIFN1Y2jDoW5layBbIF0=?= <msuchanek@suse.de>, 
	=?UTF-8?B?SmVhbi1Ob8OrbCBBVklMQSBbIF0=?= <jn.avila@free.fr>, 
	Aryan Gupta <garyan447@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 4:57=E2=80=AFPM Aryan Gupta via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> Modernize the formatting of the test script to align with current
> standards and improve its overall readability.
>
> Signed-off-by: Aryan Gupta <garyan447@gmail.com>
> ---
> diff --git a/t/t0010-racy-git.sh b/t/t0010-racy-git.sh
> @@ -16,19 +16,18 @@ do
>         files=3D$(git diff-files -p)
> -       test_expect_success \
> -       "Racy GIT trial #$trial part A" \
> -       'test "" !=3D "$files"'
> +       test_expect_success "Racy git trial #$trial part A" '
> +               test "" !=3D "$files"
> +       '

This version (v2) addresses my review comments about v1. Thanks.
