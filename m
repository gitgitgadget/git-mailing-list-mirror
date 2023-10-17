Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823142E3E1
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 21:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nDXw8wV1"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856ABA
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:12:50 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32799639a2aso5360983f8f.3
        for <git@vger.kernel.org>; Tue, 17 Oct 2023 14:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697577169; x=1698181969; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=egetfUKguP7nVokcEHvgaQD0aCWtwweegkhIZNDyjVg=;
        b=nDXw8wV1ApvEFD05s4NT3y9z9H7R3xB3OByJMUFyXrOjPrhMgw9VYEKMm56tPxLF4q
         y8+HVNIF2HYBqIdscDol6cY0Nr1l4C8p4YV0tH1sqEmvkL29IWov00gZb0lGiQpNX7LJ
         EBkCfV3O+CHWLpwRtaZVK7Hs7D0Vp04jguK5NgUPG9kbXi2DFA6qLXa9vUeRKCV0QYQT
         Z9LjVeTZpNsbWQ1Ku3O0qzIkVWv3V5KATYJtjOF7MVovwrNLMdpjN70+G7X8cNSWoFL+
         VgkxzuyZXdNCaLjdCLZnl4geJV5+5UoVBwEPrYkESkajCUhZCwuc2ivRKKoetCSQsmOH
         QlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697577169; x=1698181969;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=egetfUKguP7nVokcEHvgaQD0aCWtwweegkhIZNDyjVg=;
        b=OwHRUNjDRQtBtCZKcjJ58QLRpbLE3jOFAZZaj5ZQihPU/HHk0a1juvg1hXmRJbL5vJ
         ZTj2WGwQdYBX6dG4VfuxgbVZVX3XGygsrxMXJHfMVA+WRt2YCLQhEY4uQOEuMuatQUZR
         LyI8Ygfv6WE49+DtmnyyJYCt/Rr3wELyyXHWABRSFdqEYfWcsUO5oZpMHoP0ch0GtYlT
         mxpoC6JIhJEOwjqLlaB+9k30/UOf0B/24uTcnQBEOzHzR49gSGDBJViERrWIEKuk3Tzl
         xohlfeUPOBd93rHOzf3QF60bxMesincZIlOcedeM6NgRep51eIxFO/iD/IVRKzhYtTjq
         Zjzw==
X-Gm-Message-State: AOJu0YzqsXkUjn1AaYmJ+oVw6goFWM8fmTRlk03F//GJHT1W3PGQ4tv/
	QYdgzBO3IvrR5xkwwFhExCWFJFpw+SY=
X-Google-Smtp-Source: AGHT+IFro+Jqe03/XZ9SdVZIU6TBeXGVFZpT5sk7eIDAiHYw9R4L79S4GoUBpfB9UOCzat1SmXZuew==
X-Received: by 2002:a5d:5243:0:b0:32c:c35c:2eea with SMTP id k3-20020a5d5243000000b0032cc35c2eeamr2581896wrc.6.1697577168769;
        Tue, 17 Oct 2023 14:12:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5-20020a056000128500b0032d2f09d991sm585258wrx.33.2023.10.17.14.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 14:12:48 -0700 (PDT)
Message-ID: <pull.1598.v2.git.1697577168128.gitgitgadget@gmail.com>
In-Reply-To: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
References: <pull.1598.git.1697040242703.gitgitgadget@gmail.com>
From: "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 17 Oct 2023 21:12:47 +0000
Subject: [PATCH v2] upload-pack: add tracing for fetches
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
Cc: Taylor Blau <me@ttaylorr.com>,
    Jeff King <peff@peff.net>,
    Robert Coup <robert@coup.net.nz>,
    Robert Coup <robert@coup.net.nz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Robert Coup <robert@coup.net.nz>

Information on how users are accessing hosted repositories can be
helpful to server operators. For example, being able to broadly
differentiate between fetches and initial clones; the use of shallow
repository features; or partial clone filters.

a29263c (fetch-pack: add tracing for negotiation rounds, 2022-08-02)
added some information on have counts to fetch-pack itself to help
diagnose negotiation; but from a git-upload-pack (server) perspective,
there's no means of accessing such information without using
GIT_TRACE_PACKET to examine the protocol packets.

Improve this by emitting a Trace2 JSON event from upload-pack with
summary information on the contents of a fetch request.

* haves, wants, and want-ref counts can help determine (broadly) between
  fetches and clones, and the use of single-branch, etc.
* shallow clone depth, tip counts, and deepening options.
* any partial clone filter type.

Signed-off-by: Robert Coup <robert@coup.net.nz>
---
    upload-pack: add tracing for fetches
    
    
    Changes since V1
    ================
    
     * Don't generate the JSON event unless Trace2 is active.
     * Code style fix.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1598%2Frcoup%2Frc-upload-pack-trace-info-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1598/rcoup/rc-upload-pack-trace-info-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1598

Range-diff vs v1:

 1:  f9157979848 ! 1:  9290d586b08 upload-pack: add tracing for fetches
     @@ upload-pack.c: static int parse_have(const char *line, struct oid_array *haves)
      +	struct json_writer jw = JSON_WRITER_INIT;
      +
      +	jw_object_begin(&jw, 0);
     -+	{
     -+		jw_object_intmax(&jw, "haves", data->haves.nr);
     -+		jw_object_intmax(&jw, "wants", data->want_obj.nr);
     -+		jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
     -+		jw_object_intmax(&jw, "depth", data->depth);
     -+		jw_object_intmax(&jw, "shallows", data->shallows.nr);
     -+		jw_object_bool(&jw, "deepen-since", data->deepen_since);
     -+		jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
     -+		jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
     -+		if (data->filter_options.choice)
     -+			jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
     -+		else
     -+			jw_object_null(&jw, "filter");
     -+	}
     ++	jw_object_intmax(&jw, "haves", data->haves.nr);
     ++	jw_object_intmax(&jw, "wants", data->want_obj.nr);
     ++	jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
     ++	jw_object_intmax(&jw, "depth", data->depth);
     ++	jw_object_intmax(&jw, "shallows", data->shallows.nr);
     ++	jw_object_bool(&jw, "deepen-since", data->deepen_since);
     ++	jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
     ++	jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
     ++	if (data->filter_options.choice)
     ++		jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
     ++	else
     ++		jw_object_null(&jw, "filter");
      +	jw_end(&jw);
      +
      +	trace2_data_json("upload-pack", the_repository, "fetch-info", &jw);
     @@ upload-pack.c: static void process_args(struct packet_reader *request,
       	if (request->status != PACKET_READ_FLUSH)
       		die(_("expected flush after fetch arguments"));
      +
     -+	trace2_fetch_info(data);
     ++	if (trace2_is_enabled())
     ++		trace2_fetch_info(data);
       }
       
       static int process_haves(struct upload_pack_data *data, struct oid_array *common)


 t/t5500-fetch-pack.sh | 38 +++++++++++++++++++++++++++-----------
 upload-pack.c         | 28 ++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 11 deletions(-)

diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index d18f2823d86..bb15ac34f77 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -132,13 +132,18 @@ test_expect_success 'single branch object count' '
 '
 
 test_expect_success 'single given branch clone' '
-	git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
-	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B
+	GIT_TRACE2_EVENT="$(pwd)/branch-a/trace2_event" \
+		git clone --single-branch --branch A "file://$(pwd)/." branch-a &&
+	test_must_fail git --git-dir=branch-a/.git rev-parse origin/B &&
+	grep \"fetch-info\".*\"haves\":0 branch-a/trace2_event &&
+	grep \"fetch-info\".*\"wants\":1 branch-a/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1' '
-	git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
-	test "$(git --git-dir=shallow0/.git rev-list --count HEAD)" = 1
+	GIT_TRACE2_EVENT="$(pwd)/shallow0/trace2_event" \
+		git clone --no-single-branch --depth 1 "file://$(pwd)/." shallow0 &&
+	test "$(git --git-dir=shallow0/.git rev-list --count HEAD)" = 1 &&
+	grep \"fetch-info\".*\"depth\":1 shallow0/trace2_event
 '
 
 test_expect_success 'clone shallow depth 1 with fsck' '
@@ -235,7 +240,10 @@ test_expect_success 'add two more (part 2)' '
 test_expect_success 'deepening pull in shallow repo' '
 	(
 		cd shallow &&
-		git pull --depth 4 .. B
+		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
+			git pull --depth 4 .. B &&
+		grep \"fetch-info\".*\"depth\":4 trace2_event &&
+		grep \"fetch-info\".*\"shallows\":2 trace2_event
 	)
 '
 
@@ -306,9 +314,12 @@ test_expect_success 'fetch --depth --no-shallow' '
 test_expect_success 'turn shallow to complete repository' '
 	(
 		cd shallow &&
-		git fetch --unshallow &&
+		GIT_TRACE2_EVENT="$(pwd)/trace2_event" \
+			git fetch --unshallow &&
 		! test -f .git/shallow &&
-		git fsck --full
+		git fsck --full &&
+		grep \"fetch-info\".*\"shallows\":2 trace2_event &&
+		grep \"fetch-info\".*\"depth\":2147483647 trace2_event
 	)
 '
 
@@ -826,13 +837,15 @@ test_expect_success 'clone shallow since ...' '
 '
 
 test_expect_success 'fetch shallow since ...' '
-	git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
+	GIT_TRACE2_EVENT=$(pwd)/shallow11/trace2_event \
+		git -C shallow11 fetch --shallow-since "200000000 +0700" origin &&
 	git -C shallow11 log --pretty=tformat:%s origin/main >actual &&
 	cat >expected <<-\EOF &&
 	three
 	two
 	EOF
-	test_cmp expected actual
+	test_cmp expected actual &&
+	grep \"fetch-info\".*\"deepen-since\":true shallow11/trace2_event
 '
 
 test_expect_success 'clone shallow since selects no commits' '
@@ -987,13 +1000,16 @@ test_expect_success 'filtering by size' '
 	test_config -C server uploadpack.allowfilter 1 &&
 
 	test_create_repo client &&
-	git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
+	GIT_TRACE2_EVENT=$(pwd)/client/trace2_event \
+		git -C client fetch-pack --filter=blob:limit=0 ../server HEAD &&
 
 	# Ensure that object is not inadvertently fetched
 	commit=$(git -C server rev-parse HEAD) &&
 	blob=$(git hash-object server/one.t) &&
 	git -C client rev-list --objects --missing=allow-any "$commit" >oids &&
-	! grep "$blob" oids
+	! grep "$blob" oids &&
+
+	grep \"fetch-info\".*\"filter\":\"blob:limit\" client/trace2_event
 '
 
 test_expect_success 'filtering by size has no effect if support for it is not advertised' '
diff --git a/upload-pack.c b/upload-pack.c
index 83f3d2651ab..ea234ab6a45 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -33,6 +33,7 @@
 #include "commit-reach.h"
 #include "shallow.h"
 #include "write-or-die.h"
+#include "json-writer.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -1552,6 +1553,30 @@ static int parse_have(const char *line, struct oid_array *haves)
 	return 0;
 }
 
+static void trace2_fetch_info(struct upload_pack_data *data)
+{
+	struct json_writer jw = JSON_WRITER_INIT;
+
+	jw_object_begin(&jw, 0);
+	jw_object_intmax(&jw, "haves", data->haves.nr);
+	jw_object_intmax(&jw, "wants", data->want_obj.nr);
+	jw_object_intmax(&jw, "want-refs", data->wanted_refs.nr);
+	jw_object_intmax(&jw, "depth", data->depth);
+	jw_object_intmax(&jw, "shallows", data->shallows.nr);
+	jw_object_bool(&jw, "deepen-since", data->deepen_since);
+	jw_object_intmax(&jw, "deepen-not", data->deepen_not.nr);
+	jw_object_bool(&jw, "deepen-relative", data->deepen_relative);
+	if (data->filter_options.choice)
+		jw_object_string(&jw, "filter", list_object_filter_config_name(data->filter_options.choice));
+	else
+		jw_object_null(&jw, "filter");
+	jw_end(&jw);
+
+	trace2_data_json("upload-pack", the_repository, "fetch-info", &jw);
+
+	jw_release(&jw);
+}
+
 static void process_args(struct packet_reader *request,
 			 struct upload_pack_data *data)
 {
@@ -1640,6 +1665,9 @@ static void process_args(struct packet_reader *request,
 
 	if (request->status != PACKET_READ_FLUSH)
 		die(_("expected flush after fetch arguments"));
+
+	if (trace2_is_enabled())
+		trace2_fetch_info(data);
 }
 
 static int process_haves(struct upload_pack_data *data, struct oid_array *common)

base-commit: aab89be2eb6ca51eefeb8c8066f673f447058856
-- 
gitgitgadget
