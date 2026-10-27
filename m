Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.153
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793084436;
	b=jSGuOoDH8H6KOKXe5LkV0kJ29RAbtLuBk9vM1hfpHczniCCJol1Lpfn5RoiQ5yn+Dj+6
	 EMxMWBL5K/wj6KScupn2CNiGBLXFozHJtE/iRVYWuCdRRDw52KDKgvDWwTmAklUm5YtuV
	 FtQjdmD0UU95sdXgUD+1/KDJFY1SOc5JIki2Xy3BPuHlR/qTp/doojXjsBuy+CxxgU84Y
	 xH0eQRC+ETj5EdqCZtN6+6Nb3GTYIoa6piXRlJo9OE4HUz8wd0yGQxwtnnFRwQBK7n0mN
	 ju1kQmEvZamqUFXhGm8bA/JYRYM/YmENnpF8vd52uG4QvVMiyAX4HI5pxunQ9fOOF9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793084436;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer;
	bh=GviWiCYVV1c7HxUkxFZzqukyQhclJDXv9MmFn7km3u0=;
	b=I9t/xLYrd+0oBEhbmrSHRtd+qVBOdHZtklnnoOq70Wd1z0/ZF9z6l7YTv3ZRYLjwRjdj
	 hOQu9k5/Hrb+e04+x1Wdtuail2HfSMWmVZFJ7buW0uer0EVe1kbqjG8u3b91WoAb7NXXa
	 yRj9YaOm9JhX9lulHlUr3WEhleVfPAlX76q6OFVbcJTfy8/phopJm+OhcBYlw4oc8DgoM
	 a2q2wB1o0KMueRTkfpVuTnDEVXXR4X5pF0KbRn7K8n0x4JAau8+AtznohdDMjClqa2FJt
	 TFCwbFlpH+Enb8014eW2JXfsIm4WvDI7C/Dh7Pe3ol+0xnY5pkFKy1hEdF88Ok9SlVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=j32XZ900;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vMkCYadG;
	arc=none smtp.remote-ip=202.12.124.153
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40D6606A31D
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 07:00:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C40D6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=j32XZ900;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=vMkCYadG
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0DE6C7A00A7
	for <git@vger.kernel.org>; Tue, 27 Oct 2026 03:00:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 Oct 2026 03:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1793084434; x=1793170834; bh=GviWiCYVV1
	c7HxUkxFZzqukyQhclJDXv9MmFn7km3u0=; b=j32XZ900CURh/6iJwfaTt2Bvve
	FX3munO/C0g1iUH6xvuGvK+4jRDgQJRiwjpnYfZpVid3iFlHpAKPN0zZZNwQ1jkV
	lQl3RkNCEikB+5IG62xONZPXSsPL/2mhDtQC5RZKjUVqCkcOAtKXvHVWW2A8ww7Z
	yBJDYloVMMCNUAdYpNUtjiUCGqZR+KAJWrzK++dNGqCjZMdilt2AISXE9uORHB9C
	6KNBmQwcPkq+MXDd89EvdSI0Z8xtJEmvL315MjoyBrr8TFZ5YkB2u9TJbJXlZgpF
	F3sWmOC97Ii/CeIi7IEXCxSarlFW7wM249SkjO7lYTPV13cNeLGTEyByCA6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793084434; x=1793170834; bh=GviWiCYVV1c7HxUkxFZzqukyQhcl
	JDXv9MmFn7km3u0=; b=vMkCYadGsyOMYjgtELcKfvbpR+PzpwNjf1DQpWSlMbv3
	tCAxvx8UDpNmhPAyRasgewzlx2KtHZVNdADc6FpA7fcOA5ylZp5CEaocY037kQOo
	agCmL7OtTUvCouMTPGdUsvxWpzEJFyFz5t0fPCBp8huda8dRBZu5CbMnSFbkZNX5
	OddCQXsDB6sMi00bbXiHtnhRTGQTQM1WDZl/7CfCGg3zGzCOdEhbq9vfOYJkRv4o
	QsU/EDJRHTN2fz1SwvVX2qK48IWvblS2xgmr2EmL9kqYGOKILtf/pQcjLiaV2M6l
	qPRfeckLnNADAVeBGI77uHJlv19NwcpWOrvlt4vCqQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793084434; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:H1Zuz779o7jR5RZ1/5PrT0ROe9Icd+xKE7avIewWJgy9Vbv
	tk5sA+2/F9E5/vwTUKN75folbfBEW1aDhIZYnnlFxyAK7TqBrHNsnRMrtTz8ev5a
	69DseSzJeygYypVJdKhOQCaaSWPtC3Gd8T0Cei9wAaqSOmDH46Y0OjUqADKO+H1a
	huaHcFoBBO1sSg0yY8erZC40rzSaszcZB5RL0YSmSFlq7wSOTr0/pFGHMeZeqmrO
	UmW/Mf4CMYTG9ofSNk3Ux36nRUpAxabo6Ch/MCkQ7NVjhkcv2s3+QO+ztk1Iiyr0
	xjjr5HlH+bPqhytbN0nq1eTf9JUL09FIUNwH4Ww==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=10;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:eIuS90M1t/USydpqV4dw7TfJ7tkzkL+XTnm+k7hSwKM=:H+XoVwxJaGHWvwvQQXAyH1/U7ndK40e6UCdEC8+4d28=;
X-ME-Sender: <xms:Ekzgartgi6E2A99bU_HZwogU8jO6t0B60WECz-kt1oqBVh8bx4536Q>
    <xme:EkzgaifRNzCeF6EfTO4ngndMjgg52BxBe3P1kEPqIpMzB1HN4pX3vDYj0Q1tXMwpu
    onuKDcW8NwxNlPNNqEZCPXQHAhG6XOkM42_-cM2M1SjXDJsfwdK_eA>
X-ME-Received: <xmr:EkzgasYN6oNHUEJJ6wH6Rl-i1VddQ0qsv9KmqpBe3o4MuK1FEzfghQ>
X-ME-Proxy-Cause: dmFkZTFa7XJyOTf3fcKudai0rBJP74Ngz3tqjzBaqPQxKrXTh+vl4tFkLXUqZ+TXfDfXXD
    SgqHnCkJW9fpuOmy9cX/umOOYdAH4jCVfrjTIYAS3IOq4BAY4u1TjJD1ix2NeKvXW2t3Al
    sC1o1AuKWH8fYBH9FGVIuvM5GXHCtntQQS1wFK+wBjrHNzpzF5tOUwgyluKOdDN4rE4MoC
    siBoYCwwanv7dS0/dQP2mpz+2XTE9kMyn6e82KKqx7L9GwYady/pa07T9jB9MuqusOUuut
    eh4+XLb2HIn6MR0ErD3D10T2+YLsqbnblmRY78d6s2K7dWeUs4M+Yqlr5tGuHWwoiEQLAq
    dCrhqSqpnYMGUYeXmPKJNGoa2iqhp+Pxy2YloTzmjBcDF8NxIzgHc3flROqEQd8zeVfrxm
    DV2ZTN0fmN1dO5U/tt6dP+uXN+BnWbeQ9//sJ4PvDw68nzDsDDxD95hMdN2cdDgTsv0+xe
    CEe6OPHLduBaVgtwxhImhTIAjADUle7w8ekiyhokeXb2H0OI/8cYlnwEOM9fDyiMAXGn9x
    xxJUaePqcLLQW6JAwbCPT5fiIy5p/H5o97e11rhPUJNOZURc1jYGdJC9bO3cwB/ebPYqfD
    1zXYdfRI2ljhV607iRgIiivg14iupVSfKkM14yHvo0U5mO5QH5YS+6dNS2sg
X-ME-Proxy: <xmx:EkzgalUKagG77qsSA7PYT4lDMFN4yxvu7FOR-gFPXoCUkJeF-0kx6g>
    <xmx:EkzgauhBkQXHtPXsvDMf6tKJQ-1d1hI2sEfKEQvnNJR5amDCYqLHkw>
    <xmx:EkzgajVrh29zstXxxFw4YSQp9LwVy-3jZbH6VJiSSGVm2IMMpYasAg>
    <xmx:EkzgalP2as0nLzZwKJDZ7jBOVKUUZEpk0iGqQUBeheL-bU4g9tSXrw>
    <xmx:Ekzgamev8FEdgxVTkmDyAmIb7OCpuoFDCI873IQ_tCHh70ff2fgMuXjY>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 Oct 2026 03:00:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7bc67655 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 27 Oct 2026 07:00:33 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 Oct 2026 08:00:28 +0100
Subject: [PATCH] pack-objects: handle missing objects when excluding
 promisor objects
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
Message-Id: <20261027-b4-pks-pack-objects-repack-links-with-missing-objects-v1-1-f50f90651274@pks.im>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/z2NzQqDMBCEX0X23AUjIthXKT0kcdWtNoas/QHx3
 d2m4GEOH/Mxs4FQYhK4FhskerPwEhTMpQA/2jAQcqcMVVk1RoOuxjgJRusnXNyD/CqYKOPMQZs
 PryM+WYTDcBrO1m1HPWkM6HZM1PM3/97uf5ZXdn9nsO8HTDfEjpkAAAA=
X-Change-ID: 20261026-b4-pks-pack-objects-repack-links-with-missing-objects-ba49defedef1
To: git@vger.kernel.org
Cc: Daniel Zoghalchali <daniel@latchkey.dev>
X-Mailer: b4 0.15.2

In a partial clone Git tries to maintain two different sets of objects:
promisor objects should be those that we have received from the remote,
and any such object may not be fully connected. Locally created objects
on the other hand should be stored as non-promisor objects. The goal is
that promisor objects should never reference non-promisor objects as the
"promisor" property is contagious, where a promisor implicitly means
that any of its referenced objects are promisor objects, too.

So when git-index-pack(1) indexes a packfile from a promisor remote, and
that packfile has objects that refer to non-promisor objects, then it
tries to reinstate that partition by executing `git pack-objects
--exclude-promisor-objects-best-effort`. That command packs local,
non-promisor objects that become reachable from a promisor object into a
new promisor pack. This best-effort mode tries to exclude promisor
objects by using an `is_not_in_promisor_pack_obj()` callback for the
rev-walk: for every object that we see, we check whether it's part of a
promisor pack. And if it is, we exclude that object.

But in a partial clone we may fail to find some of the objects during
the object walk. The callback only stops us from walking into the
parents of a commit that lives in a promisor pack, but the commit itself
is still yielded, and `traverse_commit_list()` then queues its root
tree. And in a repository that was cloned with a "tree:0" filter that
tree does not exist, so `is_not_in_promisor_pack_obj()` fails to read it
and Git would `BUG()`:

    BUG: builtin/pack-objects.c:5088: should_include_obj should only be called on existing objects
    error: pack-objects died of signal 6
    fatal: could not finish pack-objects to repack local links
    fatal: index-pack failed

This bug can trigger in situations where we have e.g. a combination of
shallow and partial clones, and that bug has existed ever since we
introduced the logic in c08589efdc5 (index-pack: repack local links into
promisor packs, 2024-11-01).

But more recently, in d43b9acb05b (setup: unify setup of shallow file,
2026-07-07) we have introduced another case where it can occur. With
this change, Git now propagates the "--shallow-file" option to child
processes via GIT_SHALLOW_FILE. But when unshallowing or deepening a
repository we'd pass "--shallow-file=" to `git index-pack --promisor`,
and thus we'd now also propagate that environment variable to `git
pack-objects --exclude-promisor-objects-best-effort`. And as that asks
it to ignore the shallow boundary we may eventually try to read beyond
the shallow boundary and hit the missing tree of a promisor commit.

While we could stop propagating the environment variable to the child
process that would not help us to fix the first case. And besides, all
other global Git options also propagate to child processes in the same
way, so it feels wrong to behave differently here.

Instead, we can simply observe the fact that a missing object cannot be
a local non-promisor object by definition, and hence there is nothing
for us to pack in that case. So instead of calling `BUG()`, we should
rather just skip such objects. And coincidentally, that's also what
`repack_local_links()` (which invokes git-pack-objects(1) with
"--exclude-promisor-objects-best-effort") already does.

Reported-by: Daniel Zoghalchali <daniel@latchkey.dev>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
Hi,

this patch fixes the issue reported in [1]. Thanks!

Patrick

[1]: <CAJwQ=KQynymg4CJOLkyebACYVQa+LhXB2UifniTASkLyArWejA@mail.gmail.com>
---
 builtin/pack-objects.c   |  3 ++-
 t/t5616-partial-clone.sh | 55 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index ca3a891dfbc..d6caed16d97 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5085,7 +5085,8 @@ static int is_not_in_promisor_pack_obj(struct object *obj, void *data UNUSED)
 	};
 
 	if (odb_read_object_info_extended(the_repository->objects, &obj->oid, &info, 0))
-		BUG("should_include_obj should only be called on existing objects");
+		/* Missing; assume it is a promisor object */
+		return 0;
 	return source_info.source->type != ODB_SOURCE_PACKED || !source_info.u.packed.pack->pack_promisor;
 }
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 7cc6f58a31f..97a72e161ce 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -747,6 +747,61 @@ test_expect_success 'after fetching descendants of non-promisor commits, gc work
 	git -C partial gc --prune=now
 '
 
+for opt in --unshallow --deepen=1
+do
+	test_expect_success "filtered fetch $opt of a moved ref repacks local links" '
+		test_when_finished "rm -rf source target" &&
+
+		git init source &&
+		test_commit_bulk -C source 4 &&
+		git -C source config set uploadpack.allowFilter true &&
+		git -C source config set uploadpack.allowAnySHA1InWant true &&
+		COMMIT=$(git -C source rev-parse main~1) &&
+
+		git init target &&
+		git -C target remote add origin "file://$(pwd)/source" &&
+		git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+
+		# The fetched pack contains the new tip, whose parent is the
+		# local non-promisor shallow tip, so index-pack repacks the
+		# latter into a promisor pack. The pack-objects process doing
+		# so inherits the shallow file passed to index-pack and thus
+		# walks into the promisor commits below the former boundary,
+		# whose trees do not exist.
+		git -C target fetch --no-tags --filter=tree:0 "$opt" origin +refs/heads/main:refs/remotes/origin/main &&
+		git -C target rev-parse --verify refs/remotes/origin/main >actual &&
+		git -C source rev-parse --verify refs/heads/main >expect &&
+		test_cmp expect actual &&
+		git -C target fsck
+	'
+done
+
+test_expect_success 'repacking local links tolerates missing trees of promisor commits' '
+	test_when_finished "rm -rf source target" &&
+
+	git init source &&
+	test_commit_bulk -C source 4 &&
+	git -C source config set uploadpack.allowFilter true &&
+	git -C source config set uploadpack.allowAnySHA1InWant true &&
+	COMMIT=$(git -C source rev-parse main~1) &&
+
+	# Fetch a single commit as a non-promisor object, then unshallow it
+	# with a filter that omits trees. The commits below the former
+	# shallow boundary are now promisor objects whose trees are missing.
+	git init target &&
+	git -C target remote add origin "file://$(pwd)/source" &&
+	git -C target fetch --no-tags --depth=1 origin "+$COMMIT:refs/remotes/origin/main" &&
+	git -C target fetch --no-tags --filter=tree:0 --unshallow origin "+$COMMIT:refs/remotes/origin/main" &&
+	test_path_is_missing target/.git/shallow &&
+
+	# Fetching a descendant of the local non-promisor commit causes
+	# index-pack to repack that commit into a promisor pack. The revision
+	# walk must not die when it reaches the missing trees of the promisor
+	# commits below it.
+	git -C target fetch --no-tags --filter=tree:0 origin +refs/heads/main:refs/remotes/origin/main &&
+	git -C target rev-parse --verify refs/remotes/origin/main &&
+	git -C target fsck
+'
 
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd

---
base-commit: 7e34d8174dcda3435d1404c9a30bef46afe6c13e
change-id: 20261026-b4-pks-pack-objects-repack-links-with-missing-objects-ba49defedef1

