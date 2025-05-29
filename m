Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3ACE2629C
	for <git@vger.kernel.org>; Thu, 29 May 2025 00:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748476840; cv=none; b=t9mzyPQd1HCCbpApZa21dlqmpk9+CcijmQUVNWMfkLbJG9DyRtPHYfAc7WeIRmxISX6HwYmlmWU+woaQ/ZC+Aysc5m6ahM5wE7/AjUF/KYcbNO92d54L60MFd/CugBQ1p7mRH+0qHbdX8zhgbYdaMSIz9ymgCg+aHz8z4Sq33mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748476840; c=relaxed/simple;
	bh=DBjWQxyHggQiEHrLq18E+4maYS52DJrpERCqFRJJAoo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=elIe9dH/XBFjx/oMMks0xKzlWPNqZicFUZEMUqgJ/UyG4h2UY9XRI5wCvPBJoHenSthTccG14cp1B6zRqjCW7K4POUW8KTJ0d6Af4LD7VFzQQPKoVAQOSuCdlH3zuNDkIDqlaH9A8BegEnqRpF7RTeIp0mM80g2HUn9EGBbEFTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MgPDs1Ls; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MgPDs1Ls"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70e4043c5b7so4507457b3.1
        for <git@vger.kernel.org>; Wed, 28 May 2025 17:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748476837; x=1749081637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZFtNc3lLGJNKeiNkGEQvgEYHfGrQ3yTxPU2t1V4uwL0=;
        b=MgPDs1Ls+fPxKuN+3eCgoFBRCt9DtP4JT2c+y2MRGLVbqyfALm4yRBukdO1YzVFKrW
         kLdpmzHIZv+5y4HlbggW81O/xFZYwW4CNKchGltU7/89DTfj+OUxs+OotWJr6KhA50Z/
         oV4MOiMRXmugS0nZGhF4DS1QvrtT2dlVJCrSGjvy07XF/V8U7G6tQpuac9Ut3R1F9gHH
         FR7wcKWcgXJcRDppw+g8ttnwXEAY2goS/r624W2BbYIjcu4+gBStXSeGb7SiTzapyH/L
         rkCeMwesmnmW70ODsQps+aiwa9LbS4xJl0qYEj8oXtmO+HbA2Q0smyctYchxSjMMHhxD
         soww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748476837; x=1749081637;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZFtNc3lLGJNKeiNkGEQvgEYHfGrQ3yTxPU2t1V4uwL0=;
        b=itKRA9Dh59aWKf3qBaGjqlp1MMbVds5iI7gcEVdajUV4yjsAJ3xTVh4Umz4ic5H1Rk
         F+wkBqbrVCqO3vlF5l9SdhqHIL/WpbCDf7uxLQsYGBHa3EFZYdTYhtwRJCc70ShtXeU1
         rooz5HM5cEP9nWawsNc+y7GF+PpBKQ5Fs3RIAWmVOR84qBtGO4fsT7k9PgQExij+1rVv
         YhF+5GGG6/tHGFtWP40ZxAS5wO1a8M8nmRjdKQLb9nr+3xQPgm1T6C8Y2xuONtK09B7L
         wvAYQw2qdb4ilAvQSd1yDKUMwfos48uhQSktqDtswP8mo1CXlXY1FDklArEdTW9IzUJI
         WNYQ==
X-Gm-Message-State: AOJu0YwLpppOGLbb69aQ1dqkNhpg8vUzpIDvptGj03IXBUQ2PusAYHoq
	rOWPoCUcENRQdlJ0RwYTkNKyFXv6/jStRxKeZ0GMk7h4zLbe3Aal/o8Uue4352luTFE=
X-Gm-Gg: ASbGnctXLlHqwkQT4id9m1cnCgQHmA9KLTZSdYtq0YaQOSIU/y25YDf5Evry5WezX/1
	+3xNCiP7nAaviMw3II4UmTwWujVlZZpGitztXAo2JXAQv+Wr39WNr1u6m6lSRn7PrvmlUJPS07y
	aeyh/tFXxPPRcBY2HRY3tIN9F84PQe4tL6Uh9LtxIDg4CsVobzhdmfbJ14/hsyajDaGQojAPlt8
	xSWNyfcznLCC7bt9uHaSodCjLpdta2MCrHlLHu97J1L5mYttGPC69rhqGpIhee5fkDIXVwyq48l
	CZ8oBxXPzlBbOlV5xvPPocrX5QyColHnwNxGW4JqGMbg8Pj4RWZ7aI1lFIQLgNCQwS0hLq/9mgc
	kH8VFpRxAe4QR3qLx6Hm8+ZcFMuY6YyUj6D1HgQ==
X-Google-Smtp-Source: AGHT+IH73COZKtFd9Eo17lTJkUh/pofKQ1OrNwv7L+uyGBv2qwyYtCoOvrgH89p6ns+n/QeXSBfNUw==
X-Received: by 2002:a05:690c:4886:b0:70c:b685:a6b7 with SMTP id 00721157ae682-70e2d9e1c8dmr261020217b3.21.1748476837407;
        Wed, 28 May 2025 17:00:37 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70f8ac0f447sm516427b3.62.2025.05.28.17.00.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 May 2025 17:00:36 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	=?UTF-8?q?Aindri=C3=BA=20Mac=20Giolla=20Eoin?= <aindriu80@gmail.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Mikel Forcada <mikel.forcada@gmail.com>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?V=C5=A9=20Ti=E1=BA=BFn=20H=C6=B0ng?= <newcomerminecraft@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.50.0
Date: Wed, 28 May 2025 20:00:25 -0400
Message-ID: <20250529000027.155496-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git 2.50.0-rc0 has been released, and it's time to start a new round of
Git localization.  This time there are 51 updated messages that need to
be translated since the last release. Please send your pull request
to the l10n coordinator's repository below before this update window
closes on Thu, 12 Jun 2025.

    https://github.com/git-l10n/git-po/

The following description of our l10n workflow is from the "po/README.md"
file.


## The "po/git.pot" file is a generated file, no longer in the repository

The l10n coordinator does not need to generate the "po/git.pot" file every
time to start a new l10n workflow, and there is no "po/git.pot" file at all.

Everyone can generate the "po/git.pot" file with the command below:

    make po/git.pot

But we can also forget about it. By updating our corresponding "po/XX.po"
file, the "po/git.pot" file is automatically generated.


## Update the "po/XX.po" file, and start to translate

Before updating the "po/XX.po" file, l10n contributors should pull the latest
commits from the master branch of "git.git". E.g.:

    git pull --rebase git@github.com:git/git.git master

Then update the corresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodated "po/XX.po" file, and create a new commit.


## Refine your commits, send pull requests

In the "po/XX.po" file, there are location lines in comments like below:

    #: add-interactive.c:535 add-interactive.c:836 reset.c:136 sequencer.c:3505
    #: sequencer.c:3970 sequencer.c:4127 builtin/rebase.c:1261
    #: builtin/rebase.c:1671

These comments with file locations are useful for l10n contributors to locate
the context easily during translation. But these file locations introduce a
lot of noise and will consume a lot of repository storage. Therefore, we
should remove these file locations from the "po/XX.po" file.

To remove file locations in the "po/XX.po" file, you can use one of the
following two ways, but don't switch back and forth.

 * Keep the filenames, only remove locations (need gettext 0.19 and above):

        msgcat --add-location=file po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

 * Remove both filenames and locations:

        msgcat --no-location po/XX.po >po/XX.po.new
        mv po/XX.po.new po/XX.po

After squashing trivial commits and removing file locations in the "po/XX.po"
file, send pull request to the l10n coordinator's repository below:

    https://github.com/git-l10n/git-po/


## Resolve errors found by the l10n CI pipeline for the pull request

A helper program hosted on "https://github.com/git-l10n/git-po-helper" can
help git l10n coordinator and git l10n contributors to check the conventions
of git l10n contributions, and it is also used in GitHub actions as l10n CI
pipeline to validate each pull request in the "git-l10n/git-po" repository.
Please fix the issues found by the helper program.


** Please note: The update window will close on Thu, 12 Jun 2025. **


--
Jiang Xin
