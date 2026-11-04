Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793813728;
	b=A4aRpuJTrd6kr4RZm0nQxYn5ooaZ44cLMAKrQV7oUp2aHXmO75iK1sLFcyUR+IPpfqhF
	 /TiLIziAqL0YAyDeyLmvlpOdmx+/wz/vXXHRaq6kNoLos01gup3h6rSsTHt1gWfQPUwuN
	 42C5ot1lz5EPAvJHZQGWmJN5O12dKKxyhEe8Y1S6E2nFHFbNfNs8ELC9sximL6Utg34iT
	 0Bh6qQB6l5ydOph0Zb0T3OI4n2gOH4JK6KEmcnQEov/0M27b3C+WuAU6QGy4fl1GegA8C
	 3FqOxbIFxf+ei63QATOr31ooOewllw/bw4BwngtBnmOZvg1n15Od5njk16I7p80xV8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793813728;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MWxU772QEgZ77rLrt8/Z9zPkSkT0wBeHPiB0sLfzebc=;
	b=hDcH8T+R8HNFG/IJVFM5O9LjpmAnrAqo8z8yt5ZK7SFNQFze/UFJPpP28e8Xkj9Qf2ab
	 nylgMl+VBDMJupfEIkRAfskZfwEIfzo14p8fikyVuTDn+Fn3R1PDAyy4yqWRV2+F99xkg
	 oW6jzy44YdrtgBpCp8u36pra57LmvTqmOZTLH9XF11j6xwI+T+bWR3Iw1b/fda+Aa6cBk
	 jwfvvz3CdZVuJ2AceZppGPDLf4ne+jYVbH2eb8R9S/9uGT+5ajSUqHoaqGjq4xTTnjKRp
	 nEB/du+sZbo0ABHLBFswvTfp2gy2z+Ptu+XbG/QrKRP9+nnAlx7JYj0anuP9Rg9RAVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG4alMrN;
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2CD606A329
	for <git@vger.kernel.org>; Wed,  4 Nov 2026 17:35:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E2CD606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pG4alMrN
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so1043171c88.1
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 09:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793813727; x=1794418527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MWxU772QEgZ77rLrt8/Z9zPkSkT0wBeHPiB0sLfzebc=;
        b=pG4alMrNeu61kXteo7AjUAUehxGLoKSSPJnA4qeIU2oywEcI0kse9ifyeCV1rgRKHr
         EhK0+jfuY7kyv+7gGtymtYma/8Sf2h+haaPbCL6I7MTk38p4u9Fqyn1FpxMWIeiCVsjK
         mvWP2sVx7/xEhmx3HEODWq1iJMaip5iCdebVb3aRt2AvnmbSYV+PwcSt3q4m+eW+Fyc5
         t63lVKRr+8+hfPkb4M7nQQjR27tJON8WBuUjG2xcYTmEZGRBFsm3tPOyRwyroUdaEVsY
         +yU7aONyT+sBDsWBgW4YJ7x9hBY6IuVB8NPzZ7nRWBOVaWcu/MzxjqKe8uoE6lSs9cvn
         TeJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793813727; x=1794418527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MWxU772QEgZ77rLrt8/Z9zPkSkT0wBeHPiB0sLfzebc=;
        b=QZ+xqKZkMElmTeu0CyChLuhniV5ivfkGyWwn9mON5NsRc9eUz6gZUDi4BzgIkCmrFV
         T4npDa9SWm8X1QakQ0mMh6bCz+9vynbyo94GLJH+MMwbaENWQGhpceqrkxNklB11aiJk
         Rs6EY6U3CIM3abS49S/FUL8p3WSRYyIUPoW8UPEP2movGwf5z/t5rRIUml3drB9n29TA
         UmFilME/CaQUBijrdIS+1m0XCShjTZSVI0ES0M8lyDh6lpETn1hI3QCOIVGdbsy0Q4Bj
         DmQuB2WMET5Zwc1Z3DaLSgfvNbApegO0TErDSE8bNazplyMJuNIJilo4ibR7yoh5Y3II
         V/Lw==
X-Gm-Message-State: APuU4Z/R+xPadIq+rWBGGu3FVwYCmERFUYubu25s05eTGcaTaEz3Sjgt
	BbxlQKJtyei0Z0glpCE9cvW8kL7YA3y4Fk+QIjjqgaP83BAtzR8P1sWzD8Enag==
X-Gm-Gg: AYBFou3uwWvcjFJq1RrCOpSQcEMBHG6NeOrjIMQlYMoJd8Tf8c65M1qL3SmY97JNMIh
	2vVfPlmmCHrh/yjHir7EOaI88Aac/FvIQj3tLETw0/VnzqNZoLXZqGaKmWl/jdi9n5EdrIqQ5iT
	HduxmbT4LsmKeyP48C/8280oDy/1X+0h9ZiGhpzCqzRFwq2R9xRjv0LdC1iDHludVgFfwopBGf3
	Yy+C6sJuFr7CkrszbIMzEoYv7AFW6P395r2THjBmkcLO/V3DEFBzB0ppRYBovohPcye527UmxSV
	tdNceW1lxZrz96Fg2pDM2vfs/Z0EXt9dWSa7IHkyVOanP6Y/1fV1oreJh0lPZAZ0rgFfhLXRwaK
	vkBAU72/6FLpcbmK19cuTLjcbyCdmaN62GF0hhdnWWSD6UcN0BlJqnYWrS4HYag3+RZQPt96pHf
	hj+T+NE8Nulg2gpta+twIaJDOP8edk+w4uXOC4/WyZUAp9ko5gmDiE7u55+qu2oWGftaKOpJGNw
	ermsMvJMH8T16OEmTKVkrVMpYlEksRclHCHQHY8bk1MXbSG7thNalfLw/XsdV1fSTU9mKYyu8mz
	2JiWYimFyy9tdTga2Sk72RuqKu6QRL0lAUhlzYI6oH6Xq+aK/w==
X-Received: by 2002:a05:701b:4187:10b0:16c:ff3a:d72e with SMTP id a92af1059eb24-1ac5e322fb7mr26622062c88.20.1793813726545;
        Wed, 04 Nov 2026 09:35:26 -0800 (PST)
Received: from HP-V15.xu.edu.in ([125.22.10.135])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm13520264c88.17.2026.11.04.09.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:35:26 -0800 (PST)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	mail@thomasbachem.com,
	ps@pks.im,
	ttaylorr@openai.com,
	Pushkar Singh <pushkarkumarsingh1970@gmail.com>
Subject: [PATCH v3 2/2] maintenance: trace lock acquisition failures
Date: Wed,  4 Nov 2026 17:34:22 +0000
Message-ID: <20261104173422.20725-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
References: <20261102122955.143018-2-pushkarkumarsingh1970@gmail.com>
 <20261104173422.20725-1-pushkarkumarsingh1970@gmail.com>
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

When git maintenance run --auto fails to acquire the
maintenance lock, emit a Trace2 data event describing
the reason for the failure.

This makes it easier to identify cases where automatic
maintenance is repeatedly skipped.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
 builtin/gc.c           | 4 ++++
 t/t7900-maintenance.sh | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 9ca9a3584b..eaa0d71285 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1410,6 +1410,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		 * recursive process stack. Do not report an error in
 		 * that case.
 		 */
+		if (opts->auto_flag)
+			trace2_data_string("maintenance", r, "lock/skip",
+			    strerror(err));
+
 		if (!opts->quiet) {
 		    struct strbuf buf = STRBUF_INIT;
 			unable_to_lock_message(lock_path, err, &buf);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 3288efb391..294ab0db75 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -411,6 +411,15 @@ test_expect_success 'manual maintenance with --quiet suppresses diagnostic' '
 	test_path_is_file .git/objects/maintenance.lock
 '
 
+test_expect_success 'auto maintenance traces existing lock' '
+	test_when_finished "rm -f trace.txt .git/objects/maintenance.lock" &&
+	: >.git/objects/maintenance.lock &&
+	GIT_TRACE2_EVENT="$(pwd)/trace.txt" \
+		git maintenance run --auto --quiet &&
+	test_trace2_data maintenance lock/skip "File exists" <trace.txt &&
+	test_path_is_file .git/objects/maintenance.lock
+'
+
 test_expect_success 'maintenance.loose-objects.auto' '
 	git repack -adk &&
 	GIT_TRACE2_EVENT="$(pwd)/trace-lo1.txt" \
-- 
2.53.0

