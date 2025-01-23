Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6836B1581E1
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 17:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737653671; cv=none; b=eQRlynxmsSSNw7C8QYb4HfgZ6JV39URrKxmhDUb+4xnTxkLSrWq+E8Yo8TMZepuEEpGtcZuflzdGXkrbUzfqBn0fNK3t0S30lunrfWFwZ+MrlEpiO+tctS1zAfgRLqLBNezlMQBq2kI2HD8/VKHhAf4PdwBJtZa9LVGovzdjAv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737653671; c=relaxed/simple;
	bh=Wtrq82Dmo+EUjsd8WWGRiJGHR+KqEWsJQXT3dd2gY0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bodnE1YPRCfbqEeCD504w3820bac0vBPKKNxi7f5JnSgaun6lnPtfSJLD2Jm8of58OT9+m2x84yP7d65OJdqNmA8TNFBeMLJnwviLzkVAvAXZnpmar9mO4Yo7k8rMtsfecsoJ7qMsM8brkMvBF1SpEMksN8bXsjQ1CsUm0394BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=zqDhpjQW; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="zqDhpjQW"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e398484b60bso1892240276.1
        for <git@vger.kernel.org>; Thu, 23 Jan 2025 09:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1737653668; x=1738258468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XIAuF2Rpp2rrzkoZXCrVOsrlLB1cwByQdFvBqaOvOVw=;
        b=zqDhpjQWDGx5qYGoK3fde4oh79sW0ogcTJX/QC7ZkqswbF/3yB3jZvAf6gNfvKi2Dq
         TYeDP0t0fyoQjzGs7k3dZzkuDXRqhhkX3y/0pmkUct6PYA96Gm6cc3amE9IvRMhkWSzY
         rKUzTbu4kmW/vH4ARA2T4UA7Nu4ju37JetF6oqi1ipii39Tzxg4UQ44nD8LhVeWd06D1
         AfCgHVddUCXAErgrQ5uiJCEKc478lLlkxZ3pkOk85038HoJUv1TWkTGgVRPXoUbLNYrL
         HbtgeXcPB65k5efNsg7/kCgZeFqZu5ag5uiSxACA75xCNP/+qv1FfVdYxWOD7sBgnRhg
         e6dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737653668; x=1738258468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XIAuF2Rpp2rrzkoZXCrVOsrlLB1cwByQdFvBqaOvOVw=;
        b=CP6JU6RcTzKFR9DYoi4atYFJk37M3ijQ5rmub+m67TvJrRPvMOuYFZa6FTyTUnrCxm
         nBq2psxcJwFYLsBFkOZQQdgS+xZMBP7ffRmO8Osh9C6CxVojsOMj+EcGxz94dGlGdCYH
         r8RvwTzmr8uNMLuAzhqosfDB0vOMi/FniQctsFUnXsFFiR7g+ck9axWkDXIPDIM6kmG4
         v8LUpq3FnCDGDMQIMZB5/XH1wDbYaCY8QpVdd4pdA1fK377wifFi3MOc/QIUW0oRIpqA
         NwP53vpGk1z7GUaXXBT1adSOHZfVcSlZ7dFTYhd2r2G0L8qeJRylsz+cWnVulwwb07xu
         98NQ==
X-Gm-Message-State: AOJu0Yzl8RK76STa4UprMdP4uziKy5sErWUZSzKMGjmKd62VAh6XY1Nq
	uNiBAAauEVVAuXLKSQZv2x3U6HKaYSrWIYjBAuz+rDI0cHixpstZqV/UhXNhP0p8/IO/NgYjSzk
	PoFo=
X-Gm-Gg: ASbGncuJQghTNJdVmIkqpitGC2FDaw9HzlSTo7OPRl72g3u31p/hGeyNLC0wD+GCSDm
	0wjDre8rxR2OKzVYmqCV63vFYEttlHslhQoEFJiPjOAYyHK3kH+766Y5IcED96eQgEBPfu71Hhd
	+9nYWC/OAmwpKWCgpljSzE643vi7MljZeyHJIpyMXzB4OBvLrQPiG9BbRcaVy0dbh1xkCn7TIyN
	bIrvyDjrrBe7eqrmzmNH4IYNTAJvz5K81veONQBIm3b3zQly2kGmVhWyHixmJZj5Sj5KoRzXzlv
	2BmZyjrDPFxXo9mXCkt6mqDNV/bkqVJahtQVQxrfQArcWlFbcy/L
X-Google-Smtp-Source: AGHT+IExUx/u/z+9paHConXsWTCw1RwCUXl3iXcNj+PW48g0zIbVz8cYVcn4T2DcJ7P9ATLpGkcnzg==
X-Received: by 2002:a05:6902:2683:b0:e57:2ff6:945a with SMTP id 3f1490d57ef6-e57b0e17ee2mr20520143276.0.1737653668070;
        Thu, 23 Jan 2025 09:34:28 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e583b7669b7sm32849276.14.2025.01.23.09.34.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2025 09:34:27 -0800 (PST)
Date: Thu, 23 Jan 2025 12:34:26 -0500
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 3/8] csum-file.c: extract algop from
 hashfile_checksum_valid()
Message-ID: <73554c3b8814b4864a53469e6e20c2170a9f58ec.1737653640.git.me@ttaylorr.com>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1737653640.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1737653640.git.me@ttaylorr.com>

Perform a similar transformation as in the previous commit, but focused
instead on hashfile_checksum_valid(). This function does not work with a
hashfile structure itself, and instead validates the raw contents of a
file written using the hashfile API.

We'll want to be prepared for a similar change to this function in the
future, so prepare ourselves for that by extracting 'the_hash_algo' into
its own field for use within this function.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 csum-file.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/csum-file.c b/csum-file.c
index b28cd047e3f..7a71121e340 100644
--- a/csum-file.c
+++ b/csum-file.c
@@ -242,14 +242,15 @@ int hashfile_checksum_valid(const unsigned char *data, size_t total_len)
 {
 	unsigned char got[GIT_MAX_RAWSZ];
 	git_hash_ctx ctx;
-	size_t data_len = total_len - the_hash_algo->rawsz;
+	const struct git_hash_algo *algop = the_hash_algo;
+	size_t data_len = total_len - algop->rawsz;
 
-	if (total_len < the_hash_algo->rawsz)
+	if (total_len < algop->rawsz)
 		return 0; /* say "too short"? */
 
-	the_hash_algo->unsafe_init_fn(&ctx);
-	the_hash_algo->unsafe_update_fn(&ctx, data, data_len);
-	the_hash_algo->unsafe_final_fn(got, &ctx);
+	algop->unsafe_init_fn(&ctx);
+	algop->unsafe_update_fn(&ctx, data, data_len);
+	algop->unsafe_final_fn(got, &ctx);
 
-	return hasheq(got, data + data_len, the_repository->hash_algo);
+	return hasheq(got, data + data_len, algop);
 }
-- 
2.48.0.rc2.35.gd215225db14

