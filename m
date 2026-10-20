Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508973;
	b=QNSAzuNpGR+aNqluGUwgjY86qnClNt6suWQrNKQ05bDtqjYqmbgK+/aP3ZYj4IILt78r
	 2JrcAdp9Bkz0+fx6vdjb8HbCrmDPqMnqURjLr4ovHtY18DOb64dhyfcmfXWNUV4hLUaWc
	 /752/95a79DEVf4H7DILDGk9u9UmUHI2pGh18Vz9RlS2QxqLUk7Y7CTLOoI7pLLzkjR7t
	 w8F1GiBO9erwhxVbRLBfgqlryK06H5pUUKShfySj3LvDnh/uUTO40L8Lqj0rBZyivl0M/
	 u9AOsvtucrBzwGc3uNxrxWkUIMbgkzaKtxMvVT8Ro2xEMvclUViO85l7+jf1uHjN4Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508973;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=WUQwgPlswGzFg2lszmiABW+6mN/qdxbXibtGWMG38tA=;
	b=P993rQL9Akiky8Zj/DKNUZCS3l+sCA7ntCN1W/B4Hm+ELyOoHaukA5aHdJDuIcNywpS4
	 R0dbd4IHilvLEYKHGCXIKpWXPiEBz/OqpcxFQ6hcDD+7Mqq7goXY0ntlHq0kUUPKXCqsY
	 5WXmf8qSkZuI0KgpWmIs6+hizabENAvoT7h83ilMUp/GB+XNIIZz9+eOq10OcTgLsc+HS
	 nZKmAyb5VQUUTtM/N3YgTYdAJzm7G/R8V+Lg3i72mq+nML+18E3o6aaNRg9SXAmwbEKwZ
	 zJYv2Qryw4haAzNeZUVWvClC2oednbu6OxbbL2CgbB/sNf28Tn3CLf0ZC4HTs3StSag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jlcS6mmi;
	arc=none smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0A4606A31C
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 15:09:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F0A4606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=jlcS6mmi
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c247f6687dcso318968766b.2
        for <git@vger.kernel.org>; Tue, 20 Oct 2026 08:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792508972; x=1793113772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WUQwgPlswGzFg2lszmiABW+6mN/qdxbXibtGWMG38tA=;
        b=jlcS6mmiMW11G3mlayadWOan8VJcKn5/GcIDKIs2EHTX7nXeTnE2fUlti4XGirpfAc
         gPrInVvYo7ohlYm6lHsS6YBjWdWOKnyCGqXZ98yivWDszQnJUbmslPZQhubtQIU1fNWD
         a7xbpHD+w23X/xapxFlQg/E8XU05FJR5zZMfSNgy1ThFhV67qYA/D/nl037FtMctJhiG
         giq0T9SitolyBzyWKVRFdb8be35uymkSylj+BFktkZgDrMykSsQ7h3vsIWLNhGmo9sXn
         04AVhaeQGVnjKPZt+79FNKId+wcsvhsC2ZtzkgZHniR2aYq4v//1al3U5CENqN8vK2vO
         iB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792508972; x=1793113772;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WUQwgPlswGzFg2lszmiABW+6mN/qdxbXibtGWMG38tA=;
        b=H7fiwF4PEw3J37JFLn6FM9TuzUfozA+n/SKIE2P+2eWn2RNLtayxz+9j4+XV+IAIOK
         ucwyY1lco4Q4DzMFgk08B+Rxv+2gknglTbNh+hSN1Ep7hsUvM5yIgUHNAL81vJ6lJMdA
         OCaiMGzzgSwKdNteHIsw5G4YHQrOCBC9fx37ABo8BDNAno8Gf3ATSixyPxDNTWPdCOYq
         nsOzxSzVWEMOnU6RcUedwbKgkutqc8cqx+qAAwyOQMdcyP2ZWVGBDaUluHcyLwY8c8TW
         S+kG3pSfvPILV2MG1z3zUyD91kOzz24a2Br5gdgBLkmmO00AevO/MjSQwHKfIs3sF679
         BX+A==
X-Gm-Message-State: AFq9FYJu2OAkphKgSGvqxNU1YlU4KVBAqBK8+rfX60kKSNjEusT48dm7
	zWOeyrjr0r9dPYzT6TOYXu3cfq1MnD33Wuy3U9JHtfMSFr7ABk8ZMYbSwtf9C2/YuQk0pA==
X-Gm-Gg: AYBFou0eCxhkPHUg2zD8xkaiPDdgY3D48DBRWiNAsy2dNiHqkJ0gcFezGi4b9vvOyGS
	UWCR0qFUDdgF4Wtgw4XiZOBZF6XtpTZIzH9SNdkAMxXSHuH6v87XIpOhkwx5IZUZVDpSK4xifNh
	oA6FUx6VYFfxBVXcB0ZDPKZVWwcoSGOvrasvzlPp8kZYi7muKePT4/K9Wagpo5ujSTbCue8Zz//
	q9vcGf9DyKqpCWrQEvqu5/FXTnlgsgqkwYJDHdZCY0JZRnGkymsYg19GGRrpjLVpk5zSOGA2g9T
	9K3UIXj6JJ0dJ15Vw/EwsNMuVhgQegXj6FpZVxn1TC3HoLPQHxi3re2yeoHnPpo4fAUPdznUD21
	5uLe1m0qtfoj3ukUJrCZvz/M7vtFnH+zk2lvBUAG5SgXfH121oW/I/WZDKG54Jjl5gXquaeeeJS
	SoWN6x20Wx2ahF4wn+wn9dAQ59kZXL9fDcl1D3+4EStViIIbRvoNNAWnE6P0rDIHewzm9Uk9Y=
X-Received: by 2002:a17:907:894f:b0:c33:ae8b:817d with SMTP id a640c23a62f3a-c41a04f6418mr773976866b.46.1792508971599;
        Tue, 20 Oct 2026 08:09:31 -0700 (PDT)
Received: from omris-tuxedo ([217.71.1.73])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40919bc742sm489540466b.54.2026.10.20.08.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 08:09:31 -0700 (PDT)
From: Omri Sarig <omri.sarig13@gmail.com>
To: git@vger.kernel.org
Cc: Omri Sarig <omri.sarig13@gmail.com>,
	Jeff King <peff@peff.net>,
	Li Chen <me@linux.beauty>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Julia Evans <julia@jvns.ca>
Subject: [PATCH v3] doc: git-rebase: update incompatible options
Date: Tue, 20 Oct 2026 17:09:23 +0200
Message-ID: <20261020150923.5595-1-omri.sarig13@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Several options in the rebase man page link to the "INCOMPATIBLE
OPTIONS" section when the option is no-longer incompatible with any
other option.

- Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
  incompatible opts, 2023-01-25) removed "--allow-empty-message" from
  the INCOMPATIBLE OPTIONS section, but did not remove the link to that
  section from the option description.
- Commit a74b35081c (rebase: drop support for `--preserve-merges`,
  2021-09-07) removed the `--preserve-merges` option from rebase, which
  removes all incompatbiilty references to `--ignore-date,
  --reset-author-date` and `--signoff`.

Additionally, `--onto` doesn't link to the INCOMPATIBLE OPTIONS section, even
though it is incompatible with `--keep-base`.

Update the description of these option, to have correct references to
the INCOMPATIBLE OPTIONS section.

Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
---

Thank you for the review!

Changes in V2:
- Update commit message per the review comments from Phillip (Thanks for the
  review!).
- Add `--onto` to INCOMPATIEBLE OPTIONS.

Changes in V3:
- Downcase "Update" in commit title

 Documentation/git-rebase.adoc | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 6536ebdc90..6363b1a096 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -218,6 +218,8 @@ OPTIONS
 As a special case, you may use "A\...B" as a shortcut for the
 merge base of A and B if there is exactly one merge base. You can
 leave out at most one of A and B, in which case it defaults to HEAD.
++
+See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 See <<TRANSPLANTING,TRANSPLANTING A TOPIC BRANCH WITH --ONTO>>
 above for examples.
@@ -334,8 +336,6 @@ See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 	and this option would override that behavior, allowing commits
 	with empty messages to be rebased.  Now commits with an empty
 	message do not cause rebasing to halt.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 -m::
 --merge::
@@ -489,15 +489,11 @@ applying (in terms of the author date).
 	Instead of using the author date of the original commit, use
 	the current time as the	author date of the rebased commit.  This
 	option implies `--force-rebase`.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --signoff::
 	Add a `Signed-off-by` trailer to all the rebased commits. Note
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
-+
-See also <<INCOMPATIBLE_OPTIONS,INCOMPATIBLE OPTIONS>> below.
 
 --trailer=<trailer>::
 	Append the given trailer to every rebased commit message, processed
