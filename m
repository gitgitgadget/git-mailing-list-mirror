Received: from mail.srv.csmantle.top (mail.srv.csmantle.top [77.93.157.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461FB503BDF
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.157.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791903883; cv=none; b=Zd+AxR0y+5NwqysXSUTUhCeYQ2z0Yg9wxTSVQdbEs/zdTl7Mt9mKzgqO/r1982GDDerraEXpfK+z9CaThB0Wt2zShqOQfhDxVUd1bBpOI6AJC7BvD7f4sYIW35mEDsobNNlUGZdQXMFqXkzMsP3hbldcKEhNx1VZ7P/veq+ThJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791903883; c=relaxed/simple;
	bh=J+VcPBPNzFCMcVfe0jTL7EiImPvP+hR5XSOM12Tn21A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=axw5OqxB8N8Vz4hnV15jSkKdUFx1SYysx9Yxj/aE/kuXRGck1EHd3VTb47AwpFHVbc7bxKMQ1pnkmyZcjQzKQA3uToLsDTXJtBy/IIQniNID6B0V0ROVcfB8dZUmNm7vkS+Haj5CX/Q5E6uyN+g4phRvwARNzTe3cNwcgckLcXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top; spf=pass smtp.mailfrom=csmantle.top; dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=n3tPxRuP; dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b=buNC8BvH; arc=none smtp.client-ip=77.93.157.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csmantle.top
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csmantle.top
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="n3tPxRuP";
	dkim=pass (3072-bit key) header.d=csmantle.top header.i=@csmantle.top header.b="buNC8BvH"
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-ed25519; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=qXNT+/0mrxHTC+FyXModhcKD2AnaCkYkIp/EntQ5MrY=; t=1791903882; x=1792508682; 
	b=n3tPxRuPvOpIR5UVe9ZOzI3Qb09DqfANPwfumDqAbrWaRpNh7/SeXjfE5K+PWSDY/5nR0Z/Ijq1
	qnjaPsKu7Cg==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=csmantle.top; s=self-rsa3072; h=BIMI-Selector:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:In-Reply-To:References:BIMI-Selector;
	bh=qXNT+/0mrxHTC+FyXModhcKD2AnaCkYkIp/EntQ5MrY=; t=1791903882; x=1792508682; 
	b=buNC8BvHaC9mv252dye549OQ9ufHw6IgBlUxVxJbSwE25SuCKhWfceVvHc9Xiqr76uwQAg4D/vh
	4kgdJDq7xNgRuyCMCr1T1WNv8sG3wD2GTfgDjnAKatdYmBhMqPDScVgn+D3qkCt2XQL9C742S5dbK
	+q4N5Y9ntCxLQ6oqaHwQqHAvNvKK6qYLjn8snInArexYuwDMNXzgVhm1a6xtfsfzqKoBB5Wv4n+2H
	2Qv6RaOscrLhy75wWtxNXjbYEmhAA4AvQoD+eQjHEVokYw5xy5zvWeT0X6lKjsq9B1Z8TYMJX+jLI
	kdP3TkBLFLy9M6352VZ0Bywa4kaycePAbL3VdPEY4J1zWvQdvbBtOOucm8wWTZFw0cER53lIDOJ8y
	Zxt4LKojlJEvs61IC28uanUMp0aW3KcZqgHz6nqb1bdPw46APn7TTfpW1XbcNnn8o1yqb6C/BDaZ8
	APmupqWbVXFwF46KospefJFkOorlOeXErukyDe3JRT79K51siWlE;
Received: from [203.88.122.33] (helo=loongcatbox)
	by mail.srv.csmantle.top with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rong.bao@csmantle.top>)
	id 1xGdkJ-00000000O7P-3ufV;
	Tue, 13 Oct 2026 22:44:52 +0800
From: Rong Bao <rong.bao@csmantle.top>
To: git@vger.kernel.org
Cc: Mingcong Bai <jeffbai@aosc.io>,
	Rong Bao <baorong2005@126.com>,
	Rong Bao <rong.bao@csmantle.top>,
	Tamino Bauknecht <dev@tb6.eu>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fetch: fix --depth= and --unshallow for multi-remote fetches
Date: Tue, 13 Oct 2026 22:44:39 +0800
Message-ID: <20261013144441.1632978-1-rong.bao@csmantle.top>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rcpt-Check: Accepted by authentication
X-42: Don't panic! 
BIMI-Selector: v=BIMI1; s=me

When running `git fetch --all --depth=<SOME-DEPTH>` or `git fetch --all
--unshallow` with Git 2.56.0, the fetch isn't really deepened:

        $ git init remote
        Initialized empty Git repository in /tmp/test/remote/.git/
        $ for i in 1 2 3; do echo "$i" >remote/"$i" && git -C remote add -A && git -C remote commit -m "$i"; done
        [... snip ...]
        $ git clone --depth 1 --no-local remote local
        Cloning into 'local'...
        remote: Enumerating objects: 5, done.
        remote: Counting objects: 100% (5/5), done.
        remote: Compressing objects: 100% (2/2), done.
        remote: Total 5 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
        Receiving objects: 100% (5/5), done.
        $ git -C local log --format='%s'
        3
        $ git -C local remote add origin2 ../remote
        $ git -C local fetch --all --unshallow
        Fetching origin
        Fetching origin2
        From ../remote
         * [new branch]      main       -> origin2/main
        $ git -C local log --format='%s'
        3
        $ git -C local fetch --all --depth=3
        Fetching origin
        Fetching origin2
        $ git -C local log --format='%s'
        3

This is because the parent process doesn't pass the --depth= flag to the
fetcher subprocess.

        [pid 1622822] execve("/usr/lib/git-core/git", ["/usr/lib/git-core/git",
        "-c", "fetch.bundleURI=", "fetch", "--append", "--no-auto-gc",
        "--no-write-commit-graph", "origin"], 0x5555c4b65ae0 /* 54 vars */) = 0

Fix this by passing it when specified or implied by --unshallow. After
fixing, both flags would work on shallow trees in conjunction with
--all, as demonstrated below:

        > ~/workspace/git/build/git -C local fetch --all --unshallow
        Fetching origin
        remote: Enumerating objects: 5, done.
        remote: Counting objects: 100% (5/5), done.
        remote: Compressing objects: 100% (3/3), done.
        remote: Total 4 (delta 1), reused 0 (delta 0), pack-reused 0 (from 0)
        Unpacking objects: 100% (4/4), 345 bytes | 345.00 KiB/s, done.
        Fetching origin2
        remote: Total 0 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
        > ~/workspace/git/build/git -C local log --format='%s'
        3
        2
        1

Signed-off-by: Rong Bao <rong.bao@csmantle.top>
---
 builtin/fetch.c           |  2 ++
 t/t5514-fetch-multiple.sh | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2decc6cfdb8ae86b8b1e92caa85f4961ffc47ff..a110a2dcf09c7e6764eb232bff73286753b27009 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -2247,6 +2247,8 @@ static void add_options_to_argv(struct strvec *argv,
 		strvec_push(argv, "--tags");
 	else if (tags == TAGS_UNSET)
 		strvec_push(argv, "--no-tags");
+	if (deepen)
+		strvec_pushf(argv, "--depth=%s", depth);
 	if (verbosity >= 2)
 		strvec_push(argv, "-v");
 	if (verbosity >= 1)
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 5d79472c39f67126079da5432938c6d97f08008a..b6568d33d7a6dd725a72584fbad942d6b3f7c39b 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -383,4 +383,38 @@ test_expect_success 'git fetch --no-all --all (fetch all remotes)' '
 	)
 '
 
+test_expect_success 'git fetch --all --depth=2 (fetch all remotes with depth 2)' '
+	setup_repository test16 &&
+	git clone --no-local --no-single-branch --depth=1 test16 test17 &&
+	(
+		cd test17 &&
+		git remote add remote2 ../test16 &&
+		test_path_is_file .git/shallow &&
+		git fetch --all --depth=2 &&
+		test_path_is_missing .git/shallow &&
+		git log --format=%s origin/side >actual1 &&
+		git log --format=%s remote2/side >actual2 &&
+		test_write_lines Second Initial >expect &&
+		test_cmp expect actual1 &&
+		test_cmp expect actual2
+	)
+'
+
+test_expect_success 'git fetch --all --unshallow (fetch all remotes with full history)' '
+	setup_repository test18 &&
+	git clone --no-local --no-single-branch --depth=1 test18 test19 &&
+	(
+		cd test19 &&
+		git remote add remote2 ../test18 &&
+		test_path_is_file .git/shallow &&
+		git fetch --all --unshallow &&
+		test_path_is_missing .git/shallow &&
+		git log --format=%s origin/side >actual1 &&
+		git log --format=%s remote2/side >actual2 &&
+		test_write_lines Second Initial >expect &&
+		test_cmp expect actual1 &&
+		test_cmp expect actual2
+	)
+'
+
 test_done

base-commit: 6de20f6092dcf9bdb1c8efe03db4b70c82b423dd
-- 
2.56.0

