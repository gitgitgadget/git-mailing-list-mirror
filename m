Received: from mail-yw1-f195.google.com (mail-yw1-f195.google.com [209.85.128.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5A53ED3A7
	for <git@vger.kernel.org>; Tue, 19 May 2026 15:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206289; cv=none; b=g3X5MsU7MGD/f4kRobrqdN2zzm1GLoXUBBZ8zfV3w91l3FYWIKt+GBAklNEhdecWWsNptvKfSqC8jr73uwxvwAIFm4uoCCIIWOVzoruGRYne9SWG2IJfd2joXoH4yA4iwOY/njvRRFaDAsTtNRQF3Ol3yoAKuvzLbOm8yDDO/x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206289; c=relaxed/simple;
	bh=eUh6xLM/a5iB6YdtKsPprB/fjfhX77RbBqzrLHEvdWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hQmVUkTWZLGHFESXNs+JwCH/S5EnV63y4ujKftUAqKwgrNkmLTbEhAQ3h+omOFWiUjhMlU9zsUuHdm+LGRVoQatJ5O1Ab9twSwKCWJ7veQiifaxLJ4V8HtUeF7aLc+KjeBcE8ZmGMpqvZjo33jFTRMLwsfy14m1MkXSpileX+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=htzB23Bw; arc=none smtp.client-ip=209.85.128.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="htzB23Bw"
Received: by mail-yw1-f195.google.com with SMTP id 00721157ae682-7c0de780bf1so29171527b3.2
        for <git@vger.kernel.org>; Tue, 19 May 2026 08:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1779206285; x=1779811085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kON7al8ZRj35RJ839vzEY8M5neq4gecsMJ4R/fB+O/Y=;
        b=htzB23BwPrnpaYjd23VoN1K7EyCWjuhV8PQRDy8YuDIg1NRdW8FGBklsjj9N0UH7/1
         Os2lC5ctCegIC9QqGYtArbazjvQU8pxBrhYUHMFLxi5soCPgvqaN8m680DPjnJzbHbt9
         Tx3q9uzzasIeHmt6m8lhYGvCbrCJP2zz5ObUbR1K1BDRfve7QKLIZAIkK5cUvQgq3QnQ
         jjjgXFxBu7jQYreak0uE5ns1kwuzWacd/cfym/vHyOug9qdBoK/82hgz6j43DAFiqtzF
         fWk2pUN/2GcuRqF1HdOP8TYuXSjE2BfpltLciUeBJzwc6jTtdMQkXIz+16wCGVeGhOT7
         OSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779206285; x=1779811085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kON7al8ZRj35RJ839vzEY8M5neq4gecsMJ4R/fB+O/Y=;
        b=FVpXgaHNhKxGI8R8HsOYzGAjIWel8ZiIpuOmAmFA8/xKoirdFoh+vAhhOwsFD1pWKq
         70yGUpudX3IQweZD/7HI79HJGtdxgrc0cwDiX6A1Myw2u395qzuoQM+vgheBfEs84iVn
         LFALVqY5Yh9ZaSRov58V9ei6lkCL4aSeh8Mt41FLT4NQ+y9QeN0ZUHJFtoXzTr4MHZFm
         pPr9OfXcyleNhtV6T6ptbHY4mZ+t1RD5fDU1kdbKx4fTrIAlljikjImWEgPekMFTmUJc
         cETiOit8K0qcmOvfjLKu5wZq8TSI+VhuK80FKW/F4wyFZ/RCmpEX5i4HgcjiEFnjRt4g
         5coQ==
X-Gm-Message-State: AOJu0YwYfZz9LT9bwzGrkoRdgd5H62oTUZqpNVp8BMdHmroKHDr6QAMH
	bEIeQnuyxUYGMppY8PuEVyLr3sN5ObP6kXXae/KR3c7VYS1FZ07KVHaTFj/1OXJqw4ALiB1KAzL
	ToixLJFDc3Ix8
X-Gm-Gg: Acq92OH7uT2nGGXZpKK8IvNRxa97wcdeL933+mM0oOBEuyDQB4xKoLBToYlxX2ePlL8
	2Y3/YeekFuplF31fIUqHTRf2+VzD6SEDnt6bh9tkdKD/9Y9NYL6nQcaNfM1ll1r8oj0yCUogeSm
	ITeHaGK/KwxJpHo+8A+71aImyyFwbkePPCqdhiJkYEIXJdxIqg1fw5qrKawgYArcjNaVPPTY7P6
	lwCzOvyRqjMDGiFEuOHNbYD9vzhmAswPubckBMHFGQqf042mAol9Brr/51WBW45WtjNtpNFRiuQ
	ByHZ63owit+hTUaqIy+2Y5bK7KyzAVYqfmUdd2gihp5BQDtCDD4xyVkJdZyjypTS5cae4XlBBIE
	nsZGVXIXjNlcS/FSiGs112DjEOyFmOkMc6X6nflrjjmXXZwYYqkUPKpg1YpnX5Az5iXtSb06T7g
	shRBLa8PmlyZ30Ys9CITk2X2LdNZajbVEYIy8tBLLABmjReSqUmlh4a16L570BJl+EI7KQn6z4v
	LTerwiE2Yu+U2s+9wDUy8rB+CxXXljV3tRfEIwhgwJFguc3tRVrFcwIfYIFAd+IM/zdxZr7h/w4
	Y4jgtnaqoZIngltW
X-Received: by 2002:a05:690c:397:b0:7ba:f2f1:86d2 with SMTP id 00721157ae682-7c9596a8cbbmr207908467b3.11.1779206285528;
        Tue, 19 May 2026 08:58:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc9cbb0404sm38449587b3.42.2026.05.19.08.58.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 08:58:04 -0700 (PDT)
Date: Tue, 19 May 2026 11:58:03 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 09/16] repack-midx: factor out
 `repack_prepare_midx_command()`
Message-ID: <42111e5f75d57d377480616505ad25c2b70f8870.1779206240.git.me@ttaylorr.com>
References: <cover.1774820449.git.me@ttaylorr.com>
 <cover.1779206239.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1779206239.git.me@ttaylorr.com>

The `write_midx_included_packs()` function assembles and executes a
`git multi-pack-index write` command, constructing the argument list
inline.

Future commits will introduce additional callers that need to construct
similar `git multi-pack-index` commands (for both `write` and `compact`
subcommands), so extract the common portions of the command setup into a
reusable `repack_prepare_midx_command()` helper.

The extracted helper sets `git_cmd`, pushes `multi-pack-index` and a
subcommand, and handles `--progress`/`--no-progress` and `--bitmap`
flags. The remaining arguments that are specific to the `write`
subcommand (such as `--stdin-packs`) are left to the caller.

No functional changes are included in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 repack-midx.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/repack-midx.c b/repack-midx.c
index 0682b80c427..5634dc186d0 100644
--- a/repack-midx.c
+++ b/repack-midx.c
@@ -275,6 +275,23 @@ static void remove_redundant_bitmaps(struct string_list *include,
 	strbuf_release(&path);
 }
 
+static void repack_prepare_midx_command(struct child_process *cmd,
+					struct repack_write_midx_opts *opts,
+					const char *subcommand)
+{
+	cmd->git_cmd = 1;
+
+	strvec_pushl(&cmd->args, "multi-pack-index", subcommand, NULL);
+
+	if (opts->show_progress)
+		strvec_push(&cmd->args, "--progress");
+	else
+		strvec_push(&cmd->args, "--no-progress");
+
+	if (opts->write_bitmaps)
+		strvec_push(&cmd->args, "--bitmap");
+}
+
 int write_midx_included_packs(struct repack_write_midx_opts *opts)
 {
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -289,18 +306,9 @@ int write_midx_included_packs(struct repack_write_midx_opts *opts)
 		goto done;
 
 	cmd.in = -1;
-	cmd.git_cmd = 1;
 
-	strvec_push(&cmd.args, "multi-pack-index");
-	strvec_pushl(&cmd.args, "write", "--stdin-packs", NULL);
-
-	if (opts->show_progress)
-		strvec_push(&cmd.args, "--progress");
-	else
-		strvec_push(&cmd.args, "--no-progress");
-
-	if (opts->write_bitmaps)
-		strvec_push(&cmd.args, "--bitmap");
+	repack_prepare_midx_command(&cmd, opts, "write");
+	strvec_push(&cmd.args, "--stdin-packs");
 
 	if (preferred)
 		strvec_pushf(&cmd.args, "--preferred-pack=%s",
-- 
2.54.0.175.g8bd0ec98dc3

