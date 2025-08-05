Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CC91F948
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361014; cv=none; b=R2Tu5+duZetzvxjGyOqpSehlTiFr2pAPO3D1SMcQPQ80fcf5aklBd3UDMgYVmWE303q8b7zyECzSfmR6L08o8GcjFZpEKkxFAbcNYWn/iWVuLS7xJ6nRPoiz1SL6XMJTGamnwibnHN3F3MshscdO0koJvi97u2/KPe3vs8pX9T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361014; c=relaxed/simple;
	bh=G8s0ySmjF6vWpG6CTvKjsP12JjHtM/AOuKI1yEJhnCc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k+BH7yTxWQH8tVgbO7ppWZafzM5JbLB2cvQch9Qg/q9oTxTmEgnB+Eyn6ur7J4sBgmYagPpiKY5tVUORfRr+AvbqEgdINwl01yHJd1SkqMIgGTl64NbfKjqTDDPCSCqgcotFtiOqj5fBoCBe+K9Qr6oankLZXfrioGFkA9tpw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gNvODijE; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNvODijE"
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e8e0c6f1707so3704056276.0
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 19:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754361011; x=1754965811; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BLIi3AIsvAUFzigC2hm5naTYADoKMEIkRtla+T52Tks=;
        b=gNvODijEdxswDyVGQ4Kg+BNA19OtM974RZrF9IYD4IqbLA5pi36KHB7CDRuvJWEVHU
         9IPXSjMWVOIIUywHAlAyyHaRmUTpW3XnHoC+XF5SkKVrpZ1yUsMqucqu380JR0BZiXZR
         qzWGDzzh/b7orTVIyTHufuaDpiVmnlvRuyiKJdFLPUVOrDYGM2B4gts/acaw14h1T0hE
         MJtsPkfgQa2b6cehlfu0CeW1P5/g83QMm81HsozWQwGwRyRiZotuDQVCo18MB/D5Y0y+
         5FgJv9iLNwr0ZUHl/2OUPXiDeSJIxtP7YEKefVFsk1z00pjUHOevDTuYzkcvk1kMuS8a
         7UwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754361011; x=1754965811;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BLIi3AIsvAUFzigC2hm5naTYADoKMEIkRtla+T52Tks=;
        b=R9GKtXrTJQ6Gu/T+iR4Qqtej+QrWPAFk4bh1gLbKuIUM4Ru6+zP8PyoSQ3IKcItUwv
         WiM+SMoNPwbXetAAUEYpk83yvtLtlAnSdQdDoR4J7QfDdqi/QaYF+m7tCxANSwECttiJ
         iIVf1RMJk2kFW4pSxPVNxl2iXumObVYp46uXBKPG1awmytZMA1uDN7SXtzMe3dxpazdF
         zfDtqi1QB0eXp+ucwFh9PDSwgWoYG+/6/7nGsQH/BlR19U5eURG6Uz8uKz9+tcHqP1ey
         uUxWcHwFUKkuGmGRd7iIbqBS0PqSbPfUUiX36521iecO/5tn0NbxPLx4XWrhoxy/6uBy
         jM5w==
X-Gm-Message-State: AOJu0YzmWYZ8Puqzbz0OuY8iGSnYsCX+pJqw6zDzLuqxy0wexQH5hzdJ
	P2zGn8qFtWf0NvkMpplRV8nz0sdzNc4QAN08nPJ6tx/UsA4Z7Qy3MQyZxfChdi+A
X-Gm-Gg: ASbGncuyHiD1khWwRUqnjiSld7/Nkzw2Rem+pdoTlv2xX8uBmGzNDxLzs1k6b2pnPT0
	dDFJcWQhmhJAPY7WxQCepd3cIUi47zgDXgk0WJlO5u5xfhLrw+NUoJRht/iE6mDV6HyBAWvWptI
	PK9LFKdeJCJLSUfXqwJtgrecUA0noaINC8rcuLnGmxCFbRnPkk7nKMS7tO+mIMtSgvXgy+M+9il
	Wb3gsDKeAMu5LyoHfFTDXh/HHzCJ+TD8lS1Z3QboD/NMhyat49QMSIXdNx0KHlResV9eSBQX/84
	fT1f+8BHbD5fKX/5URhdYDAIGv3m3wBoUCtMXgzwLomjnox55GDO4tLXk4nRBeXP87EV9dUy4x/
	h782P49B5plHcqnL4nhv/4WfnwPDvVRtikNSOpalHK+9+yD+A07YJrD9Bo9FThfeOcG7K/zRIT6
	KncevhMsWV3uxGl6yHos8=
X-Google-Smtp-Source: AGHT+IFU6yNnUy2cR40EVoaYbWTYdYQ46GFI4oNiymVo1eYJzhosEwdrDX/u2qmIgdhedkN4ABOTcA==
X-Received: by 2002:a05:690c:a84:b0:71a:2961:e2ec with SMTP id 00721157ae682-71b7ed8bcabmr165125837b3.16.1754361011353;
        Mon, 04 Aug 2025 19:30:11 -0700 (PDT)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5c62efsm29189047b3.63.2025.08.04.19.30.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:30:10 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
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
Subject: [L10N] Kickoff for Git 2.51.0
Date: Mon,  4 Aug 2025 22:29:56 -0400
Message-ID: <20250805023001.310746-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.51.0-rc0 has been released, and it's time to start a new round of
Git localization.  This time there are 58 updated messages that need to
be translated since the last release. Please send your pull request
to the l10n coordinator's repository below before this update window
closes on Sat, 16 Aug 2025.

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


** Please note: The update window will close on Sat, 16 Aug 2025. **


--
Jiang Xin
