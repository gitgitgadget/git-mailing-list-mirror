Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795852392;
	b=gX/TRZfHkjnZKnKCtGSb56e9d6to+fBrnHw4BI0nK0jWAsRm2DWVsqdtiIl6Zl2VHWpD
	 RtQ9qnZ8jaDosjaOZGc7xcwetVEWJetRl/tw50ya1JN+T1Lbe34dqgLTixHBdKjCx07jt
	 Y+0GhImsmWzduIqBEcSj1x4Xy5mtBbTv2irIEAO4UHJ+Tcx7AUub+VPzW86crpVmbxaTb
	 P2wDlpcSlAq2HpHQ7mOYOe348tOSAfSe3FOevQnJjVUP0fEyTKfCZjdFGZ4zVeLuzn97j
	 vRV/sI+hueT3s3Lq9xqQHRjSFsBcCv9B0RhmQ9cFX0lUvKDzu+nNmSA1s3NIhW8L3VQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795852392;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=I6F7fyba40vxm63DMQHXtQ1bowNzrEeJBKnwEQreI5Y=;
	b=gQuf8CrXEEPjFjnLwAYBtwdbfkhHCZ+QvAwdaR0iUQ/wE65eInQCCnWcywvEHIm4DAgB
	 hZ4D59lxLOuzFTX0fsegu3rxyNHTJFUvwzhC6r+ruQTgd+EyPxxpJc44lkkX5C9qfisqf
	 JVmHotDW0q1wowgLZiJ9iRvo0ZoMZgbJf3kyTIfWLfQ6l8HPpOOETZNdq8CeNDn2rEgVC
	 2wSIS1ghRUUB8zPBmCXlQbfYUN86dr4r8WT3/KRLWlmVXnoG1BHPB1Uxkf49ZY/TQekkT
	 ZD8LmXN0NcKDP6htum/wqXpMd54o0kuygaY5zLAhzPY5MVM4ByZePNKX2ZcbIYUiX6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFNkiT0h;
	arc=none smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A81606A31F
	for <git@vger.kernel.org>; Sat, 28 Nov 2026 07:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4A81606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eFNkiT0h
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1b563e32936so4604530c88.1
        for <git@vger.kernel.org>; Fri, 27 Nov 2026 23:53:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795852391; x=1796457191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=I6F7fyba40vxm63DMQHXtQ1bowNzrEeJBKnwEQreI5Y=;
        b=eFNkiT0hvHZwizYmH0MOXVEvkC6uZTUYn2PMUaqHvc1KZtky/6m9QBW+/d8+AQ/xs+
         aIRSc0WaDJ3NO6jFqKADrWI1u9rdlrayEkqjnGP0q09X+TBahEitYt/4qc0wv6Mkh+IY
         CYjaISmz0E9fMMDVLtU5IOtHuw6PIzaY5xyng/iyKbZOGcm1o1Mn0iSlurtGmybU3xeG
         Ipo0e7WDRlamYylds0/BTH36xprVdKC5NYtve5lZf9ycL7rI6XHKm+FXpwl+GcxY/xUG
         B6Hl8Mem1IMFvLP0pF82yzWA7RtKLEPpVcRj57d/MvBe08UKtw28WQdWsrYRaTd0rY+T
         z5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795852391; x=1796457191;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I6F7fyba40vxm63DMQHXtQ1bowNzrEeJBKnwEQreI5Y=;
        b=LqwIJkvqvPYhU54M+6Q2kHfFXKOWR4fKqJ4fdnVOahtmHveDA5CDR6OpENafTnMdDt
         rnZKKTzAwc0SyzQDepiXBwjSBsnZ680AB3mcwtaH2Z400EQgeXQPQJpjdLIV0IoKwuk1
         7MIiU+RwmRWj21iOSOnb5SVIO6nnwXguXfByp5fzpiUYdr+4XF641EqpuoVccv00CKRS
         oqYq3J+AH7mO/rMDpj5//x7R9dgeLhaXt/zgN4+edldkJyszrtqS8Gn2Z76LADlJpLvX
         FIGms1Cda5giQHgqjtMRdE+AYmWQmpJkNFWm4etyQkfgm80NAcIIURhSeT9rhWROQ/B8
         /jzw==
X-Gm-Message-State: APuU4Z8MEX19OyhhS9CKAunDsVP420vd33VKrL2QEvrsuxCg1w/q5HD2
	aGdXmjvxh/C+pgueaCGgfYnOpjH/jxqO8MzEwFQ+gQyNH2mKSXmPex/vEdfpJ90i
X-Gm-Gg: AZFdTZdDYGAsb/CwS/eVRioKWY02Ap1WpyGzfkD0cPA1RXCj2vPndC/hbtQuLZOvpuk
	bbV5SmVNP4v1yA7Iu+OR0GC6iQyy8B8O/JoeCTz2uLWScsnUEKFzW4/hXTKE1/4d+9QoWikBu9S
	EwPLE5pv/ZvxLD2A/ezhq4jW5c3zxfbZuaf+Rmu+t06wJZvxjABw2EragPIJCQnrZ2Q0sXCYxPg
	FYK739zSpp+SurOGpEppJ9G+alXq2WRlL2+RKSjGTEWC44OO1dmD42imozJsH0EXv2Nr8bGf9t0
	xkO8ZRw2khzo5lqmSyE1unmrpE6ftlXyV+NQVYOg2DYRAI/GLCgYtkUA9Bi4t2+UE4ZUrNQRUQy
	32+MLZXoTCSIQK2Gz3y8q5OYHNvNQ8R9xdNHYARQuLg2mWMWviGMq68LMdP8KW9Zp2e0qijGQpz
	a5jIPS4/y1yEuDnXc9BApEC48EDYj2CBYq5zS0cLNvIMVpkLbq1bVqm+ONdBqb/DTiLYcfE2hPk
	AcgWxHkY9Uozk8IjPEeP35BdqwGbu5Z5KQ6kBqqbgzvjU8ljw94aud8hkPLsY+UJQN+MCTiBodB
	qQk4wlxMmjlmjs9cWDzWPalPgJPQWeMQ92eYOT3QiZXPkwyVbsUuPA==
X-Received: by 2002:a05:701b:2514:b0:16a:c6f2:60c2 with SMTP id a92af1059eb24-1b55689fcb2mr24372913c88.12.1795852390934;
        Fri, 27 Nov 2026 23:53:10 -0800 (PST)
Received: from ManojLaptop.localdomain ([49.37.151.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b556840494sm62683593c88.12.2026.11.27.23.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 23:53:10 -0800 (PST)
From: Manoj <manojkumar148700@gmail.com>
To: git@vger.kernel.org
Cc: kaartic.sivaraam@gmail.com,
	Manoj <manojkumar148700@gmail.com>
Subject: [GSoC PATCH] pack-objects: use Q_() for delta thread count
Date: Sat, 28 Nov 2026 07:52:51 +0000
Message-ID: <20261128075251.13852-1-manojkumar148700@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The progress message "Delta compression using up to %d threads" is
marked for translation with _(), which gives translators a single form
for every count. Languages with more than two plural forms cannot
translate it correctly.

Use Q_() with a singular and a plural form so the right one is picked
from delta_search_threads, as the "Path-based delta compression"
message in the same file already does.

The English output is unchanged, as this message is only shown when
more than one thread is used.

Signed-off-by: Manoj <manojkumar148700@gmail.com>
---
 builtin/pack-objects.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 87c3102e62..c33b075c77 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3227,7 +3227,10 @@ static void ll_find_deltas(struct object_entry **list, unsigned list_size,
 		return;
 	}
 	if (progress > pack_to_stdout)
-		fprintf_ln(stderr, _("Delta compression using up to %d threads"),
+		fprintf_ln(stderr,
+			   Q_("Delta compression using up to %d thread",
+			      "Delta compression using up to %d threads",
+			      delta_search_threads),
 			   delta_search_threads);
 	CALLOC_ARRAY(p, delta_search_threads);
 
-- 
2.43.0

