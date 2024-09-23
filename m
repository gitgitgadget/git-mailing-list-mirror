Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3395A184
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 02:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727059488; cv=none; b=E5cBISAoxzCCLNDb4e0n2lTTqBr/ofHLl4YEvXx7qQezvXWuTGcQfpPxWDaT+7MmRaMxnNoQ/BFut/Goo3/PzM75PHTSPcHWAUJmjq0jCSn/EKfxDA8r0LlXaTJxN/3yteDXHbpnLk1mY/H/HlROaapRPqU7dVhZojr2G0EYmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727059488; c=relaxed/simple;
	bh=Dsep3sdyfE//rDWXo7/4mgb0ysX3p/atMl8pki6u3LU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AZ+54jAVvJuOMopPRBz7SrjbIerbIPRWZRg3j9R1CdKJxeHjDSe45puacddfbUCIhaVYPaqNtIE7QI6mRciF9pn7bLPymPHMsGbN2DTMG0J5rce7MHqD1CHLktaNqoQlXLacOshU3AD/36xB3eC6H6A3NJAXO9bHnJaAqEvubOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmCsKzBP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmCsKzBP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2055f630934so32996495ad.1
        for <git@vger.kernel.org>; Sun, 22 Sep 2024 19:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727059485; x=1727664285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cSV0wDNrklGjNyWXj8h9fzvziicgwpbP66LrFjfE8D0=;
        b=hmCsKzBPaafItCtyoHMlor2RPq2WmwnJutV5FsbMlOy9TaPaH4Z/zkslEwhSPJQhhV
         NHsUV/oKWEQh+p4kOyQaHbvV5kr7KZ+hUCqHdXcrbW0FUqelqZyZTHlUt4eAXCRfIwtM
         noOkyg5iKPmw2R0jumd8E+Fx/EMjW6ImbsPQGgohMeIO7gTx3sF+DP5gfGLy3Y59rwyM
         h6sLp3uSHZwBQ5KSTl86D6u/xvAIkwCJUQpnoPy6y5iP/w3LaDnLVE8iirzsO9w25zGF
         v3m9C3jK/DQV2NdmgkRb7cPkW2uLvSUK2w+0SXFOL0V5bVG1d/4n/DQiDnGgbt0+mHCb
         or+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727059485; x=1727664285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cSV0wDNrklGjNyWXj8h9fzvziicgwpbP66LrFjfE8D0=;
        b=BKJC+sd5UVt2xUb/FBhETJvQTh8DO2+iYO7AXnQIDS9PrmSLMl/wgfuOj6/A28KqKB
         BOFcCLwpdssxz9KWPgYjFRX5wB0SDgJ37M6lpwLEYsJaF4FzoU2WK8oca+giiRcvjona
         TUbWvzgYnKJ6tQSxVwp02glZtEZmO5CGVQxj/Ec58yIlBaG2NE8zoHK8XLBarDeSdv6t
         8KB+33hgCfyl4YrvA6hu4l/LE79SIbQmiT0UZimFyMpkAJ7f/VsKBWHOO7kKezr4iqdp
         vRzb3pTnBv0ypeEZQkZM3sHWFtPmWJ1/F9L78u+lCX+pjfzjXvTbKy559mW5jHPOz1pV
         0bew==
X-Gm-Message-State: AOJu0Yw0j9l+d0ORfVp3zMZupZN2XoHBbL3b/VmqOHwh66z9F+O/I36G
	ZCrbI+CiOmlEbXuWwijm+/h338ZE6V17y65U6Vb2VUJ6n26xBT4j1kdQRg==
X-Google-Smtp-Source: AGHT+IGFTCDOdW0E57fxWXgOVwLevRN6k6pQDf2FsnxxFEeJ5bHSbsjogVsxz5YiLpzdbbcpThfByA==
X-Received: by 2002:a17:902:da89:b0:206:994b:6d53 with SMTP id d9443c01a7336-208d83abb55mr182571455ad.30.1727059485229;
        Sun, 22 Sep 2024 19:44:45 -0700 (PDT)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20794600fddsm124790855ad.82.2024.09.22.19.44.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Sep 2024 19:44:44 -0700 (PDT)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
	Git l10n discussion group <git-l10n@googlegroups.com>,
	Alexander Shopov <ash@kambanaria.org>,
	Jordi Mas <jmas@softcatala.org>,
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
Subject: [L10N] Kickoff for Git 2.47.0
Date: Mon, 23 Sep 2024 10:44:42 +0800
Message-Id: <20240923024442.13621-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Before the upcoming release of v2.47.0-rc0 later this week, let's start
a new round of l10n for Git 2.47.0.  This time there are 48 updated
messages need to be translated since the last release. Please send your
pull request to the l10n coordinator's repository below before this
update window closes on Sun, 06 Oct 2024.

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


** Please note: The update window will close on Sun, 06 Oct 2024. **


--
Jiang Xin
