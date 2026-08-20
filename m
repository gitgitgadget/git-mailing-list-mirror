Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220BC1D5CFB
	for <git@vger.kernel.org>; Thu, 20 Aug 2026 06:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787208397; cv=none; b=V1G4ACmn9Cr8N8Zaq0RITE5V/y4LIrGxbJb1YF+m6dSDAgFusChWcPJp3CgBYxgHchS2ByxAB1tK9sJIRF3hSeFAEjTosAYsYfYPY+SvGshr/3Gzn+8DpqFKEd7vJLEJzkRR8UBLfj8l+p690Y2mJGKGKZNNNEXzGrJ72s+qSwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787208397; c=relaxed/simple;
	bh=qMkYkPxTNaGb+m77XjYHeEj8S/cRqZyzuA8T4cGsUS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7PFE4bWSL87FHwCq0Jd7XIi2vB00jQv56PiByk3iQUzZ+KeYVXttsbiQLX/aWXMb1jkAcAOfQ6IbM3GdgUsXxNvTdt1+afvsvqWNBy7fliACteP2fHGDCx26/s0Kkz/XP8yLlz1/OqRoDH8JbTQyuXy+n/722VeCdA48HVzFB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DMl4wI/0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnBfsqnr; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DMl4wI/0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnBfsqnr"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EE63EC0198;
	Thu, 20 Aug 2026 02:46:35 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 20 Aug 2026 02:46:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1787208395; x=1787294795; bh=W6W2QTtQJR
	ViYvW37AeLoFLovb3lOhpKx9+ciMlUmq0=; b=DMl4wI/0Xs9hPix/q/MTynD89Q
	Y3E5/ACVbV8NOdqSRi0AoEm2eW+1WBrxwARdc/6lIn1FFvfrpYANPsp7lFa3GGXt
	JRxPOGnee6DbNq1q0GmVry5y1Epy4Fj4us3NRLjqZ+n9WnEHSsoWlJzixlZO4u1O
	T2YyK5aApUJBnZbFvpXoeotPvxbHuKy2HdIO+SupGxBXGA++f+xfswrreeNkhHhl
	RFpbpxAub2D7aPrYiPPTM+JtdRvU27eswocUXnQgmRZP44JH+YDmT10jTpH5fVPB
	6fBBQtwXr68fQvH5ShMW5sytXQRDXwWOuqCRNicHurFIJb5ttWPXma59VscQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787208395; x=1787294795; bh=W6W2QTtQJRViYvW37AeLoFLovb3lOhpKx9+
	ciMlUmq0=; b=TnBfsqnrLzbMBGjCTyuIFdkAowMN2v1RvWf7DzXMUuu/UNO9qJ+
	qj1Ajt7+/raI31vd/kseDDjatmrsg8/ut7QdhXqRcCjGqcVEaZwuUnm//+9lCmQX
	KKvHw+garKXkGmvylCwUoec62uDhqg5IwY720RU51f6sTAgC3GuRUWQdo79614yc
	ATBr/f8fxYBaI7S3st9CWtq81adbEvRR1qSgHLxRL87S0W1W+uxV2jS7MApAq9f4
	A3Ldw+sBqu+uJrb66KsueEMfsNiwSA5/QA4ybZ0wQnXkTOvEi40Ah+aaEf/2WzUv
	/HXJ1LSkg8lWukPSRXh515oFBl7J7kkVugA==
X-ME-Sender: <xms:y6KGasAHmZFN6LTv3qrUse9R5aj00jQfOfQG-b-hb-NqiFvoUNpfiw>
    <xme:y6KGal_E8NFrPtopT3r5X_uPsEfwJ5LJeOc-PNjqGAchnNtx9Bu61f69UBWbfcoy4
    0ZBTiUgj30xpVtizk7WY4s-OHmaUsTcffNVNhX-pCFcmatPjqqBs-s>
X-ME-Received: <xmr:y6KGas_-AlJ0IhTX6LCCOn9sAS2XCKqPvo0JK3yxfiG2FrOK7Xls_RNlSVTXKuKqr9NVaZLtffrrfVn8OUmWbSquoh7aZ01MUJStBsNvEw>
X-ME-Proxy-Cause: dmFkZTEkoe3yqOASusvPWtl0bxl0KxuqVZFU00oQkBEWFTAM2Cp7k/dcu1RVmgISAB0uKg
    pEdN2t+CruQFGhJZfO6waIYz9c31R0wjIf7lud/WcVNd0HkfIany+8Xr8WSJDHIJzDYChT
    U/GgQCtLffvN7SGj7QoRwpKXo+11cN/XLsSGou/lxKeKlC+9jEjifi63YhSPseBjw0oIeo
    7utCnL3k1399zKxCqO+1vBeO7etmf6JZf1OXp2q/SZ4F2Ka3XyFXCuNFi4lOGyGKGc2Lf2
    Fu78jJ4Sq9nJTCkSkR/f0fOiXQPhcsumgpzGzp3TcFywCW41jT/Ht9WKr9F2qQVLULyKCK
    uPE6HtmwPVYF8bza0MIY6ys6HfskzEvRAr4NY9aRGIhvqKGpWKSsdKLJfwSFxrwEXr3QtM
    xD/i/bZafnqYh33g532/po5rI+PMPRjnnrT5jkigX44Sq2CqwLwy53gjeLr+cxvq0JaGsl
    vqk0BThRvPjet21eW6qHythHtIe80GjiYnY9ar0tRxplQTJ1q6cfdteYy+g1+tsN07DjMB
    zKz8cg5iifKOME4KeHvHHMwCgcuN7qLd7UvHH2YXzTIom4tpLR5bAaLbx778G4zVHDgGTE
    bANnURPcVg1ZKiHTgJ5UzyoigzSHeu7RsmAUIyAXcNQy6HLN8VpuD720EPlQ
X-ME-Proxy: <xmx:y6KGasf70u06xn7LMZf3Hwv6q2UEz9zw8c51Ya0qkJd1UjyNyHDLEA>
    <xmx:y6KGalF53-gqhK13iHVRVkxrAsB7syt-o3GYNtEIjBuWBp8_yNOhDw>
    <xmx:y6KGaqfuYg2WeVbOKD-XVu8X4JtILyu1BqZXu4LCbBHBj3Wz4eZ-9Q>
    <xmx:y6KGavGwUNdNDLtnzjMtlS8R1mW3TydB6s9jVKGiG37RqF_K6CeLiw>
    <xmx:y6KGal_7XFGq14AS3tLn2BGQEKGyRE7-o_6MNnTx1rWWAOEdpAaaikLm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Aug 2026 02:46:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b7f7689e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 20 Aug 2026 06:46:31 +0000 (UTC)
Date: Thu, 20 Aug 2026 08:46:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v4 1/9] builtin/receive-pack: properly clean up keep files
Message-ID: <aoaixMF1biKYhWN2@pks.im>
References: <20260811175415.2044235-1-jltobler@gmail.com>
 <20260819215311.3880274-1-jltobler@gmail.com>
 <20260819215311.3880274-2-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819215311.3880274-2-jltobler@gmail.com>

On Wed, Aug 19, 2026 at 04:53:03PM -0500, Justin Tobler wrote:
> diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
> index 0798ddab02..3da253cc1a 100755
> --- a/t/t5547-push-quarantine.sh
> +++ b/t/t5547-push-quarantine.sh
> @@ -70,4 +70,26 @@ test_expect_success 'updating a ref from quarantine is forbidden' '
>  	git -C update.git fsck
>  '
>  
> +test_expect_success '.keep file is removed after push' '
> +	test_when_finished rm -rf keep.git &&
> +	git init --bare keep.git &&
> +
> +	git -C keep.git config set receive.unpackLimit 0 &&
> +
> +	# While incoming objects are still quarantined, validate that the keep
> +	# lockfile does indeed exist.
> +	test_hook -C keep.git pre-receive <<-\EOF &&
> +	keep="$(ls "$GIT_QUARANTINE_PATH"/pack/pack-*.keep)" &&
> +	test -f "$keep"
> +	EOF

Good. So we know that the file exists while the transaction is
running...

> +	test_commit foo &&
> +	git push keep.git HEAD &&
> +	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
> +	keep="${pack%.pack}.keep" &&
> +
> +	test_path_is_file "$pack" &&
> +	test_path_is_missing "$keep"
> +'

... and we know that the packfile exists without its ".keep" file once
the transaction has been committed.

What we don't verify is that the ".keep" file is getting migrated to the
target repository and stays intact while we're updating references. So
do we maybe want to add the following diff so that we test for the full
lifecycle of the ".keep" file?

diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 3da253cc1a..a722a01e8d 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -83,11 +83,19 @@ test_expect_success '.keep file is removed after push' '
 	test -f "$keep"
 	EOF
 
+	# And when updating references the keep-file should have been migrated
+	# to the actual repository.
+	test_hook -C keep.git reference-transaction <<-\EOF &&
+	keep="$(ls objects/pack/pack-*.keep)" &&
+	test -f "$keep"
+	EOF
+
 	test_commit foo &&
 	git push keep.git HEAD &&
+
+	# Once done, there should be no ".keep" files anywhere anymore.
 	pack="$(ls keep.git/objects/pack/pack-*.pack)" &&
 	keep="${pack%.pack}.keep" &&
-
 	test_path_is_file "$pack" &&
 	test_path_is_missing "$keep"
 '

Patrick
