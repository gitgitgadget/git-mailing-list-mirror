Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0422E7BCB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 08:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760345357; cv=none; b=tmWiuYhJtHHQ1UMYmP0WgGQax81Fuwp6vWGbuRCnzM5xFTZHQd/8QDV7wKOoATWJ3pjSZC3a+CT4U19LK4PM20lsyfK/RxF4Hbp0dfXNe9ZJf1ooRNEwkspud/SONtuBXnOQ+XoxNUi+JMD80FkClA9M6A0vaqgA0R/PUrtpp+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760345357; c=relaxed/simple;
	bh=ercXuJ6V00OoNG8gYHijAtuGdGJNWYT3pAeJMK2riCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WSfU2+w6cCPMJLDkvZCTGsg2vCXUPbGpRxmSa3vYqts+Sa3lJCabTce8WiGQZPSiElKnYqfXm+WKyuB1wnz5Opf8bsO0RTbw69utxOqgGoq998YbTyfcjl4HTw8LVoti3YckXLgvAxKG/uSnc5S2ynlAbzAKWpUWHqg7UXkHqHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9Rrh8EH; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Rrh8EH"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-46e6ba26c50so22863725e9.2
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 01:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760345352; x=1760950152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mUCnsncALG2uFrfsmMSUd+az65HUoNgQEp4nBE2X2Q=;
        b=b9Rrh8EH14KL8LjSnRN3oCkfyGmXz3WbJK6q6/dRijQiuy3wDNfEjQi8MlaqP9oy8o
         /2oBAVOz3XxBRT2lGR6xNnZkFMMnKP2pJJLL0K4QIgCH+PLAikyAZWzvoiwSGqdwgkHz
         CH5tUnhK8XxT8NUI9O/8q3C4LLUVhJCiiCEFWkKSiSglYF5lSKOXOFIMyem3VxGGRgfC
         lF5NP8RTRqVkb2D71Qs0zvHesO9aa4AVOJPGrDRTcFM5KrLnESDWY9NwKWaka/zbnmaj
         SUe/o62TAZ2PnhkkTQQkAeJsnb880WXYw20oFC0k4InkIvuqExbaSDkra0hmwPb18cK9
         Dyog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760345352; x=1760950152;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mUCnsncALG2uFrfsmMSUd+az65HUoNgQEp4nBE2X2Q=;
        b=YxfsnpPd6ZmkC1nMeI/h7jHIjqLd1RAEt27gEmKWkS36af/eAp6N7c/WzdaAlv90Kx
         qjOTX7BA6JIEdFR7N088pcRwKozCayLRxSiAHMoMmQ0fk0fBSZ+DZz2098JHEPbmybic
         1Kw5ko4eV34D7yULSc7eGInN9AoTwOAp4kl77QJjqpOYMkDRLEjmar+mCvX066CvQI7o
         r48wf23eVe0y5lKZwW/8i6M1oN98d8zJP17Ggy5W+/3OCNont+P9xFol/SyFI2eZWlVf
         30V+PPflpo2rIfKuSNfMq7NSGAr2S19fSc7RLB8l54nEXVg4Lg3glc/nlHYhB0KnUKuI
         HJ+A==
X-Gm-Message-State: AOJu0YxtuaCmEHChgKHefNo6udWKa3RaInkiNXnjRe8Q5d8E+00LG0sx
	PuUKU0kKoeaGn25iYS5//wo2abeQCmAgj1aJrC8ptL0h0lSLpfJISY02vUn0Qh/Z
X-Gm-Gg: ASbGncvEtZSruehzQTfVHBxix8Y+fESvFc7QvqqV4MKnwka2j7BD6Ml6K+tKfWCQD2s
	7vYfm+rvpdshWJQ7W+UKmb4HrZLNxe8Vkkt2fcuQJBZ39lm+2PPFRHn9KQ7A+WT3mCDwe0lezJ4
	uLwvYex0pKx40Hs8GgExJl5DmeG1arwtX4rzUpIKIcN+HogGa1W6URQTD8exmT8UZrnmNujTPYM
	lkCpmR59R/jaE7VQysCyFCD+0X210DLU4R1b8EV/L9WSBhbTtHKnsYT1vaoHu9s5cpB+B780gcn
	fY/B3lGk/Q6JWJGnQjWZQFz802GIo/WuBXLZlrCwRbx5L4MXHo6joyiP6a8lveqe4nYFXyrEsEL
	7wGCBfyw12a3jF69HA4fPCwhPCrZlBVbZjySJiBlQT+CE0ZwF/HJL4dVF1bzzNvcQSjtPdKqsSn
	P0L+o=
X-Google-Smtp-Source: AGHT+IEpfNCkzYBjLg5rBlXLQ3o+TBlRAeoPmODkfYm7m1TJ/NAeDo2TGna9HM37s2bje5B2KCabTA==
X-Received: by 2002:a05:600c:3b1f:b0:46e:42cb:d93f with SMTP id 5b1f17b1804b1-46fa9a98ef7mr144063375e9.15.1760345352025;
        Mon, 13 Oct 2025 01:49:12 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426d0d9050bsm15630220f8f.13.2025.10.13.01.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 01:49:11 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Todd Zullinger <tmz@pobox.com>,
	Collin Funk <collin.funk1@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 1/5] doc: git-tag: stop focusing on GPG signed tags
Date: Mon, 13 Oct 2025 10:48:53 +0200
Message-ID: <20251013084857.1646783-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.0.438.g6987fc0bae
In-Reply-To: <20251013084857.1646783-1-christian.couder@gmail.com>
References: <20251007122958.1089680-1-christian.couder@gmail.com>
 <20251013084857.1646783-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like the documentation of `git tag` is focused a bit too
much on GPG signed tags.

This starts with the "NAME" section where the command is described
with:

"Create, list, delete or verify a tag object signed with GPG"

while for example `git branch` is described with simply:

"List, create, or delete branches"

This could give the false impression that `git tag` only works with
tag objects, not with lightweight tags, and that tag objects are
always GPG signed.

In the "DESCRIPTION" section, it looks like only "GnuPG signed tag
objects" can be created by the `-s` and `-u <key-id>` options, and it
seems `gpg.program` can only specify a "custom GnuPG binary".

This goes on in the "OPTIONS" section too, especially about the `-s`
and `-u <key-id>` options.

The "CONFIGURATION" section also doesn't talk about how to configure
the command to work with X.509 and SSH signatures.

Let's rework all that to make sure users have a more accurate and
balanced view of what the command can do.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/git-tag.adoc | 48 ++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-tag.adoc b/Documentation/git-tag.adoc
index a4b1c0ec05..28d6fe4e1a 100644
--- a/Documentation/git-tag.adoc
+++ b/Documentation/git-tag.adoc
@@ -3,7 +3,7 @@ git-tag(1)
 
 NAME
 ----
-git-tag - Create, list, delete or verify a tag object signed with GPG
+git-tag - Create, list, delete or verify tags
 
 
 SYNOPSIS
@@ -38,15 +38,17 @@ and `-a`, `-s`, and `-u <key-id>` are absent, `-a` is implied.
 Otherwise, a tag reference that points directly at the given object
 (i.e., a lightweight tag) is created.
 
-A GnuPG signed tag object will be created when `-s` or `-u
-<key-id>` is used.  When `-u <key-id>` is not used, the
-committer identity for the current user is used to find the
-GnuPG key for signing. 	The configuration variable `gpg.program`
-is used to specify custom GnuPG binary.
+A cryptographically signed tag object will be created when `-s` or
+`-u <key-id>` is used. The signing backend (GPG, X.509, SSH, etc.) is
+controlled by the `gpg.format` configuration variable, defaulting to
+OpenPGP. When `-u <key-id>` is not used, the committer identity for
+the current user is used to find the key for signing. The
+configuration variable `gpg.program` is used to specify a custom
+signing binary.
 
 Tag objects (created with `-a`, `-s`, or `-u`) are called "annotated"
 tags; they contain a creation date, the tagger name and e-mail, a
-tagging message, and an optional GnuPG signature. Whereas a
+tagging message, and an optional cryptographic signature. Whereas a
 "lightweight" tag is simply a name for an object (usually a commit
 object).
 
@@ -64,10 +66,12 @@ OPTIONS
 
 -s::
 --sign::
-	Make a GPG-signed tag, using the default e-mail address's key.
-	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
-	configuration variable if it exists, or disabled otherwise.
-	See linkgit:git-config[1].
+	Make a cryptographically signed tag, using the default signing
+	key. The signing backend used depends on the `gpg.format`
+	configuration variable. The default key is determined by the
+	backend. For GPG, it's based on the committer's email address,
+	while for SSH it may be a specific key file or agent
+	identity. See linkgit:git-config[1].
 
 --no-sign::
 	Override `tag.gpgSign` configuration variable that is
@@ -75,7 +79,10 @@ OPTIONS
 
 -u <key-id>::
 --local-user=<key-id>::
-	Make a GPG-signed tag, using the given key.
+	Make a cryptographically signed tag using the given key. The
+	format of the <key-id> and the backend used depend on the
+	`gpg.format` configuration variable. See
+	linkgit:git-config[1].
 
 -f::
 --force::
@@ -87,7 +94,7 @@ OPTIONS
 
 -v::
 --verify::
-	Verify the GPG signature of the given tag names.
+	Verify the cryptographic signature of the given tags.
 
 -n<num>::
 	<num> specifies how many lines from the annotation, if any,
@@ -236,12 +243,23 @@ it in the repository configuration as follows:
 
 -------------------------------------
 [user]
-    signingKey = <gpg-key-id>
+    signingKey = <key-id>
 -------------------------------------
 
+The signing backend can be chosen via the `gpg.format` configuration
+variable, which defaults to `openpgp`. See linkgit:git-config[1]
+for a list of other supported formats.
+
+The path to the program used for each signing backend can be specified
+with the `gpg.<format>.program` configuration variable. For the
+`openpgp` backend, `gpg.program` can be used as a synonym for
+`gpg.openpgp.program`. See linkgit:git-config[1] for details.
+
 `pager.tag` is only respected when listing tags, i.e., when `-l` is
 used or implied. The default is to use a pager.
-See linkgit:git-config[1].
+
+See linkgit:git-config[1] for more details and other configuration
+variables.
 
 DISCUSSION
 ----------
-- 
2.51.0.438.g6987fc0bae

