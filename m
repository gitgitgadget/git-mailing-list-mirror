Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795632938;
	b=ODcYtNtaN47IBbJf4UQo+aWgk+Ir2KEFwNIW3uFm3YdGRnfaVOWPkVLIWHNdxZpq8WoM
	 Pt0m3FfL99AZdGP/Mygv3ALw8EEJw25veMkL5i5/ulk7qiJeAzWchP3mRXw+fJx7opzUI
	 a3vIStmB6Myb9grac+oVEwph5mDSKNDekOLA5ong6uFCKAgsArK3yMlw0Mr6eXNsTCo6z
	 w51dznJXwjG2ardRlFrflXg/+l4Za7J8X5V+5WTUD9HxKqAlJd0o8+Src2LLMigfGN7zX
	 xuPaymAbpBK91MUA3zSoGCdR3Zo+bfVv9DugM9h0Hpx05g6fsJs/9GIe+T9hJw5ZVQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795632938;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=EtIhLjY75jmKxciFbREU0c4A18lzpzPvvtmZhG8geY4=;
	b=O4Rd3jPyiL3MnZaf7TN8OJHJqr901LLWN3U4LJ3OclWvDxSrclYRU8IzC4HLZsJM6QYe
	 pFgCgT+g+k72nAqop4U1rVn8Yt0mnoatSxHNpXepPDNOkUuDE1xph4289+PncS2tvdd2f
	 B7MQDIzRO+3Gf8AHBerNts9CG/UkuB1rW+FgYmE+5HFSuUaa5BqX0HfwAmkzWPxKk1xud
	 /R7FKQH7cC/574lTyddrjJ62qMTxxm8s8j0Va0T/JxTU9Tgk2LLMzZH+Z5dpWzXD8bOnL
	 LwStwlSZUrntCFEsN3wJKgLGm0L1/1AKNIsy3/K1jd/6n8sWHzvMKlMp6sZIwClLatw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6MvSYHJ;
	arc=none smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9141606A329
	for <git@vger.kernel.org>; Wed, 25 Nov 2026 18:55:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9141606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Z6MvSYHJ
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5366ae57896so62705411cf.3
        for <git@vger.kernel.org>; Wed, 25 Nov 2026 10:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795632937; x=1796237737; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EtIhLjY75jmKxciFbREU0c4A18lzpzPvvtmZhG8geY4=;
        b=Z6MvSYHJS1fxYvJeg+M3Trk1TOGvmiT+SPwg3WxEui1otiPKQq5s2R7/1EDnans4lm
         Ik9wD77XoyZH+2JfmVy9hXYDsYv1yAtLnlYUBG5bjpwdAcnIS3V8TaYHshC+YR6Ve6a8
         dtPPX7BnWqFP8m20R8dz8CVqrsDWEufrUU7y2C6jCGMG41hmPHIt79qs/d1HWOFkN8ZK
         z/MmbBdMQx8Frl6cAkhHNq6TKfMUgTWQgSTZE5NhnChpwrWCPa0aLfNvbH0ACqEt+yKK
         BjsLWJgGp/5UEPBvtgXVOfVMoWCkygsKkQdjfYgqvW5Z2/x8UuuE3sJSxROTDopgmI0N
         EmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795632937; x=1796237737;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EtIhLjY75jmKxciFbREU0c4A18lzpzPvvtmZhG8geY4=;
        b=NxUlXLnKQ3tURWHCHjFghkMqhjj2jS670G/sDQkq0+ATMu4gZuGbLzmyJcTOqodyax
         bgTzZzRhLFXkA8++NF1LQ1hbgDGB6n1BgMECu6TqHTEVLRXv1We/Ta3DB0D0cOp5EISm
         jnryppEso1VLL3jC9GfluA9JQWEKa56p1CrRTFRZwRFuguidPNnWlwC+DuLQSn7IvwSF
         lgGl3cTfJa8ohLQXEZB1+2aa9dJEtGTZmkSWuIfrYUqOJOX5DVXIVr3M3Z7E7qqLWGfE
         rzKcZGnu3ti0ya2rtJJHKX5BTJVywyWowfxIMOPPyKjQQYWhWU7j83SzIUzHaYOhjSrQ
         Ta2w==
X-Gm-Message-State: APuU4Z8eGksQXY/VvadfU/jylwrtzrtW8TajiTeNYmGN658NpE1vpwIS
	oXEixIpjkUfIJylIArprnEtQ6d5eUmli6sxit+rujZOgCYrKym3C668DiuxgZGyA
X-Gm-Gg: AZFdTZc8sgLK7UTdgSavFHOd269HDqsJR+G4zjw4UKT2H1NHFIRE6vXY3XZcDm0WKai
	AYcp3YQbvsn0sv5aVZFum9+YqcObEaK7F2UMk6julFqdiwYek3bvZzgrZ7B1PVFLr/zFRvFLPQb
	rMJnzLhvZ09Tz3p43xB6ai56n7EwvlwAhyyNMHdt7yMJVeEY8qNrp3eeNrwS4XZxhtRs3PR2bDx
	UhqptI4LL5KWjchcHfqQ5nBLnlgWtpvy+ezBO+nJwTaj1WbWfB9VFHPcHxZsaNYURs2bxnu4PMS
	7Ah70Vy+g9bVdv1yUEtZ4Vi/gIMX8ieWLvYyOQBwFyeFpL5uxERH5WEgV5A43EvbNmWAEMum4DQ
	l2zFhAmeq9gwdDYQ3ZetdfKbjgM86rB8AaiTGAfBWMppildHF11V2Iy5jV2EP9sa6UjblC5kc0S
	oQeHeq2ma8up3SZjzCOYR0kDMgYpDb78/Ssirpjwa8tc0fdv4J8xsf7xVgsVbiSulEQcTO8zx1d
	z8H8gWctjW3JZiiIa/V2io8sEMXyQy4/dNNBRamPAI8ejPKeRO3Kvl0GRqEMQIW9+u4OVfeu6Ju
	zZeYsM+OQQajRfIWQsQLF6M4P953grQcVQ==
X-Received: by 2002:a05:622a:98e:b0:54b:a422:59b6 with SMTP id d75a77b69052e-55d76938ba0mr342556721cf.7.1795632936782;
        Wed, 25 Nov 2026 10:55:36 -0800 (PST)
Received: from [127.0.0.1] ([20.228.220.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213514d20esm168879436d6.23.2026.11.25.10.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 10:55:36 -0800 (PST)
Message-Id: <b829c46707c53095345ae0480e7e82bd83afef02.1795632934.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
References: <pull.2429.git.git.1795632934.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 25 Nov 2026 18:55:32 +0000
Subject: [PATCH 1/3] remote: reject invalid branch names in add -t
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>,
    Harald Nordgren <haraldnordgren@gmail.com>

From: Harald Nordgren <haraldnordgren@gmail.com>

A typo in "git remote add -t", or a shell that expands something
unexpected like @{u}, silently produced a fetch refspec that could
never match anything, or in some cases outright invalid syntax. Every
later fetch from that remote then failed with a confusing error and
nothing pointed back at the original mistake.

Check each branch name given to -t before anything is written, so the
command fails without creating the remote at all.

Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
---
 builtin/remote.c  | 15 +++++++++++++++
 t/t5505-remote.sh |  7 +++++++
 2 files changed, 22 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index de989ea3ba..63d2db39fe 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -123,6 +123,19 @@ enum {
 #define MIRROR_PUSH 2
 #define MIRROR_BOTH (MIRROR_FETCH|MIRROR_PUSH)
 
+static void validate_tracked_branchname(const char *branchname, int mirror)
+{
+	struct strbuf ref = STRBUF_INIT;
+
+	if (mirror)
+		strbuf_addf(&ref, "refs/%s", branchname);
+	else
+		strbuf_addf(&ref, "refs/heads/%s", branchname);
+	if (check_refname_format(ref.buf, REFNAME_REFSPEC_PATTERN))
+		die(_("'%s' is not a valid branch name"), branchname);
+	strbuf_release(&ref);
+}
+
 static void add_branch(const char *key, const char *branchname,
 		       const char *remotename, int mirror, struct strbuf *tmp)
 {
@@ -211,6 +224,8 @@ static int add(int argc, const char **argv, const char *prefix,
 		die(_("specifying a master branch makes no sense with --mirror"));
 	if (mirror && !(mirror & MIRROR_FETCH) && track.nr)
 		die(_("specifying branches to track makes sense only with fetch mirrors"));
+	for (size_t i = 0; i < track.nr; i++)
+		validate_tracked_branchname(track.items[i].string, mirror);
 
 	name = argv[0];
 	url = argv[1];
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index 5fbfcb0848..055fa42e27 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -266,6 +266,13 @@ test_expect_success 'add invalid foreign_vcs remote' '
 	test_cmp expect actual
 '
 
+test_expect_success 'add -t with an invalid branch name' '
+	echo "fatal: '\''@{u}'\'' is not a valid branch name" >expect &&
+	test_must_fail git remote add -t "@{u}" badtrack bar 2>actual &&
+	test_cmp expect actual &&
+	test_must_fail git config get remote.badtrack.url
+'
+
 test_expect_success 'without subcommand' '
 	echo origin >expect &&
 	git -C test remote >actual &&
-- 
gitgitgadget

