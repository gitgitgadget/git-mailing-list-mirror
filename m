Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9CD37B032
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789102281; cv=pass; b=XUo0WNfFZV86JoNCWWalYkl8jCr2unfv8PIdqBTU3J6n6NNX4GCh230Dhu7jGKyFa/F1k7tPA9sqyvcxX3Rz4HIhJ1U+ahZLc6LfBORLCsE62CYxY4+uf9CdRnTY/xayoWZHnX/kYs0lgpDlapq78xad4+UydO7hj+5JyD5c2lA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789102281; c=relaxed/simple;
	bh=4Ry0uiQrzQtV60J+bY3M5kim0L4JIyddSDQifAHYEN0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=MmAj7Gv9NSf3pJp+Z94d9dLFZnw+DaC82WwdHBR1SRsxHSMiqef3u8WFomfZAv8Wb3VShXekG/gdff/h0t5Ft+m+nvys6Yhh0Di4OViNWSjfvCbS6TdrjDtyvZxccZhArvtT62R1Yk3q6HlQ7yp4KR3cy90uFgNVBfKBMHZkXO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pqXyv7ao; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqXyv7ao"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d249c5so422152b3a.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 21:51:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789102279; cv=none;
        d=google.com; s=arc-20260327;
        b=N/575Q6mmqZQlreqRBKoqwpBw6oQt+lwpS45BsMdDZb9gZZHOuchlAWQfWn7o3W8cb
         JnK7yXWB1AzVtLKpdbjWSbzsKscfFVqYTLUIY1aHkuHHAA2V9KPEucHUQjoJnT6TK3Iz
         MNYMpaKekwabopOaySxfCgGVd4fqWS2+KoCtowyR7grWOwHQPqIhV+3PStd9mahwYihD
         8nROKl/J4oWDAj34NOn1x26v9e2X03uaLrp5bRC8cVjENAEVe4FJWS4dpwz02GyuGaxO
         7vn64nQieL4gQePYgazl1nzt7XL00vCuZP4QwiEbRF+Xr5BhXsyH2gbq+9gcw3726gER
         BfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2OwjdTqZLkGDE7H0pOJxqAu9YEjqiwu5RH2surq/qG0=;
        fh=t7hsJvmOTQUwC9Kj6z2qIpQEnkRPtcTDtIVw0Kf4BHE=;
        b=MEq/D0HhYaAiG3pwaFqX+TcHvrSuoTDMk6YVPoakxt3v0bswhDATjT/+6R+hy+HOfj
         TYTjMLe5lTxsazVGM91U2Mn88cWLFe8a1F3vX+3p14GHJzw/oqYA9pvkCvxiXI9uzPeS
         D+qE8iIwA0I24bqaMgfoi8f99jZY20kwT69PESP7CenUQ+y9nK2zSileWeiaCeEx9uPl
         MYKblvn0PkpCyE01VeCYkqSLu1JUrkdhh1eGkDElKnj2zndPn55dRfH9LqeYTA8ewyzj
         UBeTrtCs3hzyySDH/5Fbk/iqozXQi8y3ebJMnIP/kD2LbwMruRSljxZ7Nj9yaAPekqca
         woqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789102279; x=1789707079; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2OwjdTqZLkGDE7H0pOJxqAu9YEjqiwu5RH2surq/qG0=;
        b=pqXyv7aosYe3NY0ekuqhYJrGG+ebUGpuzoK01ultoEU6WwB5ghMzOTGgSBz48GyBOq
         Ji66wWxW8JDw/KJyp9wr45nv1Fz74mmuz3nzifSiRPWefVvQrcCa1UXWgNqmJ7udrDDB
         ylFRX8oJbtheNy7PnZcDFEnDKKVKqghYIa8iIRoYh3HK9+7LSzskhvr0VLiKIcCQ090F
         vmsmltHkJ8GV+AVVMiJYB9YEZasZb5/vxn4jIOCrJrh6b+ajbEAICxRW1nJc8htkbU/q
         Qu21yiZc/465jGTXJZcsKvrHUcaS5FZUa2m3IUPpj3UH6PAGMAQxBkiBmhp2uYDXCUje
         DvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789102279; x=1789707079;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OwjdTqZLkGDE7H0pOJxqAu9YEjqiwu5RH2surq/qG0=;
        b=kpWqepBin/VP8ha0Bv3WTxRg7fWNIiY4r77WpCJdui/Oh852qRq2hn4aTiF6OjcX0A
         H0qbHqLlg2IiJNmT6q4KD1EAjRWsqHXwsuuDcVjbxrICncTYZ725GqJm0at2f9FNIn10
         COG5Ha8evE+lP6HCHKN2SsA8RSLP69WgDxkQVOGXXX5NLmrJRfV9YoO9XYoJ4JKpTctT
         KIM2nBMelJPR+ta/BRc9seEXsq2pjay72qoq0ohDXXQELdhLyT0xzl+R6n3wuKzxqPQl
         Mw0shVa1W4autnEFfZ+1GVRyEUHIlbUAChbA/gFAxHYxfxeFPOEdAGaVf0ptqfqveBro
         lEsA==
X-Forwarded-Encrypted: i=1; AKwUvBznLsWEOSXQRWe0HQxv/2AaO6igx38/GOuuc5Xwt7CSff82nCRhADZjPpER5JWVhaeJUNg=@vger.kernel.org
X-Gm-Message-State: AFuF++n1x/SWmSQej/CKUcXEq1NIRzHNkzwJCfGBL/hGA4YMTTActCCu
	urXJzP8Q82SwA2eyaLsFR6OMtuuDXw0d4d8juurDCMCFeMYlJCM+LGYc7lcFUXpGQMDahwC5ekX
	1oVyGvB5N82SnOoXwYfF69BHJio6TA/0=
X-Gm-Gg: AYBFou35Rc9yb2ZUNs2L3Y0t4rqitIxcM3t3wZCdNbu05ABjiiUUZd6NvdA0gHlVTnW
	oA5kAOmPpZWVe1TGyYMuWuAM4xiYw8L79dOJaFgLd3LYXOJ8vCKWGDVdn9M1h970UzPERleJK4q
	3+Jx4EPDES4naQ9hUzdZTpJlGsBf4UDO8P5gSf/ItuT5ZAGxSyCeyXN6D5Sj4AElQ0/2FSKHdkz
	2f0VPklX2ioUqssdwrn/bLbsnkXK8CL2LGj0gvyOAaxBfdrpsz7QsaDv292F+AwlLgIOd6rTIoF
	8tsmWtdvJLZVpAechzGcs3jJRDIfUBJRGJ4xAUGQ7V9VLxTnCJxbUcqngNBJQ2tSeW21d0+kLYr
	KM7ItcM6rj5X00bF6O+uExOZkcX75B82C+bnTwzmAjbW2s657cvNjWfo=
X-Received: by 2002:a05:6300:2211:b0:3da:c10c:6aa6 with SMTP id
 adf61e73a8af0-3daed0095d8mr4672106637.1.1789102279021; Thu, 10 Sep 2026
 21:51:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jiang Xin <worldhello.net@gmail.com>
Date: Fri, 11 Sep 2026 12:51:07 +0800
X-Gm-Features: AcwNN1U_Yp8P7izv352ctrKF6bwYdA2FPuabcVk0eclynz-ioaRp_pTZi8spM7I
Message-ID: <CANYiYbF3En_u8+CwqnSccxW6JBuM0hBPMYBnh66s-58dHDSv2w@mail.gmail.com>
Subject: [L10N] Kickoff for Git 2.56.0 translations
To: Alexander Shopov <ash@kambanaria.org>, Mikel Forcada <mikel.forcada@gmail.com>, 
	Ralf Thielow <ralf.thielow@gmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Dimitriy Ryazantcev <DJm00n@mail.ru>, 
	Peter Krefting <peter@softwolves.pp.se>, Emir SARI <bitigchi@me.com>, Arkadii Yakovets <ark@cho.red>, 
	=?UTF-8?B?VsWpIFRp4bq/biBIxrBuZw==?= <newcomerminecraft@gmail.com>, 
	=?UTF-8?B?5L6d5LqR?= <lilydjwg@gmail.com>, Yi-Jyun Pan <pan93412@gmail.com>, 
	Daniel Pereira <danielmaraboo@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi,

Git v2.56.0-rc0 has been released, and we are starting a new round of
localization for Git 2.56.0. Since the last release, 163 catalog entries need
to be translated. Please open a pull request against the l10n coordinator
repository (URL below) before the update window closes on Sat, 26 Sep 2026.

    https://github.com/git-l10n/git-po/

The workflow below is adapted from `po/README.md`.


## The `po/git.pot` file is generated and not kept in the repository

The l10n coordinator no longer generates `po/git.pot` before each round, and
that file is not committed to the repository.

You can build it locally with:

    make po/git.pot

This step is optional: when you refresh your `po/XX.po` file (see below),
`po/git.pot` is generated automatically as part of the process.


## Refresh `po/XX.po` before you translate

Before updating `po/XX.po`, pull the latest commits from the `master` branch
of `git-l10n/git-po`, for example:

    git pull --rebase git@github.com:git-l10n/git-po.git master

Then refresh `po/XX.po` against the current sources with:

    make po-update PO_FILE=po/XX.po


## AI-assisted translation

Using AI coding tools together with `po/AGENTS.md`, l10n contributors can
translate a freshly generated `po/XX.po` with a prompt such as:

    Translate po/XX.po with reference to po/AGENTS.md

Please treat any AI-generated output as a draft. It should be reviewed and
approved by someone who understands both the technical context and the target
language. The best outcomes combine AI-assisted speed with human judgment,
cultural nuance, and community review.


## Set up filter drivers for `po/XX.po` before you commit

Comments in `po/XX.po` may include source location lines like:

    #: add-interactive.c:334

Those locations help translators find context in the source, but they add
noise and consume a lot of repository space, so we strip them from `po/XX.po`
before commits.

Content filters are configured for `po/XX.po` files so that the clean filter
removes location comments (`#: ...` lines) from what Git commits. Inspect
the active filter with:

    git check-attr filter po/XX.po

Configure whichever filter driver matches your setup for `po/XX.po`, or
configure both:

    git config --global filter.gettext-no-location.clean \
               "msgcat --no-location -"

    git config --global filter.gettext-no-line-number.clean \
               "msgcat --add-location=file -"

After you commit your `po/XX.po` changes, open a pull request against the
l10n coordinator repository:

    https://github.com/git-l10n/git-po/


## Address feedback from the l10n CI on your pull request

The helper at https://github.com/git-l10n/git-po-helper helps the Git l10n
coordinator and contributors check Git l10n contribution conventions. It also
runs in GitHub Actions as the l10n CI pipeline that validates each pull request
to the `git-l10n/git-po` repository. Please address any issues it reports.


**Reminder: the update window closes on Sat, 26 Sep 2026.**


--
Jiang Xin
