Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547420;
	b=1PyP4ivwHlnYGyEvcmRJFxNh3k3rtrdXTHlgzEGF/7Rapp42vy6fSW77YejFtaNy9v3W
	 qT60M9vYrZDqNlbL378T3JI6Ym6Nj4aJFhD/Q9GoJEGpkmzqoRMnF9TzoimXa80MV55ay
	 EUqdhzmyzBslBJLMibAEpEI/f9yvdtRY+BKpeGoCYSG24IpQlOKIMSmH0DOwZV8LpAmhS
	 Q0V99iGOgGV6F6O9AYz694c7qjzByf2p+W1a0UpTwAQ3AP9uNS84EWNxJhNU/n0TVINO6
	 B46efdVnokAOVQm/lE6Qz7FBMNZG0NI3lMTk63fPVYJ0Wqq+CuNd992de37miOit9JA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hXdWdddNk0G3BVdDMyEwQxyqlOh4syew/0TS1Rr1lT4=;
	b=A8DcbvUTuu3cdxibBjVbY6vqKtCdQ6wAoIUqDd7WITCXxLoV3/TxfOdt5hv+hHLjL7sF
	 L9o/d0Qy5f0bgbz6+RTWBsmZP3PG0sez4Zip+b4OVFRG8u99R8KuQHVywXHMHUj00k/z9
	 eRYPxZ95eNZDMy9qE17yGKXPEf4bYfDrJR3plPXIW1ZogJAjtuT0sAWGjFel4w49W9wGM
	 WEoe3KC/baoBHpmL0Lh+o44wQt+EP4pFGF0E/nnB1Il4kDROxTqGQtG+tsXcqZPyfTQnN
	 tGO4gE2S5UmnfHJnAMU7m5WtBMyJB3kS2kiYCEwILz3qKNEs8gJ8y0/MFLTCUy9KM2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HP90hvk;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774F9606A32D
	for <git@vger.kernel.org>; Sun,  1 Nov 2026 15:37:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 774F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0HP90hvk
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6cf958bso9605365e9.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 07:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793547419; x=1794152219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hXdWdddNk0G3BVdDMyEwQxyqlOh4syew/0TS1Rr1lT4=;
        b=0HP90hvkeNi1ydZ+6Ki6Qj0/z0wHnhVN7qIspDQFNSpxPKHp8jcsyA1BDBA8oBKMnK
         /r4yUtXcx47J0nXEA8RjzPmbGm0wzzIjISic8YHtcb5CT1U1+6MoEqeaTZyCVI4Fmu1q
         m11g96bmKu+cMmBZ51R+ZKmKnoZ0PO/qGomSWfSFHeWWh96otpJYV1Lreouawi+hq1zb
         5eoxxAaB2yGhV4Rr0LLziZG6d/LNIx3JGWxi+APGX8vcWG00UjmapsJQ4WD/h3Q53+K6
         ppKnibJcaxChpEaRSIH9lZJq6d5v8T0nesR1ew4cX9OkGzuM9izLCo9jAQ8/TC2aHrKr
         XLtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793547419; x=1794152219;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hXdWdddNk0G3BVdDMyEwQxyqlOh4syew/0TS1Rr1lT4=;
        b=f/f+LEPSUEMN0+fgmqCHWpJ5EE7lX2MQAQQ29HWJIIvoQibKShUztYI/9z3RlBtFap
         8FSkbindhLc+gVW0yKdUMRrx0dvDL5ufXs64/9dwQqpOsa9kOQ37KDCjODd7GdT7hNll
         OJqEwNrJqMxmzGyKxmkgzNRN19JY6m7a9bA2OADHayYY1yQ268V+kLb3PwIn4xC/PIzZ
         LHH+mHEubmmBZjyCNaFkbPcbDlW71dajR/LbdFLYpxnF6U+/CY7udG5W4skFjSYsq+aO
         PV3K3XNn2uDQX+R0l5mjJHwBiCkAODca7y444I5jpBw5NR3n5+BC0ormwZ+/cCuO2TGd
         02yQ==
X-Gm-Message-State: AFq9FYK/xNCJ/BKplCzeQufkAfeGZIcCuDZEfY0TXz5sOUtYYgzuPWJ9
	qv7s4lTYGEhcUJK2SpYs0FkBkFFx/AO1E4e3JCcwCGKeUX0yDusI/tBfpPeLxn+v
X-Gm-Gg: AYBFou329QQPCRJO4Z6YOMaJCCaD8twPIX8k03pQfeKsfrMQNVpMFpAwuGLNTOMoO8s
	230TkHNbpma4c6EDAJX8PiP4HsSkDP/1uJN3oam240ICgl2bdHMbSYo2FjPIgwnnSYfTHZm1xDe
	6V6eM+onve+2xQPynsU4h+Hsq2zJHZx+TaMKx20piSV7eon88Exbg4IqqJN9NNPU92oB13hFqU0
	cqcskhxjBXNNG4Yrl9qR3Mu6YQSsQGc5HkCrrFCxCwl1hsMx2RlIaq1UBZkojEIUMAX/Dl13a6n
	Gn56cZFsgmOI+3YhpJOZ4e3nDNu7v+Ebzs+EC1vS8AsMhiTsmy+n/kErIoSyQye7yALvENGJFQU
	I+1VJwVeMsoyIwNMlhybCFtbQYsfwBCt+FL5lWow//2LzuraMZDGKJs5JJIkNQQmY0m2cbHobhC
	IWQE0cynHmHuoofOeixsBXH+Lsw2R6gFJlFqZquq+L37pDiN4p23I/qV8gFaoizAjtQkXeQ3GhU
	fBNINdmZTgVK1leU7wjexXvJ2ROCalVbf3I0YN/+Yziz+nblS+S+hN1/YZy+VRag4+P5psq2556
	EvXdLFa4EW02elUWPF/ibjKqwObZuMsXhtKdK5nunQgwlQ+TMjqNCKtXm+RsBLDYrbdJ0DdGTu/
	dl4JNcP8A
X-Received: by 2002:a05:600c:8b6a:b0:4a1:e6c8:ff74 with SMTP id 5b1f17b1804b1-4ac17e10acemr167328355e9.29.1793547418575;
        Sun, 01 Nov 2026 07:36:58 -0800 (PST)
Received: from ubuntu26lts1.example.com ([151.31.213.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b7246fsm14908450f8f.19.2026.11.01.07.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 07:36:58 -0800 (PST)
From: Elia Pinto <gitter.spiros@gmail.com>
To: git@vger.kernel.org
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elia Pinto <gitter.spiros@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Michael Montalbo <mmontalbo@gmail.com>
Subject: [PATCH 2/3] diff: use size_t for the size passed to count_lines()
Date: Sun,  1 Nov 2026 16:36:50 +0100
Message-ID: <2011b90d80c5a823878055fd1016bc38b6a072b7.1793546752.git.gitter.spiros@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793546752.git.gitter.spiros@gmail.com>
References: <cover.1793546752.git.gitter.spiros@gmail.com>
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

count_lines() takes the size as an "int", whereas callers have "unsigned
long" or "size_t". It is used for the diffstat of complete rewrites
("git diff -B --stat") and in emit_rewrite_diff().

With a file of 2GiB or more, the "int" becomes negative (or truncated
above 4GiB), leading to an incorrect line count. This only affects the
diffstat output, with no memory access issues.

This was verified using a 16-bit simulation, where "git diff -B --stat"
reported 0 changed lines instead of the actual count.

Make the size parameter a size_t. The line counter remains "int".

Triggering this requires processing a file of 2GiB or more, so no test
is added.

Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index b4ac17f8ef..ed7a931c41 100644
--- a/diff.c
+++ b/diff.c
@@ -655,7 +655,7 @@ struct line_range_callback {
 	int ret;			/* latched error from orig_line_fn */
 };
 
-static int count_lines(const char *data, int size)
+static int count_lines(const char *data, size_t size)
 {
 	int count, ch, completely_empty = 1, nl_just_seen = 0;
 	count = 0;
-- 
2.53.0

