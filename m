Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E8B282F10
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 21:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780350795; cv=none; b=OuCiczv/awjD+yOGZCPn+zqQUjDVhTXmYHCCUIftp68KVISKdcoRG88UGFjnOLK0MVxy3vvWSiz2dZA27gCzyfkZoRjn47b5u3leJq36rXNzm0G6sPIz6Bg7vCLczH9u4UZYhnAyCd5Lf/SrU6NmyxCqwSXj1/4fln/Mou58pTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780350795; c=relaxed/simple;
	bh=1GX+9Iej6Lkd+wyd5SxkP9PtYuUHIfJZT7oyGALq2yQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K5wI2o4S4SqpiiJiEGqeJ7cfms8NOWIsj/A0vm+VKREAR1wzLCOQE/zNXUu+WQTAc9J57LT4D63QEajZBf1aDUFizVRN2rCPKen07E0v/B/xrhbPH2PWQmjK/3h6NWV63txuPvVbO2L5mOyOYDv5z+d68SiD13wbRH++QMEvI/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=oX7KiSv1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TZDwHRsM; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="oX7KiSv1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TZDwHRsM"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id C1CA41D000F4;
	Mon,  1 Jun 2026 17:53:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 01 Jun 2026 17:53:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780350792; x=1780437192; bh=BXF3hBr5XX
	l+nmcNtFN2IdJfD0daaJH/qE8lH7/ETeM=; b=oX7KiSv1DDeNNYmPqlOAvTZJgN
	OpRFBqrOdK16CJPQecEx7FBqkqXQjGrs97FIFzcssPk6zBZwl388B89YCmBEijV1
	OxWKW7JMuWs/G/+iWwojpnJMJP8QUp14++Ku6/NLpwrUKWrL8bVsNRtrk0yiI1/6
	/x1R10pc1x9vw8/nyPy4XhixSziXq6va6xoLby6HiBFKYy0QR8zNWWA3ym6C4V4W
	Co65SRQAb/FRSVpY4AWYezJd/Pyn6ms/+mZzD/yVMpZD/6hLeO/sRmyMGyR2kAjr
	hsk2xlQElTDyu/Pb3/K5rsAgzORXfGgX1hJNRvixZ6iOBxSK1f605Y5z4Yxg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780350792; x=1780437192; bh=BXF3hBr5XXl+nmcNtFN2IdJfD0daaJH/qE8
	lH7/ETeM=; b=TZDwHRsMYHb7jDmi1ikkxcULN2sDSKVbOkANZkCauegkFgRXSNi
	y7oiBXrih6lDmN4/BPG4MWp6e8mIew9sFmarN/JQp7YDEFPOVuFPcnsgOuroztbq
	L3pWALHIsEVx35HcSHLiBJvsNS9byATAbfYu4yqw6cVXSYib0vhYnNWoc9NuzRBj
	zDaXx/b5waLL6tM9Rr4YkxyuMtC80QThDxXn5ueoKxPH3CBn33UBxhGqWwT5Ixlj
	+wVJOFV5C65cDO5q1mnvqJNeK60WUC3f3LiRWwHwz90uqHXEJyl2nMyEH2/lsA0O
	Xlap/BmEb8BwdhCzGd92hynj4x48Qo1GcLA==
X-ME-Sender: <xms:SP8dasW0cQ5hSNcT4v4wl6X8FjJ-I1M6P1dqVxzfhMqTIgiG9HrNEA>
    <xme:SP8datLcOkLxHs1pswDY3IT6j_qkunNhwyDEwUNcNZLDOklFax3SD6yOPNf6RDAP0
    X50D6M489VAQy4QJY-bXwaNjxCqlK5g76PEsIzqhVIt_mbd1azqtg>
X-ME-Received: <xmr:SP8dak3qsjbCl_U1I6os_sJkySjFE1ocTWVH4r0YD-u1FoMq4O6Wtd1Qbyn0yauMNQhvp85JIFqH2V2fv7itDx2HGPiJMN91xm15>
X-ME-Proxy-Cause: dmFkZTE+aF889o6iXs6l3quf7eTeEXqnuYaK+5KTIgThZnfNBqdbJiFurFlKffyfJRT+vd
    roZcPGzEn9oxLKG1vg6tZwVV4/7rSqp4p5Qa08gAD3GfLtRSGb+YBcKmQON9Q96nke5VSr
    xzNSVvkDkup6jeesU33xdYxl6WQKIK+3RS35nUiENUDsEvkJwfBUWY2sR6gLYK3O0XpwX4
    xRIswvtYlX+mUU4C39qberGHVwBH2Aoh3FKNwAc7M+SOE6bC8auWzw5Vh0LYnn0OX58z87
    0SZj3WJbiZuHFcRSO1vzqsi2HdmA4Ig+0sDObUjuDcdJOlXXsYwqwdJ3chPrrptCxZxUpr
    QE03GZofjXDyOtmMXVcai+Qk0sXFHijH//tA/IBjpqnflrdlNlHzJAXQB5MSV3johcsAjM
    GjsKjAMs7wwG+TG0BT0WfGSA/8fCZKlG3lR4GQWT3J4tRl4IaR6Kmpc82rLXYwBQNNnkMn
    5CX5dxg9jon2lUAQ3Q6cQQuADECEYqV9k8C5arjncuKBIhjZMV7mBML1rAacKDlZmnsED6
    zcJKkVJGHBm5iWUp+Un2Js+xn2rxbvXy08+eruSb8GBHV7AHIfmV2Xz6uorcFNtkzDCMgd
    sO9wbabDEBpsuRr4QAnPw++oAUZ1vpaMlm2tnybCidCUwfe7muhp5i0IEqZw
X-ME-Proxy: <xmx:SP8daiLyH_4aiEBItCdgy3gXj7aXFxV-i9S6K_KYO_U8tu9e4zwYYQ>
    <xmx:SP8danh8mvYAqCTmyFd5KSq7fKDI8qd4M6UXeFhZzVUJ-Izc7ryp9w>
    <xmx:SP8daqBGPXN5_7HcSaVKGvbwYrPF60sX1YLqvVovf7EBfQ96gIaNKw>
    <xmx:SP8dah47y42AgBOC8FAPvGiCprefALOYalFs4a3Cr-FfdDi9RsuRwA>
    <xmx:SP8dagaoqqfPt0JMwsXhfKXkHnj-01hqsOBe5pYGDjW6OrrgLK3t2hAf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 17:53:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  =?utf-8?Q?Jean-No?=
 =?utf-8?Q?=C3=ABl?= Avila
 <jn.avila@free.fr>,  Patrick Steinhardt <ps@pks.im>,  Tian Yuchen
 <cat@malon.dev>,  Ben Knoble <ben.knoble@gmail.com>,  Johannes Sixt
 <j6t@kdbg.org>,  Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v9] revision.c: implement --max-count-oldest
In-Reply-To: <ag3kJ_xKY6584De4@exploit> (Mirko Faina's message of "Wed, 20 May
	2026 18:42:36 +0200")
References: <463cc8e2764edb7de3d379f615f5cfbd0919bfa3.1778887662.git.mroik@delayed.space>
	<8210d60832b9a58aa4d71fc3790e44d8989564ce.1779152064.git.mroik@delayed.space>
	<xmqq7boy4o05.fsf@gitster.g> <ag3kJ_xKY6584De4@exploit>
Date: Tue, 02 Jun 2026 06:53:10 +0900
Message-ID: <xmqq4ijm3p2x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mirko Faina <mroik@delayed.space> writes:

> On Wed, May 20, 2026 at 03:02:34PM +0900, Junio C Hamano wrote:
>> 
>> This breaks CI
>> 
>>   https://github.com/git/git/actions/runs/26138986677/job/76880268854#step:4:2072
>> 
>> Squash something like this to fix.
>>  ...
>
> Sorry about that. And thank you for the fix.

It has been a while, and we saw no further comments by other
reviewers.

Perhaps we should declare a victory and mark the topic for 'next'.

------ >8 ------
From: Mirko Faina <mroik@delayed.space>
Date: Tue, 19 May 2026 02:55:22 +0200

"--max-count" is a commit limiting option and sets a maximum amount
of commits to be shown. If a user wants to see only the first N
commits of the history (the oldest commits) they'd have to do
something like

    git log $(git rev-list HEAD | tail -n N | head -n 1)

This is not very user-friendly.

Teach get_revision() the --max-count-oldest option.

Signed-off-by: Mirko Faina <mroik@delayed.space>
[jc: fixed up t4202 <xmqq7boy4o05.fsf@gitster.g>]
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/rev-list-options.adoc |   5 +-
 revision.c                          | 111 +++++++++++++++++++++++++++-
 revision.h                          |   2 +
 t/t4202-log.sh                      |  40 ++++++++++
 4 files changed, 154 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
index 2d195a1474..e8c88d0f1c 100644
--- a/Documentation/rev-list-options.adoc
+++ b/Documentation/rev-list-options.adoc
@@ -16,7 +16,10 @@ ordering and formatting options, such as `--reverse`.
 `-<number>`::
 `-n <number>`::
 `--max-count=<number>`::
-	Limit the output to _<number>_ commits.
+	Limit the output to the first _<number>_ commits that would be shown.
+
+`--max-count-oldest=<number>`::
+	Limit the output to the last _<number>_ commits that would be shown.
 
 `--skip=<number>`::
 	Skip _<number>_ commits before starting to show the commit output.
diff --git a/revision.c b/revision.c
index 599b3a66c3..5d53db3152 100644
--- a/revision.c
+++ b/revision.c
@@ -2339,10 +2339,28 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	}
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die_for_incompatible_opt2(1, "--max-count", 1,
+						  "--max-count-oldest");
 		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
+		revs->max_count_type = 0;
 		return argcount;
+	} else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
+		if (revs->max_count_type == 0 && revs->max_count != -1)
+			die_for_incompatible_opt2(1, "--max-count", 1,
+						  "--max-count-oldest");
+		if (revs->skip_count > 0)
+			die_for_incompatible_opt2(1, "--skip", 1,
+						  "--max-count-oldest");
+		revs->max_count = parse_count(optarg);
+		revs->no_walk = 0;
+		revs->max_count_type = 1;
+		revs->max_count_stage = 0;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
+		if (revs->max_count_type == 1)
+			die_for_incompatible_opt2(1, "--skip", 1,
+						  "--max-count-oldest");
 		revs->skip_count = parse_count(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
@@ -4521,15 +4539,91 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	return c;
 }
 
+static void retrieve_oldest_commits(struct rev_info *revs,
+				    struct commit_list **queue)
+{
+	struct commit *c;
+	int max_count = revs->max_count;
+	int queuei_count = 0;
+	int queueo_count = 0;
+	struct commit_list *queueo = NULL;
+	struct commit_list *queuei = NULL;
+	struct commit_list *reversed_queue = NULL;
+	struct commit_list *p;
+
+	revs->max_count = -1;
+	while ((c = get_revision_internal(revs))) {
+		/*
+		 * We need to reset SHOWN status otherwise --graph breaks.
+		 * It is fine to do, get_revision_internal() doesn't consider
+		 * children commits as they have been already processed and the
+		 * traversal happens only child to parent.
+		 *
+		 * We do this because the --graph machinery relies on the status
+		 * of the parents to decide how the printing will happen.
+		 *
+		 * We can't simply replace this instruction with a
+		 * graph_update() as it doesn't do the actualy printing, we'd
+		 * have to remove any commit that goes over the
+		 * --max-count-oldest limit from revs->graph.
+		 */
+		c->object.flags &= ~(SHOWN | CHILD_SHOWN);
+		commit_list_insert(c, &queuei);
+		if (!(c->object.flags & BOUNDARY))
+			queuei_count++;
+		while (queuei_count + queueo_count > max_count) {
+			if (!queueo_count) {
+				while ((c = pop_commit(&queuei))) {
+					commit_list_insert(c, &queueo);
+					queueo_count++;
+				}
+				queuei_count = 0;
+			}
+			c = pop_commit(&queueo);
+			queueo_count--;
+			/* We need to do this otherwise we'll discard the
+			 * commits that go over the --max-count-oldest limit but
+			 * not their respective boundaries. This matters only if
+			 * we're discarding the commit right before the boundary.
+			 */
+			for (p = c->parents; p; p = p->next)
+				p->item->object.flags &= ~CHILD_SHOWN;
+		}
+	}
+
+	while ((c = pop_commit(&queueo)))
+		commit_list_insert(c, &reversed_queue);
+	while ((c = pop_commit(&queuei)))
+		commit_list_insert(c, &queueo);
+	while ((c = pop_commit(&queueo)))
+		commit_list_insert(c, &reversed_queue);
+
+	while ((c = pop_commit(&reversed_queue)))
+		commit_list_insert(c, queue);
+}
+
 struct commit *get_revision(struct rev_info *revs)
 {
 	struct commit *c;
 	struct commit_list *reversed;
+	struct commit_list *queue = NULL;
+	struct commit_list *p;
+
+	if (revs->max_count_type == 1 && !revs->max_count_stage) {
+		retrieve_oldest_commits(revs, &queue);
+		commit_list_free(revs->commits);
+		revs->commits = queue;
+		revs->max_count_stage = 1;
+	}
 
 	if (revs->reverse) {
 		reversed = NULL;
-		while ((c = get_revision_internal(revs)))
-			commit_list_insert(c, &reversed);
+		if (revs->max_count_type == 1)
+			while ((c = pop_commit(&revs->commits)))
+				commit_list_insert(c, &reversed);
+		else
+			while ((c = get_revision_internal(revs)))
+				commit_list_insert(c, &reversed);
 		commit_list_free(revs->commits);
 		revs->commits = reversed;
 		revs->reverse = 0;
@@ -4543,7 +4637,18 @@ struct commit *get_revision(struct rev_info *revs)
 		return c;
 	}
 
-	c = get_revision_internal(revs);
+	if (revs->max_count_stage) {
+		c = pop_commit(&revs->commits);
+		if (c) {
+			c->object.flags |= SHOWN;
+			if (!(c->object.flags & BOUNDARY))
+				for (p = c->parents; p; p = p->next)
+					p->item->object.flags |= CHILD_SHOWN;
+		}
+	} else {
+		c = get_revision_internal(revs);
+	}
+
 	if (c && revs->graph)
 		graph_update(revs->graph, c);
 	if (!c) {
diff --git a/revision.h b/revision.h
index 584f1338b5..e157463cb1 100644
--- a/revision.h
+++ b/revision.h
@@ -309,6 +309,8 @@ struct rev_info {
 	/* special limits */
 	int skip_count;
 	int max_count;
+	unsigned int max_count_type:1;
+	unsigned int max_count_stage:1;
 	timestamp_t max_age;
 	timestamp_t max_age_as_filter;
 	timestamp_t min_age;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 05cee9e41b..75edb0eb38 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1882,6 +1882,46 @@ test_expect_success 'log --graph with --name-status' '
 	test_cmp_graph --name-status tangle..reach
 '
 
+test_expect_success 'log --max-count-oldest=3 --oneline' '
+	test_when_finished rm expect &&
+	git log --oneline | tail -n3 >expect &&
+	git log --oneline --max-count-oldest=3 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --max-count-oldest=3 --reverse --oneline' '
+	test_when_finished rm expect &&
+	git log --oneline --reverse | head -n3 >expect &&
+	git log --oneline --max-count-oldest=3 --reverse >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --max-count-oldest with --max-count' '
+	test_when_finished rm stderr &&
+	test_must_fail git log --max-count-oldest=3 --max-count=3 2>stderr &&
+	test_grep "cannot be used together" stderr
+'
+
+test_expect_success 'log --max-count-oldest with --skip' '
+	test_when_finished rm stderr &&
+	test_must_fail git log --max-count-oldest=3 --skip=1 2>stderr &&
+	test_grep "cannot be used together" stderr
+'
+
+test_expect_success 'log --max-count-oldest=1000 --graph --boundary' '
+	test_when_finished rm expect actual &&
+	git log --graph --boundary >expect &&
+	git log --max-count-oldest=1000 --graph --boundary >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --oneline --graph --boundary --max-count-oldest=1' '
+	test_when_finished rm -f actual &&
+	git log --oneline --graph --boundary --max-count-oldest=1 \
+		HEAD~1..HEAD >actual &&
+	test_line_count = 2 actual
+'
+
 cat >expect <<-\EOF
 * reach
 |
-- 
2.54.0-514-g9d901a57fc

