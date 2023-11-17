Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB6ECJEl"
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81079A5
	for <git@vger.kernel.org>; Fri, 17 Nov 2023 09:47:51 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-3316ad2bee5so519660f8f.1
        for <git@vger.kernel.org>; Fri, 17 Nov 2023 09:47:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700243269; x=1700848069; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=04FK1noSSnxP747cHrA/hwHn2NonOwENeJ6ayp3e+48=;
        b=AB6ECJElCv5eJKIu9C86miss+FHAvrpdIsjr3r8DRVW6GzRWRFdDfJmqzM3K3CrSTh
         aw5XasTsS7svglLL95GgAQaS7PWDqxr/iV6XMVxjoVErouasOrzJEXUKXj87Un1xvHQF
         xsN8tC2I2ROYQxRPtFcO9NGeMf2CTCelwgsOboyHOlxmwDZoIGHJOv5aj/xuzqzeb6SP
         9ZJZkoFNk8XCWBIPQeavSmirwoz+qkx4AQggrvRQMG3GPM5ZH8cD5hPN77DBsdVTsmtV
         sZJwuAM821EapirTFk0K3XopHwdfrkZyQd6wskMCmYIOlTDMeCSP+96G9byWArrJtqbW
         qdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700243269; x=1700848069;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=04FK1noSSnxP747cHrA/hwHn2NonOwENeJ6ayp3e+48=;
        b=oIId9z5gA2G1ZTgU0XA/ZO7WTM45Ec/CQGpMUupX10kpNhXf1yshGzh7b/7gYSeS7Z
         owPfF5eXhjk8/RTIhAKtXs8qYUHsdZpAFaS2tPe/up21WHjZwuI/fmyMfymyt5kKERXS
         1/Qe8bQ6hwwNdRrC9uSggVnG78mX9qxbgCDcx/R0glgE3oRbpxHrM0MGMx7tZdI5LP/w
         LzaOk5jvsvXIaKaODdQxM/Mxsiap82UWF34PBZTSKfp5dvUfieZ/Ooi7kAEqL3PlmGbV
         j9yHiNz2DDozsGBI6pCc4srvHcKBqvMiVnMDsmtWLmJo7UjzunDLTC7oByJIGF0ZvBNH
         9tvA==
X-Gm-Message-State: AOJu0Yyk7/ftPf6EShKrj6PcKDy4BzB3Shgyt64v+Mv/oKmxoV/zIcb/
	f6U+sZ/ere5yrwbHx1yDc16gkl4z1eI=
X-Google-Smtp-Source: AGHT+IGm5tM29ssoBsvQ5NAqLv2Vf/2BJkvCUwvSxWC9SX6dukfxQAtefcy3xZvoghs/YlDsNSplYA==
X-Received: by 2002:a05:6000:18e:b0:32f:c3f0:f869 with SMTP id p14-20020a056000018e00b0032fc3f0f869mr13272208wrx.41.1700243269081;
        Fri, 17 Nov 2023 09:47:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12-20020adffb0c000000b003316b38c625sm2110539wrr.99.2023.11.17.09.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Nov 2023 09:47:48 -0800 (PST)
Message-ID: <pull.1612.v4.git.1700243267653.gitgitgadget@gmail.com>
In-Reply-To: <pull.1612.v3.git.1699959186146.gitgitgadget@gmail.com>
References: <pull.1612.v3.git.1699959186146.gitgitgadget@gmail.com>
From: "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Nov 2023 17:47:47 +0000
Subject: [PATCH v4] fuzz: add new oss-fuzz fuzzer for date.c / date.h
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
Cc: Jeff King <peff@peff.net>,
    Arthur Chan <arthur.chan@adalogics.com>,
    Arthur Chan <arthur.chan@adalogics.com>

From: Arthur Chan <arthur.chan@adalogics.com>

Signed-off-by: Arthur Chan <arthur.chan@adalogics.com>
---
    fuzz: add new oss-fuzz fuzzer for date.c / date.h
    
    This patch is aimed to add a new oss-fuzz fuzzer to the oss-fuzz
    directory for fuzzing date.c / date.h in the base directory.
    
    The .gitignore of the oss-fuzz directory and the Makefile have been
    modified to accommodate the new fuzzer fuzz-date.c.
    
    Fixed the objects order in .gitignore and Makefiles and fixed some of
    the logic and formatting for the fuzz-date.c fuzzer in v2.
    
    Fixed the creation and memory allocation of the fuzzing str in v3. Also
    fixed the tz type and sign-extended the data before passing to the tz
    variable.
    
    Fixed the tz variable allocations and some of the bytes used for fuzzing
    variables in v4.
    
    Comment: Yes, indeed. It is quite annoying to have that twice. Yes, the
    tz should be considered as attacker controllable and thus negative
    values should be considered. But it is tricky to fuzz it because the
    date.c::gm_time_t() will call die() if the value is invalid and that
    exit the fuzzer directly. OSS-Fuzz may consider it as an issue (or bug)
    because the fuzzer exit "unexpectedly". I agree that if we consider the
    tz as "attacker controllable, we should include negative values, but
    since it will cause the fuzzer exit, I am not sure if it is the right
    approach from the fuzzing perspective. Also, it is something that date.c
    already take care of with the conditional checking, thus it may also be
    worth to do some checking and exclude some invalid values before calling
    date.c::show_date() but this may result in copying some conditional
    checking code from date.c.
    
    Additional comment for v4: Thanks for the suggestion. Yes, that maybe
    the easier approach. Since the new logic is only using 2 bytes for the
    int16_t tz, thus the local and dmtype variable could use separate bytes
    to increase "randomness".

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1612%2Farthurscchan%2Fnew-fuzzer-date-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1612/arthurscchan/new-fuzzer-date-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/1612

Range-diff vs v3:

 1:  046bca32889 ! 1:  33a72d4c197 fuzz: add new oss-fuzz fuzzer for date.c / date.h
     @@ oss-fuzz/fuzz-date.c (new)
      +{
      +	int local;
      +	int num;
     -+	int tz;
      +	char *str;
     -+	int8_t *tmp_data;
     ++	int16_t tz;
      +	timestamp_t ts;
      +	enum date_mode_type dmtype;
      +	struct date_mode *dm;
      +
      +	if (size <= 4)
      +		/*
     -+		 * we use the first byte to fuzz dmtype and local,
     -+		 * then the next three bytes to fuzz tz	offset,
     -+		 * and the remainder (at least one byte) is fed
     -+		 * as end-user input to approxidate_careful().
     ++		 * we use the first byte to fuzz dmtype and the
     ++		 * second byte to fuzz local, then the next two
     ++		 * bytes to fuzz tz offset. The remainder
     ++		 * (at least one byte) is fed as input to
     ++		 * approxidate_careful().
      +		 */
      +		return 0;
      +
     -+	local = !!(*data & 0x10);
     -+	num = *data % DATE_UNIX;
     ++	local = !!(*data++ & 0x10);
     ++	num = *data++ % DATE_UNIX;
      +	if (num >= DATE_STRFTIME)
      +		num++;
      +	dmtype = (enum date_mode_type)num;
     -+	data++;
     -+	size--;
     ++	size -= 2;
      +
     -+	tmp_data = (int8_t*)data;
     -+	tz = *tmp_data++;
     -+	tz = (tz << 8) | *tmp_data++;
     -+	tz = (tz << 8) | *tmp_data++;
     -+	data += 3;
     -+	size -= 3;
     ++	tz = *data++;
     ++	tz = (tz << 8) | *data++;
     ++	size -= 2;
      +
      +	str = xmemdupz(data, size);
      +
     @@ oss-fuzz/fuzz-date.c (new)
      +
      +	dm = date_mode_from_type(dmtype);
      +	dm->local = local;
     -+	show_date(ts, tz, dm);
     ++	show_date(ts, (int)tz, dm);
      +
      +	date_mode_release(dm);
      +


 Makefile             |  1 +
 oss-fuzz/.gitignore  |  1 +
 oss-fuzz/fuzz-date.c | 49 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 oss-fuzz/fuzz-date.c

diff --git a/Makefile b/Makefile
index 03adcb5a480..4b875ef6ce1 100644
--- a/Makefile
+++ b/Makefile
@@ -750,6 +750,7 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
 ETAGS_TARGET = TAGS
 
 FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
+FUZZ_OBJS += oss-fuzz/fuzz-date.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
 FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o
 .PHONY: fuzz-objs
diff --git a/oss-fuzz/.gitignore b/oss-fuzz/.gitignore
index 9acb74412ef..5b954088254 100644
--- a/oss-fuzz/.gitignore
+++ b/oss-fuzz/.gitignore
@@ -1,3 +1,4 @@
 fuzz-commit-graph
+fuzz-date
 fuzz-pack-headers
 fuzz-pack-idx
diff --git a/oss-fuzz/fuzz-date.c b/oss-fuzz/fuzz-date.c
new file mode 100644
index 00000000000..036378b946f
--- /dev/null
+++ b/oss-fuzz/fuzz-date.c
@@ -0,0 +1,49 @@
+#include "git-compat-util.h"
+#include "date.h"
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size);
+
+int LLVMFuzzerTestOneInput(const uint8_t *data, size_t size)
+{
+	int local;
+	int num;
+	char *str;
+	int16_t tz;
+	timestamp_t ts;
+	enum date_mode_type dmtype;
+	struct date_mode *dm;
+
+	if (size <= 4)
+		/*
+		 * we use the first byte to fuzz dmtype and the
+		 * second byte to fuzz local, then the next two
+		 * bytes to fuzz tz offset. The remainder
+		 * (at least one byte) is fed as input to
+		 * approxidate_careful().
+		 */
+		return 0;
+
+	local = !!(*data++ & 0x10);
+	num = *data++ % DATE_UNIX;
+	if (num >= DATE_STRFTIME)
+		num++;
+	dmtype = (enum date_mode_type)num;
+	size -= 2;
+
+	tz = *data++;
+	tz = (tz << 8) | *data++;
+	size -= 2;
+
+	str = xmemdupz(data, size);
+
+	ts = approxidate_careful(str, &num);
+	free(str);
+
+	dm = date_mode_from_type(dmtype);
+	dm->local = local;
+	show_date(ts, (int)tz, dm);
+
+	date_mode_release(dm);
+
+	return 0;
+}

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
