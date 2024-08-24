Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77B5625
	for <git@vger.kernel.org>; Sat, 24 Aug 2024 17:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724520049; cv=none; b=d2dl4Oi6NAKBBWAI3g2YL6wUn468s1KgQ6f4v3UtBCdQkCrhssKrFtWbdx1JLIu38xjLs1U5eOBGewm19gkI8142jEs1LJTqkgbUWuq1R30RKk2yh2T2dN2QKrGaDS/R4A4ADfI2XoH/GqXsZ+SsMXTKlWOh6OTOX6pAaE9i0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724520049; c=relaxed/simple;
	bh=hqffnVnudCpEEpfD1SBYkatl+/PZeCHPCBeZw9Ml3WM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RwCflhrsu3XUEAjfchI8yCdvIzrc+oP5UpTjqAEArVXqtBD4YizUoIRxM/VJUT3po19eCm75Pc2HQsD5LYwFu8FCa7xBRzvMExOSUZeu/M9GcV1yrCBo0AqDdIN2Qn44NDC8tabweK0lR7kjPwg/USJMHThEW1P8C7QJfrap9BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dtrLzCyA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dtrLzCyA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2d3c99033d6so2371161a91.0
        for <git@vger.kernel.org>; Sat, 24 Aug 2024 10:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724520047; x=1725124847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pq63sIGGLo5hmEHNnUWfkF6zy3dGH45Nw9F/BuPhdUk=;
        b=dtrLzCyAj57FZrzjE9wxVGeAqplsSlc9FSh3oKP1C3tE7kcasdQcC/ModABDcq6bbz
         UPJGfCvCtJ+86/ComjOfRPLSfXFZLJPxRWS3JBFEPZWItqIr1uP1u5sGV/bo9+ei4ESQ
         PkdACJBlGYuNBQrwJ38fO4T/5uzNQHHLRCBV/8ssoFUU78PIL7SNZkDGuOpSijmkfNzg
         oD2D4BtC4riqmLs4flLCxDcEECQBfQCaTWhgBf4tDhXF9rmqKQ3mhhQ3T+Z4GIFMzwrD
         Ud87BWhITvvvO2Bax1C4WtQ5XHfy/NPSulYoFyGmuL+JVgOUWonuCA/d+I0zyil1ncB1
         8s6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724520047; x=1725124847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq63sIGGLo5hmEHNnUWfkF6zy3dGH45Nw9F/BuPhdUk=;
        b=qZNBKFhYtVgfRIhFEsJ+KNy0fVyXXnji5YGyLYb1gG3oRB9Ho5EhKcXQ3ejKMQsya7
         FrH3uQD1BpFYURcuWbt+Eei73sI37jyZReLD6o31+w2qYPpQLSWFxEPdEysDE5nmS0fS
         uj+/wgh7ALQJGGRYneqCfkSXW4TcapcqmH/6owFhAs4IH3tt5+ezWTIYlMt/yK7/iBWT
         guEFS/eIDA23OORDdqdTpJ+b8ZjXnxWD8oHIfmj8JnpXu4Ct6nHcLcK11OFeur3ky2gJ
         DQpShGoTTsXb+O2ASUEX0YALlBtaWbQKkWwMRJ/Rk7PcD7IQuPXllfu8MsQamHCs5Dk6
         Qoug==
X-Gm-Message-State: AOJu0Yw8/dNwi2NDm2w0OGvsKXeQcOfA/hR3KpIbdb1D6TWNl0VvgB3k
	SHIkBBk5kZa0OIqz5NmWG+oUC6a1Tnk7I0MpFctEZzxcGeD54+HemY8uoj0ytjojUw==
X-Google-Smtp-Source: AGHT+IHPyD9r2nsc/e2uoX0hJwOQ6ihVS6jagCXY9WLHz4uqXawL7idAg2vl9t8YmO8K5g4bdmNikA==
X-Received: by 2002:a17:90a:8985:b0:2d3:b821:ba78 with SMTP id 98e67ed59e1d1-2d646c25366mr6864730a91.22.1724520046388;
        Sat, 24 Aug 2024 10:20:46 -0700 (PDT)
Received: from localhost.localdomain ([106.222.205.87])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d5eba23d78sm8706156a91.29.2024.08.24.10.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 10:20:45 -0700 (PDT)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC][PATCH] unit-tests: add tests for oidset.h
Date: Sat, 24 Aug 2024 22:50:23 +0530
Message-ID: <20240824172028.39419-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for oidset.h library, which were not previously present using
the unit testing framework.

This imposes a new restriction of running the test from the 't/' and
't/unit-tests/bin' for constructing the path to the test files which
are used by t_parse_file(), which tests the parsing of object_ids from
a file. This restriction is similar to the one we already have for
end-to-end tests, wherein, we can only run those tests from 't/'. The
addition of allowing 't/unit-tests/bin' for allowing to run tests from
is for running individual unit tests, which is not currently possible
via any 'make' target. And 'make unit-tests-test-tool' also runs from
't/unit-tests/bin'

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
I know there is some hesitance from the community in imposing the
restriction of running the unit tests from certain directories, so
if this case does not justify imposing such a restriction, I am fine
with removing t_parse_file() in the next version.

Thanks.

 Makefile                          |   1 +
 t/unit-tests/lib-oid.c            |   2 +-
 t/unit-tests/lib-oid.h            |   1 +
 t/unit-tests/t-oidset.c           | 222 ++++++++++++++++++++++++++++++
 t/unit-tests/t-oidset/sha1-oids   |  10 ++
 t/unit-tests/t-oidset/sha256-oids |  10 ++
 6 files changed, 245 insertions(+), 1 deletion(-)
 create mode 100644 t/unit-tests/t-oidset.c
 create mode 100644 t/unit-tests/t-oidset/sha1-oids
 create mode 100644 t/unit-tests/t-oidset/sha256-oids

diff --git a/Makefile b/Makefile
index e298c8b55e..5c1762fa1b 100644
--- a/Makefile
+++ b/Makefile
@@ -1338,6 +1338,7 @@ UNIT_TEST_PROGRAMS += t-hash
 UNIT_TEST_PROGRAMS += t-hashmap
 UNIT_TEST_PROGRAMS += t-mem-pool
 UNIT_TEST_PROGRAMS += t-oidmap
+UNIT_TEST_PROGRAMS += t-oidset
 UNIT_TEST_PROGRAMS += t-oidtree
 UNIT_TEST_PROGRAMS += t-prio-queue
 UNIT_TEST_PROGRAMS += t-reftable-basics
diff --git a/t/unit-tests/lib-oid.c b/t/unit-tests/lib-oid.c
index 37105f0a8f..8f0ccac532 100644
--- a/t/unit-tests/lib-oid.c
+++ b/t/unit-tests/lib-oid.c
@@ -3,7 +3,7 @@
 #include "strbuf.h"
 #include "hex.h"
 
-static int init_hash_algo(void)
+int init_hash_algo(void)
 {
 	static int algo = -1;
 
diff --git a/t/unit-tests/lib-oid.h b/t/unit-tests/lib-oid.h
index 8d2acca768..fc3e7aa376 100644
--- a/t/unit-tests/lib-oid.h
+++ b/t/unit-tests/lib-oid.h
@@ -14,4 +14,5 @@
  */
 int get_oid_arbitrary_hex(const char *s, struct object_id *oid);
 
+int init_hash_algo(void);
 #endif /* LIB_OID_H */
diff --git a/t/unit-tests/t-oidset.c b/t/unit-tests/t-oidset.c
new file mode 100644
index 0000000000..4a63f9ea94
--- /dev/null
+++ b/t/unit-tests/t-oidset.c
@@ -0,0 +1,222 @@
+#include "test-lib.h"
+#include "oidset.h"
+#include "lib-oid.h"
+#include "hex.h"
+#include "strbuf.h"
+
+static const char *const hex_input[] = { "00", "11", "22", "33", "aa", "cc" };
+
+static void strbuf_test_data_path(struct strbuf *buf, int hash_algo)
+{
+	strbuf_getcwd(buf);
+	strbuf_strip_suffix(buf, "/unit-tests/bin");
+	strbuf_addf(buf, "/unit-tests/t-oidset/%s",
+		    hash_algo == GIT_HASH_SHA1 ? "sha1-oids" : "sha256-oids");
+}
+
+static void setup(void (*f)(struct oidset *st))
+{
+	struct oidset st = OIDSET_INIT;
+	struct object_id oid;
+	int ret = 0;
+
+	if (!check_int(oidset_size(&st), ==, 0)) {
+		test_skip_all("OIDSET_INIT is broken");
+		return;
+	}
+
+	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
+		if ((ret = get_oid_arbitrary_hex(hex_input[i], &oid)))
+			break;
+		if (!check_int((ret = oidset_insert(&st, &oid)), ==, 0))
+			break;
+	}
+
+	if (!ret && check_int(oidset_size(&st), ==, ARRAY_SIZE(hex_input)))
+		f(&st);
+
+	oidset_clear(&st);
+}
+
+static void t_contains(struct oidset *st)
+{
+	struct object_id oid;
+
+	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
+		if (!get_oid_arbitrary_hex(hex_input[i], &oid)) {
+			if (!check_int(oidset_contains(st, &oid), ==, 1))
+				test_msg("oid: %s", oid_to_hex(&oid));
+		}
+	}
+
+	if (!get_oid_arbitrary_hex("55", &oid))
+		check_int(oidset_contains(st, &oid), ==, 0);
+}
+
+static void t_insert_dup(struct oidset *st)
+{
+	struct object_id oid;
+
+	if (!get_oid_arbitrary_hex("11", &oid))
+		check_int(oidset_insert(st, &oid), ==, 1);
+
+	if (!get_oid_arbitrary_hex("aa", &oid))
+		check_int(oidset_insert(st, &oid), ==, 1);
+
+	check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input));
+}
+
+static void t_insert_from_set(struct oidset *st_src)
+{
+	struct oidset st_dest = OIDSET_INIT;
+	struct oidset_iter iter_src, iter_dest;
+	struct object_id *oid_src, *oid_dest;
+	struct object_id oid;
+	size_t count = 0;
+
+	oidset_insert_from_set(&st_dest, st_src);
+	check_int(oidset_size(st_src), ==, ARRAY_SIZE(hex_input));
+	check_int(oidset_size(&st_dest), ==, oidset_size(st_src));
+	
+	oidset_iter_init(st_src, &iter_src);
+	oidset_iter_init(&st_dest, &iter_dest);
+
+	/* check that oidset_insert_from_set() makes a copy of the object_ids */
+	while ((oid_src = oidset_iter_next(&iter_src)) &&
+	       (oid_dest = oidset_iter_next(&iter_dest))) {
+		check(oid_src != oid_dest);
+		count++;
+	}
+	check_int(count, ==, ARRAY_SIZE(hex_input));
+
+	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
+		if (!get_oid_arbitrary_hex(hex_input[i], &oid)) {
+			if (!check_int(oidset_contains(&st_dest, &oid), ==, 1))
+				test_msg("oid: %s", oid_to_hex(&oid));
+		}
+	}
+
+	if (!get_oid_arbitrary_hex("55", &oid))
+		check_int(oidset_contains(&st_dest, &oid), ==, 0);
+	oidset_clear(&st_dest);
+}
+
+static void t_remove(struct oidset *st)
+{
+	struct object_id oid;
+
+	if (!get_oid_arbitrary_hex("55", &oid)) {
+		check_int(oidset_remove(st, &oid), ==, 0);
+		check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input));
+	}
+
+	if (!get_oid_arbitrary_hex("22", &oid)) {
+		check_int(oidset_remove(st, &oid), ==, 1);
+		check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input) - 1);
+		check_int(oidset_contains(st, &oid), ==, 0);
+	}
+
+	if (!get_oid_arbitrary_hex("cc", &oid)) {
+		check_int(oidset_remove(st, &oid), ==, 1);
+		check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input) - 2);
+		check_int(oidset_contains(st, &oid), ==, 0);
+	}
+
+	if (!get_oid_arbitrary_hex("00", &oid))
+	{
+		/* remove a value inserted more than once */
+		check_int(oidset_insert(st, &oid), ==, 1);
+		check_int(oidset_remove(st, &oid), ==, 1);
+		check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input) - 3);
+		check_int(oidset_contains(st, &oid), ==, 0);
+	}
+
+	if (!get_oid_arbitrary_hex("22", &oid))
+		check_int(oidset_remove(st, &oid), ==, 0);
+}
+
+static int input_contains(struct object_id *oid, char *seen)
+{
+	for (size_t i = 0; i < ARRAY_SIZE(hex_input); i++) {
+		struct object_id oid_input;
+		if (get_oid_arbitrary_hex(hex_input[i], &oid_input))
+			return -1;
+		if (oideq(&oid_input, oid)) {
+			if (seen[i])
+				return 2;
+			seen[i] = 1;
+			return 0;
+		}
+	}
+	return 1;
+}
+
+static void t_iterate(struct oidset *st)
+{
+	struct oidset_iter iter;
+	struct object_id *oid;
+	char seen[ARRAY_SIZE(hex_input)] = { 0 };
+	int count = 0;
+
+	oidset_iter_init(st, &iter);
+	while ((oid = oidset_iter_next(&iter))) {
+		int ret;
+		if (!check_int((ret = input_contains(oid, seen)), ==, 0)) {
+			switch (ret) {
+			case -1:
+				break; /* handled by get_oid_arbitrary_hex() */
+			case 1:
+				test_msg("obtained object_id was not given in the input\n"
+					 "  object_id: %s", oid_to_hex(oid));
+				break;
+			case 2:
+				test_msg("duplicate object_id detected\n"
+					 "  object_id: %s", oid_to_hex(oid));
+				break;
+			}
+		} else {
+			count++;
+		}
+	}
+	check_int(count, ==, ARRAY_SIZE(hex_input));
+	check_int(oidset_size(st), ==, ARRAY_SIZE(hex_input));
+}
+
+static void t_parse_file(void)
+{
+	struct strbuf path = STRBUF_INIT;
+	struct oidset st = OIDSET_INIT;
+	struct object_id oid;
+	int hash_algo = init_hash_algo();
+
+	if (!check_int(hash_algo, !=, GIT_HASH_UNKNOWN))
+		return;
+
+	strbuf_test_data_path(&path, hash_algo);
+	oidset_parse_file(&st, path.buf, &hash_algos[hash_algo]);
+	check_int(oidset_size(&st), ==, 6);
+
+	if (!get_oid_arbitrary_hex("00", &oid))
+		check_int(oidset_contains(&st, &oid), ==, 1);
+	if (!get_oid_arbitrary_hex("44", &oid))
+		check_int(oidset_contains(&st, &oid), ==, 1);
+	if (!get_oid_arbitrary_hex("cc", &oid))
+		check_int(oidset_contains(&st, &oid), ==, 1);
+
+	if (!get_oid_arbitrary_hex("11", &oid))
+		check_int(oidset_contains(&st, &oid), ==, 0);
+
+	oidset_clear(&st);
+	strbuf_release(&path);
+}
+
+int cmd_main(int argc UNUSED, const char **argv UNUSED)
+{
+	TEST(setup(t_contains), "contains works");
+	TEST(setup(t_insert_dup), "insert an already inserted value works");
+	TEST(setup(t_insert_from_set), "insert from one set to another works");
+	TEST(setup(t_remove), "remove works");
+	TEST(setup(t_iterate), "iteration works");
+	TEST(t_parse_file(), "parsing from file works");
+	return test_done();
+}
diff --git a/t/unit-tests/t-oidset/sha1-oids b/t/unit-tests/t-oidset/sha1-oids
new file mode 100644
index 0000000000..881f45e661
--- /dev/null
+++ b/t/unit-tests/t-oidset/sha1-oids
@@ -0,0 +1,10 @@
+# comments are ignored
+0000000000000000000000000000000000000000
+9900000000000000000000000000000000000000
+dd00000000000000000000000000000000000000
+
+  4400000000000000000000000000000000000000
+
+bb00000000000000000000000000000000000000 # test comment
+cc00000000000000000000000000000000000000
+# 1100000000000000000000000000000000000000
diff --git a/t/unit-tests/t-oidset/sha256-oids b/t/unit-tests/t-oidset/sha256-oids
new file mode 100644
index 0000000000..3c1c687812
--- /dev/null
+++ b/t/unit-tests/t-oidset/sha256-oids
@@ -0,0 +1,10 @@
+# comments are ignored
+0000000000000000000000000000000000000000000000000000000000000000
+9900000000000000000000000000000000000000000000000000000000000000
+dd00000000000000000000000000000000000000000000000000000000000000
+
+  4400000000000000000000000000000000000000000000000000000000000000
+
+bb00000000000000000000000000000000000000000000000000000000000000 # test comment
+cc00000000000000000000000000000000000000000000000000000000000000
+# 1100000000000000000000000000000000000000000000000000000000000000
-- 
2.46.0

