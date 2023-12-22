Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1368F17730
	for <git@vger.kernel.org>; Fri, 22 Dec 2023 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmwoNHnz"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-1f066fc2a2aso804631fac.0
        for <git@vger.kernel.org>; Fri, 22 Dec 2023 03:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703245272; x=1703850072; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jiYYZkgrUgCajPLEwQEvgK9uVXeh47/LcT62WhAq+EM=;
        b=MmwoNHnz9sgYcZ76N80Fkk6Kt5d/H5TQ3TNvlcZ6hcoJsALtfAIxN7YRgNTEoGOnfX
         WKpOcfVOecDKEmiuRLw0Oe2cX/sJXoR9557ROdzSdogaPEL/nhnl5cik+5O3A+FgTgA+
         /IowZf1JvUdLLPFV0L2fuFR5bLdgmVURCpUR3BXFj2uGQdVkD6yAlyruQRZOSGKCjHp4
         nL1FyEzfBSBZP9OQF6oXomGDGQ7m6JnC3Zpj1jzZoK14hw1bxvh4npqQOhEEHAnzkHmX
         +BvOWP7jflgO4PsRSKHD1gxKVZGBw+/s04iHPFIiyHQTji9FkF2rEIgRcHijot+BNL7S
         0gGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703245272; x=1703850072;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jiYYZkgrUgCajPLEwQEvgK9uVXeh47/LcT62WhAq+EM=;
        b=J19cWGacM9xQVKzbjcWJSh/te6XDHfZsMHazf571nrTBAFUaQASPjuugsZvf8Ist9s
         xO2t0UK05mT0ZoatHBxs5rAgCuAVvLCIfRiLuzqze6Vd++3UmmXkyujSsIO+vbboaP76
         pPFceT78soY5P1aO7lqQ7JsTpkFeczJcpA1SOZsZGFyUdhYlgFsCRIDk7m4M33lnJZ+F
         Fzi3Jo/PUuo6SRYam0owq05LA1/L80K/n9cLqWsi3qhKbhWvKpObyQoPw7opvYF9tiOy
         HBYy95dL9Xo/TIJRy4deuef2t5gtmTvD1Yh2udZDdXXQJ9GjVp1uabBcbDYqtljScaC2
         Op3Q==
X-Gm-Message-State: AOJu0YyP0DWOXrvcSxw5ooEMPHzxN+u5s+YblvOZP1RU5oi67W0zCNwc
	VWCQ1D0BNQcK3Bu4UWnCLnfEtIismgzgsgFvdRN793Ebwqk=
X-Google-Smtp-Source: AGHT+IHh9h5VT6erHQMfqvzWtTgEVzElAhVJoQy1ea5oGSOsKwW+MY0/wNBwlq3NT816zV72/AtpfZhIaaQgNpC6lJk=
X-Received: by 2002:a05:6870:9195:b0:203:90ab:c19 with SMTP id
 b21-20020a056870919500b0020390ab0c19mr1056465oaf.48.1703245271646; Fri, 22
 Dec 2023 03:41:11 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 22 Dec 2023 03:41:10 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <239ca38efdbe3195e6319be4423b17d2b42e0b9f.1703067989.git.ps@pks.im>
References: <cover.1703067989.git.ps@pks.im> <239ca38efdbe3195e6319be4423b17d2b42e0b9f.1703067989.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 22 Dec 2023 03:41:10 -0800
Message-ID: <CAOLa=ZSY-FBUMOx9SHkJqf7XteQC=hVoYxo73q=E1wL3QOBYtA@mail.gmail.com>
Subject: Re: [PATCH 01/12] t: introduce DEFAULT_REPO_FORMAT prereq
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> A limited number of tests require repositories to have the default
> repository format or otherwise they would fail to run, e.g. because they
> fail to detect the correct hash function. While the hash function is the
> only extension right now that creates problems like this, we are about
> to add a second extensions for the ref format.
>

Nit: s/extensions/extension

> -test_expect_success SHA1 'git branch -m q q2 without config should succeed' '
> +test_expect_success DEFAULT_REPO_FORMAT 'git branch -m q q2 without config should succeed' '
>  	git branch -m q q2 &&
>  	git branch -m q2 q
>  '

My only concern is whether we'll end up blindly adding
DEFAULT_REPO_FORMAT for tests where only SHA1 is a prereq or only where
the new format extension is a prereq.
