Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793219685;
	b=s7PkX39LtKeH3iTFRp/IFzvdDs2TybisZvzW1sHz/EJ3gZpuxEpxVfdJuWy7mFqluwW7
	 U/ZWJXA6AFwzVX/0FpbUViykAIpI/FJCoHly4p5n8T5kppWjm4YAz7Dai8OZsFiTaY1Iy
	 Vk03jGa07E9h6aVenYNWBXPSQw4xHkT/a5jPaLg0V3ijHHcvT3Zp+VPLqSTxc19VB76PH
	 wT370zdKpEgWZZM7sQ8DUUlqmWkwqAMZRBxuYmqHHMjMUK4nBy4E7FX3VqDA9yBg6fHmH
	 pO29RiFbK3W4rrxZjaFXrrzKKbiXgfGX9UOnhF/L0aP6bibUPVutK6LNrQHUvoMJDGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793219685;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Subject:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type;
	bh=WlFiPotmQFP6rxVUzej3Sv+TgAlli7XioVOhGF6SusA=;
	b=gSIC4uPJ7D+x3WejFb1lGYbWFb8k505lv3bu/aOGy458qKhcY785h/MyN/gFB/nXVcM3
	 E1mS3/xhSI/I9aq/e78RuiZfIUD4VxhQSaFhEGxg/em14+BtU5BGGxNCX4VCS+9QEy+xP
	 jlwJk81l9SR/h178MKT+o3izQWFlr4Ca+n3Y2WWGc/NCbMQcqrNN0o4VBpW3OeS6opAfv
	 iQSrpmcFGj12myK1bj5rI0HokAjYNPECKxGuFVbYaFyl5lxBsiodVetuyqbGERYNxrc/o
	 BrW0ivx/XOf3iQmZpl0OdkXu5qFQTrIj5RN96eW3dvSXf9DOkFZLX9rJBncLMSGhNyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NsUVPgcq;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GVo6hArs;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B28E606A31C
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 20:34:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B28E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm1 header.b=NsUVPgcq;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=GVo6hArs
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C20D1400076
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 16:34:44 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 28 Oct 2026 16:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1793219684; x=1793306084; bh=WlFiPotmQFP6rxVUzej3Sv+TgAlli7Xi
	oVOhGF6SusA=; b=NsUVPgcqc/oKsj6g2iNOXlADKGhc7nDAGon/XpN8Kjx9R3l1
	ayUM0jY5vJft+hfAUHbszvn0/XV3wUreBT6iM6PKWUL6J6Vw++fiLQrUSRZdPHAO
	+eHiAqyR3jeajq0euIF7up0Wuf7u6FG/5WlltiUyCS+d3TsbRnMUuZUh7faNc/sS
	2nqpvyXF2v1ZIxhCPhwYE8H7q8YumOVdVBH+JbDVnU2bEsPPJUvY4S6JVugdrpF3
	pbHd7DK0MR3Pg5jGaVIaSo7RwpWNNw1c1elmNw9L3hggXsZl2wrD8qgYWVWvJ5B1
	ZrgClRxRZJrURiffg0dT4HEYest84SA/D16oTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793219684; x=
	1793306084; bh=WlFiPotmQFP6rxVUzej3Sv+TgAlli7XioVOhGF6SusA=; b=G
	Vo6hArstiYvQ/57MeQG6+72IOaDYFRI3hiYu0MFGrrunS90Ter1sj3HpLcOmKSY5
	4iZRkd0dW3n6684RI3nY3SXcwwqtCAHshT9ziXpPkUYLry2aE4RNSkI7PFBOCIt7
	4qf9aJwSry+uQItNWxD3w7YTqEg4iOUCkm29pWK+2P6+bGAWo4vcEZmXS5xlujy1
	aPLHnAwTBLXyqEyj/9Ayf38evgaY6OgxX3sSavnzjxvlGO6gLUDTUukWRe6RfLIi
	6fp0bcUvjX49yUwqyJceIjXoS5S6MYev3XwS+sncnoj9n+1L7g9OnPDAeuK04XWV
	yoJvU1D6aHwke1v10ZfUw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793219684; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:gLlyIpMHCNr4m/DLuETGvt/j2w4W++Xx7eErQRqJhfzZ06h
	bHvaIBJCY14ZNK9cK0IUJ3uyBxV113X9vzUnIBX9uBhDYzyQ3CaQB+ZoTHMk9hta
	SkOmwq5ER5E7Cn1cWpjUAvDmTjqd60esh6Cx0vrN7H/dKowQoZw1ONpA9dOCSKmm
	iLb0uf5P95Tb+Lts0BJtelRvgmBoa6AR/t+wYhZnr3H9mwHDZK2htlsYIxE5kTG0
	ZgqRHZ5CGimbZkq9xL4aIZJBGYh12VPtZtMOjK1jYBD96sGxkzCVC3ywMhIA3avz
	HkQfVQQo96xSN6flkX7UhZ4j9rlJIRQ98dk7emg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:wSjfjEkZiIcv1Sa22yTaQkz0GHAvO9G/3UM7z+IgooU=:O5jntxhuVlA5LWyqPkoeeth+J3fOGDtwUHjLb8mefyk=;
X-ME-Sender: <xms:ZFziag-hSWiEu_ZhsKekFPCUtbhzXqSRvBmeudVu0XKtvktA9iS6IQ>
    <xme:ZFziauusdOJdWC0uiJ5r5QhacjFRJbVcPGy8O54FY2pJHcyaKqV85I4DBMZBZdca_
    WSK47jLLVrpY4Ap8wsqn0E-oNn5f3ZLkTMYAnakHTNjiQg0QdrLkhCk>
X-ME-Received: <xmr:ZFziajq49aUmAiTPrzWijjpXZAF4ZrX_Icz4rzQvUXlVYFA7qPMKj4M5qqQyknuqGsuswow5mjHIRaXfCvbFBBR0egjhJQAXhjPf>
X-ME-Proxy-Cause: dmFkZTFXmUHVZZMlgrlPC33BLV5S9clz6WRe9x3tfa/2+NnobX3sq72Ys7u6wvAC1PoT9J
    SnwJuD2Uk9r+tNcVX9HMNC45CRVsIZhPizsxuCkdbszuCyemYJ2agRXcP63dyE+W7vCGRG
    hZmDZAFhAKPdDxq2v1TcxWedtBYMfK+F1L98dt5M8ZkAu+KgFc3rU9q8UqC8whGorWJPAV
    R8ybHgeJ/Q56g9wk8RoBt+RaBWO9j1+g3xGCHkz8IfVJGCadjRKUtpi6kJUg0FCTEmGXl0
    x/6jb6VSQIzbU+YMQhJUMgbAtKN2m7eEMclxPWFRipkEVCVlRYY62Zi28/A+tzjyeh4LQ9
    UihLYGBpJw4xig/t2ov58aSrQ+NW4ySlklekBg9TFhYLFswfRC18afvNNsqF9fsuYalajo
    KnLc+tsNVnq6JhNris2/5Q5QIOXMerQpmRwkHHFkF/lEYuOOWtJcQvVq63CV5m/iKlmUGY
    nSDYoZd+sWLNB3g6QoNx87PZOu7WBKTgQNTFCZjf99R9OrycCbpsTncrtgqiNYGkp5R+qm
    uVV4uG4MwoqhIuEkkQOn2zDLGyrJK2d2d5T0OzOwlnwcv7m9qNHfC3g4pTj+sMWJkY0qxu
    pc9XvosxMxnyfwDRRnU+EEFuFeVwrJIn7HHDFMh/KdZO+8K+N4wQGF1oTPcQ
X-ME-Proxy: <xmx:ZFziarnVdbYC5maEV3GtF265XKGZihKUPTGLXV9MISH4x_imRcxVmA>
    <xmx:ZFzianyzguz5Ra3TfNK3OIjo9gGXH8I7iZe2LJajHHE98wb2yhBPNQ>
    <xmx:ZFziajm_z7xZSqikHW_MTbMhF6nJ1LGQonv_WFlVr0jiSv3L4grMfw>
    <xmx:ZFziagdUYpzcx8JJ6fqz1PDZ-ZDuWaNQb7MZ2q_ujxfHqSs1vgLdDw>
    <xmx:ZFziasVi5-R0KxIgZKJlhh_Ji_cUmnjUk6q9Zs-FBcqHhFnG1Nc-rqxY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Oct 2026 16:34:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] read-cache: hide refresh_cache_entry()
Date: Wed, 28 Oct 2026 13:34:42 -0700
Message-ID: <xmqq4ie58syl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Once upon a time, there was a merge strategy called "recursive",
which was added in 6d297f8137 (Status update on merge-recursive in
C, 2006-07-08).  This implementation came with its own machinery
that creates an in-core index entry, and then refreshed the index
entry it created by calling the refresh_cache_entry() function
borrowed from the read-cache.c API.  refresh_cache_entry() used to
be file-scope static, but was made public with this change.

When ad45b327c0 (merge-recursive.[ch]: thoroughly debug these,
2025-04-08) finally removed the entire code for the "recursive"
merge strategy, the last external caller of refresh_cache_entry()
went with it.

Hide the low-level implementation detail again by making it a
file-scope static function.  The external callers would indirectly
call it when they call make_cache_entry() or rename_index_entry_at()
external interface, which "ort" (the successor of "recursive") does.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 read-cache-ll.h | 2 --
 read-cache.c    | 8 +++++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/read-cache-ll.h b/read-cache-ll.h
index 066dd8bc3b..dd30befbb3 100644
--- a/read-cache-ll.h
+++ b/read-cache-ll.h
@@ -475,8 +475,6 @@ int refresh_index(struct index_state *, unsigned int flags, const struct pathspe
  */
 int repo_refresh_and_write_index(struct repository*, unsigned int refresh_flags, unsigned int write_flags, int gentle, const struct pathspec *, char *seen, const char *header_msg);
 
-struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
-
 void set_alternate_index_output(const char *);
 
 extern int verify_index_checksum;
diff --git a/read-cache.c b/read-cache.c
index c4cf08a3a3..94dff890a7 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -129,6 +129,8 @@ static struct mem_pool *find_mem_pool(struct index_state *istate)
 	return *pool_ptr;
 }
 
+static struct cache_entry *refresh_cache_entry(struct index_state *, struct cache_entry *, unsigned int);
+
 static const char *alternate_index_output;
 
 static void set_index_entry(struct index_state *istate, int nr, struct cache_entry *ce)
@@ -1624,9 +1626,9 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	return has_errors;
 }
 
-struct cache_entry *refresh_cache_entry(struct index_state *istate,
-					struct cache_entry *ce,
-					unsigned int options)
+static struct cache_entry *refresh_cache_entry(struct index_state *istate,
+					       struct cache_entry *ce,
+					       unsigned int options)
 {
 	return refresh_cache_ent(istate, ce, options, NULL, NULL, NULL, NULL);
 }
-- 
2.56.0-433-ga9209adf11

