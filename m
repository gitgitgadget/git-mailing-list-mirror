Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926493;
	b=Zf1QSCp526vYdsPoGM2p1YiPMylTr/Hw+l2z2MWq+Xd+DH7k1E2OnyffZZtuBmIJrShw
	 UQ0HeXKnMOYPeaNs/M3YHCbh+QbxeOx0oW7V+nISMrYF80LrJrafg2OEQgjp6oFvkA4fp
	 +gPBh81oQrLB+Bwb478xzqwCuaIoC/xZpOZZ58D9iMEkKv5HvhfXYV8kNBAXWfPxWsSwy
	 jgNsEfGywqvV7Ih5e7ucio8w+clKHOifjHbMrM9AzdPQAUs48g56W50V5P7olQIbjA1mC
	 rlWuUh0VVY5SaMav6h/Kv9qCnomp7GOPRsjt8QMBc8g4kS7k+XVYgXAXHMsd43GUw4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926493;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=TH0jJX9rpWoOzYA9mnZo2lcZuS+4zfsKlHedhmdNO5k=;
	b=2Dd/ec61sKvx1o9M3H9nCHAwqR6z9VvavipeGugnPYoKMqVQpxGTTIxITn/Mjhw3mAoo
	 +Kaz69fgkdZWwloFG83nt4lSgXP4+WCqDXAJQXUDRWxbFEQkvVX3VrFylI8M6SRsDDGLn
	 SLXXgdmF+dN/8W5TLB+VpUmW+M28MSGRvbQbrDfIvfm70u1Y7gq88/RFcjAaiPDWCB5Fg
	 1w1kASn69KPorh6gHFSTLzdg7jlyI6IDUNqtqekrqzshHkAF9zEhlYwSKIuJlxa/XuvK1
	 VbaPI/kGXrX9M25DVcS3VtAP83QaisHRPw94OwfDKVgfVKPwgz/nVwtMO/i3bl+ZABQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJJEKdwN;
	arc=none smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6232606A31A
	for <git@vger.kernel.org>; Sun, 25 Oct 2026 11:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6232606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hJJEKdwN
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b1f4d8e09aso3181001a12.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2026 04:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792926491; x=1793531291; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TH0jJX9rpWoOzYA9mnZo2lcZuS+4zfsKlHedhmdNO5k=;
        b=hJJEKdwNxNxqIjGaemEp4vopVqL10sSkDa5wpl04AGoYjio3wiXw3cbE2f98lwhffB
         Vw7Q+G+Cl1pfH/aMHbgSlV4Y3bmKHRaBajYupycU1UPay29RYhM+XQY3+5y8S5eOiDjd
         KDRPmDtD0QPe4qupxkzI/YMhzMbA77gC8DS2guO13LmnkAKG7eKGGShcTd/u3X5xguz1
         2DvB77+vvXQ9LGBNsFw5iskBUI7Tq5eDkuKktitwJlkolmZvEoHMH5A680tOwPMphY45
         9fOdrT9MST8WQIvdiToUDeyshTKW3NLmerHKNhsNELckHGmWQ1bL6jBxfd/Kd3IsqozJ
         1ebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792926491; x=1793531291;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TH0jJX9rpWoOzYA9mnZo2lcZuS+4zfsKlHedhmdNO5k=;
        b=CT7CrWe+nM15yjlhEmuJUH0qBXdv7kcY1OBH5mkenOcmdLzG7TQSBUlNUdwAw6MHQz
         ykXY0Yb8xTV7I76zTJv+oLMdfFuSBHq5aBdATymxe/YJfNVErBwMEqNJ78HKIrHvPwxp
         xm9IsnHVs5kqzIA55+boBuquK750pSDKIZo5QNAADc8DJw/NwiCzuxFswhH4PjFfCqxK
         RPRXIg3fXuBZdCWTNFRMimN5MhcIj6Zem4RzdhxhIYg3iVJW14Hswe2YOSQIFtVU27si
         h6KTT4IB2jaswBAnFBfC5hKAFzW/9r2p5aN64wiBZT0XSloZRAIIt8bcD4II1UUFnSdq
         q1IQ==
X-Gm-Message-State: AFq9FYKhfWnAL+FGWIubJyLNPa2wnepUq5DaE8K9RhvRE224LzT/h2cs
	/u+1qCPeRlSKPl5V89ogMk8/cYbw7FAEIeFZDeDCoeoC+IUbrVKXwca/BWUoy2mi1iw3oQ==
X-Gm-Gg: AYBFou0eNmLjez2JZKA7PNC+XSneDKCIYg7q0qAK1/kjNdP9qPFm/aXGrReHLCRpGC6
	MR+06kl3IakrgamjCJNVXdd8mCDYveWa4KhRKfvXtxVGXba0XeTfyJ6W/29HQ6w/Qz/JeCRw2fN
	fAYY9wEvYQEE3niR+8Fx9K2dN+pLopawIBqHyUFskjoG/pqFSfUk4p9NpcHvR8Ip1AgyH2GJy9z
	+50DvYT1Cc+2KnFKKhRMYuQ3ZAjKVexxrldfootZ3COcbj9DrgLikDcytsn8pCg6RJ4r1ELdHd8
	DiS7gNjlSgNkbGxlYip/CkcvJowhPJXFLrc/LntdvmOLO8vsCCwPHT0U+gEN7yr70sLheScybAH
	+FQ4A4WWBPLUG3Rp/+vyhAIwlHp/4w7IOn2JnY+5bztTfbchdLxWqXyGHJGQY2HBPHU2KmlOYLN
	sVfITHVdje8IVpbpeljbjloHOhLlnDnFuKafCYIwZbCXbgDOwsKYnLKQtx//AdfyjeZSF3iLII1
	juvAoCJnQqrc/wagUknBVYQIxgxVkKwci4ciS40VvTadGtrzJ3drQVh
X-Received: by 2002:a17:906:4788:b0:c2a:c76c:c743 with SMTP id a640c23a62f3a-c46bdea94c1mr489698366b.35.1792926490773;
        Sun, 25 Oct 2026 04:08:10 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c46c59c063csm149709166b.34.2026.10.25.04.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 04:08:09 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Li Chen <me@linux.beauty>,
	Julia Evans <julia@jvns.ca>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH v4] doc: git-rebase: update incompatible options
Date: Sun, 25 Oct 2026 12:07:59 +0100
Message-ID: <20261025110759.204336-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few options in the rebase manual page link to the "INCOMPATIBLE
OPTIONS" section, but they are no longer incompatible with any other
option:
- Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
  incompatible opts, 2023-01-25) removed "--allow-empty-message" from
  the INCOMPATIBLE OPTIONS section, but did not remove the link to that
  section from the option description.
- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option from rebase, which
  removes all incompatibility references to `--ignore-date,
  --reset-author-date` and `--signoff`.

Additionally, since 414d924beb (rebase: teach rebase --keep-base,
2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
it is not mentioned in the INCOMPATIBLE OPTIONS section.

Update the description of these options, to have correct references to
the INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

Thank you for the review!

Changes in V2:
- Update commit message per the review comments from Phillip (Thanks for the
  review!).
- Add `--onto` to INCOMPATIBLE OPTIONS.

Changes in V3:
- Downcase "Update" in commit title

Changes in V4:
- Update the commit message per review comments.
- Rebase the patch to be compatible with the maint branch.

The main difference in git-rebase.adoc between the maintenance branch and the
main branch was created in 2fc11e3382 (doc: add more AsciiDoc cross-references,
2026-09-25), which turned all the "See also..." lines into links. This created
conflicts with the removed lines, which I've solved.
I was not sure what is the correct way to add the new INCOMPATIBLE OPTION line
in this patch. As I see it, this line can be aligned with the current version
of the file (without the link), or "correct" for the final version of the file
(with the link). Here, I opted to adding this line in the aligned form for the
maintenance branch. This will require some work when merging this change to the
main branch, as this new line will have to be updated.
I was not sure if this is the correct strategy. If the right way to do it, is
to add the "final" version of the line, please let me know, and I'll provide a
V5.

Thank you for the support in helping me get this through.

 Documentation/git-rebase.adoc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index f6c22d1598..f1f675d311 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -217,6 +217,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also INCOMPATIBLE OPTIONS below.
 
 See TRANSPLANTING A TOPIC BRANCH WITH --ONTO above for examples.
 
@@ -332,8 +334,6 @@ See also INCOMPATIBLE OPTIONS below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 -m::
 --merge::
@@ -487,15 +487,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also INCOMPATIBLE OPTIONS below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
