Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6C72417F9
	for <git@vger.kernel.org>; Tue, 10 Jun 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568909; cv=none; b=lf4HJj/mdwn9pdaozcCjQEgslQQmVyfGo/rRvcTp8yE0aiTxBvYV04pHVraNyGG9WNaMeUC2tnGLvBK6HZWF4ByhCXeFFfGEcjlJAPSaetRRC6hhCxawav3ZM66q+icAvFiAQIJcSFINfbGj3PTvVqDQw5c98dztvT2jdL8UrSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568909; c=relaxed/simple;
	bh=G6WJro9U/oBoNX4kKG+AaWXzVrcpKbTNdhfhqDY/Y10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iU4e64zjqxg8fT8CzRte3KyyKAPaPWAkx18QI7+5bLM64lSS8DUqlQYD3b3VSkZD88aGWSRvRMC24zzr2rAd8JoYLYZ+qZ0kkWOEqL5OHjP3NSpw8c/s+Mx7kUMcVSCosdHhs6srNyJp6RUua+8yCfSNwfT4ZzyO4slO/BjUxOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lZ1wNiJt; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lZ1wNiJt"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4a4323fe8caso39561901cf.2
        for <git@vger.kernel.org>; Tue, 10 Jun 2025 08:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749568906; x=1750173706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iRM2rybnE/TPYhjTzfC8CrkZJayfrLk+j9XZgg+ciSo=;
        b=lZ1wNiJtASF9Ze5s3jYETSy+YjQmh0tve9AbPxwaQ90ydDme3/VPsx757/XS5JUyUx
         sIRopum7oEPgT5P035V0X4+CEczqPyZaCDUYfYqK8yaVBrCDKgwfIk1hmBAB0v5cFqkE
         yGP3Q/MQkqa0cWx3WxHaLhoFgwbq/JkBnfNJSif1EoWweRHh3uPVCgx0n5vbSGZQXchn
         mQIRpSCMZCjNymcRLWhPAp8reZaJuu+u0Y4WEOlfQ9slRm/NmPAhIx5LUi8bXZQTsJWw
         5dFAlmAa9KJBFFj6Z0chQ652WYdA0D8CwMYvWeWaPl10Vy/jLX/dIIxrTOLYmXR4IZdn
         XIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749568906; x=1750173706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iRM2rybnE/TPYhjTzfC8CrkZJayfrLk+j9XZgg+ciSo=;
        b=uAfq5Yt3YRAkPaSTLsBfswV4veQ2xIG8NAmuKbDQGAbNWHy2Mebt+42LeTExlQoi74
         xtrtZ2cR2Z17F3QCu7A7Ph5VcOBaURzLEyCyyrUwFm7Pu/GCBFN/uDdo/z2ved6bGUL5
         uHnIE5DFBgpAdlgJdFR/+JAHflSaRg8euumPtcfoo7cDc5p+U+gDgDvvUeD+gkHhoeAU
         3yQ6ReesMh6DKGeumK13HqyytoEyJqbBc3bHc4vvd6y27O+OlC6KFP88u72hkIyzJqNX
         ZC8IiS6zZIIFDLgVMIH43f2fzm0Cb3vfFgElywKr/PBqbrW/amJQsKI2pGfT7TehNVGO
         qVLg==
X-Gm-Message-State: AOJu0YwsHN6gvfjXn6DEWM2z5wGaxs7zRycW5l+D7PqQkxRs2r+6xT0P
	gmzTWiqghi8YOCZ4mL+J8wIWClg31cf3O4FTbtx7YlfpyyxBBpooAVcHNChEeQ==
X-Gm-Gg: ASbGncueEdkEgWXT4WqtdduGgdGX+fdx6NBQRKqwlBs9eC5UsWTVi78vvi59vM0gSxS
	YnpxL5Chd0835cZDRorI5ItVlV5YetyUf+6JKHFEE9c9ijdiPCWdruMUjBZR/TXkRwttecJ8iWq
	KFQCJcgy+MRZFBSoi4MXDYq3TASH/1cfe4VtI3bA/6qzSSy/jktK6BJRGXJEJkutduP/MWnDumZ
	qOVKe4ufFOzi6IN4BL1xsGn1akM32zupPr1NPuiGLXIXNJzCbM1+rcQNwAKS9GS4nK4Ro66fc8p
	anSp7mxTcXM+0WKvtsNKhZox9TlmJwC+zgHQrMOxGTlQjsbb/gvpVGK5D97R+kfi9tZ+o8WrLl4
	f2A5RG0C+8e8Sm0ZsBCS02FPKeA==
X-Google-Smtp-Source: AGHT+IG73zCdiC9iwmxmx3JGs+/m+A9tdXoHTLMTexwoED3pYSMl7tpFuR9cO1f0pLquhdXXB5UikQ==
X-Received: by 2002:a05:622a:2285:b0:4a4:3913:c1a5 with SMTP id d75a77b69052e-4a5b9a2c032mr319594941cf.16.1749568905797;
        Tue, 10 Jun 2025 08:21:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:93bc:ecb0:85aa:3d44:2d04])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87eeae4c86bsm1379180241.3.2025.06.10.08.21.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Jun 2025 08:21:45 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving repository info
Date: Tue, 10 Jun 2025 12:21:12 -0300
Message-Id: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi!

This is the first RFC for my GSoC project: the new command `repo-info`.

## Motivation

Currently, `git rev-parse` covers a wide range of functionality not directly
related to parsing revisions, as its name says. Over time, many features like
parsing datestrings, options, paths, and others were added to it because
there wasn't a more appropriated command to place them.

This way, many of these features would be better placed in new and dedicated
commands. This kind of movement had other precedents in Git, for example, `git
switch` and `git restore` were created after `git checkout` became too
overloaded.

## Proposal

This patchset introduces a new command `git repo-info`. Its goal is to bring the
functionality of retrieving repository-related information currently returned by
`rev-parse`, displaying them in machine-readable formats (like JSON or plaintext).

Under `rev-parse`, these information is retrieved by using these flags
(described in the section "Options for Files" of `rev-parse`'s documentation):

- `--show-object-format`: the hashing algorithm (i.e. `sha1` or `sha256`)

- `--git-dir`: The Git directory of the repository

- `--git-common-dir`: The common Git directory

- `--show-toplevel`: the top level directory of the repository

- `--show-ref-format`: the reference database format (`files` or `reftable`),

- `--show-superproject-working-tree`: the absolute path of the superproject

- `--is-bare-repository`: whether this is a bare repository

- `--is-shallow-repository` whether this is a shallow repository

## Command design

The retrieved data will be presented as in a JSON format, like this:

~~~
$ git repo-info
{
  "objects": {
    "format": "sha1"
  },
  "references": {
    "format": "files"
  },
  "path": {
    "git-dir": "/git/dir"
    "git-commom-dir": "/git/common-dir",
    "toplevel": "/git/toplevel",
    "superproject-working-tree": "/super/working/tree",
  }
  "layout": {
    "bare": false,
    "shallow": false
  }
}
~~~

Or in a plaintext format, like this:

~~~
$ git repo-info --format=plaintext
sha1
files
/git/dir
/git/common-dir
/git/toplevel
/super/working/tree
false
false
~~~

It will also allow the user to get only the desired fields, like this:

~~~
$ git repo-info --format=plaintext objects.format references.format
sha1
files
~~~

or:

~~~
$ git repo-info objects.format references.format
{
  "objects": {
    "format": "sha1"
  },
  "references": {
    "format": "files"
  }
}
~~~

Currently this RFC only implements "objects.format", "layout.bare" and
"layout.shallow", but I'm making it flexible to add other fields, following
this format.

## Feedback

I would like to ask for your feedback on this proprosal, specially:

- on deciding if the JSON and linewise plaintext formats are the really the best,
  or if I should consider others (e.g. gitconfig syntax, NUL-terminated, etc)

- on deciding how the fields will be specified. This "<category>.<format>" was
  a first idea based on the JSON structure

- about the JSON schema

- about information that may be nice to include in the output of this command,
  even if they are not currently retrieved by `rev-parse`

Thanks!

Lucas Seiki Oshiro (5):
  repo-info: declare the repo-info command
  repo-info: add the --format flag
  repo-info: add the field references.format
  repo-info: add field layout.bare
  repo-info: add field layout.shallow

 .gitignore           |   1 +
 Makefile             |   1 +
 builtin.h            |   1 +
 builtin/repo-info.c  | 233 +++++++++++++++++++++++++++++++++++++++++++
 git.c                |   1 +
 meson.build          |   1 +
 t/meson.build        |   1 +
 t/t1518-repo-info.sh | 123 +++++++++++++++++++++++
 8 files changed, 362 insertions(+)
 create mode 100644 builtin/repo-info.c
 create mode 100755 t/t1518-repo-info.sh

-- 
2.39.5 (Apple Git-154)

