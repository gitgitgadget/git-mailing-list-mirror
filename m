Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.158
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709816;
	b=IIqRS4F6K/AkbOeaL28s3ElV52/hRieeSict0xl/KCfgLC102qzK9eaFcnqcnF4wu5BO
	 6G0LbYdozVd5nemgq4e8JDaCExIC5yio4rtx/6DdUUwd10mBXcuxoysyEplN1KjH5BWoa
	 WawRYWDDDK9KBDiE5bRbuPkfw7bzY21ezKeKjEd7SxPunv2aFrvW2kjX5O0VLNrs0kacp
	 AzPDcXM+dIcto0scYLM3XLXo7Z83kEnWHPbD0Nej3onhILey0mYitEueyiPb95/1NMiwE
	 cKXrubuLKgZsroGcA/IYdBj/IAtrn39Ck3yaYxq3+M3WUExO3rEt4mzwLAy3aOZs3hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709816;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=p2CoxQW9RmGzyebyrW6Kvk7h6euiQ3vx5a/zeKhLhB0=;
	b=o7FpM9OQvpIelKUGScyk4Rgz7IODYy0/uZUY91CFXkfcvjokkkHfM1q/dRbdZ1ws9cmD
	 AGHPQPOOPDOFZeudi9gRYo0G8iJIePLN1J3ZJwXtdDOBxIVxe8bYvXSGWGDqjKUxLAgIM
	 hLjXDRAQJXZnKQRQuoQm8JlSjGELLMc0mW+ZCoSHRjdKfO+Yn0ijjPNQrxCJnCr6rDeWW
	 wuEUwQvn7Z+ECeS5kdhAF/JoARBdCLE6kb4bcIknqkmaEbIwavk1hO62u5B4vArata3u6
	 sezD5ZB1UdISbW7ALJGTp+1TKaDECKwk4R/no4yMVKzzBEYcZPSIIereZhYKUK55FOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=O5UxpsNr;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pQs4H8Vq;
	arc=none smtp.remote-ip=202.12.124.158
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B42C606A338
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 12:43:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B42C606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm3 header.b=O5UxpsNr;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=pQs4H8Vq
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EAA477A017A
	for <git@vger.kernel.org>; Tue,  3 Nov 2026 07:43:34 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 03 Nov 2026 07:43:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1793709814;
	 x=1793796214; bh=p2CoxQW9RmGzyebyrW6Kvk7h6euiQ3vx5a/zeKhLhB0=; b=
	O5UxpsNrbpXK1ehCtYE2oreglQSjOESPLrvrLIeh7/1jeMkVx0J5EBZDRxB9FCnM
	ITFKNT11GD91SNc+8yZgNNhEj3bB2rIW0RhV7W/qVzwBS92zlspQiehIt37vCLkq
	XA12sXHe6MjO2gpObKgRvfcqLpKdVHmLkUUVdFwUU/ADUDH7ED3vBdCJwvPa/Hj2
	lfKQDnDarWQ0Wfr8Is70lJz6aTdQkb6SIlDNnAIgYki26TXbTHwA1jUwYYlzJET4
	GfowWK0ErfKJ7Rqpoy+Qp15jWP6VZ/ZYKaNt2g+u/GgZUcZ4V7NXAtFYdpzeRoQ3
	EED4/riy4RsDysd1YJ/msA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793709814; x=
	1793796214; bh=p2CoxQW9RmGzyebyrW6Kvk7h6euiQ3vx5a/zeKhLhB0=; b=p
	Qs4H8VqERGpBOwJISb02M/0M1oLSGwKiMPH6U9LUwTfhHU4Vl9Vih5M7Td6S6GqQ
	t5fhrT/Px4gzafzOcbaCtrFT28sIZtqFRlMtSY7vG5PlQtOjUnozgxeG+WUcs48C
	Rq+2n+6E0gv1smfiRBwTNF970Ou0ksQNt0w84lL8f678FRfzYKpUXZ4/HB/ahopL
	/3crY0xgjazWL2UPpwKNELq62FmFrqxB2/DCFxr+DqIszrh+3C6s/mOiuRf2zCSU
	SOnla6WC+pw3WpeP79iUWd67vvKZcVP2T4KX9aM+OUPRMNtlGl8gCADyThgjkBEy
	0773VqPMdMsFSlQf1eOdw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793709814; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:NyUFJc8yb64HrTNpySASJiPUIq9J8aleLYRI2YIqvFmnLKX
	Z9RwI11z92XuQ5Q3jUIvdEcmhGgIO96kyOczNKWrfhxey1Ft8VU40Uqlrmm8bemQ
	ADdqDrisiW7G8DCd1hX2EF8SvyRxH2yy+YgONiEcRg48nouDx/FTPkTnp/DmYmWO
	NGfWlcPaZuFKrGzAbTnsNwpvgtwYwg/iq+EXYoijhJHAeNjfDjxT/BuFDGBV9ma+
	dVPRMMu36ki3TTCtOZuyM9Yc0DEAXupcos1TRg5Y9HGUgJutYJXNVdNBAZCLKXX1
	zUVD6Wuv/8jOBGD2afoYcrINOD41p+vtJ1X9O+Q==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:reQT9A1H2nkq647vUdtylqLbGFSZZ7gpFUskq9tcDz8=:Qbsva7XwzPR6cAI8lBCZghWh7tQ5AS5bTKWR83myWR0=;
X-ME-Sender: <xms:9tbparKJzldiubc-WnSVJRoUlCId3I-4jFyge7e_u0aexWQJ_u-fKQ>
    <xme:9tbpammEkPDQwqzboTkadv7firKhX0Pz8llmyCfhWqwItagIubLhYybn83MgI60Oj
    PT65axguql2N3ZTJv1h4iRlnLf2sV_xXxzc-q3DkKwoyrfKBRb1>
X-ME-Received: <xmr:9tbpahG_yJdohyw7nJu1I6Tk5bC2orMPe7p41UzPSt1OwSA-voLK_g>
X-ME-Proxy-Cause: dmFkZTE9bw4aj8XCg136vA1W2XqjbzgHyCXkD3W2aEoGxmPmbuT7HUEaH8jvX8ZAAoGKqi
    K8YmCh02A6o5Ky7MwGZWHdBS7NHduZ5LbxezUDBzT1WBcemr9rWzcDEbICZdGnMppriJWO
    YP2La3UWeDvaFZTQlI7NIZ1OYxVOfvHGT/UhI/XA93Lx0fLGcYy5w4K9bUyBwXSQY0277W
    tYLf0hdtX4ZFBrxQ9Uga52S+iwolc1B+rAu34J3FNa+m96qz2zYLLF2zxhdpkwO5Fbx+Co
    5zoN0xxDhzOqi/I95xcRb/JpI5wEZllriYHMdjWyOWZN9/QA8T/GYok/P/P8UVohTe1pbh
    eeo4lnEhiAvxjSBZ7YhMDCInG2dowETE/3O7nZUULyJ5XIg0smahxfmTc3kFS8PsymDoOJ
    4MQzxoYMgpXvNQjOiKU9tZXFsdZDL75Uu6nYYQb7vrJ6IYOhRZU7lRw75Af4hiIMwZGo9J
    FxXATnfz6lq2sfCQmR34d4F+vmmDsVulRVxkqL9FsWZXUlB4gRKIlkZ52yO5dNLrRg0tTT
    E+YhlnOWI8Q3shjndAGMSxcpC1z7/OhxvgRy7KMkCY09A+xJCrNUQJjWux+5mD70GTl55S
    azPKoyg2ExHCv8B2plCPZrXENU8+IZAvxjpe4+UkJ4crBooBz2193IIftQxA
X-ME-Proxy: <xmx:9tbpauEjmcZzgao2XFKRxZXW5sHEBlhOSXzBboLchxI2lShFeklQpg>
    <xmx:9tbpamPoPcGkD5slkc4p49Hyv_b48VQAAtZAfZSq-4M_aLw3ExwLBA>
    <xmx:9tbpalFl-gVbhVDhmSmSeOJu3OJ9s9-BQFpL2EvdvyA7veV06OoM6Q>
    <xmx:9tbpalPzIpWDWN2tLsJLXUxpqkWJqWA6DFo0SfMlDh-VmF7jOW7G2A>
    <xmx:9tbpattSi0cNZBRRf4iM0XH3WL5_eXGFTqvubt7imj3AiA-nLo0kvHSw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Nov 2026 07:43:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 82630c1a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 3 Nov 2026 12:43:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Nov 2026 13:43:20 +0100
Subject: [PATCH v2 1/3] builtin/grep: read submodule trees via their
 repository
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261103-pks-grep-recurse-submodule-v2-1-b00e3b3dc865@pks.im>
References: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
In-Reply-To: <20261103-pks-grep-recurse-submodule-v2-0-b00e3b3dc865@pks.im>
To: git@vger.kernel.org
Cc: Root <rootminus0x1@gmail.com>, Toon Claes <toon@iotcl.com>
X-Mailer: b4 0.15.2

The function `grep_tree()` searches for a specific string recursively in
a tree. It can recurse in two different ways:

  - It may either see a subtree, in which case it recurses into itself.

  - Or it may see a submodule, and in that case it recurses via
    `grep_submodule()` which then again calls `grep_tree()`.

In the latter case we continue grepping in the submodule repository's
object graph. Historically this used to work by linking that submodule's
object directory into the main object database. But in 93cd344e34f
(builtin/grep: stop registering submodule ODB as source, 2026-09-11),
which was released as part of Git 2.56, we stopped doing that and
instead expect to read submodule objects via the submodule repository.

This logic is broken though: while we indeed know to read blobs via the
submodule's object database, we didn't adapt trees in the same way. The
result is that Git fails to read the object:

    $ git grep --recurse-submodules -e hello HEAD
    fatal: unable to read tree (935cff11a11f8734cf4e0d40955d1e0e5c12038e)

This went unnoticed because our tests only cover submodules that contain
files at the top level.

Fix this by reading nested trees via `opt->repo`, which is set to the
submodule's repository via `grep_submodule()`.

Reported-by: Root <rootminus0x1@gmail.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/grep.c                     |  2 +-
 t/t7814-grep-recurse-submodules.sh | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index b045f8a488d..22fb365eeac 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -653,7 +653,7 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 			void *data;
 			size_t size;
 
-			data = odb_read_object(the_repository->objects,
+			data = odb_read_object(repo->objects,
 					       &entry.oid, &type, &size);
 			if (!data)
 				die(_("unable to read tree (%s)"),
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 3d149d34c15..f51c5181805 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -631,4 +631,27 @@ test_expect_success 'check scope of core.useReplaceRefs' '
 	git -C base grep --cached --recurse-submodules C
 '
 
+test_expect_success 'grep --recurse-submodules with tree-ish and nested directory' '
+	rm -rf sub super &&
+
+	git init sub &&
+	mkdir sub/dir &&
+	echo hello >sub/top &&
+	echo hello >sub/dir/nested &&
+	git -C sub add top dir/nested &&
+	git -C sub commit --message "sub" &&
+
+	test_config_global protocol.file.allow always &&
+	git init super &&
+	git -C super submodule add "$(pwd)/sub" sub &&
+	git -C super commit --message "super" &&
+
+	cat >expect <<-\EOF &&
+	HEAD:sub/dir/nested:hello
+	HEAD:sub/top:hello
+	EOF
+	git -C super grep --recurse-submodules -e hello HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_done

-- 
2.56.0.500.g5d06dc02cd.dirty

