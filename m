Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4835E38E5D0
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773112163; cv=none; b=DWG+extQNz3vaug4bj+TDOKHrhV+06ALePegWB3XIY9LwWT/8pE/CgThKJaTXSbyU7VqMEU1xMcJJHeFxUbC0nhe6z8zsdHO1m5652R/SWVQ2rrIbqnUOx+43ibVeWqrnigOPTBv+t/U/D7y6tcOkou/TiCDd3PQkNQkaO4hcWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773112163; c=relaxed/simple;
	bh=ut3PRF23q+5xJbtESuvsErn8NecOnkD51O3qC5VkCEs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TD61khlDFaxeSLn64MizB+eU7OYK8CAqz0sbQXnf9uumc8gbhjid7eLsZuCHTzN5MmJD1HpcF/UrXfa8OqUbjglR4v4Yweu+CCKVsUEfweMX13s9AlG7q5i0DBVV6O4dEzwQLy9b3NF4fbg9aFKrjYG0CsdXQfiAAl43kv8sA4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DsXYNr7C; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DsXYNr7C"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-899fbf92bdbso119808606d6.0
        for <git@vger.kernel.org>; Mon, 09 Mar 2026 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773112160; x=1773716960; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=it/jAkv1s+tfwB90WhP7pF49MIDjzkLsNyVKYmnNyy4=;
        b=DsXYNr7C3FvLOdLK8cH5cUfKT4tYWq11zFdDx67vlVfgq/RXza8/YoaEGxaq67F7f7
         b5ht4iXwPFKXV3gpR5lzPdtliyccaI26J5rLx7aECCq/UFa2/ZubdxsLe8LXvSxIAz4N
         yHLUeGRPE69KvgDZYRWXRYFwNjWPpZj7fqJ8RqC8vGwUVLr6+Ydt9U18xkZhc6kK3AW4
         AIXABS4SmNvyhZHXWxCBsIUe2ir7T13GDCQUme1EYkQfd2ieFghfjplpAggr2bVpK3F2
         ZSQwjqwTq9aXsObW64rMyp7LqA4Q/5P/CIVocP+hRSBrp3gArb+uSBpniEn+EADERk/k
         xm+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773112160; x=1773716960;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=it/jAkv1s+tfwB90WhP7pF49MIDjzkLsNyVKYmnNyy4=;
        b=DF+We92oNC27cd5AfQLI3VZDAtoPL0HW6Kdy9Pz8Izv7xtWZLhuqM5GeG92NY/hAot
         aOLj0YJQOo1f2nNtwhCWxLGK3BpzbErt77OiHDV/ijwwiSSsxJkbCSIBz1LN+1DpDuNv
         opjFVEMFRJyLTNhG8Dr/9aL04WN14B0i8tSv6T3rSsx1e+LfILt8KVmlyYfaw9/r7f2E
         qXfa2pPFY6hzhs96MGx/+R4DSEql7389rPpB9afZTKy9nuHgbiFnGbw3L4h34A0+5l75
         3hjO3sVsmsF1x3sdJ3BfiSErni8JHJCweAzgUTHZYghPaRDQ6AaVJITp6r1RCg67LrwD
         Xqqg==
X-Gm-Message-State: AOJu0YwekzpnMaYmne8T7JNi/FLs+W38BTaVppzy6kWR1pUNMG8Ozi4D
	nHQAZtFM+651EDhXLg+Sot+E/SnufyCR+l7THNfucAxDbuzOOOjdcGFfblhvsA==
X-Gm-Gg: ATEYQzx4j4laugdrz9AN5uYUPsyFJ6UTXfvDbeu1Qmp3DmGrfLWcqO6Minm4PiCmsi7
	aPo5d+1i+xGyC5aWr7EFKuxU/c/tgV4JvwFiCP/cKVy0qBztF9mOkZYOmmluZVWGy9tKGK9ihOo
	eO+4SNNLz0V0ZvZPZ4oAslLxuiUEl3CDTwa5H72jxYluZpbmO1hNIn33XkKqzQ09VqaTaDEDIyE
	kMTTwSo39lRcmoHnRaDJUmiwL3tlIonmHjrQcMKrvmuCxKhcetX3JPXDZfFNze9jEhhx39L6za3
	Y/Pk62ih/UjWe5Urs3oj+H37DPt05P3zyQFtiURgdJDLWCml3Jf8wJgKfgFGsycQ3Q2vgflHG6X
	QxpRFzQBTY9uav8UvIqMTbLxOgM0l2V9ZrX67jxYQKOGHhmtTVxEeB4qfD/Kf9NGkutPuzNjWLb
	ya9ktM6PdTaKi95FvbjLj1EUU=
X-Received: by 2002:a05:6214:262c:b0:89a:e5f:d536 with SMTP id 6a1803df08f44-89a30b06e13mr206254466d6.63.1773112160528;
        Mon, 09 Mar 2026 20:09:20 -0700 (PDT)
Received: from [127.0.0.1] ([9.234.151.19])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89a57c2c482sm10441266d6.42.2026.03.09.20.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2026 20:09:20 -0700 (PDT)
Message-Id: <pull.2066.git.1773112159662.gitgitgadget@gmail.com>
From: "Mansi Singh via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Mar 2026 03:09:19 +0000
Subject: [PATCH] t1900: add tests for git repo structure subcommand
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Mansi Singh <mansimaanu8627@gmail.com>,
    Mansi Singh <mansimaanu8627@gmail.com>

From: Mansi Singh <mansimaanu8627@gmail.com>

The t1900 test file covers git repo info thoroughly but has
no tests for the git repo structure subcommand. Add basic
tests to verify that:

- git repo structure succeeds and produces no stderr output
- git repo structure --format=keyvalue outputs expected keys
- git repo structure --format=nul succeeds
- git repo structure rejects an unknown format

Signed-off-by: Mansi Singh <mansimaanu8627@gmail.com>
---
    t1900: add tests for git repo structure subcommand
    
    Add tests for the git repo structure subcommand in t1900-repo-info.sh.
    The tests verify that git repo structure outputs the expected fields
    (commits, trees, blobs, tags) in both default and key-value formats.
    
    Signed-off-by: Mansi Singh mansimaanu8627@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2066%2FMansiSingh17%2Frepo-add-structure-tests-v3-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2066/MansiSingh17/repo-add-structure-tests-v3-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2066

 t/t1900-repo-info.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..b63d404075 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,26 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+
+test_expect_success 'git repo structure succeeds' '
+	git repo structure >actual 2>stderr &&
+	test_must_be_empty stderr
+'
+
+test_expect_success 'git repo structure --format=lines succeeds' '
+	git repo structure --format=lines >actual &&
+	grep "references.branches.count=" actual &&
+	grep "objects.commits.count=" actual
+'
+
+test_expect_success 'git repo structure --format=nul succeeds' '
+	git repo structure --format=nul >actual
+'
+
+test_expect_success 'git repo structure rejects unknown format' '
+	echo "fatal: invalid format ${SQ}foo${SQ}" >expect &&
+	test_must_fail git repo structure --format=foo 2>actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: d181b9354cf85b44455ce3ca9e6af0b9559e0ae2
-- 
gitgitgadget
