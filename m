Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCF21DEFE7
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 05:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766034169; cv=none; b=OiHTWVOV5KtjAfaMw8HTjbl7mF2l/TCAbVIFqHgHOT8PeXe7GI137dxfOppA3es3dQIaf5kjaxHvA8VN+xSO/+mPbnSjfnYi8RirjFDoT9OUW7LrIzXQ4fiOxJJIcEKuGIugy7M8iNWUqEOAut+MGeTtRErCJlTaH1FKxSrnw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766034169; c=relaxed/simple;
	bh=6uDWqlB3AJuAW8UWUz+vk/gkXYG4Tj+odit2g+Lev5Q=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fkY8Kjqw89vwzLwhvAJBGbD0M8BwswfAPZX+e15tAzQdp4xJLe23VT93M5BoHf8LD6yDdvu6QLguqDmsdSBQdK/F+WTrf9wnXw/HPEqvp1iEP6hq4IDtSdsVvH92gG/2VkjFNUYC6OGbkMqlm5LvctdubnqKbOcnmvcChv5A3Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fgQ8kW+z; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fgQ8kW+z"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5942bac322dso264828e87.0
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 21:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766034164; x=1766638964; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iWWbgm0PAhP5ld3FJNQgcLMJjql39KYyxL7A5kPO/oA=;
        b=fgQ8kW+zjzc3IRS8NygbCI8aknCzHfcA30KlvyEz5oaNUvAzcQJAdoKNbiNoKzrn2o
         zYhQV3aVa939abkzTgTAmtjl2vn70Tf7tp0PKQS3/uDYXDeS9HFofQrX9YI7Ak/zjqUS
         mGb87I67fdUDUMGcj94w2jv6T9fvtdDIJ8Q7brnXPTV6ZN4SPE337OaTOOvzDGfM5Q2C
         uDZ4EHtS4eQXqslhYx4F4iMpMafA3+BGYpPcUsO+MLFkTfl72KfEB27+yC0OsJbEwrqC
         /2GErdm13kgy9MoVkpgajEYikT4qVgepXQZTK9sBy3sO7SIOCipYzx6rLLK2Cn/bQIqW
         kQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766034164; x=1766638964;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWWbgm0PAhP5ld3FJNQgcLMJjql39KYyxL7A5kPO/oA=;
        b=al2znlESAm9m0HUF9Td61CvuphiCKDuRhgjEYt/e0lU49Cr/vXoS9s1+HJR80pN8dr
         jCeMGsQXfARbYTD267qZd6+yvBBFUoEAUEZtOnZhGf0qJQCGz4WfSa6yDlPc4npx+cdJ
         qJn+PSSFObZHZinHL1SXIY3F9Wp+n2WO8axMmqaNap/T9TwKNS0OfYmYW3qeZSO5O5i8
         KHbi/+3LE3Axf6O4q/SE6yYMmj90iyMzLzlA+mfeP9IK5FyNwy9aXdacZLi3+U+Fe7iY
         ZBVlf74ro71Jy5QsEtXT3YGri+kYgqfajGVLy6X12xpLGJCaP+uyYF5+PJZoxJo9ogbn
         UAng==
X-Gm-Message-State: AOJu0YyLD9dQTCaviymGchGbcMNhKz6gpSN4aYvxZ1Yy9sst3XuG/rpN
	N271rl+aSGMv5Rwm0L5PEWa4+k6CqTEUjy3s2OjOP0WvB4PK/2kceOrsxHB+plnRYJ9Kr2xcitt
	lqVLz3dt42WwrK6sX2/6S4P+srnJlWaggiPW8ti8=
X-Gm-Gg: AY/fxX5MgPqJmueCtenmaAhr6pj2VUggVHpXJpFfUJcthtU69nRkeWFLqf1SZrZVqkt
	AlA8QViWp5kEEUT4x/La4cKNucMdCRicC10lyrOWx0/zmuOMFhV46qR7zfItxlVLOciBRRZTlhK
	VDmYo0i0eJxhlp4wHEIbAoeSU6hyZ6FhMZM1PYksws+kXAIzRefPz3Vstxh90RmW9yENHbhexTI
	tlHWSfcJWDuaEq8P8q9o2pejb7J4SgEKXogaX6+/+THIKgZYk1CFokzFQZzSIRTBJYf5hOVGs3y
	BTGWYZPBzT1M
X-Google-Smtp-Source: AGHT+IHXiH+wPpdjqZxbsoRkXKoJhSEugGL+sfBhp/FnXb7Sx6BLsvx1+6Sg8gRytcvHrv1x54lFmKmI+jtLjJpMDIY=
X-Received: by 2002:ac2:4c49:0:b0:594:5236:283f with SMTP id
 2adb3069b0e04-598faa016efmr5855300e87.9.1766034163914; Wed, 17 Dec 2025
 21:02:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Abdullah <abdullahindo888@gmail.com>
Date: Thu, 18 Dec 2025 00:02:32 -0500
X-Gm-Features: AQt7F2qM5Vvuhiebl0sx_L-3dNxcZARRF4ruGyTrqR9QXMSRYXvVSovsgdlgp7s
Message-ID: <CAG-pPd-4StfLAsassx-fqzavHJkAmi8P5UkgvqE3Yz-yGJ7GUw@mail.gmail.com>
Subject: changes for adding new features --snapshot,
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

---
 builtin/commit.c |   2 +
 snapshot.c       | 108 +++++++++++++++++++++++++++++++++++++++++++++++
 snapshot.h       |  13 ++++++
 3 files changed, 123 insertions(+)
 create mode 100644 snapshot.c
 create mode 100644 snapshot.h

diff --git a/builtin/commit.c b/builtin/commit.c
index 0243f17d53..e880409be7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -43,6 +43,7 @@
 #include "commit-graph.h"
 #include "pretty.h"
 #include "trailer.h"
+#include "snapshot.c"

 static const char * const builtin_commit_usage[] = {
  N_("git commit [-a | --interactive | --patch] [-s] [-v] [-u[<mode>]]
[--amend]\n"
@@ -1545,6 +1546,7 @@ struct repository *repo UNUSED)
  int fd;
  struct object_id oid;
  static struct option builtin_status_options[] = {
+ OPT_BOOLEAN(0, "snapshot", &opts.snapshot, "Create snapshot of staged files")
  OPT__VERBOSE(&verbose, N_("be verbose")),
  OPT_SET_INT('s', "short", &status_format,
      N_("show status concisely"), STATUS_FORMAT_SHORT),
diff --git a/snapshot.c b/snapshot.c
new file mode 100644
index 0000000000..8c117a7314
--- /dev/null
+++ b/snapshot.c
@@ -0,0 +1,108 @@
+#include "snapshot.h"
+#include "run-command.h"
+#include "strbuf.h"
+#include "utf8.h"
+#include <time.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <errno.h>
+
+#define DEFAULT_SNAPSHOT_DIR ".git/snapshots"
+/*
+## Idea
+The `--snapshot` flag would create a copy of all staged files in a
timestamped folder before the commit is made. Users could configure
the snapshot folder, defaulting to `.git/snapshots`.
+
+## Example Usage
+
+# Enable snapshot feature
+git config snapshot.enable true
+
+# Optional: configure snapshot folder
+git config snapshot.folder "../snapshots"
+
+# Stage files and commit with snapshot
+git add .
+git commit -m "Initial commit" --snapshot
+
+# Example snapshot folder created:
+# ../snapshots/2025-12-17_14-30-00_Initial_commit/
+
+# Notes:
+these codes are never tested, I send it just to know if it fits to
your development
+*/
+
+// Get snapshot folder from config, or fallback to default
+static char *get_snapshot_dir(void) {
+    const char *cfg_dir = git_config_get_string("snapshot.folder");
+    if (cfg_dir && *cfg_dir)
+        return strdup(cfg_dir);
+    return strdup(DEFAULT_SNAPSHOT_DIR);
+}
+
+// Check if snapshot is enabled
+int snapshot_enabled(void) {
+    const char *val = git_config_get_string("snapshot.enable");
+    return val && strcmp(val, "true") == 0;
+}
+
+// Get current timestamp for folder name
+static void get_timestamp(char *buffer, size_t size) {
+    time_t now = time(NULL);
+    struct tm *tm_info = localtime(&now);
+    strftime(buffer, size, "%Y-%m-%d_%H-%M-%S", tm_info);
+}
+
+// Create snapshot of staged files
+int create_snapshot(const char *message) {
+    char timestamp[64];
+    char snapshot_path[1024];
+
+    char *snapshot_dir = get_snapshot_dir();
+    if (!snapshot_dir) {
+        fprintf(stderr, "Failed to get snapshot directory\n");
+        return -1;
+    }
+
+    // Ensure base folder exists
+    if (mkdir(snapshot_dir, 0755) != 0 && errno != EEXIST) {
+        perror("mkdir snapshot_dir");
+        free(snapshot_dir);
+        return -1;
+    }
+
+    get_timestamp(timestamp, sizeof(timestamp));
+
+    // Sanitize commit message
+    char sanitized_msg[512];
+    snprintf(sanitized_msg, sizeof(sanitized_msg), "%s", message);
+    for (char *p = sanitized_msg; *p; p++)
+        if (*p == ' ') *p = '_';
+
+    // Create snapshot folder path
+    snprintf(snapshot_path, sizeof(snapshot_path), "%s/%s_%s",
snapshot_dir, timestamp, sanitized_msg);
+
+    if (mkdir(snapshot_path, 0755) != 0) {
+        perror("mkdir snapshot_path");
+        free(snapshot_dir);
+        return -1;
+    }
+
+    // Copy staged files
+    char cmd[2048];
+    snprintf(cmd, sizeof(cmd),
+             "git diff --name-only --cached | xargs -I{} cp --parents
{} \"%s\"",
+             snapshot_path);
+
+    int ret = system(cmd);
+    if (ret != 0) {
+        fprintf(stderr, "Failed to copy staged files\n");
+        free(snapshot_dir);
+        return -1;
+    }
+
+    printf("Snapshot created at %s\n", snapshot_path);
+    free(snapshot_dir);
+    return 0;
+}
diff --git a/snapshot.h b/snapshot.h
new file mode 100644
index 0000000000..7542538f1f
--- /dev/null
+++ b/snapshot.h
@@ -0,0 +1,13 @@
+#ifndef SNAPSHOT_H
+#define SNAPSHOT_H
+
+#include "cache.h"
+#include "dir.h"
+
+// Check if snapshot feature is enabled
+int snapshot_enabled(void);
+
+// Create snapshot of staged files with commit message
+int create_snapshot(const char *message);
+
+#endif // SNAPSHOT_H
-- 
2.34.1
