Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378AA232364
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 15:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739807432; cv=none; b=OHlgiku3O6GtMublQxCvcCUfKvuKinI9kIOld2qSEI9XRFQpzljLNESJp4eJ2BHsQdv3a58gd23uJxiTCCqmsaI071ZlOhs29kq7h29RgyEEbebSXw7oNG/B9m4qux5hMMlFZtGWrt9Ulr1Q0WcLtDcK53HQ381sQnZ1i/9UEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739807432; c=relaxed/simple;
	bh=Ai99b/uUdMwPoekRYqPG/ZUDmUUd7r7Ba/9lxgwkBVI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K2VuAV4FV7mCenx1td9PztEiKL49oGSnphh5Z/xiDhZleUWgCoNuktKVCRfNLwWH/I6KjpHuKx9G2y1YQe+NgDwsAzjioHUVegzWLp6xihEVU5fsO15VLcauj/0dBFKskAXpoVllPUNqrYt4YDSixg/2CuWpaqZ4uoPe/pinlUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=pveavqaA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lHGkS7u8; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="pveavqaA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lHGkS7u8"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id 2B6351140186;
	Mon, 17 Feb 2025 10:50:29 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 17 Feb 2025 10:50:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739807429;
	 x=1739893829; bh=6j2iX6QmkMB0jJg9WGPRU7Ht5o27SYUm24ZVsb9AHNo=; b=
	pveavqaAKypY6lStiv02B9Ry6rtN2BWEeF+aNNGJBJMWljYNBsFn+ah4dvsE87k4
	W1SK6AmyfO3XxirzbNmlPCoLikzkSnr0v9zhfGOessyPI6W1/oEVCQVWcvpqqBo3
	xTkUZnBNeTuvOiARan8Z+Oa2stD+SO3u0MaZh3odpHWJ5wewyBQIjrLPFer92RzD
	wASykrCxGoKmee29hnPfWCObQpX9WpSf3EdGNFp4krGIE6cgdnrnbXZFnrPynidX
	IONqD32L9ZBh65pYARK4OkvbKRgM4A0E6QuMhRFDf6/3sdtDYQP7w0qsncjr7JpE
	rQtfgR/l8yJJRIp0Ud7rFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739807429; x=
	1739893829; bh=6j2iX6QmkMB0jJg9WGPRU7Ht5o27SYUm24ZVsb9AHNo=; b=l
	HGkS7u8lpD+lqEYt5GtpzvvqGaL93ukgl6N6Q8qqvEpgJbbUiB65/0tJawg8tBT4
	IIGMkBTXiWvYSdF25s13QKlHDl1F3ZkmkgwDn1lVE+AREnZdDxbILfabHnailmbE
	E/5G7/N0pYwkmz+dhgE1MsZEsBPGfPFcuujPVtrucNONCgiGteejsiwVOci/gwSM
	foF4TOIg/DxyqFAafZjYGHMraRlkQsh9XRCWdmeHuksBwkE3esv4CeVc2VEMf9Xr
	5pT4qHb72teEngCmpBTMnvg3ZER7HcZmaM8e88AMNA+d2vPbM9dVZf5Xgtd8JobX
	RjD+4HEKjCxFjLTHmBKqQ==
X-ME-Sender: <xms:xFqzZ6B5sq3Fm_zizB3yJo0s1FtKDArWMUSzs3mr4FbcBFd3_WE-7Q>
    <xme:xFqzZ0iluXVDx8CB82xMa_BMmsF1R3uS6tjZiHt-O0z78PqXqKP7ATLJIsZsDQYzZ
    vnLevkkp2Zl8K-zJg>
X-ME-Received: <xmr:xFqzZ9lnSrDp53e5cHcgoeRn-tfuyq9XmYoveAupc06BvG5Ju7gUCordC5Uuv02-W7cm5w2JSvo5PC34VQOX0hXpocunfdwxS6-og0SlrrlecqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdehkeektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepfefhueegleehfeejkedtffehvdfhvdetfefgtddu
    ffduveevteegueeutdekhfegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehpvghffhesphgvfh
    hfrdhnvghtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghs
    thgvrdhnvghtpdhrtghpthhtoheptghhrhhishgtohholhesthhugihfrghmihhlhidroh
    hrgh
X-ME-Proxy: <xmx:xFqzZ4yZ6hekysPHYHPj98zhQW9icimLSUyNLO8xRyq-qbkrMtzViw>
    <xmx:xFqzZ_TsKiYupO2kyk8p3htG_dJynfNjRHuhlHyPPjLnB_ufD5EHdQ>
    <xmx:xFqzZza4AFvHmVDhaUFfO21rG2msWBhoGslxVvAEhM8lGGI7aJhqig>
    <xmx:xFqzZ4SENH0XGmVAuFXNbLSonsOvQOmhqM9RYmaqkFh4IjQS6Ksm5g>
    <xmx:xVqzZ-GGMUdJP92f8mCLbsZDnpD0rVu-c9IReGKX4oc5sEyHQJmLhiWi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Feb 2025 10:50:27 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 449e3970 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 17 Feb 2025 15:50:25 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 17 Feb 2025 16:50:17 +0100
Subject: [PATCH 03/14] builtin/update-ref: skip ambiguity checks when
 parsing object IDs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250217-pks-update-ref-optimization-v1-3-a2b6d87a24af@pks.im>
References: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
In-Reply-To: <20250217-pks-update-ref-optimization-v1-0-a2b6d87a24af@pks.im>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>, 
 "brian m. carlson" <sandals@crustytoothpaste.net>, 
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

Most of the commands in git-update-ref(1) accept an old and/or new
object ID to update a specific reference to. These object IDs get parsed
via `repo_get_oid()`, which not only handles plain object IDs, but also
those that have a suffix like "~" or "^2". More surprisingly though, it
even knows to resolve references, despite the fact that its manpage does
not mention this fact even once.

One consequence of this is that we also check for ambiguous references:
when parsing a full object ID where the DWIM mechanism would also cause
us to resolve it as a branch, we'd end up printing a warning. While this
check makes sense to have in general, it is arguably less useful in the
context of git-update-ref(1). This is out of two reasons:

  - The manpage is explicitly structured around object IDs. So if we see
    a fully blown object ID, the intent should be quite clear in
    general.

  - The command is part of our plumbing layer and not a tool that users
    would generally use in interactive workflows. As such, the warning
    will likely not be visible to anybody in the first place.

Furthermore, this check can be quite expensive when updating lots of
references via `--stdin`, because we try to read multiple references per
object ID that we parse according to the DWIM rules. This effect can be
seen both with the "files" and "reftable" backend.

Disable the warning in git-update-ref(1), which provides a significant
speedup with both backends. The following benchmark creates 10000 new
references with a 100000 preexisting refs with the "files" backend:

    Benchmark 1: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     467.3 ms ±   5.1 ms    [User: 100.0 ms, System: 365.1 ms]
      Range (min … max):   461.9 ms … 479.3 ms    10 runs

    Benchmark 2: update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):     394.1 ms ±   5.8 ms    [User: 63.3 ms, System: 327.6 ms]
      Range (min … max):   384.9 ms … 405.7 ms    10 runs

    Summary
      update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD) ran
        1.19 ± 0.02 times faster than update-ref: create many refs (refformat = files, preexisting = 100000, new = 10000, revision = HEAD~)

And with the "reftable" backend:

    Benchmark 1: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)
      Time (mean ± σ):     146.9 ms ±   2.2 ms    [User: 90.4 ms, System: 56.0 ms]
      Range (min … max):   142.7 ms … 150.8 ms    19 runs

    Benchmark 2: update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD)
      Time (mean ± σ):      63.2 ms ±   1.1 ms    [User: 41.0 ms, System: 21.8 ms]
      Range (min … max):    61.1 ms …  66.6 ms    41 runs

    Summary
      update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD) ran
        2.32 ± 0.05 times faster than update-ref: create many refs (refformat = reftable, preexisting = 100000, new = 10000, revision = HEAD~)

Note that the absolute improvement with both backends is roughly in the
same ballpark, but the relative improvement for the "reftable" backend
is more significant because writing the new table to disk is faster in
the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 4d35bdc4b4b..ac330748244 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -179,7 +179,8 @@ static int parse_next_oid(const char **next, const char *end,
 		(*next)++;
 		*next = parse_arg(*next, &arg);
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
+			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
+						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
 				goto invalid;
 		} else {
 			/* Without -z, an empty value means all zeros: */
@@ -197,7 +198,8 @@ static int parse_next_oid(const char **next, const char *end,
 		*next += arg.len;
 
 		if (arg.len) {
-			if (repo_get_oid(the_repository, arg.buf, oid))
+			if (repo_get_oid_with_flags(the_repository, arg.buf, oid,
+						    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
 				goto invalid;
 		} else if (flags & PARSE_SHA1_ALLOW_EMPTY) {
 			/* With -z, treat an empty value as all zeros: */
@@ -772,7 +774,8 @@ int cmd_update_ref(int argc,
 		refname = argv[0];
 		value = argv[1];
 		oldval = argv[2];
-		if (repo_get_oid(the_repository, value, &oid))
+		if (repo_get_oid_with_flags(the_repository, value, &oid,
+					    GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
 			die("%s: not a valid SHA1", value);
 	}
 
@@ -783,7 +786,8 @@ int cmd_update_ref(int argc,
 			 * must not already exist:
 			 */
 			oidclr(&oldoid, the_repository->hash_algo);
-		else if (repo_get_oid(the_repository, oldval, &oldoid))
+		else if (repo_get_oid_with_flags(the_repository, oldval, &oldoid,
+						 GET_OID_HASH_SKIP_AMBIGUITY_CHECK))
 			die("%s: not a valid old SHA1", oldval);
 	}
 

-- 
2.48.1.666.gff9fcf71b7.dirty

