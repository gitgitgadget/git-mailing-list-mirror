Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C43328630
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 01:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768526008; cv=none; b=K5hB5TXuwHUUB5h0hk58f8xdWvnQjfemWijlxYcl2pMGq+3hvRZd0tDQCsP8qqdxzX68eSbPaYzaR253J2kDABRuyKEQ/KaxKNgGIUzh4YExF7TvYu73gpQjJgxvyYC9mCNFgkmLAvpO/q9SrqKwrOhCVoU3kSd2WS5uxpsVCbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768526008; c=relaxed/simple;
	bh=HqQe5PwY0UwWk85HurfsittGCRTXOWbHXkwWgbPRPHM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jbnQ7+h/QxSZrPYgKfipqrRLZECaNiU2L5HhtkZrjT8OFhUxcHMMxl3X0g8hXPCsuc6wNhTgKzJzWoOIQZz7yHHhisd2k7J/ooQPJbsdEosaIV7LZqdDzOqD20sP46KBgmWefLjd9GZMPEciEt/B3Fo2hrg1ve/lwy6Gjym9P3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VtPrL1kj; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VtPrL1kj"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78fdb90b670so14536217b3.2
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 17:13:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768525990; x=1769130790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/M+5tCmMcJQ74g4OMAej7kcumOhucY3HZRK190OPHKE=;
        b=VtPrL1kje/ISAcYjdwgPWHPBFPVn86DPmV8KI6QrDKm+MTwVxQl3HK7+aMiFI7EN4H
         9nn+u507CQnoV07GW9HOFuZqveYbGG8ii0p1VS3BCp+NpySIX20Hf7A4d14KP0MdY6WU
         T3/ry2XYYQrDJfSML1hiF6nu/M0dlyeRoqrrrT5FHZ07MU7KDg3Lm6tUQYsmao9XfKVs
         uR60czCZhtVZ4yy+SuNLnC5DoaHkDyCn/T/x1zOIP95YibWSo+9rtvnKjkThl63aX22Z
         H/CqB309WkUy3k2/IHi59bQ8ynXos4Qy3pbs/8dfXT55S04+ERzNAKMBCs3vdreN9TEH
         sGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768525990; x=1769130790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/M+5tCmMcJQ74g4OMAej7kcumOhucY3HZRK190OPHKE=;
        b=Pyxol7WQ4pl8nkSsoevwnWHCgK5qNMSiLUrid3PgK2Y4rd4Z4/s9kqd2qJZDaeIu/V
         UYPqDtNe8L0g/Bm85tp4jf9TI+G6zoGO36310I38bm2r2QpATYAdKfXcMjdt/d1DTLLA
         0eeZLNwWnZ3j3b+mIu0xTI21QwzPqTRj/oyJExlCFKgqNb2qFODXxH3BH/k0+R+jQNho
         fTIlgSLCVjsMWTvoSTNSAJa3NLLiiRlatP4jxfj0iWQyGwaEHUiAAre7aMZZuz37E0gE
         MgxQ4HKE5sYDuzOVFPkM146EzeUPDNZqEKyDfear7q72feUdvlqj5/yNm4G0AsmcOsW+
         1R6w==
X-Gm-Message-State: AOJu0YzCsdVUaz6VC8YTRfasTzm0brmJmCer34Obo84TMvLHFlABMZsY
	ySq+3a3b438dmwD+3p4DMcVXovx/KrqwdYCsSm/0PXdcBX0a52pP+AXQhKy72hOh
X-Gm-Gg: AY/fxX74UvyGlkBmjCWW2QYRFhXObc9p/EV2rWL6nVBS4o+cANbFqZVoCJ96pKBaFaV
	uhQryN6qU5bpTVVd+OoC87HbZOegL3UivMca52/evXXskmUVKLaPiRU+408MUMYW1Ly5TBdEV7W
	ruroNivJW47Y+QMLIPD1Kk2nRdImypHTH68Znl4VvNh6FzzT9BGFrRmG2UqS04vdx/7sWnjPodJ
	M1e5PM5ysHnA19GvNpZTNZDFpHfMMxfCEvOFWXseyU2lJ7Zf6IkMGud2YfJVSzqy2lz2saKcPN5
	4eOa9o2uTTeZeuWj77g5NPjrKnPI/xqCPj3piD9m5fnvs8Bz8VvaTBLhYSfXXs2csLCGaIB8ixH
	PJY1jVuKB2CpclEhlRJKvjtIYiy29FRbx7Uvs0+JJhqTcHl2Hf5tkAhC2o1Vk8LSp05g3+B0Ekd
	ZC5vMolNCzD1/SLGAAOvCwvdiEV/HFDuDiJVrWZ1Q+jNbKVmH5+kpmNy4u1bQXn8SEY8/AUUJi0
	NDjD4QmurbNwUep8bRl8/wyFyGWn1pfSOlJIVjdezlLojPiLZlTXI4BvXquI/YvI6uJOgEmSQ41
	ukjwETI7cw==
X-Received: by 2002:a05:690c:6c83:b0:78c:1038:b710 with SMTP id 00721157ae682-793c526f785mr15710647b3.24.1768525990590;
        Thu, 15 Jan 2026 17:13:10 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66c6e52sm3838837b3.5.2026.01.15.17.13.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 17:13:09 -0800 (PST)
From: Jiang Xin <worldhello.net@gmail.com>
To: Git List <git@vger.kernel.org>,
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
	Yi-Jyun Pan <pan93412@gmail.com>,
	Git l10n discussion group <git-l10n@googlegroups.com>
Cc: Jiang Xin <worldhello.net@gmail.com>
Subject: [L10N] Kickoff for Git 2.53.0
Date: Fri, 16 Jan 2026 09:13:03 +0800
Message-ID: <20260116011305.1093750-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.51.0.rc2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git v2.53.0-rc0 has been released, and it's time to start a new round of
Git localization.  This time there are 44 updated messages that need to
be translated since the last release. Please send your pull request
to the l10n coordinator's repository below before this update window
closes on Sat, 31 Jan 2026.

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


** Please note: The update window will close on Sat, 31 Jan 2026. **


--
Jiang Xin
