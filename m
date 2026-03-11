Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB073374180
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 06:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773211474; cv=none; b=csvdn7KYs5huigSOlU1XI03B69CtTipKd2ztoFUfgwBIh00YFUlnpuyk1TwhLusVZgb6YWhGurkMkDDV+YJluZ/8u1V9D9L2VGYgEzbVvRO0wYqzB9aICLRzWwEEY0IVXKt0QMZTRmKnw8k920jpuldn0wy+diT5Yx/10dV8iAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773211474; c=relaxed/simple;
	bh=R4cCzE9KZ3pKzCBIoJaANe5E/aeXHxWHs5qUZspNTvY=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=BaIHRSdEst7bAjWtN53gYKwKmiHEv0brS/aqdbGo+V7cpNK16aEu5rHU3y3eBbuF2QDLHwVwKbY3HMO6tE6Ve3fwuM5I0Oxn/RuyIUi/8GvwaKowy2XpU922aarOWH/w+JEFJxvXGnR6WsXdLgInmljHGKFOQpWw1t/ZuWJRkRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk; spf=none smtp.mailfrom=git.strova.dk; dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b=olhYyoH0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6qNDrqf; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=git.strova.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=strova.dk header.i=@strova.dk header.b="olhYyoH0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6qNDrqf"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 09E9A140023A;
	Wed, 11 Mar 2026 02:44:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-09.internal (MEProxy); Wed, 11 Mar 2026 02:44:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=strova.dk; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773211472;
	 x=1773297872; bh=iBDSPkaOGH8QS3Dxq/x01Rks6hsDAAJLWB/fCUex1nQ=; b=
	olhYyoH0asDD6U7FdjWy312THnEF1YCAHsLKPo6oUBuPzDZ7fPTnU2dKfH9WEV/3
	AY/7SIKUKxrVYVC6d7NzrWb6G4jf0V1ccmDOwWwvV/pqFhkHSMhWe3jJ1JJQk9Sv
	/n06dZKpKzQnMHYRFxcLfDi0qRudy2pY0ZSKeP9ochTlQI8Qa61MB8//skreVTLe
	6zCfqaeYM7j29OmfCsaT0zsim7hDZtwO65VJxRf1jRQSVELV7sziKgcHSs8HM/kD
	AuR3BfTxcNTFnsM4ai2tF9wGNfeVK5FtnXIm6ZKANGYWw0rCR37w17r7zN2/vygD
	PmqMzfGKoi6GbzJQbZIQlw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773211472; x=
	1773297872; bh=iBDSPkaOGH8QS3Dxq/x01Rks6hsDAAJLWB/fCUex1nQ=; b=h
	6qNDrqfXrkUB3BkRO4VevPVENa06LWtJH9RR7qgbKmVrqXPV6JFFFXM+88+HNP7+
	LIzwAZ8DSNRrtSqSqqVfLLe3MBRzfruGQKYFr3FLhVmAkqMKTgjZXINKDnmwtd4x
	+ebMR/i9YCrHjLqco7+z4lt5MXfG/VVm8Uc4Gx+HVNP5j+5h0DOOMG4dSaHNgn0m
	2HH+dEk3MQ1C6QaPeEylssyOiDxj6/gPBJPF1WQ4NJ4x8syyuKdYS40Em0c/Zri/
	jI1cVopiFhfIfoaPe3pFjCxra809gRs7PDY+jN46+tlr/PH2AUOYPMUbkeLIocan
	yObLwwsGB0utagkQ+jKHg==
X-ME-Sender: <xms:Tw-xafnMncHicg1x0PxTlsVmK3o6AvdEF6GlPWX46BwkOstyIvqdhA>
    <xme:Tw-xadrPcvUNHWd5PN90KqPeP3YHfWHDsdfixMMtzhl0_nSagXOAbSZQcsG6TuSUz
    PPwOfrbBt8GtSwD0LamS2y0YDSsJPy_3rKMIEXw3zWkrS--IP7knhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeefvdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfofgrthhh
    ihgrshcutfgrvhdfuceomhesghhithdrshhtrhhovhgrrdgukheqnecuggftrfgrthhtvg
    hrnhepffeggedtgfehheefieejfeduhfejgeefuefghfevgeeftdehleeitddvgfefhfdv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesgh
    hithdrshhtrhhovhgrrdgukhdpnhgspghrtghpthhtohepjedpmhhouggvpehsmhhtphho
    uhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrd
    hnvghtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguseguuhhnvghlmhdrohhrghdr
    uhhkpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepjh
    hohhhntggrihekieesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdrihhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:Tw-xaeAJEWHYkMv0r45EQEyteyiwi7IgZwZ68WCGc6-5NNVBzkgOMg>
    <xmx:Tw-xaQLQenGFpkBfdz1kFG3fXJ3cvCiMAu6dwoZwCFlkFPJZIAkhww>
    <xmx:Tw-xafNXbbTP0OXL5t5nAAFsP7mpYh8AD4yqQEazfTbBmAek7Y40bg>
    <xmx:Tw-xaW6CI3GRS0ZnHcrry5aOv5hI321JBI1qqKj_VkhttxuIcvsjgA>
    <xmx:UA-xaTs2XD7y5rOpfGGCG18lls4yQLtXeVu88vo6QQOm_MQSUex8iacv>
Feedback-ID: ic5d648a2:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30FB3700065; Wed, 11 Mar 2026 02:44:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AaOh3R4_o__g
Date: Wed, 11 Mar 2026 06:44:06 +0000
From: "Mathias Rav" <m@git.strova.dk>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "John Cai" <johncai86@gmail.com>,
 =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= <avarab@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Patrick Steinhardt" <ps@pks.im>, git@vger.kernel.org
Message-Id: <c076edd0-9057-443b-ba37-33aacde2eede@app.fastmail.com>
In-Reply-To: <xmqqh5qntpvy.fsf@gitster.g>
References: <86e5c9f7-cd99-4c4f-a852-f3b1ada53722@app.fastmail.com>
 <abATPiRUczb8fe4t@pks.im> <xmqqh5qntpvy.fsf@gitster.g>
Subject: [PATCH v2] merge-file: fix BUG when --object-id is used in a worktree
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

The `--object-id` option was added in commit e1068f0ad4
(merge-file: add an option to process object IDs, 2023-11-01)
together with a call to setup_git_directory() to avoid crashing
when run outside a repository.

However, the call to setup_git_directory() is redundant when run inside
a repository, as merge-file runs with RUN_SETUP_GENTLY, so the
repository has already been set up. The redundant call is harmless
when linked worktrees are not used, but in a linked worktree,
the repo_set_gitdir() function ends up being called twice.

Calling repo_set_gitdir() used to be silently accepted, but commit
2816b748e5 (odb: handle changing a repository's commondir, 2025-11-19)
changed this to a BUG in repository.c with the error message:
"cannot reinitialize an already-initialized object directory".

Guard the redundant call to setup_git_directory() behind a repo pointer
check, to ensure that we continue to give the correct "not a git repo"
error whilst avoiding the BUG when running in a linked worktree.

Signed-off-by: Mathias Rav <m@git.strova.dk>
---
Thanks Karthik, Patrick, Kristoffer and Junio for your feedback.
I've incorporated the sum of it all in this PATCH v2:

- Check !repo before object_id and add a comment
- Use term "linked worktree" instead of just "worktree" throughout
- Use git -C instead of a subshell in test
- Remove gitk's quotes from the commit references in the commit message

As for the quotes in the commit references, I use gitk's "Copy commit
reference" daily and am personally used to the quotes. Since
SubmittingPatches seems to give equal preference to --pretty=reference and
"Copy commit reference" I didn't think that the quotes were a problem.
(I wonder how controversial it would be to remove the quotes in gitk.)

 builtin/merge-file.c  | 5 +++--
 t/t6403-merge-file.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..cc8fda3b5b 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
 int cmd_merge_file(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	const char *names[3] = { 0 };
 	mmfile_t mmfs[3] = { 0 };
@@ -110,7 +110,8 @@ int cmd_merge_file(int argc,
 			return error_errno("failed to redirect stderr to /dev/null");
 	}
 
-	if (object_id)
+	if (!repo && object_id)
+		/* emit the correct "not a git repo" error in this case */
 		setup_git_directory();
 
 	for (i = 0; i < 3; i++) {
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 06ab4d7aed..ed7eec8f93 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -506,6 +506,15 @@ test_expect_success '--object-id fails without repository' '
 	grep "not a git repository" err
 '
 
+test_expect_success 'run in a linked worktree with --object-id' '
+	empty="$(test_oid empty_blob)" &&
+	git worktree add work &&
+	git -C work merge-file --object-id $empty $empty $empty >actual &&
+	git worktree remove work &&
+	git merge-file --object-id $empty $empty $empty >expected &&
+	test_cmp actual expected
+'
+
 test_expect_success 'merging C files with "myers" diff algorithm creates some spurious conflicts' '
 	cat >expect.c <<-\EOF &&
 	int g(size_t u)
-- 
2.53.0
