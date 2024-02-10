Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3066C364B7
	for <git@vger.kernel.org>; Sat, 10 Feb 2024 10:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707561807; cv=none; b=nt8+/YredwnxBuChDzxLzyPEh57lhTzpCK7Q5wSdDHca4XpPzVyUvLS1ESBjVKiXPUEf3G47c9ljRAAyMLLGBiqy5rnCaGWuDNJtMz+VxlqxPkp65TxsBWS7cc+DQfdyei2qD1lPrv+YtJkOzRaKpNHJRdVml73n3zg30V4n/Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707561807; c=relaxed/simple;
	bh=GZmBeAFEBKe/Ry/hWRDicwm3U97pwMuoT5/dfiourUM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XAahRchG9qmoB5QoA34TKSpclLRqaSV2uv3nJNY2Vv/6ux4ZD4WwBWaDVD1eB58Ib/2Rm8Ns+plY83eTf9nTdDZCkgHSVOy7k3Gx1DBGl+WudmDWRSb9tk1VJLzAnw+rSLlVNs1qjTIK1m8sSPZNc4C6kDfCtQVssa3i/O8B7t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhWZ89kq; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhWZ89kq"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1d94323d547so16795395ad.3
        for <git@vger.kernel.org>; Sat, 10 Feb 2024 02:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707561805; x=1708166605; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=l3mWJb9dAGuxzmyHbYkSqfvm4fCOml4ojquX9CVlSks=;
        b=WhWZ89kq3caQaRkq7vo9wmoyTLc3cNsBkON1jwFBElXU+Jw/C5mJx5Q+A1Zj+sSs+l
         D3/vjZ+t9tp7XQ1uOAqT8dDGYTzNV5QHekFlKPuwCrhHMkBRul+RFyWjhb3nHOiS3JOp
         nbnsq+7gUlv3wMxNMRpPS6C1aylkvucBFuaWpblgfUQOFDvTNS5AW/YLvjD/GUaKNfCh
         68KgG7/3CsLjSNb1OOx1ZyLRsSnqCgSE4wZy/qc1x3aClau2yp5tePQsccl3laYpY2OA
         k+QoI7djm5vdxFXlx/yiF/b+2Kwlx/Gh8Yync3McBOmhr46RBK0gHA0T3v7f67fDwROo
         eFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707561805; x=1708166605;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l3mWJb9dAGuxzmyHbYkSqfvm4fCOml4ojquX9CVlSks=;
        b=QzOohhYKt72ValmFQF2BpiOw44RAZElswW4IA3CgyPHNbh3xRtIkNc1odCkHuop9zc
         1121A1dp92fMqBdh8YD1yv5R6xqmmexFvKy6AQ5cyObWRvPzaLk/72TBk4Hi6dlGNEZn
         PQPXxHEXRpr+B+HZD7C3b9/TMD7jtMWAwHW9wc704YqqMDkxaMb66c8lNft/z1sJpOM5
         38sVnhNI7621F+m9RH/HeyXlxprZxiCDkpZPAHxO5gFh98CwZCfSdFhOaFj3IRjOnDnD
         +Xybu7SOoyhSH7aLh55FoAXqBDbQU8scMVGmGUhvgSz8LuLbXJHJY4i8M+dgOMNXbAl4
         KZwQ==
X-Gm-Message-State: AOJu0YyrPoFMHFXniyr5Ls6BBu9Jb2fcd9LVqUkx5YdXHQvokuVP/iKS
	/cqgV+Rb4BWwQGrFlnHvyi9RlkUg6nrO2dxMfHCxIHJeiudDQK10eCLzjDBmk3w=
X-Google-Smtp-Source: AGHT+IHisiWBq2pliCUpKJ1MGogVugPLmw6uYpkYzXBfqp7BP36+UsXiG6tpZftfCyMEDkq/BbK0cA==
X-Received: by 2002:a17:902:cec8:b0:1d7:15ea:4249 with SMTP id d8-20020a170902cec800b001d715ea4249mr2204437plg.7.1707561805224;
        Sat, 10 Feb 2024 02:43:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCV7ntS6I3YmN221fDmc7dKApys5UWfbf4JRh+aK6VeP02JLSKSikcV/ZO+HTL7sRDG3W64UITKWH2ydaEJ11gP8ovhr4f8yFqevNE90aWUsIg205guLK1ZUSc7S8fYH1qtXI8xvbakixJFOfuRZGhZUj07B6YEkMMxc5KzrRu8GcQ582vokRigIqcriXEnyO/iv5GomTCs4euXGrGgWw1k0BNdyVuV9b5RgXembGfAuBBbMQ52PSMV2+61t1CFD5Jo119ki85UBKY8+Vux81xzmH3+90TaGup7UDvBsYWezutA8Y4FK6m3Ejf6YY+lmmLwKAomfTxeekI9aDTvsycK08niTuaf4JM8BBEfU7ZHIgq0NvLkYOS+5JWrYENOVU7B2IFOL7/FKUxo9Nh9v5zS61QmjufA166tV7pDSOR0xGejKcDgToiiaE78fAhdebRRdIay0cCpYK2io0c2l2AO0LoirEgVGRok0fNtxi8TxzH+SoMQfPcWfc4rTEtaS4LjvDUKx05XU1HWxvsDX/8X0ZImh4gThgxkZBrZrzKFyX86ofBG1xarN2TasrFWlQWjkh5ZGxAsDbdHNHgNpvlu6DFtDxby3ILSsntg2aYoTQj7HCUAH
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id jz8-20020a170903430800b001d95d1078fdsm2840853plb.56.2024.02.10.02.43.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Feb 2024 02:43:24 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
	Ralf Thielow <ralf.thielow@gmail.com>,
	Jimmy Angelakos <vyruss@hellug.gr>,
	=?UTF-8?q?Christopher=20D=C3=ADaz?= <christopher.diaz.riv@gmail.com>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Alessandro Menti <alessandro.menti@alessandromenti.it>,
	Gwan-gyeong Mun <elongbug@gmail.com>,
	Arusekk <arek_koz@o2.pl>,
	Daniel Santos <dacs.git@brilhante.top>,
	Dimitriy Ryazantcev <DJm00n@mail.ru>,
	Peter Krefting <peter@softwolves.pp.se>,
	Emir SARI <bitigchi@me.com>,
	Arkadii Yakovets <ark@cho.red>,
	=?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= <vnwildman@gmail.com>,
	Teng Long <dyroneteng@gmail.com>,
	Yi-Jyun Pan <pan93412@gmail.com>
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [L10N] Kickoff for Git 2.44.0 round #1
Date: Sat, 10 Feb 2024 18:43:21 +0800
Message-Id: <20240210104321.3303-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.44.0-rc0 has been released, and it's time to start new round of
git l10n.  This time there are 52 updated messages need to be translated
since last release. Please send your pull request to the l10n coordinator's
repository below before this update window closes on Sun, 18 Feb 2024. 

    https://github.com/git-l10n/git-po/

Our l10n helper program (git-po-helper) has been upgraded to v0.7.3 to
detect typos on mismatched refspec (such as refs/ vs ref/) reported by
Patrick. See [1]. Please check translations using git-po-helper before
sending your PR.


As of git 2.37, we (git l10n contributors) have a new l10n workflow. The
following description of the new l10n workflow is from the "po/README.md"
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


** Please note: The update window will close on Sun, 18 Feb 2024. **


[1] https://lore.kernel.org/git/ZX_9nRYKVq0jT0Lp@tanuki/

--
Jiang Xin
