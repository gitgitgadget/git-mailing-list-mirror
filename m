Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD011EF09B
	for <git@vger.kernel.org>; Wed, 30 Jul 2025 06:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753856832; cv=none; b=X8tdws3dez/p1vyeVLzid9MwNojDsL2ltt+1l2V9scm/C0BN3lAlirY6YZzRUpITUvR6EUEJRPoA3ioC066y0KwI/aRYYbYaJCNX/m/7w/Y+xNsYKccy3gJxpp/RD+OZuPEhFyc4RkWfD2q6L2rZhr9RNuVfQvsPLJuxHE9+ik4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753856832; c=relaxed/simple;
	bh=7ju7DzbudbF3FEMMrdZ8X7p6b2HJlQc5rlG79V86HxE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=Lz9NCbXUDjvYJMHs+IsrA+cKOnGxSaRlgih0UFuRFMRa9DRwJowHWQsz4u7AgQNlk+R+6esEwDURNBXGEAQ0TiswoxQz+hBLQQIfCikfgGREKQvQ0y1EXngehOf07CugRQdyXiVTYj+MGJ9yoPcgtqU/RC9kGmLeKdzxHbGDk+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHjK97yr; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHjK97yr"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3b78127c5d1so2287908f8f.3
        for <git@vger.kernel.org>; Tue, 29 Jul 2025 23:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753856828; x=1754461628; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lQpnE7wMx6HoitNZpVDK3m4ZjgWbJ6QqrOu8d5nokfo=;
        b=FHjK97yryCyNCktVvM03U5X12leiN8GQ07WpyYEmGeBeOCaYud9fI+TlXecqsBcqdK
         c7GyFTAkmhQLaEkgjXWoIMWwLZ0F0PkEtr+rMr1Gb80Ro3AJRopNFBY3eAU4K8BrltJI
         baZACwkUNersSYpIfXoMMsV8fb8XjlDg6wPcz3sc9Cu602LfwTs8YT++HH20+DmWaLnC
         TWhgOe5GFP5gyIcW4J7j+Moi2wxzTAYw97/w1Wtcxg22/63MJG9hYufNvWXoc+fKD+cc
         LYuKuL43OiuwoFi75zFlYWGHjxVEi6oiGaLdNiQmETfFSrAVun4GqIlnzZuRN+Zb+RZ0
         xCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753856828; x=1754461628;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lQpnE7wMx6HoitNZpVDK3m4ZjgWbJ6QqrOu8d5nokfo=;
        b=Gn+YfxYfKgTG0DRM/8Oln9ICoMLQtWE4QXSiMrTyeNINZxjImqTvb6K5LPa+FWkEJ+
         t478RUFGRO81Xi7EOS+JVm5N9dbl7JwPap7CfBh7brpBrMTnkjvfEFiu9H4O/7AMJSy8
         UjiWsEm5hMK4lcMiHsKvlcOVA0Ia+x7v6ZWp+TA2QVkIyHRmSw2LK/3xlS06NJKaTKh7
         a6cSUeJBfQh2gdmMRHeq867K8Naz12fMZQyTBE0s9uTKGl458DewF0qKsSJnIY/XOgOH
         IZIXbZmts9orTAksnjRQQm1o9H7HOmFB57UEcWkLCQK/mJiRM/ndYNk6A9aKEkh7FWi0
         RsSg==
X-Gm-Message-State: AOJu0Yx/FFdAldckm6SQ+uIUta0UohpEbw4h5OCNs9jKuRwFzZlp9pzn
	phnNAPe3aJ3wxhlrTPn64/FfvirC4fIcrC7nenH3m7OZalPEsx62u3wYmOHbUQ==
X-Gm-Gg: ASbGncvnKKkDZOcH9xXz3HIh8S2bmbja0XCM/3kYbyaFuSfUY5Ug7CxIJcb8VLpvj7J
	u3Q0WGHsLsfN0ILUIlUXURgA9NvEu1Sbuhq4beAoQiLru4Y0dMhe0maKyf/nHsqcj9w7g6KFi6n
	NKlxci8tozXuBOOQU1kerc1D66TSmwU83YAlDuCwsx0kqtgVBjBaQuylfftbx7ReiTSfJzvCY6t
	GGFaSujlaoxB+saZv2PHRYNoif36nZpxzhhPlx2+IfygIV7lpEZTt131PZ/niE5X+8D0FNJt3bB
	GFCS7B0LV645/mCxFDvxfCyuFgUgS4fkNeSieZLNQSKntO6MZil3Mq20fzpaXpL3I6FL+s394fQ
	/CtEsmpQ+fSvxibsj3G/W2jU=
X-Google-Smtp-Source: AGHT+IFxb5PGnjh+D6aIpa1hEbILcrzqQgk2SbveKugU40i+9OKlg43sWOhHKTgWBxUOME50CgaSfw==
X-Received: by 2002:a05:6000:4011:b0:3b7:899c:e87d with SMTP id ffacd0b85a97d-3b794ff16f9mr1291406f8f.30.1753856827840;
        Tue, 29 Jul 2025 23:27:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b788f5f27esm8632097f8f.14.2025.07.29.23.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 23:27:07 -0700 (PDT)
Message-Id: <pull.1937.git.1753856826464.gitgitgadget@gmail.com>
From: "Tach via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 30 Jul 2025 06:27:06 +0000
Subject: [PATCH] status: add --json output format to git status
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
Cc: Tach <tacherasasi@gmail.com>,
    tacherasasi <tacherasasi@gmail.com>

From: tacherasasi <tacherasasi@gmail.com>

Add a new --json flag to 'git status' that outputs repository state
in a structured JSON format. This enables reliable machine parsing
of status information for tools and automation.

The JSON output includes:
- Branch information (name, detached state, ahead/behind counts)
- Staged files array
- Unstaged files array
- Untracked files array
- Ignored files array (with --ignored flag)

Implementation details:
- Add STATUS_FORMAT_JSON to wt_status_format enum
- Add JSON output option to git status and git commit
- Implement JSON formatting helpers for arrays and branch info
- Structure output for easy parsing and future extensibility

Example:
  $ git status --json
  {
    "branch": {
      "current": "main",
      "detached": false
    },
    "staged": ["file1.txt"],
    "unstaged": ["file2.txt"],
    "untracked": ["file3.txt"]
  }

This provides a robust alternative to parsing traditional output
formats, making it easier to build reliable tools and automation
around Git status information.

Signed-off-by: Tachera Sasi <tachera@ekilie.com>
Signed-off-by: tacherasasi <tacherasasi@gmail.com>
---
    status: add --json output format to git status

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1937%2FtacheraSasi%2Ffeature%2Fjson-status-output-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1937/tacheraSasi/feature/json-status-output-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1937

 builtin/commit.c |  9 ++++-
 wt-status.c      | 98 ++++++++++++++++++++++++++++++++++++++++++++++++
 wt-status.h      |  1 +
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index fba0dded64a..f1db4fdfd9a 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1540,6 +1540,9 @@ struct repository *repo UNUSED)
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
+		OPT_SET_INT(0, "json", &status_format,
+		    N_("show status in JSON format"),
+		    STATUS_FORMAT_JSON),
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		{
@@ -1603,7 +1606,8 @@ struct repository *repo UNUSED)
 		       prefix, argv);
 
 	if (status_format != STATUS_FORMAT_PORCELAIN &&
-	    status_format != STATUS_FORMAT_PORCELAIN_V2)
+	    status_format != STATUS_FORMAT_PORCELAIN_V2 &&
+	    status_format != STATUS_FORMAT_JSON)
 		progress_flag = REFRESH_PROGRESS;
 	repo_read_index(the_repository);
 	refresh_index(the_repository->index,
@@ -1735,6 +1739,9 @@ int cmd_commit(int argc,
 		OPT_SET_INT(0, "long", &status_format,
 			    N_("show status in long format (default)"),
 			    STATUS_FORMAT_LONG),
+		OPT_SET_INT(0, "json", &status_format,
+		    N_("show status in JSON format"),
+		    STATUS_FORMAT_JSON),
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
diff --git a/wt-status.c b/wt-status.c
index 454601afa15..7192fb4d057 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -2564,6 +2564,101 @@ static void wt_porcelain_v2_print(struct wt_status *s)
 	}
 }
 
+
+static void wt_json_print_string_array(struct wt_status *s, const char *name, struct string_list *list)
+{
+	int i;
+	fprintf(s->fp, "  \"%s\": [", name);
+	for (i = 0; i < list->nr; i++) {
+		if (i > 0)
+			fprintf(s->fp, ", ");
+		fprintf(s->fp, "\"%s\"", list->items[i].string);
+	}
+	fprintf(s->fp, "]");
+}
+
+static void wt_json_print_change_array(struct wt_status *s, const char *name, int change_type)
+{
+	int i;
+	struct string_list files = STRING_LIST_INIT_DUP;
+
+	for (i = 0; i < s->change.nr; i++) {
+		struct wt_status_change_data *d;
+		struct string_list_item *it;
+		it = &(s->change.items[i]);
+		d = it->util;
+
+		if ((change_type == WT_STATUS_UPDATED && d->index_status &&
+		     d->index_status != DIFF_STATUS_UNMERGED) ||
+		    (change_type == WT_STATUS_CHANGED && d->worktree_status &&
+		     d->worktree_status != DIFF_STATUS_UNMERGED)) {
+			string_list_append(&files, it->string);
+		}
+	}
+
+	wt_json_print_string_array(s, name, &files);
+	string_list_clear(&files, 0);
+}
+
+static void wt_json_print_branch_info(struct wt_status *s)
+{
+	struct branch *branch;
+	const char *branch_name;
+	int ahead = 0, behind = 0;
+
+	fprintf(s->fp, "  \"branch\": {\n");
+
+	if (s->branch && !s->is_initial) {
+		if (!strcmp(s->branch, "HEAD")) {
+			fprintf(s->fp, "    \"current\": \"HEAD\",\n");
+			fprintf(s->fp, "    \"detached\": true");
+		} else {
+			if (skip_prefix(s->branch, "refs/heads/", &branch_name)) {
+				fprintf(s->fp, "    \"current\": \"%s\",\n", branch_name);
+				fprintf(s->fp, "    \"detached\": false");
+
+				branch = branch_get(branch_name);
+				if (branch && branch->merge && branch->merge[0] && branch->merge[0]->dst) {
+					if (!stat_tracking_info(branch, &ahead, &behind, NULL, 0, 0)) {
+						fprintf(s->fp, ",\n    \"ahead\": %d,\n    \"behind\": %d", ahead, behind);
+					}
+				}
+			} else {
+				fprintf(s->fp, "    \"current\": \"%s\",\n", s->branch);
+				fprintf(s->fp, "    \"detached\": false");
+			}
+		}
+	} else {
+		fprintf(s->fp, "    \"current\": null,\n");
+		fprintf(s->fp, "    \"detached\": false");
+	}
+
+	fprintf(s->fp, "\n  }");
+}
+
+static void wt_json_status_print(struct wt_status *s)
+{
+	fprintf(s->fp, "{\n");
+
+	wt_json_print_branch_info(s);
+	fprintf(s->fp, ",\n");
+
+	wt_json_print_change_array(s, "staged", WT_STATUS_UPDATED);
+	fprintf(s->fp, ",\n");
+
+	wt_json_print_change_array(s, "unstaged", WT_STATUS_CHANGED);
+	fprintf(s->fp, ",\n");
+
+	wt_json_print_string_array(s, "untracked", &s->untracked);
+
+	if (s->ignored.nr > 0) {
+		fprintf(s->fp, ",\n");
+		wt_json_print_string_array(s, "ignored", &s->ignored);
+	}
+
+	fprintf(s->fp, "\n}\n");
+}
+
 void wt_status_print(struct wt_status *s)
 {
 	trace2_data_intmax("status", s->repo, "count/changed", s->change.nr);
@@ -2583,6 +2678,9 @@ void wt_status_print(struct wt_status *s)
 	case STATUS_FORMAT_PORCELAIN_V2:
 		wt_porcelain_v2_print(s);
 		break;
+	case STATUS_FORMAT_JSON:
+		wt_json_status_print(s);
+		break;
 	case STATUS_FORMAT_UNSPECIFIED:
 		BUG("finalize_deferred_config() should have been called");
 		break;
diff --git a/wt-status.h b/wt-status.h
index 4e377ce62b8..e929af832b2 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -74,6 +74,7 @@ enum wt_status_format {
 	STATUS_FORMAT_SHORT,
 	STATUS_FORMAT_PORCELAIN,
 	STATUS_FORMAT_PORCELAIN_V2,
+	STATUS_FORMAT_JSON,
 
 	STATUS_FORMAT_UNSPECIFIED
 };

base-commit: cb3b40381e1d5ee32dde96521ad7cfd68eb308a6
-- 
gitgitgadget
