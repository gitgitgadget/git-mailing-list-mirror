Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD00C10E9
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 15:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727881429; cv=none; b=a+N6JB9o/avoWKtw1w419UqEF8NTA84NGVdBz/mIjPrXIhxgMBZ63h+Wv+8D3kZ87vJ+cOiKbeidTkvD2YdOSbIExPr8tBE+Z9f4av/KyfctfoQhFG8pk5GE64QkJ8mJnb2wqh6tnRuQtrmBsUBVsrEgy44RZ2LLvsljyZgH8gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727881429; c=relaxed/simple;
	bh=8A5pgZxezoP542TXNFQinq0hHYRJH/MHr0KTO+K/zrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5DReus+K9bAnf/UZpZDuEZqopqcf/kVVe4DZ6NZVaUcOw7bsHoyZze4K9AREzYjaxHeuvQ1Ii0jBe6A0JsQyhEULgEd3ivFLr3bXBgEDmEE1acP/DAa8oRJ6f2fthAfwco1TwzfPgOUSAlSj2dTofszCl3HKQyoNTCGZnwxyIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=SoMdqzLN; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="SoMdqzLN"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e25d380b464so5898122276.2
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 08:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1727881426; x=1728486226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya5vUJN/jxQYgPp6eCYLwiqmuQ9VqEm2p9sjUVttYtE=;
        b=SoMdqzLNPJC6GnpidZWGuhIW+jFY305HyBZMTtNk6fQggVPHr/51ZFC4OO7Q9SA7RP
         NtwdtDnFVYPiTr4/Emasnm5gkzm3O6TlOtshQ1ok98/HIeWUXfe/bV5PVsRevf7Et65Z
         TLHZ/nPWAepW71U/sZPSHFRPUY6j0sSbsvwOR85TPQMDaBQfxuM8nmvNLcL52BUE0Rh7
         tWAUDyELoEmC1D/cfrhWu3/WLxo8j3n50peX9AOEf7//sqKX7zfX3wUalF55W9w0qgrQ
         1NTfpLzc770MP+Mz3Ci5H5MlIJCSVEOIo5peb++xW1Xpnw48/n07Ou5eVBwaM9yVxRjW
         LenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881426; x=1728486226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ya5vUJN/jxQYgPp6eCYLwiqmuQ9VqEm2p9sjUVttYtE=;
        b=Z1YKOQi3waGNgFpy+j/YihmaCY2r5PtYy894MLHAfXEtG39ZmeMXCnSfsdtW0bCk5W
         1EMWqa+wbulOV4n3c8AEEunlZmmgHnivSM9D/PYQpDsbQiv++uMAauSZnG0AyYfs3HWk
         ewZG1UcJk3XNUXweko3x0MuMw8Mm9mVdoruLdmEFaWINEceCePM37Omhp0mQ0hf4wg6g
         Kr0B51jeDGBvhFaqvoiU8XAAJ296/PPm/6+c1l2YwNSD/RxnAI+7tSbz4oXm0+vklgdq
         8gOebWhrBEnxUJTnsPrlNacJtX3rG4FriUgmlcd5dDQrHBXx60jFKTeYMCzRiCpLg4HE
         IChg==
X-Gm-Message-State: AOJu0YweJuweE2jB0rNH0wkCWYhu0nWVrfeCt4qf0SH+zZaab/nUyamr
	ffaxkscnbdClAq8gQW7ssJfcVHBUOyB5gyJF5z57dA+Ji1k1WP34vKmDc7duaQvPv7V52/WDdQI
	VKH8=
X-Google-Smtp-Source: AGHT+IFKMg7udaNUP+/4HHLvEDvCiGe3aVa4qLJY2nftWPcmxgqq6Ix86Z0hOrzk33KRjjpsOYJG2Q==
X-Received: by 2002:a05:6902:f85:b0:e1d:a1f0:6683 with SMTP id 3f1490d57ef6-e26383e5a43mr2492085276.17.1727881426182;
        Wed, 02 Oct 2024 08:03:46 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e25e3ef9b12sm3943672276.12.2024.10.02.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 08:03:45 -0700 (PDT)
Date: Wed, 2 Oct 2024 11:03:44 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Emily Shaffer <nasamuffin@google.com>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Subject: [PATCH v2] Documentation: mention the amlog in howto/maintain-git.txt
Message-ID: <5cc8e2bcb88424d8dce526f518282e4b26a1760a.1727881364.git.me@ttaylorr.com>
References: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4b1da93e16d88323181f8f8444f01d96e09ef45.1727729100.git.me@ttaylorr.com>

Part of the maintainer's job is to keep up-to-date and publish the
'amlog' which stores a mapping between a patch's 'Message-Id' e-mail
header and the commit generated by applying said patch.

But our Documentation/howto/maintain-git.txt does not mention the amlog,
or the scripts which exist to help the maintainer keep the amlog
up-to-date.

(This bit me during the first integration round I did as interim
maintainer[1] involved a lot of manual clean-up. More recently it has
come up as part of a research effort to better understand a patch's
lifecycle on the list[2].)

Address this gap by briefly documenting the existence and purpose of the
'post-applypatch' hook in maintaining the amlog entries.

[1]: https://lore.kernel.org/git/Y19dnb2M+yObnftj@nand.local/
[2]: https://lore.kernel.org/git/CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com/

Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
Similar to v1, but with:

- an added change to "The Policy" section written by Junio

- a tab/space fix in the notes.rewriteRef example

- and a mention of the fact that the notes.rewriteRef configuration is
  not read by 'cherry-pick'.

 Documentation/howto/maintain-git.txt | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/howto/maintain-git.txt b/Documentation/howto/maintain-git.txt
index da31332f11..76d6688d4c 100644
--- a/Documentation/howto/maintain-git.txt
+++ b/Documentation/howto/maintain-git.txt
@@ -122,6 +122,13 @@ Note that before v1.9.0 release, the version numbers used to be
 structured slightly differently.  vX.Y.Z were feature releases while
 vX.Y.Z.W were maintenance releases for vX.Y.Z.

+Because most of the lines of code in Git are written by individual
+contributors, and contributions come in the form of e-mailed patches
+published on the mailing list, the project maintains a mapping from
+individual commits to the Message-Id of the e-mail that resulted in
+the commit, to help tracking the origin of the changes. The notes
+in "refs/notes/amlog" are used for this purpose, and are published
+along with the broken-out branches to the maintainer's repository.

 A Typical Git Day
 -----------------
@@ -165,6 +172,24 @@ by doing the following:
    In practice, almost no patch directly goes to 'master' or
    'maint'.

+   The maintainer is expected to update refs/notes/amlog with a
+   mapping between the applied commit and the 'Message-Id'
+   corresponding to the e-mail which carried the patch.
+
+   This mapping is created with the aid of the "post-applypatch" hook
+   found in the 'todo' branch. That hook should be installed before
+   applying patches. It is also helpful to carry forward any relevant
+   amlog entries when rebasing, so the following config may be useful:
+
+      [notes]
+        rewriteRef = refs/notes/amlog
+
+   (note that this configuration is not read by 'cherry-pick').
+
+   Finally, take care that the amlog entries are pushed out during
+   integration cycles since external tools and contributors (in
+   addition to internal scripts) may rely on them.
+
  - Review the last issue of "What's cooking" message, review the
    topics ready for merging (topic->master and topic->maint).  Use
    "Meta/cook -w" script (where Meta/ contains a checkout of the

Range-diff against v1:
1:  a4b1da93e1 ! 1:  5cc8e2bcb8 Documentation: mention the amlog in howto/maintain-git.txt
    @@ Commit message
         [2]: https://lore.kernel.org/git/CAJoAoZ=4ARuH3aHGe5yC_Xcnou_c396q_ZienYPY7YnEzZcyEg@mail.gmail.com/

         Suggested-by: Junio C Hamano <gitster@pobox.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## Documentation/howto/maintain-git.txt ##
    +@@ Documentation/howto/maintain-git.txt: Note that before v1.9.0 release, the version numbers used to be
    + structured slightly differently.  vX.Y.Z were feature releases while
    + vX.Y.Z.W were maintenance releases for vX.Y.Z.
    +
    ++Because most of the lines of code in Git are written by individual
    ++contributors, and contributions come in the form of e-mailed patches
    ++published on the mailing list, the project maintains a mapping from
    ++individual commits to the Message-Id of the e-mail that resulted in
    ++the commit, to help tracking the origin of the changes. The notes
    ++in "refs/notes/amlog" are used for this purpose, and are published
    ++along with the broken-out branches to the maintainer's repository.
    +
    + A Typical Git Day
    + -----------------
     @@ Documentation/howto/maintain-git.txt: by doing the following:
         In practice, almost no patch directly goes to 'master' or
         'maint'.
    @@ Documentation/howto/maintain-git.txt: by doing the following:
     +   amlog entries when rebasing, so the following config may be useful:
     +
     +      [notes]
    -+	rewriteref = refs/notes/amlog
    ++        rewriteRef = refs/notes/amlog
    ++
    ++   (note that this configuration is not read by 'cherry-pick').
     +
     +   Finally, take care that the amlog entries are pushed out during
     +   integration cycles since external tools and contributors (in

base-commit: 3857aae53f3633b7de63ad640737c657387ae0c6
--
2.47.0.rc0.4.gd73fb26592.dirty
