Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4CB37E5F1
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 16:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788365483; cv=none; b=jxLPvOGcRw74U9IoHR1W19PjYoLAlh94Hwrx+e8h9/vsgRj/e4NiVXQxMDTKT+0hvrwrNyAWbRcHzAmErTgQQVMa+alT87Whdthszn6sjKz5854wlbi7WOiX+JFROq/Zy3EduLZOoDn7LnRlcvIP4KGalIKNDB1K42fXOZI0PY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788365483; c=relaxed/simple;
	bh=PRb/z/OcIb2RdojRtNZXQ6P1uVdX/Y4v8funMJ+6OGI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mj0RXrCTUIL07gir3OsY0tqybvHAjpBtiIXZpSYmmqdeqFmO6vIOeyT+YShXcJ0KILXtuRegPcmlnA7Un6FSq9vIPX7Xl+lzmG7ua5DE+cpuh1ubvXa2kePd2HL0W6e8ULvO8Rfz9T+O1U5Szh/Ds5rX0Ku6pqe/PsuRxcAVpTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJ4lALFF; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJ4lALFF"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso328025e9.0
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 09:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788365480; x=1788970280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Zl+LlvtbNfgNhdtitPiITzqiqkJjd6ag71VLsUthwPk=;
        b=ZJ4lALFFNc2zxX7Oci/d9TBnRjLvpuIVFbM7Edet6dNZMISyH2McCYCXFFpmE/BDAM
         X13zJ9QJ7aYT884g0KqRC+2Z2AFRQMWK4Gt46QeZhXjR8SgtuFgUAvs6gRw5urOmOWRb
         kbcecdjVXEasiykU2utow/+ju9m+EN2pwVojO9ZL1xeT1HqP1CGvwdFfg4zpo7vwIz7v
         bA1/kBx5tfQpX6pDkl2gSVBXKgTEG5882YrOTD26IUm+JOHjmecWSYFGrl0bfExHMOJI
         iDrrQSUJ0LXEfFnwo1wBo5zjAx83H6lU+GGUbQMQvEkoFpEQPBYeGUxLIf/wzMmJrg4x
         4zmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788365480; x=1788970280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Zl+LlvtbNfgNhdtitPiITzqiqkJjd6ag71VLsUthwPk=;
        b=myKLwRty0O0VRUvQujRLKVzMaAIGXK7bq7Sd8SSZGOzkS7HV0ks5IRwluRdBX7w4tq
         sKnFY191NB5lqnEvmCcFPXngGSttVMjIQbe8MXakRlHL9iXaypBB0b1fpXIIyk353ekn
         8Q4lJAQOfq3/eSPL2E/Rd2OJTmKUNqOkUm/quU0F7xQeZKoNJbAC1qgbuVZgpNXCF4Xa
         Bupa3keArClj03Ag51cnSDRLcKLyyw4e3p5DidFr+jgRnpN+8IIfa4bdzTA/REAdXaZ1
         bMqloxX2n/Esgc8Zh/P4Y8+lseKOiSaS7K6un50B5XEV3uuI+2OpgooKumPbVoM0bZRg
         1big==
X-Gm-Message-State: AFuF++kx8nR2R69qEKWr/ZmYp8kuZsxpCIJfjnoo9r8O66NJLnDnbTsj
	DcJ4y36JXjYtQAi211+A9THmUTUKIRZOG8er7ydyggfgwePdtLB0xQ17LgMn4aXs
X-Gm-Gg: AR+sD11UaKrNJT5l9mQWCr46CqQX5w/IlC3vMvPbd8hQKOsFgQj2qbWWwEujiaVTpms
	8JoCDCyn78GF8UtTpnyfyQ7CyLsrTILNcQqvU9NTuU3Zhf6Dg3GZRybVl27Y6/PsTF/ml4Slzzr
	gw3QoJGoSp4zzcw7VCU7ltFTJNB5EqAz9MJEvYX4Dzaz9/yw3S3kR2ykZEvbC2mcW0FUlR+Ifbe
	j3+1yzx2wMzvj9pbpRZyhL7+G6qo19WtNry2MjSb/cuYldKkQhKEl/i0huglYIbyLTWboid+Gk5
	OMXbc6ztGbliB6gDdf26SE5QASCoJFtsDON0UZ9iOwOtEAG2v6LIyKyPOQwjdC9byNZ6W4nnnU7
	ztqQouE1HY0iGUPca2Ev74QnT5rFhaL/PTkTQSXYKoT1YIbDtm7aS2hiqh1GkYKvcS1rsMjXVXl
	MZIJp/7Nx5slVVDX4lQCs4nvh0kE4Oa3NoBmAi6azT/HDOlBv2rHjRVPnAS5hAwR+pZfxK0yw5T
	GjjMAfPTVLOPc4MOO0M1JuyywVrqxjhR0f77SEg9hWnDzoSUP6MLPNVvh+Ihybm9pz4c+XiRlGy
	//eXcJPlDFdE8qqI7OkpnR3bct2vZIHA1tR9zHJF/ABPBFMPhHP/rJB/aUl/hkT2h+PKzJUXzes
	=
X-Received: by 2002:a05:600c:4ecc:b0:49c:e37e:4389 with SMTP id 5b1f17b1804b1-49cee5e2370mr3695785e9.4.1788365479384;
        Wed, 02 Sep 2026 09:11:19 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce5563c6csm50938075e9.4.2026.09.02.09.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:11:17 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Justin Tobler <jltobler@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 3/6] rev-parse: fix "--" detection when it is an option value
Date: Wed,  2 Sep 2026 18:10:44 +0200
Message-ID: <20260902161047.476753-4-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.787.g3f9e2241eb.dirty
In-Reply-To: <20260902161047.476753-1-christian.couder@gmail.com>
References: <20260902161047.476753-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`cmd_rev_parse()` walks its arguments twice. The second loop actually
parses the options, and it knows that `--default`, `--prefix` and
`--resolve-git-dir` take their value as a separate argument, so it skips
that value.

The first loop, which only looks for the "--" separating revisions from
paths, doesn't know about these options. So when such an option is given
"--" as its value, that "--" is mistaken for the separator and
`has_dashdash` is wrongly set.

This matters because `has_dashdash` makes the second loop die with a
"bad revision" error on an argument that is neither a revision nor an
existing file, instead of reporting that the argument is ambiguous and
telling how to disambiguate it. So:

  $ git rev-parse --default -- notarev
  fatal: bad revision 'notarev'

while the very same command line with any other default value gives the
usual, much more helpful, "ambiguous argument" error.

Let's fix this the same way as in a previous commit, by using
early_scan_options() and telling it about the options taking their value
as a separate argument.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 builtin/rev-parse.c  | 26 ++++++++++++++++++++------
 t/t1500-rev-parse.sh |  5 +++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 43693454d5..7ced82e25d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -695,6 +695,17 @@ static void print_path(const char *path, const char *prefix,
 	strbuf_release(&sb);
 }
 
+/*
+ * The options taking their value as a separate argument, which the scan
+ * looking for "--" below has to skip along with their value.
+ */
+static const struct early_scan_option rev_parse_early_options[] = {
+	EARLY_SCAN_SKIP_VALUE("default"),
+	EARLY_SCAN_SKIP_VALUE("prefix"),
+	EARLY_SCAN_SKIP_VALUE("resolve-git-dir"),
+	EARLY_SCAN_END()
+};
+
 int cmd_rev_parse(int argc,
 		  const char **argv,
 		  const char *prefix,
@@ -724,12 +735,15 @@ int cmd_rev_parse(int argc,
 	if (argc > 1 && !strcmp("-h", argv[1]))
 		usage(builtin_rev_parse_usage);
 
-	for (i = 1; i < argc; i++) {
-		if (!strcmp(argv[i], "--")) {
-			has_dashdash = 1;
-			break;
-		}
-	}
+	/*
+	 * The scan below has to know about the options taking their value
+	 * as a separate argument, or such a value that happens to be "--"
+	 * would be mistaken for the "--" separating revisions from paths.
+	 */
+	i = early_scan_options(argc - 1, argv + 1, rev_parse_early_options,
+			       EARLY_SCAN_STOP_AT_DASHDASH, NULL, NULL);
+	if (i < argc - 1)
+		has_dashdash = 1;
 
 	/* No options; just report on whether we're in a git repo or not. */
 	if (argc == 1) {
diff --git a/t/t1500-rev-parse.sh b/t/t1500-rev-parse.sh
index 4174ca40c3..897e9a7735 100755
--- a/t/t1500-rev-parse.sh
+++ b/t/t1500-rev-parse.sh
@@ -383,4 +383,9 @@ test_expect_success ':/ and HEAD^{/} favor more recent matching commits' '
 	)
 '
 
+test_expect_success 'rev-parse with "--" as an option value' '
+	test_must_fail git rev-parse --default -- notarev 2>err &&
+	test_grep "ambiguous argument .notarev." err
+'
+
 test_done
-- 
2.55.0.787.g3f9e2241eb.dirty

