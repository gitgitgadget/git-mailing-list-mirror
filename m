Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EB6184540
	for <git@vger.kernel.org>; Thu, 27 Feb 2025 01:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621491; cv=none; b=rJXVgYD9131+ZKJspSJ3O8wJQh2/tnZ67j+CfmNKa9U8d9prJD/jqVk+0io15+dx5Agn4T+gzScMLonOrr/VvIcnOA0Q3gBA+pOK2OOptwZCf4OYulmcduJFz+3T2CG3GXwsOC6JWwqzkrQRycIKXNLsJJw4gSMZoxISoGvuBJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621491; c=relaxed/simple;
	bh=zcdvLcdb+zT3vH3uphQYee6QTi3kCRf9iq0mrbpOfL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pZFLesGLntD4d/2Wj48v9L+t0M4N4La4e9Kc5VdbnUhj64Lw9lsobE61qEalGtLgKBfjqzh63x457Evs0HhGAFPH4kzQyqftJ1ijoIaMWZ5OcT5/vga4H+FdR1J8DOjeYS5HhKtNkivdXKBrs3yfaswsCdp7Q1DlShcFv+ppTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVwyX+Md; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVwyX+Md"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6fd2fca1cebso3402497b3.0
        for <git@vger.kernel.org>; Wed, 26 Feb 2025 17:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740621488; x=1741226288; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j+EKPLXfdeVQcctEZ0RZTV6jrvv1Hw0hXlS3njHW68k=;
        b=BVwyX+MdrvINFUmVMOSVVRHsvxMBkrpRoPfBtf1FctuJWeIbTsfV9h/aAW+RDvEXFm
         lmAPHOdLfBI85ZspvGyyQoKBFbS/QT8/OP7jyEkEpBumZghVZ15yIMJuvGegZfUjNNdy
         kNTi7k3P/jhd6siy3dy4eCysUYxPRz0OZyPlZp4R4edYRFUSlukb1IAyxVbbkWmnghXm
         m2yVw7jhcPZURz4+69iJaGt7urfc1a5NpJhrTwadE4FCUBfLXavVacwKThNZzSn3t17D
         JCpGSsjn9e1eyeSAPANps3ZbxgkhAvO9pIchLM9JuHGYVn9MgQpypHycnFATNWQ2dv/D
         tqww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740621488; x=1741226288;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j+EKPLXfdeVQcctEZ0RZTV6jrvv1Hw0hXlS3njHW68k=;
        b=bvAWQNYTp5XR6nMrXH1cEZU9EMSOMdKTiqs85xMEoJlohcyimM7BGfsC3qS/ptG1wV
         5SowWRB18OfEIaK66kei+6NTt18pR7O6TR34HnH2L+8k8g9H1suUVXWR0CVkkE3Ym54m
         m7MssrXq0kTE/CBenVBOGoiIpVpMhMcXVoIEkFZi08HHSyyfJITRnOA5UF1mO49+KoTR
         srBZ5dAovjArEJss7aSJ5vJNQi+gC7inrMGTs48jyy/G/aPfRsr+C24jy/EaJtouj0Yx
         D/WpeD5Qxpg5IwENe8GCwoeJv1cOabOVGE9/1fXlgDhdbLRLRD6uWOGpWlJzPqD9I11X
         Gwxg==
X-Gm-Message-State: AOJu0YzMBo9l06Akf80bd1AUW7HiQYghTT1oAL95Y1hbn8RYoMaaQttm
	2xYZ2qjretadmFR9SEB8tEO4XLvlFVoprVtufpCB57DQfC70U1L5QbNvHw==
X-Gm-Gg: ASbGnctznUp1YcVxS0W5byLv3p11I+GhjI1JNdwsAffxUpHAgXnZ3GkeFDp+9bereJN
	8Wld8qKMuV880NMfl2TYumGUQ/aazUapsE2b8jZa3PXz3XwXsAoPrW9bE5q8vqCBUTweeGI3IhM
	FzkXFaTh2upaFvnIE5S7p8nmXawFfWJovrsBQJWrQp8PAYo5aVrksAa7jtyY6Cu0mMfrh4IfSqG
	JzSOSqklnEIBlX15nYFVsakgcu4hJHVQFNCRYqLtR9EkXHzVakq+6albU6TXYe6mhcICne+vaRB
	J6CcFPMF2kbBvIFBN4RE6p9p88ZvssuFuxdU2RgMOcSfHEJY85ykc6ua7USdVgUrWdFX6o6Gh/x
	D6O+ENEXMdJ7X
X-Google-Smtp-Source: AGHT+IHV21OlKLaG5iys5JFnjbCTkIQpt6ujDcWElazI/xXbCKWN+QFA3mluoZCQZajAMjIIoayzyQ==
X-Received: by 2002:a05:690c:3585:b0:6fb:9389:3cde with SMTP id 00721157ae682-6fd109aad0cmr87278537b3.3.1740621488302;
        Wed, 26 Feb 2025 17:58:08 -0800 (PST)
Received: from jiangxin-bandwagon-2.localdomain (172.96.255.155.16clouds.com. [172.96.255.155])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6fd3ca0e6e3sm794107b3.16.2025.02.26.17.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 17:58:08 -0800 (PST)
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
Subject: [L10N] Kickoff for Git 2.49.0
Date: Wed, 26 Feb 2025 20:57:59 -0500
Message-ID: <20250227015804.100880-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <y>
References: <y>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Git 2.49.0-rc0 has been released, and it's time to start a new round of
git l10n.  This time there are 35 updated messages need to be translated
since the last release. Please send your pull request to the l10n
coordinator's repository below before this update window closes on
Thu, 13 Mar 2025.

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


** Please note: The update window will close on Thu, 13 Mar 2025. **


--
Jiang Xin
