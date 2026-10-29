Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793277950;
	b=WoJx0Xxu+AOR+5DhKowK6xmgH8B+mHvPTCEpeXcF4KdqWZTIJuZua9VlekstwqQ3Q31/
	 RoL4yrT0OpoqLKBYboGPH+KFwWt+g6VJyL6VYLlHCaJaxTxGK8NiaXBHNQLTkW07vBQmE
	 dUq267TKt/15/5w0GR9Zft37praDMlVIgeUY+HjXD5UQr2787T30Wbzp97fyNnmPXDjHd
	 23ziX/VPnkqW5iemLbRw5V/n+U4jhoyKVzB8y4K2z4Pylbu8uq2Lb32qkkcuFoth2jcqN
	 ngNZpXvWRcFvKt07dB3MHICFeUd2zijeiDtszh6LYjNo7MzxtM5A9JNJXVa3uH6A6uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793277950;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:In-Reply-To:References:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=HNjxk6BKSlKsGSI4DqYZcZy9GVuIPFRwFQH5Kh/1ksk=;
	b=msx5I7IBmq6czLRJLuDmRkDkE3eNFWYdt2TrRXe0voSV/3Q4CLDAoTujXoYENT0n9ufa
	 J6bSjyseFhh9qJ9sEBlK1gehz230opHvBnnNvWW9G96g8osNlNvXEpe2i3qA2ynv4QXlf
	 Q8F98zvp1QFVtnKPvYII1Pk68h23cIK8bJoZsr4ZJDSj0zSTLshGcbpYm+uFumiE/Al9U
	 BmKiQI7YSNknRi4on0IvnkSeOvvdbte5Wc3cgWtSBrvB2OapaGr9cDNBqtwJCAxLJ+yXF
	 0ZdbGtEWYFkeMpuL8VYpu/EFiBLnT+z1UkZucofQ3RxLdqm2Iaql3QQ366uWDh2rYVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDbBFFG6;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F77606A31C
	for <git@vger.kernel.org>; Thu, 29 Oct 2026 12:45:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62F77606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pDbBFFG6
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a2000d5fb1so15137275e9.1
        for <git@vger.kernel.org>; Thu, 29 Oct 2026 05:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793277949; x=1793882749; darn=vger.kernel.org;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HNjxk6BKSlKsGSI4DqYZcZy9GVuIPFRwFQH5Kh/1ksk=;
        b=pDbBFFG6pYqjgK7WDJ5fmjB+EegJ7HU4DpK3+qpcD2hfbfs0ZP73p/AymZx46tGXmO
         zB/l1x2YB0u6YS/mXraU0tJmbJbuQi3KRcVldh0EogAKcCttKjpQvYAXxbnwQ3ozmBpZ
         PtziEwGqwxvo+VZrZMp47ADRws/l2bUrKZjuaiQNz6ivaVcKtG3UlZnn1ID+JMS61m65
         R7oCPKk11wBE13gAwKeuK/J12Wa2RQf9t5qqw6BSzb+bOg7mz/KiV0+n+we9YEP5oAJk
         yxewTx5AlxFGxBswCS1eRYWq/B3qnYKpgPESlKloXGP3BvMil+mWFatDFU3KyL9m90on
         QdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793277949; x=1793882749;
        h=cc:to:references:in-reply-to:content-transfer-encoding:content-type
         :mime-version:message-id:date:subject:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HNjxk6BKSlKsGSI4DqYZcZy9GVuIPFRwFQH5Kh/1ksk=;
        b=btnGItk1ClV88Cfie5570fxpLSnZr+OkgOw1ShlV1WNO4nzlSOojQT7zzkQSDgEDT/
         Jpvew7J07bRtdjWZ4GeaZ6b1EhW4FHZXgqs0RnLnGXh8qpeXitz96EPk7MPdX0IXFStg
         7ZMjtiY70pMtS1Qe6+iwfgFmxSkb5dH/tH5n+IwZqOYX12Mk11FWy6lpaxKJs36oH557
         z1HLAuuFBIV4RZWhG86cEHX9DEGhYzHX3wudU7e6ZbGxbbullfg+NAP7WX3t0Meg8U9L
         kNk7FcML+k5yU0YbZTWxklIf42fo/po4oCyjdmRJUG19l+Yg2qu7RXbRXhdRc6ZISExW
         YYww==
X-Gm-Message-State: AFq9FYLz2ScK8gbkdsW1fgG6dkFTA4Lju1mqp9UIjN3v4X0BFUBGj4sa
	eV32dr8ZVHPuiDtKeKKO4Z6fteuegoUvTI+gZoYHOxxUg4GqX9AhzqR3
X-Gm-Gg: AYBFou1NORUCZtjdgTTGv/fb93XTpZJ/nB63wOcaMKNmJcCFhSb0mo718MZ3IyUbwNy
	yYIlXu9v5zfMqms8Bpl7wfOWOSNqAXv2sr8kp5y8ZTTVZXotBiCup89Rt6r5TfYfessJl/NwEkJ
	zW5yq+jPW5E5Onld+4QlWBTmkHb/DNzZtzh9hM/32aL0BuCfdUM8WG61lCtS6V68MV9codt6TC7
	91wYgv7dzq6uWSk+v1pIsC0NZHnnY7/p+vcRl73RlFKVMu7dYBUlUmTEJvRz0vkd2EGWHiZcWpu
	dbZ8HliXRqFFc4n3HOF03wpVtc/KQxxZF6zviiNs+qj7GJFvi4ye2/TKXNRtRUXqrURIDSiBv3Q
	7Eu8ASUi+EqZfHmlI9uHno27f2z7CYsrLfCoHyhiDRi7fNp7yzTXlvLSfT0iCVgPNE7cSmim5Dx
	sYUv8jeseW3zhhyPgwfhmfEcjwYU3NZpfamBTmImeeTWDGJ4+CSJfu5kwp0Daj46A6rfVxksddA
	fKzYGxvo/BnFrHzA2a8v3OgMmBQ2DWiHvySNca6sPetUWKFtX2FlMabtlHJ0scsEodUFQxK8DN9
	ev4xHeoEzGcwiOFAmUXyMigIPNPtNSqjpnL2kOWcd7BRRYNPm6e01hXtDahBv5dVIVKOhg==
X-Received: by 2002:a05:600c:3e0a:b0:4a0:1c0e:b057 with SMTP id 5b1f17b1804b1-4a9640f1fbdmr125372775e9.4.1793277948419;
        Thu, 29 Oct 2026 05:45:48 -0700 (PDT)
Received: from [127.0.0.2] ([2a02:8109:d906:4e00:7938:fafa:2306:bf7a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a930a63eb3sm106593635e9.1.2026.10.29.05.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 05:45:44 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 0/3] fetch: advertise fetched refs when backfilling tags
Date: Thu, 29 Oct 2026 13:45:36 +0100
Message-Id: <20261029-799-shallow-fetch-with-tags-v6-0-e6ddd5201def@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOy07DMBCF4VepvGaQx85tuuI9EAtfxolR2qA4p
 KAq745ThBRlEZZHGn3/3EXiMXIS59NdjDzHFIdrHtXTSbjOXFuG6PMWSqoKpayhJoLUmb4fbhB
 4ch3c4tTBZNoEvlJWc7CKghRZ+Bg5xK+H/vr2u9OnfWc3reR60cU0DeP3Iz/jevdXosPSjICga
 /IVlrIwoXxpLyb2z264iLU0q42F6thS2SoUIpNB7bXbW3prlceWzhZJW7FuLDVe7a1iY6l//iq
 y1Rh0xEETsd9b5dZqjq0SJNSu0M6R4Qbl1lqW5QfGeRblCAIAAA==
X-Change-ID: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0
In-Reply-To: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
References: <20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
 Justin Tobler <jltobler@gmail.com>, gitster@pobox.com, 
 =?utf-8?q?Mitja_Bezen=C5=A1ek?= <mitja.bezensek@login5.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4663; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=stqYgPA8B3WSm102PIcIMMeHvD6G+NfQnzym1Dn6KFY=;
 b=kA0DAAoBPtWfJI5GjH8ByyZiAGrjP/bI3OoSLFy+/0Gz9SEMwXTwjWSu9mQND/RGxq3sp1gqI
 IkBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJq4z/2AAoJED7VnySORox/sxoL/A2T
 dV2tNuESt12gqVfP7pnDJ90yH275TUYdJVwlAQ8bydRSmXLRbAvWyp+193Kr4jHNmmmLqkmSkeJ
 9ZdVZoM2HiqxueP0Jpd22o3h5ODpJurMjlZSkxGVtAA7egktvVDVbujkFvapA+PKTWvtlkkLTyC
 xXZ2AUYKflx7DHIbXKaWGwATGB/eSEEqm96o4CpCrsX2xBzqulnyfcFfTvUEXEAQwgUbFMwVjt2
 cJrfWYIgsC3Bf2rhcFRv2KTk4szKGF/xhEcZsPWndTYosa3KtUMoshNJgfIdGj0mvMeA6GWL+jJ
 z1qIEbDUTAv7/JPsTnZm3I3f/m9WiwzzDBTYleYPyMgYe21c+hLewA+pYvtwmCU0gVnlqrTACGp
 MfJ6178A0tx84VYumBpujigkxu3to3mehV8xi8gDtd+DDVXprdWCOlrIGqexWdHejVVVEroWOss
 jY7UbqWYMzwWDS5JPc6hFdDy/I3U6pAPwuRJ47mcmPg5/4FDXlxZtzhaqA/Q==
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The issue was reported by Mitja Bezenšek on GitLab's Git repo [1].

When fetching, git-fetch(1) performs the reference updates in two
steps:
1. Fetches the regular references
2. Backfills any tags

With batched updates, both of these operations came under the same
reference transaction. Unfortunately, this meant that the initial
references fetched were not committed and couldn't be used as 'haves'
during the negotiation when backfilling tags. In shallow repositories,
this could mean that the server was sending objects the client already
possessed. This series fixes this regression.

Earlier versions (1-3) tried to fix this by splitting the transaction
into two. Which works, but makes the code more complex and is a bit
messy overall as we have to deal with errors and also jumps in the
codeflow.

Justin suggested that we could use the references already available for
negotiation instead, that is what v4 onwards does.

[1]: https://gitlab.com/gitlab-org/git/-/work_items/799

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
Changes in v6:
- Move the last commit to the front, since it adds a test to exercise
  existing behavior.
- Fix grammar in the commit message and mention how the next commit
  would catch the leak fixed in 2/3.
- Link to v5: https://patch.msgid.link/20261028-799-shallow-fetch-with-tags-v5-0-7c43cc9ae810@gmail.com

Changes in v5:
- Add a patch fixing a pre-existing leak in the remote-helper
  transport's cleanup. This allows the patch to drop its manual cleanup.
- Move the upstream-info test into its own commit.
- Some cleanpus around the commit message and grammar
- Link to v4: https://patch.msgid.link/20261022-799-shallow-fetch-with-tags-v4-1-8a1c9ef399ed@gmail.com

Changes in v4:
- Instead of committing the first transaction and starting a new one,
  advertise the refs already fetched when backfilling tags. Thanks to
  Justin for the suggestion. This also fixes the `--atomic` flow.
- Link to v3: https://patch.msgid.link/20261015-799-shallow-fetch-with-tags-v3-1-90b6e38b98d2@gmail.com

Changes in v3:
- Fix the early exit, so a failed transaction_begin() only skips the
  backfill.
- Keep the first commit's result separately, so rejections don't skip
  the upstream and remote-HEAD setup.
- Test that the backfill advertises the fetched tip as a have, instead
  of checking that the root object isn't fetched, which passed even
  without the fix.
- Add a test for the upstream setup when a main ref is rejected and a
  tag is backfilled.
- Link to v2: https://patch.msgid.link/20261012-799-shallow-fetch-with-tags-v2-1-4211e9a13d3c@gmail.com

Changes in v2:
- Add benchmarks between master and this branch to show perf regression.
- Instead of checking the trace file, simply check that we didn't fetch
  older objects in the test.
- Link to v1: https://patch.msgid.link/20261009-799-shallow-fetch-with-tags-v1-1-379d61504af5@gmail.com

CC: Patrick Steinhardt <ps@pks.im>
CC: Justin Tobler <jltobler@gmail.com>

---
Karthik Nayak (3):
      t5510: cover upstream info update on fetch failure
      transport: add `transport_options_release()`
      fetch: advertise fetched refs when backfilling tags

 builtin/fetch.c    | 33 ++++++++++++++++++++++++++++--
 t/t5510-fetch.sh   | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 transport-helper.c |  1 +
 transport.c        | 24 +++++++++++++---------
 transport.h        |  2 ++
 5 files changed, 107 insertions(+), 12 deletions(-)

Range-diff versus v5:

3:  ed24854913 = 1:  6aafee69c1 t5510: cover upstream info update on fetch failure
1:  f15e69e2e6 ! 2:  a22b348247 transport: add `transport_options_release()`
    @@ Commit message
         the latter misses this.
     
         This means when using remote-helpers, data allocated for the structure
    -    leaks. Introduce a new `transport_options_release()`, which acts as a
    -    common path to release memory allocated with the structure and use it in
    -    both files.
    +    leaks. None of the existing tests capture this leak, but the tests
    +    introduced in the next patch do. Fix the leak by introducing
    +    `transport_options_release()`, which acts as a common path to release
    +    memory allocated with the structure and use it in both files.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
2:  dc7024fafb = 3:  ebe210d2df fetch: advertise fetched refs when backfilling tags

---
base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
change-id: 20261007-799-shallow-fetch-with-tags-d62b3efb29f0


Thanks
- Karthik

