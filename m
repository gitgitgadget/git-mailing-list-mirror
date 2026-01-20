Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5213D3D04
	for <git@vger.kernel.org>; Tue, 20 Jan 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768917987; cv=none; b=mny8FaIjaoW5eHdW7PFrAIRTzktV5TQaU9h0b43aD6P8xL/4uxVGAmt70YiZ5hGsOr7MDZU5p6dHfRsLe6izHziJ+VTuQ7kyLl8BSwPldVcKLtQiLCihk/K7dD2LZW8Ochm07QvzXwZQw1ZC7MK8CPipW8eaD/lh/Z+FHGzlDWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768917987; c=relaxed/simple;
	bh=ANoFpwipQXzQwtrPmJkKJ4I1O2DZtnaTkEn8lz7AuVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTre9xE0bzXn2D3iBgIHtuySpHTFzHuRLb1syvc7pYEpfHnGAAeQcG7PiWeRR1dZ5ta+mieB5t1vvtziH3NMVX/edxcEAp6KH1pSbpCXuO+vgOfY0LrCbpFtflcXMf6dCl6XES8iW0qcAWaIzytcPMRImUn5oOuL0qz+VJ7iVQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXBWdvT8; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXBWdvT8"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-78c6a53187dso52172407b3.2
        for <git@vger.kernel.org>; Tue, 20 Jan 2026 06:06:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768917984; x=1769522784; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V5VRbhyH6mEIFrO7LF1dAL1mVGohl31pT3kili0B5So=;
        b=aXBWdvT8hOppC60V/0necG03aHsv4j6LHBpMbhIkWt22Zx/Qa3CJfxt93bpQ1BEYXt
         FEqxopnOnaqZAyL6/wdVhHdkBcpb6CQKzfQuH2UKzhUqzuPhcDpOmCn35Qe5pHBoe1ZR
         JlVsf6hfj0xXPQ4yHFBQEixHoLaKogjk2b8bH0oIcAtZs51hfbE3MPlNyOzWun1SbKRt
         7RpxXLb65lWpTHyYl96APHju0ais3TlPbRFRKWroC+NTTySIBlqxjjsbSv+PqcSoNTfx
         f92Up42husWu0BFgrQECsedHbQ6zZz20RFFWrDO5ec2TV14O5SCjDlH/5GClxAVYLcKn
         DzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768917984; x=1769522784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V5VRbhyH6mEIFrO7LF1dAL1mVGohl31pT3kili0B5So=;
        b=h7K7bN/IdpA2mqNBgkqnitukvuZkTBA6pKwbtMWEOv1CGHdF9J9OItgVI+FF0b2RFw
         ehnimKM4OFcxz/qsEFNGLEjdrlGLJXzs5P3vdOs2+nJLHqy1IOYNRaX2gGwDWdBH3XMK
         f/IxLfCHtGISNn58hgJ3poYb8Ru6hdPz9VH4pSahNb1iSnqau1nLjz4hhx3InK/12V2/
         3O6va72kPihbt+PIisRP5eLbvvKQLMXESkd3sB6KBk+vEABbFTktUlUCg3pJ15DiPkpw
         395CYr0f4/U3yE+2CuSBJUonNqTvLu15TeRU0JjDVvjp1NBFPHTHO/pbiNMPPxGtpM2j
         Tg7A==
X-Gm-Message-State: AOJu0YxH5FJiIu2LPFBjrh15LTnpNnLI2R7k7opMTixen46437fRykaN
	QYyiWmueFtayput+kPpGlWqAeRAmtFY6ig9XUSE61BsgZGdz/cpBbZWasEQv+A==
X-Gm-Gg: AZuq6aIxUX0E0c86VaFmeLkp80elhvbdci7TLd1jzDeEYGDyDvvrUrMOPTqxBvWde2l
	qmweLgR+2JmYRyTFhuuPfDhcy0ufKuGlPj46r6/fbAo/PUnHvtArJxxARqN1/NqSG9UdVMakubm
	+9/TjeEu2TcccTQnARuCYn44zw11OEvpBLxhEaRf/K9YIvZO6jzwiFXIwXb6Bzyg0rC/wnoMI6x
	QLVYjybbAJaFvTWjIVHeahpovqWPM/sQWwGvtsCGJp/e5J758Ig3ZEnbnR/tSY7kaWwmNREyMjw
	GdEI+Nta/oit0XGYEfsIQ6TRhpW7Smjj3jiQXiLMLfTo2wzYw508K5547piPQPgHM7K8AbC4Xtf
	CJcvdrpN1DrU/Z0eLakoGfIWxi6hsYOw1oKlzbROnn3g1uObYlFN6U094yHHn/ABIsXYluaYM0n
	pwE7POcrkdiV7Q7RmFcO/ICF7RSV8Ls5Qcr87yIt3jaNXFoqyxhElu0fL2EPVKlBMCJSxt1VYWm
	8va
X-Received: by 2002:a05:690c:c09:b0:789:62c5:db2f with SMTP id 00721157ae682-793c686d999mr110056177b3.62.1768917984219;
        Tue, 20 Jan 2026 06:06:24 -0800 (PST)
Received: from localhost.localdomain ([2605:a601:90a8:8b00::a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c682e0e6sm52320177b3.35.2026.01.20.06.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 06:06:23 -0800 (PST)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Sergey Organov <sorganov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] replay: drop rev-list formatting options from manual
Date: Tue, 20 Jan 2026 09:05:57 -0500
Message-ID: <97ae3ba465511d1ff73b11efb55d393ac5a4d9d0.1768917929.git.ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.52.0.rc0.569.g0e1cb519e9.dirty
In-Reply-To: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
References: <01a7acfaf87494419b3766da57d4c05cf99c79bb.1768873599.git.ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The rev-list options in our manuals are quite long; git-replay's manual
is no exception. Since replay doesn't use the formatting options at all
(it has its own output format), drop them.

This is the first time we have needed compound tests [1] for if[n]def in
our documentation:

    git grep '^ifn\?def::' Documentation | grep '[,+]'

[1]: https://docs.asciidoctor.org/asciidoc/latest/directives/ifdef-ifndef/

For both ifdef and ifndef, the "," takes on the intuitive meaning:
- ifdef: if any of the listed attributes are set…
- ifndef: unless any of the listed attributes are set

(Use "+" for "all".)

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 Documentation/git-replay.adoc       | 1 +
 Documentation/rev-list-options.adoc | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
index 4c61f3aa1f..c3b214ec69 100644
--- a/Documentation/git-replay.adoc
+++ b/Documentation/git-replay.adoc
@@ -64,6 +64,7 @@ The default mode can be configured via the `replay.refAction` configuration vari
 	range should have a single tip, so that it's clear to which tip the
 	advanced <branch> should point.
 
+:git-replay: 1
 include::rev-list-options.adoc[]
 
 [[output]]
diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 453ec59057..c4d7a6b989 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -1096,7 +1096,7 @@ endif::git-rev-list[]
 	Overrides a previous `--no-walk`.
 endif::git-shortlog[]
 
-ifndef::git-shortlog[]
+ifndef::git-shortlog,git-replay[]
 Commit Formatting
 ~~~~~~~~~~~~~~~~~
 
@@ -1265,4 +1265,4 @@ ifdef::git-rev-list[]
 	counts and print the count for equivalent commits separated
 	by a tab.
 endif::git-rev-list[]
-endif::git-shortlog[]
+endif::git-shortlog,git-replay[]

Diff-intervalle contre v1 :
1:  01a7acfaf8 ! 1:  97ae3ba465 replay: drop rev-list formatting options from manual
    @@ Commit message
         is no exception. Since replay doesn't use the formatting options at all
         (it has its own output format), drop them.
     
    +    This is the first time we have needed compound tests [1] for if[n]def in
    +    our documentation:
     
    - ## Notes (benknoble/commits) ##
    -    I noticed this while reading. It took me a minute to find the
    -    Asciidoc reference on multiple attributes [1] since it's not used
    -    elsewhere in the rev-list include :) I'm not sure it needs to be
    -    included in the commit message, though normally I would, personally.
    +        git grep '^ifn\?def::' Documentation | grep '[,+]'
     
         [1]: https://docs.asciidoctor.org/asciidoc/latest/directives/ifdef-ifndef/
     
    +    For both ifdef and ifndef, the "," takes on the intuitive meaning:
    +    - ifdef: if any of the listed attributes are set…
    +    - ifndef: unless any of the listed attributes are set
    +
    +    (Use "+" for "all".)
    +
      ## Documentation/git-replay.adoc ##
     @@ Documentation/git-replay.adoc: The default mode can be configured via the `replay.refAction` configuration vari
      	range should have a single tip, so that it's clear to which tip the

base-commit: b5c409c40f1595e3e590760c6f14a16b6683e22c
-- 
2.52.0.rc0.569.g0e1cb519e9.dirty

