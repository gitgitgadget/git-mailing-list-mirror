Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5936DC142
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719384785; cv=none; b=Nbt2LIcYL/MGZoaajOZN4mUvI88gyIQIimKwvFDH15WsLHCkWFQc/cO40i3U0bkSiDQCk31pD143xUZ8saiszAqJE9gMID7nd0Trg++7pFsEb7UH24ftf/UBIb4t8PHBs/+8b3LIVyF5kHouiiCCobrxtvYbxD81o/uEYMM3Jlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719384785; c=relaxed/simple;
	bh=AuTHxbWZIJz4WHBWmD49FHnRioSGhaioJ09qqanDah8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHbxMj3Ui3Q399YdBqxbz//evjPDcxpmnJfevAlocMf8+fGhh61vy6WMF84Jk2akz2mUODpQt76fFdDE0AkyhCQVU1BhLSforrXRaf9bVPl/ltwR8gU1hIq4OoyHtHY5ceZmO+woimvrUFYXhjEkSp31jM86TdQaWkZ5QGe2phE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZBTdkhX; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZBTdkhX"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3d21e7aab20so409140b6e.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 23:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719384783; x=1719989583; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IzZG7pKmJ0/k1uxdFlFjaazcDnoq4+YZLD/09FsjhvQ=;
        b=VZBTdkhXdr/q7HhRhb/swI034T05TcGDyFWncgkW+iadGPl/dw8C3Lzx5kzVBLkyfH
         k9e76J4zb3KAI5oHfNMZRoistJZh1hpuuBgFnncWkDdheDHxk4rDR36uhS3oLrpyToBK
         lv4I+ztVZOalMjE3yfZw5+UdQT5vJeNt2HBbZoJ7dYlj025nCEsz2JAip07UCPpn++2+
         qivuQIjCqPLNKxf4p3b6oP74T1N6niLc679e1pmKZTGIYdllSHYN52DUsIbACAtJoDWX
         /KqC9vHmwCCkOBRFXvhMrjwPBDgyY3UTpuc4xZVnYfGx5AEHnubcGrcoHnnD+tFTX4IA
         3FbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719384783; x=1719989583;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IzZG7pKmJ0/k1uxdFlFjaazcDnoq4+YZLD/09FsjhvQ=;
        b=mjHPS0Qj7G82j1ZsI31SPjjEpap8ke/fKN9DpcM5M0+MWB9ceUXPrlqdmt43Grayz0
         4wAndK0M7G04c7KqP8a5IJuhNfzucywiX/Gw5C23mCeuIj/lz31sUJrqDYvrt1dPbOVY
         n+ic0OY4Rv60YCVvqlG7ZrJ8GR0cW79xBzD9n8hRgIvNHgGyfa4iGEfT/HkPbFOHpBd3
         Shd6JZoK7qGv/g3ZJGk85Nl8pEqiXn65OvrIrzdiXWfYI2vBZazFJKeiBgtgzAvG9pn0
         h23L680tjyklTuJxZLnbteCUBXIUy1kZK0yJnbXqwP8FABmd046lPFnVmSzC8J9r2Mr6
         lanQ==
X-Gm-Message-State: AOJu0YxntiCzRJcVaxW7bTxjOSOyQn5prceGAo6OwXruVejgk2G5Qcf8
	P/aLAbhImfWISEEfx/N/00QbpVsGX8ypinaxkRFFLfflP8T84cguM/auiGW6Mck=
X-Google-Smtp-Source: AGHT+IHGFaibv4P7cPfAB6wtOqZ91FtgE+rJAos5sYpB8H2T5dJnFqPgD9AP+NcugY7nTO7dW2/+Yg==
X-Received: by 2002:a05:6808:33c3:b0:3d5:4780:2d75 with SMTP id 5614622812f47-3d547803532mr8007094b6e.4.1719384781949;
        Tue, 25 Jun 2024 23:53:01 -0700 (PDT)
Received: from TTPL-LNV-0102.. ([2409:40c2:205a:5198:5a00:e7e1:cbf1:679])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-716bb22e148sm8122947a12.85.2024.06.25.23.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jun 2024 23:53:01 -0700 (PDT)
From: Abhijeet Sonar <abhijeet.nkt@gmail.com>
To: git@vger.kernel.org
Cc: Abhijeet Sonar <abhijeet.nkt@gmail.com>,
	Paul Millar <paul.millar@desy.de>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH v5] describe: refresh the index when 'broken' flag is used
Date: Wed, 26 Jun 2024 12:22:11 +0530
Message-ID: <20240626065223.28154-1-abhijeet.nkt@gmail.com>
X-Mailer: git-send-email 2.45.2.606.g9005149a4a.dirty
In-Reply-To: <xmqq34p1813n.fsf@gitster.g>
References: <xmqq34p1813n.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When describe is run with 'dirty' flag, we refresh the index
to make sure it is in sync with the filesystem before
determining if the working tree is dirty.  However, this is
not done for the codepath where the 'broken' flag is used.

This causes `git describe --broken --dirty` to false
positively report the worktree being dirty if a file has
different stat info than what is recorded in the index.
Running `git update-index -q --refresh` to refresh the index
before running diff-index fixes the problem.

Also add tests to deliberately update stat info of a
file before running describe to verify it behaves correctly.

Reported-by: Paul Millar <paul.millar@desy.de>
Suggested-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Abhijeet Sonar <abhijeet.nkt@gmail.com>
---
 builtin/describe.c  | 11 +++++++++++
 t/t6120-describe.sh | 24 ++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/builtin/describe.c b/builtin/describe.c
index e5287eddf2..7cb9d50b36 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -53,6 +53,10 @@ static const char *diff_index_args[] = {
 	"diff-index", "--quiet", "HEAD", "--", NULL
 };
 
+static const char *update_index_args[] = {
+	"update-index", "--unmerged", "-q", "--refresh", NULL
+};
+
 struct commit_name {
 	struct hashmap_entry entry;
 	struct object_id peeled;
@@ -645,6 +649,13 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
 	if (argc == 0) {
 		if (broken) {
 			struct child_process cp = CHILD_PROCESS_INIT;
+			strvec_pushv(&cp.args, update_index_args);
+			cp.git_cmd = 1;
+			cp.no_stdin = 1;
+			cp.no_stdout = 1;
+			if (run_command(&cp))
+				child_process_clear(&cp);
+
 			strvec_pushv(&cp.args, diff_index_args);
 			cp.git_cmd = 1;
 			cp.no_stdin = 1;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index e78315d23d..6c396e7abc 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -671,4 +671,28 @@ test_expect_success 'setup misleading taggerdates' '
 
 check_describe newer-tag-older-commit~1 --contains unique-file~2
 
+test_expect_success 'describe --dirty with a file with changed stat' '
+	git init stat-dirty &&
+	(
+		cd stat-dirty &&
+
+		echo A >file &&
+		git add file &&
+		git commit -m A &&
+		git tag A -a -m A &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual &&
+
+		cat file >file.new &&
+		mv file.new file &&
+		git describe --dirty --broken >actual &&
+		echo "A" >expected &&
+		test_cmp expected actual
+	)
+'
+
 test_done

Range-diff against v4:
1:  1da5fa48d9 ! 1:  52f590b70f describe: refresh the index when 'broken' flag is used
    @@ builtin/describe.c: int cmd_describe(int argc, const char **argv, const char *pr
     +			cp.git_cmd = 1;
     +			cp.no_stdin = 1;
     +			cp.no_stdout = 1;
    -+			run_command(&cp);
    -+			strvec_clear(&cp.args);
    ++			if (run_command(&cp))
    ++				child_process_clear(&cp);
     +
      			strvec_pushv(&cp.args, diff_index_args);
      			cp.git_cmd = 1;
-- 
2.45.2.606.g9005149a4a.dirty

