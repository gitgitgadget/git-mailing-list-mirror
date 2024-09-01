Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEAE2C6AF
	for <git@vger.kernel.org>; Sun,  1 Sep 2024 21:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725224542; cv=none; b=mu6SQRkdM4ZLDNUOZrQeuzsQYSUEXhIkjrYkfoFDItpwNVmff4LYFoMAi0v5Fb1bp8QPLSlmG8LTIDea2norPnVOSkvZ4XGponYKGNptypFVZncChyg+czBkzsEq5tfpkBszkEEPb1DYUyGEGR2bSf4eTihRfX0p1oANyWYMk/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725224542; c=relaxed/simple;
	bh=wzwnu+UW1RqNXiu7VcGKie8L48KBD5V+WLCoioN9Ejk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LtnYuu/9xto/F0vtn0tQMnLj1a3Z9nOYadeJNEMf+sNkPyC713Fv/KGjaqEbt9XWHRGPe+yq+ZSEUT8IhmtPTcOmi0MQzutTo/BHq51hJ6M1kELMC9mlPvfwAxQr3kRKfLbPewh5n8IMKUWIoknUYM4oMb31Is0bBoGhQNOhNu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y6BL2Dls; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y6BL2Dls"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c255e3c327so521321a12.1
        for <git@vger.kernel.org>; Sun, 01 Sep 2024 14:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725224539; x=1725829339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wXglCmVmm+AkA9HR6W6czNltk23AlHqF3m3rOIPvmqM=;
        b=Y6BL2Dls/shSQNaNYG4GlEhsZc9Ed3YpE8i0PGuZgaAE3siuLZzhGcyJBd4LTPEJ4L
         rkESx07amGg1F+zwq2HyjBXwhond5nzRUWrK7M8Ob1L2tR16AV+mkVDUf5uO87+E3gbf
         no+bYeQ1kGnG21VujPmw+xTmzEooXeUzSG5AJxVQzOztLX6ZwgmU7S3EkqHqVjtB8W5m
         Affnrmld+oK5x1arbwbvAT6l3JRHmDK9LU9gtvdv/xFl5aBw4CTD2WOgLT2ryTC7ctS2
         UxVOjSKiUO3vD6jT+y0ufewEhVhonuXFCfsTAMUiSoXMoGw60q7L8kh3uFraccny47Nk
         brfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725224539; x=1725829339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXglCmVmm+AkA9HR6W6czNltk23AlHqF3m3rOIPvmqM=;
        b=IP2RfcU/hFeQp0nms3gtrHHANw/Zq6HXLGFfunBeCmiF1lKL7smPRbLiK5i+qTp0jv
         6O04wrLPdUYqo3wlrnil+SO+OaFdgrjJ5IzeIQBZyTuUw4dp7ELEWM/zCnPRKRWVK9Ss
         OnrwPHHo80W2sHhvXVAcsr9w68SeSBRs/Ck+pr4X9rKvT0w0PDYeQzDYtCstJY3oaxsi
         lSUXaJJKUeqkxcXwxhGDVirreUxUmjRYj+HcN8BXjw0qK+ds3WVPfgVyQlJ02DMF/aHZ
         qwgqyuR+7aMyOrITV360Ht3qT8oXwjYIXwOxGyuROFHKFxdGNYF5Y3zqWDY+t5RTo5rO
         IzlA==
X-Gm-Message-State: AOJu0Yx8QnZ0k4ENwS6uB5FXKWedR/dFS25s8Tk5vliWUFusVS0nqHRx
	Kod4uxIok6WpBH/sDzzoECnVdffhyL59vUHbtrv83n8NTU72SjVhlaa776dmMJXFHsXNVi4oSN+
	Va4TsDCSSk9QTxmVwBLMpZ3gvGfs2cuhO
X-Google-Smtp-Source: AGHT+IG3yd6qiKXXpU25qLT1kEG39kdqePL7reUioFSrxg6tTG+npXoCNWW7VH9rnUB8U7pORsr7nkO0z/o4SZ0Pu3E=
X-Received: by 2002:a17:906:99c5:b0:a83:9573:45cc with SMTP id
 a640c23a62f3a-a89fad7b546mr134576166b.14.1725224538157; Sun, 01 Sep 2024
 14:02:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Sun, 1 Sep 2024 23:02:06 +0200
Message-ID: <CAP8UFD1Cyy9Fy6TC0MecAh-WAQ42s74Md5QmtXXat4iHrmgtcA@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 114
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, Eric Sunshine <sunshine@sunshineco.com>, Victoria Dye <vdye@github.com>, 
	Toon Claes <toon@iotcl.com>, Brandon Pugh <bp@brandonpugh.com>, Derrick Stolee <stolee@gmail.com>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 114th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2024/08/31/edition-114/

Thanks a lot to =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, Brandon Pugh, Ralf Steube
and Toon Claes who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/726
