Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795194756;
	b=Ye8ziudFBTp4GUgxI+T/lBIpp7SiEA+ty1vcuppvaDSHFNxR1qogeSPJiu78sGviQ74D
	 0ZNTvuvB0Ib4zUT9Nk6T15ImyY079TkrFmJlextFp5i/9Z3mrtxuk0uo49v2HdqsInw9L
	 CxSaMRj9Bo2kc8QmY6hjK3knk0qPHPUSGfxbNqec60Ul6AKmRrloxgLAksBK2l6UQM2LL
	 Sm3K/aw1RgqdX42hijqLe1oEiZ2txNXqyDoMMJFrvhPrzBdsmNoPxAO3/yM4/R4y/5AhQ
	 rHCiEp2HtB7waIfLgrZjDbicmzX03OF4dmouk0hyI3i8DBaL/0iKTsAjB5v5bnhspdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795194756;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=FNP/r7Q21Bx+vYNS0rYe5vKPZNO248YuxTovS3f/YKk=;
	b=w0EuopsKVhoYNtSMzHHtV2wkqn7LjHUBUBGOOKu6IP91Q0Vj1tKPXfHAEEcPGpbTEnx1
	 erXczJIfl6FRWzOa4YDqIHpePp4dFtlaWExnoXGz2MRYn19GWWjRY+dEj3I37gsB0/NQR
	 BHf5klbb38jk/LJvVjLqNrbY2sOO8Q8I6tQ8KjiQPWLbhyY5iPf/qW9IZirPyQE3MEKm2
	 HS/ejWyUdzpio8clOdU+loDMdlU+58qzMwhZ4uX6Fy2YOhXHqmS7ZoS2IfYS0PJQLlhg/
	 bZlwr5ypp/Hety7S0+zP/lW5ZbshhKW40fE64yWylhXJ20+JF2qa3NhrH2NRBmdLQDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsqxs9Ct;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB145606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 17:12:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB145606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Zsqxs9Ct
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5c14a204305so792170e87.3
        for <git@vger.kernel.org>; Fri, 20 Nov 2026 09:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795194754; x=1795799554; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FNP/r7Q21Bx+vYNS0rYe5vKPZNO248YuxTovS3f/YKk=;
        b=Zsqxs9CtUQQcrvuhxYqERbd8kGkPM2I0qEhpSFsT+GXNd7JGJKFOm8vM6L2FXA2JGl
         ODWd4QLdcO7YCcIv4NApQZAutFHrLYQz8CijN5423mWABfum5JIViPDEAHAYtBDHtIc9
         KnstZiBEHx6wOmX0ZiQWyAc5B1YRff9HYDy2NW3cik3FoME9S03kPAMjcqQ8VW2KGKJ8
         Ig5gaczG8d+E5AeoxHmictq2IzUOvl2abeU1rw65ipzAbNb47VEK2XdvgpLPbNpQ+UT0
         I5+bP3TXH/hLTSconHTfML2+xp4+uBiryBw+AR4TOwzNi6XT/hivKPEJ5Vjxz/2IfFXy
         nwAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795194754; x=1795799554;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FNP/r7Q21Bx+vYNS0rYe5vKPZNO248YuxTovS3f/YKk=;
        b=uThUQLTSQIPp8NKo+6HR991E2JNSQvfERrlquPjLTWgtZSTfghnC182zfADK6aIIjG
         xmMMVx0C7BQiMWVAoMkj99v6ZILCmjpYfxChKUG1vRZV2l5QADaa/4p+rP8Vy+0G3srC
         HLRusOyFYUFW3oo4qTwoaWl1h7dx3iY4IuLpYDGkLjirGUTXsPiQZUa/dnu2JyRfQtFS
         DEyBFe1WNu1tDFQqGizNPKpivpRgudotLCKz4KdK8WPNBOkD4DUCBBc35i3NOM5zvnw5
         Oh8HwJapQ3036sWUE34kD3ru+1klaI8b0Knx+J3i5c9JGi/4hXHYaBHozCTxqrlOmVgP
         qAxQ==
X-Gm-Message-State: APuU4Z9RWCHKhMqYwCz+p4ZNS/Rr6aDWwNv9zMiTkXSe9IBe8hzUvGxZ
	qVh6j7ICuQsDpi4xRm+pPa/bt5GKK+byeTHc604coq8b15tvEbyUrdJ/ao7yr54F
X-Gm-Gg: AZFdTZc4NzR6i+m/E9Dk10yXsKxqnSYx2R+903WzikkDoiDb0bPrutrWg063BOJeXah
	AQmhZNXwT26s+fB2q2Fd+CUigQ1otdqX1uNoj8ExB/nx+fneIKZGqQfOdZT1LHgnngkjOCriwWC
	feV84RNtfoxogkyHsweESKgTgaBtcmXe+HMzIwIaLo8bMgv+9r7T0IhtYSYd+LJ33IFrBlILOpB
	WcysWK5osAd1cHA92FmAy66akOq9LZhIA+OW1Zut9MRIAf+fhoheSxrrNhRUei/6Unu4HRW+B9E
	6gyjagJDmeim1rWfKK7/T8Igf7q4QxmFE3rrr5tSywKlbPmkmI309/h4ct8P2E9HKhCA+Z0bHBm
	ggBZxW/opYRy+3C7tAIr5icWDLGvFqIUvG3EXzEGLdjr/4vdw+kLGnTWSlJw4rOUubb4H3LoWsY
	0YJs4opO86IuGzOtje9sjC0TYoPaTgh+3bomhvnUH983DpfdvQ7xFdIlZzPajE42ljYkqd4lgrm
	5VzULkS3SJADy9NZWIW9PtCqrysZcCYKwGHJKaNg708pTDK9ekcEYLMD/lmWTl8R+E+e8UI50yo
	Uc2js534Meq+0k/InaQ2aiO/GwadAf5jX/oVEp8Ouh5yx4vxc+bVTw==
X-Received: by 2002:a05:6512:1152:b0:5c1:4e2d:58ea with SMTP id 2adb3069b0e04-5c1bc81b0bemr1149853e87.53.1795194753820;
        Fri, 20 Nov 2026 09:12:33 -0800 (PST)
Received: from [127.0.0.1] ([68.220.157.62])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1bd0176fcsm724346e87.34.2026.11.20.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 09:12:33 -0800 (PST)
Message-Id: <pull.2496.git.git.1795194752259.gitgitgadget@gmail.com>
From: "Ophir Bleicher via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 17:12:32 +0000
Subject: [PATCH] doc: fix AsciiDoc syntax
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ophir Bleicher <ophirble@gmail.com>,
    Ophir Bleicher <ophirble@gmail.com>

From: Ophir Bleicher <ophirble@gmail.com>

The Documentation/MyFirstContribution.adoc file accidentally used
Markdown syntax for a link:

[here](https://gitgitgadget.github.io/#...)

Fixed it to use AsciiDoc:

https://gitgitgadget.github.io/#...[here]

Signed-off-by: Ophir Bleicher <ophirble@gmail.com>
---
    doc: fix AsciiDoc syntax

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2496%2FOphirBleicher%2Fpatch-3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2496/OphirBleicher/patch-3-v1
Pull-Request: https://github.com/git/git/pull/2496

 Documentation/MyFirstContribution.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index c58253fd54..3b531b24fa 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -931,7 +931,7 @@ either with the "New pull request" button or the convenient "Compare & pull
 request" button that may appear with the name of your newly pushed branch.
 
 The differences between using `gitgitgadget/git` and `git/git` as your base can
-be found [here](https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror)
+be found https://gitgitgadget.github.io/#should-i-use-gitgitgadget-on-gitgitgadgets-git-fork-or-on-gits-github-mirror[here]
 
 Review the PR's title and description, as they're used by GitGitGadget
 respectively as the subject and body of the cover letter for your change. Refer

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
