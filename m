Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7235AA685
	for <git@vger.kernel.org>; Fri, 16 Oct 2026 18:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177044; cv=none; b=pTzIQxQ/VYRh8AxG2vqRoQFuQF939zSKUd/V+L9QE39tCqA/ttvFYbeHvNPyKtRC/zX4pUJDadzvJbn/SEJScASM/QkiHepkzCCiJGR8pq3U/btL/v+IaPL/VI+FnmhuzGMFWEEw9YvehgjDab2DdhPqlEShNycIcSWyvMY+kUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177044; c=relaxed/simple;
	bh=OwQuv/0u+viVB/qHSvQHt4/5RfT776HP8R82Sq84ND0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EvVYLOex1lQgpF6RByWpDDMrvuDP8D5gkBNnE574bPthr/8r28hjAfW/P6S5179IF+E5IN2UqM0mMENgp4TBcMJcTmHcYWjJXBVbyglZPbzg6pdVUM5NpCt2/aLYoTHn62GPrGAL16DWgzeHRc2ItYPd6npBhymkomyFD8/ThxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aay0UO2W; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aay0UO2W"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a021c809e3so3027675e9.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2026 11:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177041; x=1792781841; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/5iRv9NOnzbljdyaosDgGBcQrXQCNrNOssbLjDf7+v4=;
        b=Aay0UO2WJn6XljeK65vmKz7x/+ERhWhl+lB9692tnVloijYgRk9fLphVFaDxRM55mH
         nnqoH++3HSMX/4jamDhVnXmxJHrfwcBlZj8wNmCxmcsPO1pNlszp4DtT/8VT+DhfLVdX
         Ui/s7GYkKtYfi903Xpx4AZiXe9mYP+Ab3a2kqWIlAMX6B2HRGrt8ifiDRx/Bid0Y06aJ
         mbQckcZUMsf8pmXbFP1hVUfRTh1efBiLx9FytUsLVfaSBavuXVQRDPZsBhIpDheNY2Og
         2zmPAitIQoURZ46ygBH2qpZNPhPtoJgk0jEzZK0d+PG3MeKkqQGz78oUvIsREAdQAfWi
         m/Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177041; x=1792781841;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/5iRv9NOnzbljdyaosDgGBcQrXQCNrNOssbLjDf7+v4=;
        b=q/4J0JWFHwTRlxSC87ge8up1ePxZb62SNb1CHgqDT8n+hKnVUt55id1sHYJ0r4MUx5
         NQROce7m5q92JaGbHr9jhPO2c5uTLXCFJWStjT6kK0fZykHNbfLb8HmFuYr5Xa6R22R2
         MbhJfFIvUy3H0903wFjNwBMJWaFdOoE64sCsRqw5vZmefBtBqBJxjV6R451XptWUawMl
         z4JsoqoVmPEd5d4xzRAVK5qr6hHVU8oaoDg38bNF/IGQPFN/I/Q/Nr25Ok7rGpFSuWWW
         J91GEO8Udnhzca6NiKhDl6VS91H1WmfHREyWnwTMMJ8J36kcHW1zfY5HOP81D9DMJW1D
         ZktQ==
X-Gm-Message-State: AFq9FYJQbvQghBlpvwcWuy01whROD5OO4An5qG23LZouLZT5dAIGIQOx
	bbfbOkoYADS24B2M4BdurG7/l/V/TdmkETObJzG8X6lzHqDOcgDx0P4A
X-Gm-Gg: AYBFou2IcP67W4iDpsc4QyHYD2kWJsHohX6NY1zmDjrteESd4Tsz1gScI8nUcjtSVjn
	B98bDfOYLU5BGmqc6vbTugkYLw2h9mldiC8EnEF5v9r69mvM/DQAWqDH/+j7ZvUR7QVOHqV8LTS
	+Fp+MxY1zUTJq6F6HTXUl8TI94p8ccmBnD9dmoW+wKRxPsHAP9bgdS1nwBW+jC6/9614k7wK7mO
	qDwN/H3NGi6R0/byC+Ku7lAf8YOP61jK65ISTnyV5cm4F2oiEYDpwiftlxifHAIn2eH69KMbWs1
	aJyO1O2Cz3DjmCJCeX7yju7spw701PHj9dMogX/kCQi9QuKPKhMtTaX0pAn47kbOyTwNNAMQz14
	Sai1bAhJkVFyFzp2kkpjYjwrXFn6wm1S+W6Lj/iYPAOMUfzhfIa/2Y8KjI1hkz8D5f189nWRuTG
	ArTxlu1YG2BSWQY+G66t7onfZC3hM4gefv/zW8t/IUpryCile+ygZTmEDGUub62bKsvYz6V9B2S
	+6MJgz/rvLZ87PfmIIILAaPe6J8Vn0LtNaePb8qnWtKrhsowDly0tZiFP+xc1lGbS34ZuFql8JS
	GYwhzKkFfk48SWoDHOZ0FZXBwhg=
X-Received: by 2002:a05:600c:3b1e:b0:49f:fdca:c361 with SMTP id 5b1f17b1804b1-4a1d75f9341mr18278535e9.12.1792177040997;
        Fri, 16 Oct 2026 11:57:20 -0700 (PDT)
Received: from antek-thinkpad.home (217.96.148.114.ipv4.supernova.orange.pl. [217.96.148.114])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ad6252sm106978665e9.5.2026.10.16.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 11:57:20 -0700 (PDT)
From: Antoni Borowski <antekborowski11@gmail.com>
To: gitster@pobox.com,
	peff@peff.net
Cc: git@vger.kernel.org,
	jpoimboe@kernel.org,
	Antoni Borowski <antekborowski11@gmail.com>
Subject: [Microproject v2] describe: do not translate --debug output
Date: Fri, 16 Oct 2026 20:54:18 +0200
Message-ID: <20261016185418.162998-1-antekborowski11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <xmqqpkx9fq8o.fsf@gitster.g>
References: <xmqqpkx9fq8o.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The --debug flag is aimed at developers debugging describe's search
strategy, not at end users. Translating this output makes it harder
to grep for known strings, compare logs across locales, or paste
output into upstream bug reports written in English — all things
developers routinely need to do.

transport-helper.c already follows this convention: its "Debug: ..."
messages are plain C strings with no gettext wrapper.

Drop the _() wrapper from describe_commit()'s and describe()'s
debug-only fprintf() calls accordingly, and prefix them with
"Debug: " to match transport-helper.c's style.

Signed-off-by: Antoni Borowski <antekborowski11@gmail.com>
---
 builtin/describe.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index c0abc931a5..775f9f27f1 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -351,7 +351,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 	if (!max_candidates)
 		die(_("no tag exactly matches '%s'"), oid_to_hex(&cmit->object.oid));
 	if (debug)
-		fprintf(stderr, _("No exact match on refs or tags, searching to describe\n"));
+		fprintf(stderr, "Debug: No exact match on refs or tags, searching to describe\n");
 
 	if (!have_util) {
 		struct hashmap_iter iter;
@@ -419,7 +419,7 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 			}
 			if ((c->object.flags & best_within) == best_within) {
 				if (debug)
-					fprintf(stderr, _("finished search at %s\n"),
+					fprintf(stderr, "Debug: finished search at %s\n",
 						oid_to_hex(&c->object.oid));
 				break;
 			}
@@ -477,14 +477,14 @@ static void describe_commit(struct commit *cmit, struct strbuf *dst)
 		}
 		for (cur_match = 0; cur_match < match_cnt; cur_match++) {
 			struct possible_tag *t = &all_matches[cur_match];
-			fprintf(stderr, " %-*s %8d %s\n",
+			fprintf(stderr, "Debug:  %-*s %8d %s\n",
 				label_width, _(prio_names[t->name->prio]),
 				t->depth, t->name->path);
 		}
-		fprintf(stderr, _("traversed %lu commits\n"), seen_commits);
+		fprintf(stderr, "Debug: traversed %lu commits\n", seen_commits);
 		if (gave_up_on) {
 			fprintf(stderr,
-				_("found %i tags; gave up search at %s\n"),
+				"Debug: found %i tags; gave up search at %s\n",
 				max_candidates,
 				oid_to_hex(&gave_up_on->object.oid));
 		}
@@ -565,7 +565,7 @@ static void describe(const char *arg, int last_one)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (debug)
-		fprintf(stderr, _("describe %s\n"), arg);
+		fprintf(stderr, "Debug: describe %s\n", arg);
 
 	if (repo_get_oid(the_repository, arg, &oid))
 		die(_("Not a valid object name %s"), arg);
-- 
2.56.0


---
v2: fixed commit message, no Q_() was actually touched
