Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CB78F55
	for <git@vger.kernel.org>; Sat, 30 Dec 2023 14:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knP3nsau"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a2335397e64so849089466b.2
        for <git@vger.kernel.org>; Sat, 30 Dec 2023 06:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703947127; x=1704551927; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E5Wagkbfakn2a5YBp9S6WWFG1xS11Wn3hzlvJXjIqoc=;
        b=knP3nsaubxLI80dlz0dYfH0Zagjk/Z3og0lAeFFWDPXdmyQsQR+28vOYuncgE38WAM
         bmqYa+YVLiRH5s1PxZi3G1Ct2/+KpWoAEYddwJZW/MKGcuCuENio0s18ZJ9yZ/hAJG64
         +/OEEKTv6p4avzet5FCBQ8MFTp96GhpPafAkaxe0/U115e68o/FTrk0kVJTKK3kQ72mq
         c/2AUyU9bQVWvY9zS59plDo4qbEJBOlXD+JVRFl6FN6XX7SFrvnGvP5p6gAmf3Y1NQlg
         Iu+mbn/pZivVA27rB3auN9Qw0+1R7iFkgX9mGw+x9QBbjzoBez8LnNg0hRpO/3Q46nJI
         zzbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703947127; x=1704551927;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E5Wagkbfakn2a5YBp9S6WWFG1xS11Wn3hzlvJXjIqoc=;
        b=bIeGD6qj1V637ZWBORFsoWsaqd05Kx9229K01ZzM7E1/a7ijbw9wH4VKUWQvRWpYEm
         a7oYVukZ4tIwi8GhXyMMWl+LGXfva6sgKRjUtq3jdrV5C9v5/5qCd4if6LPmSTvmK8el
         mCwS9cRHQKjhSE2EYnFXbz0D3ilSDnhDcqReUGMZJpliQUqlYFHoM0hm+/Mc580Jd/or
         YMdCOvGlB67uEKZJfSbj3DHORq0clhgz8/0NmhPy3Abf8fKUc8nQztGY5bD2ia2vCgfy
         IZYReEs0Et9NvRv2oj9aA9MsENVxUuyy/W786yUCVHyvLL80dJSPX1mg2HhJ4z/2ATtM
         E2DQ==
X-Gm-Message-State: AOJu0YwViPN9ZkHlkqfsT2TefMyto3XqBXVI84eZsk2Gx+Rgr6TZq8dB
	u8VqbB6WRI0aPceh8Jw0CnUCp4b+moohT9VNMg2fFVQO5/0=
X-Google-Smtp-Source: AGHT+IFQ2UkYkvND+CrCu9aATkLGjjtwAGd+acg3LkDQN9kw8+waVzRil5blWV6G/PyiwvGNxEx31IzgrVkDTYX0DP8=
X-Received: by 2002:a17:906:355a:b0:a23:5ebc:9835 with SMTP id
 s26-20020a170906355a00b00a235ebc9835mr6703199eja.127.1703947126839; Sat, 30
 Dec 2023 06:38:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 30 Dec 2023 15:38:35 +0100
Message-ID: <CAP8UFD2hNsfUUfzBUb2F=awYh+mCdoGjERct8Sf916StQyD46A@mail.gmail.com>
Subject: Draft of Git Rev News edition 106
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Josh Soref <jsoref@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>, 
	Elijah Newren <newren@gmail.com>, VonC <vonc@laposte.net>, Scott Chacon <schacon@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-106.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/675

You can also reply to this email.

In general all kinds of contributions, for example proofreading,
suggestions for articles or links, help on the issues in GitHub,
volunteering for being interviewed and so on, are very much
appreciated.

I tried to Cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and I plan to publish this edition on
Monday January 1st, 2024.

Thanks,
Christian.
