Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75EE2595
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 02:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734401331; cv=none; b=ZF3UpGTfi8sJ39EYGvgA0ySIfelctiiYsZdxkxp89S2Svc5sfBS7Dr8LSCIF5H5U7RYlEb9QSLoHPAIVD6duCINT2ZH7JTOmz/zcoExJygZSgpAycYXxhDvhTL0iqBruw1TOs5cTAgc4Au+rDtjravoVsgfx4duelmpmjuFfO2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734401331; c=relaxed/simple;
	bh=/f6LOZxADag9CMnW0oHi947/Nwa8fhh1xOkvjmSuH9o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=j7pxYJcPmbwhcD6iSesFaU9Pq0Gbd24mKMIbAYikLrh2d/yRehvAGBq22W3KVQrPQtzbi0jAf+pwKqBzjTYMFHJ27lXJZK/N38tFE5C2+asuc00hFvT7Nn/G3HMIrrvgTZGSEbnt4FYyWtkcHgsLbl6yGHDGBXRpZs81HxHpAak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=He6BGTx8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="He6BGTx8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2eeb4d643a5so4170152a91.3
        for <git@vger.kernel.org>; Mon, 16 Dec 2024 18:08:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734401329; x=1735006129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ClbH430EJJr19C66KRyRXutJNHAJUw5dT24UuJN1cOk=;
        b=He6BGTx82weM/EaUhf06CHmlsAQEN+ujaFOqlkwyy8i2wY4mFU+UTw3RbFlnbQoWvU
         esc6kEP+h3XGI7VO06rF8lFFEZgcFcrR9a7WZ9AagSlyeIpQ0p/zb9yZYLmr6ATZQF/Z
         4+qduNbis17H1Fop3BT6fCaeGuIsII2pIZLsV2tM1k53wg5i+7tl/OAv92kZJWc5VM9+
         4YsbQfUfy50Tic5mFYvZCBQSYhBn3Es3bSdXv5XUYBuUEAZd1QGQXl2M1PlpV+X1+BTJ
         qXGz6N2bF6XnvzP8KYHU7hMJ+ei+mkfGJMc4M/LJfNtyGuiXwqDOlmiTSGZ+f2f8PJbp
         Ko4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734401329; x=1735006129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ClbH430EJJr19C66KRyRXutJNHAJUw5dT24UuJN1cOk=;
        b=Gjs6AExLGNd/+zFu1jx3Irjn5Y7qAOblePf60UuVrohgrBUWOilkKeYpFW+yss3HGR
         qrUl7CvQPyCYoJ2gXTeXDA5RnVZPP3ee81cBirrs5l5exIW81sHEdFJP0frXTdF1yIjJ
         C/XZ/AOrbbOtyCZB2Zj7ZhzMRoAMgsacMXoshJozh+vekteHlqeKJDWBEAX4MAY1VY73
         oVQRLR9bcfWBkEGC/6+56l+HDPxGExSDJmAss3ISCtvP4hZRC3Qr+sOb8h97rYZRoQhv
         EG707aXm9DlY0K75w9by5GkpfVkqlBCfwEfkIx+ltm42mQoNuFcpNH0cpJqUgtFN14ec
         oITA==
X-Gm-Message-State: AOJu0Yy2zHod7Ya3j0NMa2VtOrURxE3Ireo4Vk90ORndZyQ5JIJ/3CfV
	ihgOUk6Y4cHwKO0/JjDgWeicusHY4XmHRWR/47Wve2UZp/vqDiCm9OPRnA==
X-Gm-Gg: ASbGnctvIc59oUemBavgKghDh084FyZxRodOt7DuP93Goqdy1O2csrtUsbd+GDjB0HH
	4PK7JZCxlI6HTr0Mt6aJCQQM3VvsOPkE97T1RUg0t9hv2oQ/KPL1xlQL2sRrTtPAy9qV6Y5hsJ+
	eRmCtMmDHgC3E2X8tS0RTH25hNvyYgl/bR7o1uSP2+Y362cEu0zkb6bVQ8RFeHDTny6emDP8p9k
	kUoYEMtl+/C5b4Oe5E3oGuG2F1Ccp3qBBF1Sq3LpAgj1lnQy+wySJHDDhbUwILip+jgCfQO0lg9
	VSGaAbWtjK/4ZrbhTAnFwwPw9/UxGh1N7dT05lvD3O2XXb4G
X-Google-Smtp-Source: AGHT+IGp32kcSudNsI9Kz9TgyY8E+Tnzran8pLLt8QUMefsXo/1v0pT/0jrwBG/bvJN3pEYpBmJUSQ==
X-Received: by 2002:a17:90b:3c8a:b0:2ea:a25d:3baa with SMTP id 98e67ed59e1d1-2f28fb52241mr21478240a91.5.1734401328685;
        Mon, 16 Dec 2024 18:08:48 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2a2434a7bsm5381049a91.36.2024.12.16.18.08.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2024 18:08:48 -0800 (PST)
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
Subject: [L10N] Kickoff for Git 2.48.0
Date: Tue, 17 Dec 2024 10:08:43 +0800
Message-Id: <20241217020843.27943-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git 2.48.0-rc0 has been released, and it's time to start a new round of
git l10n.  This time there are 36 updated messages need to be translated
since the last release. Please send your pull request to the l10n
coordinator's repository below before this update window closes on
Sun, 05 Jan 2025.

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

Then update the cooresponding "po/XX.po" file using the following command:

    make po-update PO_FILE=po/XX.po

Translate the uptodate "po/XX.po" file, and create a new commit.


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


** Please note: The update window will close on Sun, 05 Jan 2025. **


--
Jiang Xin
