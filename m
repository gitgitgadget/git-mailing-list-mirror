Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5B62F7F1D
	for <git@vger.kernel.org>; Sun, 17 May 2026 20:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779049620; cv=none; b=Fj0cINqyPzkwOdM1fUNb9y86ArZwq0OixL+uhlXnKQvPdxII/3oHisfjNVppPEDk3wqymj6ebvvC/XmvvurPCqqay0GizgwgPNfPAETnBQg8T/WZRh6Kbmw0qSVSgjqP1uiflLsKI71QCqdnRLrR2jY2vSahfUHkg9C4c1lFc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779049620; c=relaxed/simple;
	bh=5QMo76cZ9Az3aTYd+75pW+c1yvxYEJMKGKLmofiU9O4=;
	h=Message-Id:From:Date:Subject:MIME-Version:Content-Type:To:Cc; b=BOB9X+ct4X5RniqnwuaI5Gr47yI0O8vV4UBOGGv5wkoikcPd1bp2ktSZN0mkjMzTYwKrjbTbHpZMBt9C9BVsqKeHn3uS0NzZbMmIILjTXsOHeuCvQaVG9/SxgP/TTczQtJaFBk1jW5tfAEUe/4Q0YO52CXnpQgDb3LWxbplATJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lp7q9Ak2; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lp7q9Ak2"
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-51306c36c3eso21855381cf.0
        for <git@vger.kernel.org>; Sun, 17 May 2026 13:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779049618; x=1779654418; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=DvVhRlPZg+OgExY6nJEBtxoyh/Pq2wsZuSzIvOs42Js=;
        b=Lp7q9Ak2XJ17ie5xRTLzvg2QIQck2n22mFE04fEINA3RIZ45Fh6T8+RgtM2kp0f2Uf
         H3RoL8L3QLFCBoHJD8R8Fhi9kM/vzhHXXOQ0PQXxSEpwPJlMzRQ0avpxYLH3qySKkz75
         DQg6Y0NyhJxzHn/BaCTbXYWuH1D6utVhRJi4OJi6NNw6rrFsqwy0jVPEnLHxOdEL8HIU
         PTW/V+8+fZttxERRoc1DecTrq7MmsI8v74PAaq4n/4ERyC1ypjnhLvJq/3ybiNWW4wwc
         p6VJiiRY0yxAZpYown8wltbc1PZiLmZ21RFA6iz2/cJ7I3w3abWVPC5EFVL4VVZ8RmmN
         0FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779049618; x=1779654418;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DvVhRlPZg+OgExY6nJEBtxoyh/Pq2wsZuSzIvOs42Js=;
        b=Lxa0AJeQL0FPy5W/DThMCgHZ3bzX894+xKaJlnGyfS4s9Vu9eA5e+K6Htmg+XUnmlr
         2WPbO5hfStqr26/R8q+JbP+Yr97eiPs3ydryKoSa+Kh3FEkx0rE/D9B1weefRsRrPeZ1
         zfqKGiWwGpgqu2IDCR0BgJPSwQIlVG4sh5/WorysZlIcjRB01rgDDtlQHoKJg/8vdlZL
         izU/zQJv/kiwTDgUBbkYrBTxVwEdVvgAcmXr+DhYM/0/7k0fEsfS95wgvlQlimOMtad6
         oh4Qpj6PpNDGPUQS3bhZ1UH9CTZPpTkgBjWT6i9xz2p2uidGxNHLfuH08ewgKmmex7Y7
         Mmsg==
X-Gm-Message-State: AOJu0YyXhYlMpZT8hlpGowjnCRZLQnesMGicbjr4kYYEYSzoF3DlLoOb
	O0n7nz6neg1BdsSf2pNMHt3VYP2uIguKvpmeJzm/Ij6s/P2mO9CxOc5YeSYslw==
X-Gm-Gg: Acq92OELM2BM5eKrJ8a5PgF0eOse6oTX3s3bOBS5TVj6usRsnKRSRRsgsueE8HMMjw+
	ENBqPT515V8Mz+oxCU3mUx6u7GaeFu8IO5DUYttPgGOTd8mKCm05CFHFwX+pShUOXy824Pxt5cR
	qG7C4cHkBEVhAlsWLwb8/mQzBU7F1ImxcwLNfPWbNpiLz+e1VZQFsgtqrGvEuAnaHmRhPQDAJcD
	If1HMg0ZIi9yh+6dTStSJOakiRGs0w2ZnK7/CvZMWmAF2mgeugD19NmcmR2qKR6OWU+F9Q7HV0M
	oHTdLKPzBzdeWJ92u8J0ybxWxIdFRFbU6Kjf+ItEhTvJtnfYAqaX7jPUXfi9crZN1Zm82PRm75Q
	GnxT0nb3yUeRtSoxGuvxOyoQtPMzPmoR++Vf2xXfE+PWUpDGfE0WimwGP5TSDtm6wceq/IG6WAK
	W1Q0S5lLZ0lkEeStZPdqCbBFuN2JpksOFJ7ma3Ug==
X-Received: by 2002:a05:622a:1181:b0:509:3257:c050 with SMTP id d75a77b69052e-5165a0dfe92mr179964471cf.24.1779049618027;
        Sun, 17 May 2026 13:26:58 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.134.161])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ca36086afcsm32357756d6.10.2026.05.17.13.26.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 13:26:56 -0700 (PDT)
Message-Id: <pull.2117.git.1779049615.gitgitgadget@gmail.com>
From: "=?UTF-8?Q?Jean-No=C3=ABl?= Avila via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 17 May 2026 20:26:50 +0000
Subject: [PATCH 0/5] doc: convert another batch of files to synopsis style
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>

This time, 4 new conversions:

 * git-grep
 * git-am
 * git-apply
 * git-imap-send

This batch was an opportunity to test AI-helped conversion.

Jean-Noël Avila (5):
  doc: convert git-bisect to synopsis style
  doc: convert git-grep synopsis and options to new style
  doc: convert git-am synopsis and options to new style
  doc: convert git-apply synopsis and options to new style
  doc: convert git-imap-send synopsis and options to new style

 Documentation/asciidoc.conf.in                |   6 +
 Documentation/config/am.adoc                  |   6 +-
 Documentation/config/apply.adoc               |  17 +-
 Documentation/config/grep.adoc                |  36 ++--
 Documentation/config/imap.adoc                |  30 +--
 Documentation/format-patch-caveats.adoc       |   2 +-
 .../format-patch-end-of-commit-message.adoc   |   4 +-
 Documentation/git-am.adoc                     | 132 ++++++------
 Documentation/git-apply.adoc                  | 125 +++++------
 Documentation/git-bisect.adoc                 |  80 +++----
 Documentation/git-grep.adoc                   | 196 +++++++++---------
 Documentation/git-imap-send.adoc              |  24 +--
 12 files changed, 337 insertions(+), 321 deletions(-)


base-commit: 59ff4886a579f4bc91e976fe18590b9ae02c7a08
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2117%2Fjnavila%2Fbisect-synopsis-style-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2117/jnavila/bisect-synopsis-style-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2117
-- 
gitgitgadget
