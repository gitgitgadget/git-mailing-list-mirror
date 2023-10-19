Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB192EAFF
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 19:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLCpSMI4"
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A949C182
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:49:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7bbe0a453so249877b3.0
        for <git@vger.kernel.org>; Thu, 19 Oct 2023 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697744977; x=1698349777; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JVL4GJQ9gOSa+GL/1Rf9V4xgBza5NyTVkUyishPav3s=;
        b=WLCpSMI4b8zMfxjFt8g2RJOAeaxkg6PBPNq3RucxKa5m6WqClObm0t5YxqeUA3I11G
         CvkPABId2Rl8IllSBmLW9djJKmv/J5LD/Z8T7bP4BmaVoQ+5kE4w4OkkNGznS/BPlNGA
         eLTEIKwmmVM2PvdLRgTx4dYaD9nuj3kT4ZxkE1sC0lfCaPm0jThhbhVCNLZqF17l/axa
         fZ7OXVstY14ODRZc73FmN3IxdwQA5ziI11dBoMi3MvEpMdwBMfqndY9sgMrgtFiH41Rk
         PdadJu5nJcSxAe9FEVdre61qzlhJ41Y68Cb88oP4uxuJBt5ME4AOr166GtP8ZMoHLagt
         GJpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697744977; x=1698349777;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JVL4GJQ9gOSa+GL/1Rf9V4xgBza5NyTVkUyishPav3s=;
        b=luitZd/6vc32rAral5YkB4cmdHylrR3YoNmeVujgB9QyR/nyvg2Z3ZwN/fckliPGUf
         m4nezXdw8ey9ak1PWWON4t1EMv/2m9E3ldS1OQqn9a+sliw+Q3kjVbTbaleydorrmK+c
         VdtN/OnJVYgXrYuVL5FwE5TSjvgaKfVu2QcER/Zol0BQCOpXDKgRGDQvSHbDxPy6uz6P
         62kz49CNUBN1BG+NMCjaeaxMn9Khc8LakyjVZdQWpojqcDWBnpxXpGXQdYEKah2gKoLV
         9/uqy3x7CxbDXdJ8X4616pg/UqCnHe+Kjwif+46Nu/3vDkE2pRyYyvWRN0ECpIu9m1PL
         YpdA==
X-Gm-Message-State: AOJu0Yz4HpkMCQffTlw04vFnzULAargDAz7YrM13t516/Guzog+KAxmK
	Hmy89XDQaRtx8M9MC8DIfY++J4/Jg7Y=
X-Google-Smtp-Source: AGHT+IHciKnAHyg5z+RwR9rKTm1JxdZUyz8frUOvHe+oEZiOxRQWpKdDFnQ0wD+SyWSjAsuA3eUrUlmZK5Y=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a0d:cbd1:0:b0:5a8:28be:bf86 with SMTP id
 n200-20020a0dcbd1000000b005a828bebf86mr83620ywd.5.1697744976958; Thu, 19 Oct
 2023 12:49:36 -0700 (PDT)
Date: Thu, 19 Oct 2023 12:49:35 -0700
In-Reply-To: <20231010123847.2777056-12-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230907092521.733746-1-christian.couder@gmail.com>
 <20231010123847.2777056-1-christian.couder@gmail.com> <20231010123847.2777056-12-christian.couder@gmail.com>
Message-ID: <owlypm1aqto0.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 11/14] replay: use standard revision ranges
From: Linus Arver <linusa@google.com>
To: Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Elijah Newren <newren@gmail.com>, 
	John Cai <johncai86@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Calvin Wan <calvinwan@google.com>, 
	Toon Claes <toon@iotcl.com>, Dragan Simic <dsimic@manjaro.org>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

This patch's documentation bits LGTM. The comments I have below are all
nits and I don't think they are enough to require a re-roll. If v5 is
accepted as-is, then this stuff could be #leftoverbits for a future
(minor) cleanup.

Thanks!

Christian Couder <christian.couder@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
> 
> +DESCRIPTION
> +-----------
> +
> +Takes a range of commits and replays them onto a new location. Leaves
> +the working tree and the index untouched, and updates no
> +references.

Nit: in v4 you had

     Does
    +not touch the working tree or index, and does not update any
    +references. 

and the "does not update any references" sounds more natural than
"updates no references".

> The output of this command is meant to be used as input to
> +`git update-ref --stdin`, which would update the relevant branches
> +(see the OUTPUT section below).
> +
> +THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.

Nit: add "IN THE FUTURE" at the end.

> +EXAMPLES
> +--------
> +
> +To simply rebase `mybranch` onto `target`:

Nit: s/To simply rebase/Rebase

or, remove "simply" because it doesn't add much value.
