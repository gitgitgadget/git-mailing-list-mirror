Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792425793;
	b=LaIV80G44GBheBQzCJny9uvRaW1zWSLY4lrr8uCOm0mE7fBgoKcszcdT9QyhDnReH9dg
	 g4RZcWP5a0SxlnytrtYdpGxP73/l++yeBJrun4lAem+E5VXYVy2uPCQ8dU6Qg2GdlJhcZ
	 Ffng1vgSb0tzJArgqMO1pL8tTdeX4KPNlBXPaMf71WfzJg7zRCanFv4exrF9uNxa9wrXY
	 HaxS/ljGrh9qlvaPIpuUKx+XYNdIn1wj4cXMtvyfSby7H2ehuW+zjEu1UD2viFEl3/Qqs
	 eN3wwaQ2T8UXebCSPeAwMjbqyiJRctznRT+YJleWVv9yuZnjShcPKX3iUPWcv+zmqFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792425793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pPDzXXtfgWOYmQyHBXeJkuMYD6OYijwKZifBS60yPaE=;
	b=ITnw5UNb34z3Y06LmNzaPtV8XQDJWS33SmGYMF+yO2IieoZNQAYCvsUpBOTEOdHso5X3
	 NQYvUWeXigoOUgp13662QnrIFo1+H1cE8Iykx16etDBtT+FkZAEnftXm+5awXi+8SHKhO
	 VZDSg6Qv01P3BEK7IqIr7ncZHoqZIlfFBjc7wx8rh8KQAzu7nwGeF5mCGJM1rllIx2yqc
	 9jSUruqqaj0qIDVMNuBVEpyX3Z/URG1GwwCMx3/udVf8aWpv+BAeG/CUjlrssDwh5W/wR
	 VNcTp2+PV32F9mbzAiu83d2Plkl5Trk/ACxhRtZvfHda5oIBH83VPzCwXuTg3eH/m9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lex.la;
	spf=pass smtp.mailfrom=lex.la;
	dkim=pass header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google header.b=aeY8dmcd;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B781F60774F1
	for <git@vger.kernel.org>; Mon, 19 Oct 2026 16:03:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B781F60774F1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lex.la header.i=@lex.la header.a=rsa-sha256 header.s=google header.b=aeY8dmcd
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a180fbeef5so17506695e9.1
        for <git@vger.kernel.org>; Mon, 19 Oct 2026 09:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1792425791; x=1793030591; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pPDzXXtfgWOYmQyHBXeJkuMYD6OYijwKZifBS60yPaE=;
        b=aeY8dmcdmjNQhflZHvYnGfE+Fnh/8Z7z/6p0eZoGBZA4dUeADKv083fCEJwPYZOl6a
         bY/KB1AjNgNakqrG1c1FbJXx+3a+mUs3BrEhvRXimeiV+KKfQ86/579fSzPkCC4/3p8r
         FyLnbWOTHECG+j1c5dRcp71EVnGFOH8n8pdQ4sRmaDYZlStkv8AfP0aAwsbPwRuEWaJ2
         8iAOAQfDjPF41t/xvBbitEH38jGMFjFSF6h8xVvlXpmgoWijLWJ0zqTLr5vT0ApHbTUJ
         5E8Rv+y+8LqMGyg52t+US3qKncEGfpJafPlcim1i1CwTt5TOSGqIbMNAD8QsY9YO17nX
         UyTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792425791; x=1793030591;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pPDzXXtfgWOYmQyHBXeJkuMYD6OYijwKZifBS60yPaE=;
        b=gV9rARV/2jx8lti4Q1nW/q/avDOzh9OEzmjGUlxk+kpvsRNPsLxRa4r1EuB69mY19y
         9QY12YGQ8FIAv097BbLx8P88boT2ePDpsaAezkehsvUN4nSRpX9IK+ZuK2KA3ePFIOp4
         5R6xIBsvcsdB1zvujZxWqqyoMYovL3y+UZunXa6zvzmlncEKB59ghWQWQ369zMsUncih
         sq5jRfLnu2xsNReSgf17mRG5ZmAo8NOrrfNmnJzl2Lw8PN040qEyFMAXMz4tAP15esXe
         fOfaepEKkASKruYb8016bNpngAJEkwMu7M+OB619umHRwjHZH2fsAY9aVbP3BGg7jwH7
         oTXg==
X-Gm-Message-State: AFq9FYJausTmx2l6BUxPurqIe4bp1YXlHhjRtJZ5FBgUxUeRR6wWcpJ1
	yOmz9iagn//RIECXHA3J2L+KIWhxeLwiDGDZjzVlg0q2V+sGWJ0tRrsI/Pl7elmmsbftXwms+QR
	elgZltS9hBA==
X-Gm-Gg: AYBFou3tJ5CplBFAs364F1A/sWZkOS/jfOHdDhUYTiWyvzcDe0Qpd6JTvdLLB4z6OGH
	wPL1TRJmVXLYV4TP8zoJVD+iFg7xq9kBCv6sQHfFpK9A3RJHth9UjXQhhO103z8JAYvrCH2rPFO
	0Kw80wm4pxMnhJefy5I1+KLBVzVilQH2Jyzf8WVYOJpqAr0wJbO745PgNejznmEEnpAF9u7R9uE
	/eT0IiCYsyQhurz/bpUPA26OksTHRG5uttI0LdLbmpZS8N0XJfonvVS2I5lEkKFujJ9tOZEOV+g
	OZD295vf2Z/WmDsOvSkJiYGbZs38qAMfKqby+ee0si+jAiKs6zdbM0PRFq+16zWnsQLifNF2aCm
	nVukvicamPzP24yxaUqbCDa6S2f8bhRvQ+J0K7jwYiCsjrRPvtbmS/qeHjzIFuR5UzePVw2LU6x
	2omA8CCcjeFtzcJKN0B6uO2HbR4ojR+NCwrcBhGTAuzwKMvShfg7SVm9Fi1KKgXCQDcCM=
X-Received: by 2002:a05:600c:4f95:b0:4a1:7bae:d80a with SMTP id 5b1f17b1804b1-4a1d75e3c9amr181496435e9.9.1792425789588;
        Mon, 19 Oct 2026 09:03:09 -0700 (PDT)
Received: from ownbook ([195.181.160.195])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1c8ce32absm196503585e9.1.2026.10.19.09.03.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 09:03:08 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>
Subject: [PATCH] technical/partial-clone: narrow the one-at-a-time fetch limitation
Date: Mon, 19 Oct 2026 19:03:00 +0300
Message-ID: <20261019160300.15789-1-f@lex.la>
X-Mailer: git-send-email 2.56.0
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

The design doc says twice that dynamic object fetching is slow because
objects are fetched one at a time, without saying which code path that
describes.

Only the object lookup fallback in odb.c works that way. The other ten
call sites of promisor_remote_get_direct() collect the missing objects
first and hand the whole array to one fetch subprocess per promisor
remote.

The bullet also still names fetch-pack, which 7ca3c0ac37
(promisor-remote: lazy-fetch objects in subprocess, 2020-08-17)
replaced with a "git fetch" subprocess.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Repost of the patch from September 3. Only the log message changed; the
diff is the same and still applies to master.

I am very sorry about the unreadable message. Your guess is right: it
was machine-written and I signed it off without reading it as a reader
would.

Unrelated to this patch, since the subject of messages going unanswered
came up. I sent a security report to git-security on September 3, a
follow-up on September 16 with you in To, and one more to you directly
on September 26. The same day as the follow-up I also filed it through
GitHub's private vulnerability reporting, where it still sits in triage,
untouched. Nothing back on any of them, 46 days now. The documented
process says the list aims for an initial assessment within a few days,
and that a report judged not to need an embargo comes back as a redirect
to this list, so silence does not look like one of the expected answers.
It is not a contrived unreachable path, it is something I ran into doing
ordinary work, which is why I would like to know if anyone is looking.
Is that channel working, and if not, where should this go instead.

 Documentation/technical/partial-clone.adoc | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/partial-clone.adoc b/Documentation/technical/partial-clone.adoc
index 18718a3840..d5fd1420e5 100644
--- a/Documentation/technical/partial-clone.adoc
+++ b/Documentation/technical/partial-clone.adoc
@@ -141,8 +141,10 @@ remote and then retry the object lookup.  This allows objects to be
 For efficiency reasons, no check as to whether the missing object is
 actually a promisor object is performed.
 +
-Dynamic object fetching tends to be slow as objects are fetched one at
-a time.
+This fallback asks for a single object per request, so it is slow when
+many objects are missing.  Code that can name several missing objects at
+once passes the whole list to promisor_remote_get_direct(), which
+requests the set rather than one object at a time.
 
 - `checkout` (and any other command using `unpack-trees`) has been taught
   to bulk pre-fetch all required missing blobs in a single batch.
@@ -247,11 +249,11 @@ remote in a specific order.
 - Repack essentially treats promisor and non-promisor packfiles as 2
   distinct partitions and does not mix them.
 
-- Dynamic object fetching invokes fetch-pack once *for each item*
-  because most algorithms stumble upon a missing object and need to have
-  it resolved before continuing their work.  This may incur significant
-  overhead -- and multiple authentication requests -- if many objects are
-  needed.
+- Dynamic object fetching invokes a "git fetch" subprocess once *for
+  each item* when it goes through the object lookup fallback, because
+  the object has to be resolved before the work can continue.  This may
+  incur significant overhead -- and multiple authentication requests --
+  if many objects are needed.
 
 - Dynamic object fetching currently uses the existing pack protocol V0
   which means that each object is requested via fetch-pack.  The server
-- 
2.56.0

