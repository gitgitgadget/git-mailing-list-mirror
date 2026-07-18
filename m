Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212E736682A
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 21:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784411422; cv=none; b=frZZrRUIxMvIxfdbPS988DrEYuJQRctu2Ucac/N+69m1+wbLWV99lbDDKk5YOSJmvlFLGcv6arMu1rubFuUeeh4KCL8pgMzr8zKEzfCp77XKrmTJfymsJ/tzxGeWqzCSrGEm6PUzph+iBE/+Bs2kbeJjkWEG3rIoHp3ZD+ge8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784411422; c=relaxed/simple;
	bh=GnUJXHZE790eQnLxUVyhpOxXpxrPVS0DpL9MT6Xb1Ag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fY1yoT5jTqOJPXfM9O6Rud6fqDY2G9CjQBGqRA707MqcrMQNBcqNr6T4+VUoDPR9w4W8l7ikxzB3zLO8IDHutYZvVxSq5rnYnded7zcZJConMFsUPZasIdwZYJEt72oEQ76p72yPbVan0CHfQbhfKfaRW4eA/tICVEhtVOm6514=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dj6PLWP6; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dj6PLWP6"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso6787705e9.3
        for <git@vger.kernel.org>; Sat, 18 Jul 2026 14:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784411419; x=1785016219; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=dj6PLWP6rvhkjbtQ1VBFx27r1mguTTew8YJDq0X+Fr+DvJkmhzTx+iDac3PwLM49Nb
         OY3v34QB1AJfetfSwPzIhNHdIy5bFe5Ao0/yfBdo+XFSIrfImdalmbC1esdCIJLhH+u6
         ZBZ7ZbTU+nrrwAXh5Tq19PElcMCJtBXv8YAG5iEQxyjKcKz+DvahkQbLHQjS+biQyKWO
         rqfOxPoeXDjaT+fhvfeSAuw3D0Dy/jHyzYoxJe2HzxDnBEEUa+6VxX51c5OdvdpLIsbr
         IeqL7uP/6AJPAtwm37Nn2NiZ4uutykHfzDtbT6+iYAzNNtsGVyQAsmd/LVcTJvsiAUVJ
         WICw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784411419; x=1785016219;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6wXA3r8XOJMXVM4IQaZkcMiiWJEnDFhSXXWQcDmyLH0=;
        b=Y/OeZVLE+fzG0bHREWdK/LprYUMEZMJj08pLJeDhYcOhLOLnbWyMPVQH0qhrdNPf34
         bljmsSmVFB3tweBZYEO3RFcN/mwiPVqxT2IErBh7QUUIlxyacxxnSbJ87ubswq5qtIkW
         Hq9QDN69aBECQbd6AAce0IO7SNkOWyKnY4YQc7a1jxE7nqPBe7kHn0Xk95FAxLQ+etvn
         cN+no5qotV3VjJmnsalFwm5bZZlZC3KIbXIKcOy/+I3B6lyqi79SR6C0eBhPK5lceh53
         +4AxgLqwvgJ4cnPxzP8Dx2sG5Y6cbR/y3u+jz9Gf/PZARysZoDBONkRkEvneL0Jovddh
         Ujwg==
X-Gm-Message-State: AOJu0Yz3CcafDxkRWgv0rBQpBfQ7Us+If2Hy1btadKEFMuSAgfLGyy2q
	HSs/gbe9/CJXvriiGq9HjERIFKsVrRYDlTzJ55xUCkiLJ0ej55cWH0PtBLg4JESC
X-Gm-Gg: AfdE7cl8Ue9W4G3WHsWbra3pMpgjctaF5pO8FMDayfBtpm+hs6fPyeuYaTvpiUoj1A3
	xfzo20XLR8Zy+vS706qmDUy+fcJjjsxCoUQdy2pmUqfgz4dSNjw06ZE6+MVLqIMy9Z7Jxh5QDYQ
	UKMHIREl0SBJf16jVGuP1kymGQD2Pj6gP9Fd8PETEqZrQ90/ar9qytDPxiBv+pkb21KSMolVNhu
	Ah+gV9WwANfCKaOn0nUhJdgjPHfw/ukOkYeNFjtFydQZayYFi7w+t6Y/ePOd6gxyq8Np6Sxhcui
	cIt/UP8a3655vAF9unyjM54i0l6npkZQJubNCdRWw9ce4dcjJ+jYKWCbEhLhL21V+PuOGVLCD4p
	vZJOnMdjYYng98LP6GqCvAuJOvFV13WDxnsG4adK1wCpGMwPVinZHBFK/aR4auvEoBMHm6JckT6
	rbv9MS8PB5iIdJakw4VQq95LfbJIsSEjyIznNORG1RDEBvNTN8q/Z7fxJKAuhy1gTkEObJISTeF
	qTCPODBmcbAxHmZEQVY9eEUlwbIm4nxTs9Ffacu8z3VP4IRExSMQlqT1FUeqAMXvvqEQILHjrqM
	2QDpe2yuLYX+3CNPLLkxUUfX2d1m5Pas
X-Received: by 2002:a05:600c:45d3:b0:495:503f:cf9a with SMTP id 5b1f17b1804b1-495503fd2a0mr41241675e9.9.1784411419263;
        Sat, 18 Jul 2026 14:50:19 -0700 (PDT)
Received: from localhost.localdomain ([47.58.6.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edda2sm146225145e9.13.2026.07.18.14.50.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 18 Jul 2026 14:50:18 -0700 (PDT)
From: Pablo Sabater <pabloosabaterr@gmail.com>
To: git@vger.kernel.org
Cc: pabloosabaterr@gmail.com,
	chandrapratap3519@gmail.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	gitster@pobox.com,
	jltobler@gmail.com,
	karthik.188@gmail.com,
	peff@peff.net,
	toon@iotcl.com,
	szeder.dev@gmail.com
Subject: [PATCH GSoC v20 08/13] fetch-pack: move fetch initialization
Date: Sat, 18 Jul 2026 23:49:57 +0200
Message-ID: <20260718-ps-eric-work-rebase-v20-8-0c13962ac532@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
References: <20260717-ps-eric-work-rebase-v19-0-d4faee35764b@gmail.com>
 <20260718-ps-eric-work-rebase-v20-0-0c13962ac532@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

There are some variables initialized at the start of the
do_fetch_pack_v2() state machine. Currently, they are initialized in
FETCH_CHECK_LOCAL, which is the initial state set at the beginning
of the function.

However, a subsequent patch will allow for another initial state,
while still requiring these initialized variables.
Move the initialization to be before the state machine,
so that they are set regardless of the initial state.

Note that there is no change in behavior, because we're moving code
from the beginning of the first state to just before the execution of
the state machine.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju <eric.peijian@gmail.com>
Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
---
 fetch-pack.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 3695059cd5..922a9b2581 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1735,18 +1735,18 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 		reader.me = "fetch-pack";
 	}
 
+	/* v2 supports these by default */
+	allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
+	use_sideband = 2;
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
+		args->deepen = 1;
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_CHECK_LOCAL:
 			sort_ref_list(&ref, ref_compare_name);
 			QSORT(sought, nr_sought, cmp_ref_by_name);
 
-			/* v2 supports these by default */
-			allow_unadvertised_object_request |= ALLOW_REACHABLE_SHA1;
-			use_sideband = 2;
-			if (args->depth > 0 || args->deepen_since || args->deepen_not)
-				args->deepen = 1;
-
 			/* Filter 'ref' by 'sought' and those that aren't local */
 			mark_complete_and_common_ref(negotiator, args, &ref);
 			filter_refs(args, &ref, sought, nr_sought);

-- 
2.54.0
