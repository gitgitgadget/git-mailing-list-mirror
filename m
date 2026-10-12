Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AFF7080D
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 02:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791770619; cv=none; b=isuOmtUyPfChyHpGIG6dLHtSAwgVZRxuXtGRTovxix8HlaotXetl2CAPIWmvucOe+eNVRK5PnKNKs//md8LQIa1QFvJPDLIq1LRBncMy0jNH2aD6PV9D3KkBdvsEM7xb/5Cu2MrWsO9MtZo3Xdww6CIZjZVGhjjl14uUBQTn6a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791770619; c=relaxed/simple;
	bh=OcL8gaidOJX922f7DnLP1YQyJt4XdOX9V9ZvMefjdXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A5NSLpDKNjIglAJxlbZur57d1yPFM7bsvvibx27Ev5+2YmG6mCW2zEYYlFhU91b8KNX+qMwOrQcDQLUcpUJ/fCXP9MnRpM2pW93pcx2cV67yZ0JHukAmJdU/BO5tTOJvJAoVZvy1Cf06DFqUo0U7Kv7aYes7snh0CDQnljCs7IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XeNS8bjf; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XeNS8bjf"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3535bf8b3e0so2389547eec.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 19:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791770617; x=1792375417; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBDrqC39G6M45k3Fl+1eDxqvKANkAR50/i+MWY9Pen4=;
        b=XeNS8bjfjVfwyVAFuT7NWcbJGMT0FR4ffARxHx9h+FVSenTJvwflRtX5hEzNtqY2O/
         VF4NvvwJHE6wCxn7JEauedRvquEuE8tLaqjIcrT4u+k9Fhfw7JAm4GTN5aXtVK2dJrRN
         g8bIOOIXWSeJpwtPaicEQp+4tc80YLXkiBIKKsCCXJdWt+lhLI9B4Q1dxHnFWjp+EpSf
         r2ZKBg9ALQiiak9SnbGXj8EtwvifhotBHVlxx7zRSmRNz1TXGhOSd9j3WX0e+qsEG7TR
         FvovTpMV3kTfKkk8pB+8qn2N6P/H01H6FkOBThsYu+++Byu2oPEX89zTrU4s8L6ZkehB
         Y8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791770617; x=1792375417;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBDrqC39G6M45k3Fl+1eDxqvKANkAR50/i+MWY9Pen4=;
        b=z2ORx4VJmVcAtDmX8gyA4j0KFLaCszlJBAe0AkfkqPjiR91+mbV65C/YGSfveN/lW9
         ly9JZY1LyKDsRvGEGYb0pQpMjUt8v6yeh6co7gGcNMvUJit04kiQduonwG8iDL5lcbQN
         o67vg2JWW2kuuO1S3YBueE3Ax163/j9AC/z/9yaxttP82FfpfLTYdiaBbiFeRkbsxYjS
         u3yKrJbPTlMR7eCqLVVzds4W0V2YdQTOUwnoGdAbynZjZZnKwtbpi/3v7PwJlSRqYRsS
         8E0Men2bSzvdRU7lkXN2Su5JG+xJMme+01EG/uReReQVr7rFUxv+yiv4WD3HSWt3lkKZ
         A9Mw==
X-Gm-Message-State: AFq9FYK2yHn3etF85i4h9h78+sRJkAHLKbbxW+Ae0tNpc98dnkUlmLtK
	6D0w/eWxDtAgS8CKG2gOz2tGjQ73zgOMkEzWt+0guGuHsEVcSloX2XPH2x7hxd+S6F4=
X-Gm-Gg: AYBFou1CKBPxV4wUJOohmnpu287Zy7fjXS+AqlzZZGWfvJUvogbk3qylJufmqeHAdXP
	sZ0qVWkVS1YteXCN1s6PYdJqCpl+OOt61S6A+dtnaR8+/dp8gYOAko9I0P2Kn56+N0wzKC0yd1x
	eXSaHiqStm+3kwNz7mZHKGkmtP9Xrw5iHhEtBxLTuNAREeyYKH4XKLS8FEuy2alpG4G7ahnm6hO
	qXYBC4kFq1vicmWOSPrjI4pjALnLdidRfILfOfFE9Fl8XGiKe+PuKieZ7b0LtMsxdybd46RPf4o
	a3cXl/H5IDKF5qrQOnDsMsXdFPwhdiKjdHsNN8DD9pogEAFdm0x2DiUi9ZGMT4PTz8cnCaSA9y3
	r272rbdKA0gNoIGWzYjmBrclxalsgkYW5yYbsqvVsaHRGb+/TwVciIwkJeeR/BLU6aWWK9Pd6fQ
	SSFgs3bhz91fDzaMGMyERECkHDa1xwe8SeD/YjDQS3EI8XZt7nVuxCjuC8S/gjoEiwIQqWOr3CV
	p/rw36JZUDeIqGzaIQVe6cLj05We+eU
X-Received: by 2002:a05:701b:2084:10b0:143:8188:fafe with SMTP id a92af1059eb24-16a63099ec2mr12466877c88.41.1791770616685;
        Sun, 11 Oct 2026 19:03:36 -0700 (PDT)
Received: from isabella-caselli-linux.. ([2804:14c:9e:81ad:adb8:bc9f:a8c8:3c2d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-35a352d4b05sm7196412eec.19.2026.10.11.19.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:03:36 -0700 (PDT)
From: Isabella Caselli <bellacaselli20@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Isabella Caselli <bellacaselli20@gmail.com>
Subject: [PATCH 3/3] config: learn the "hostname:" includeIf condition
Date: Sun, 11 Oct 2026 22:58:46 -0300
Message-ID: <20261012015846.2649843-4-bellacaselli20@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012015846.2649843-1-bellacaselli20@gmail.com>
References: <CAK4AdTSnaAOk649a0GLe1M9C+cYuDa0Nwo54=HT47R53Q4ZdWw@mail.gmail.com>
 <20261012015846.2649843-1-bellacaselli20@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the same home directory is shared across multiple machines, they
all read the same ~/.gitconfig. Settings that should differ between
machines therefore need a way to make that file behave differently
on each host. The same problem affects people who keep their dotfiles
in a repository and check them out on multiple machines.

Add a "hostname:" keyword to includeIf. The value that follows is a
pattern supporting standard glob wildcards, and the condition is met
when the machine's hostname matches it. If the hostname cannot be
determined, the condition is not met.

Depending on the system configuration, the hostname may be either a
short name or a fully qualified domain name. Making the name fully
qualified ourselves was considered, but it could require a DNS lookup
while reading the configuration. Instead, match the name as the
system reports it, document this, and point to "git var GIT_HOSTNAME"
as a way to check the value being matched.

The tests obtain the hostname with "git var GIT_HOSTNAME" before
writing the configuration, so that a failure to retrieve it makes
the test fail instead of going unnoticed inside the here-document.

Based-on-patch-by: Ignacio Encinas <ignacio@iencinas.com>
Signed-off-by: Isabella Caselli <bellacaselli20@gmail.com>
---
 Documentation/config.adoc  | 14 ++++++++++++
 Documentation/git-var.adoc |  2 ++
 config.c                   | 17 +++++++++++++++
 t/t1305-config-include.sh  | 44 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+)

diff --git a/Documentation/config.adoc b/Documentation/config.adoc
index f67dcd2f8e..aa6360e230 100644
--- a/Documentation/config.adoc
+++ b/Documentation/config.adoc
@@ -232,6 +232,16 @@ As for the naming of this keyword, it is for forwards compatibility with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`hostname`::
+	The data that follows the keyword `hostname:` is taken to be a
+	pattern with standard globbing wildcards. If the hostname of
+	the machine matches the pattern, the include condition is met.
++
+Depending on how your system is configured, the hostname used for
+matching may be short (e.g., "myhost") or a fully qualified domain
+name ("myhost.example.com"). Run `git var GIT_HOSTNAME` to see the
+hostname Git uses (see linkgit:git-var[1]).
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
@@ -315,6 +325,10 @@ Example
 	path = foo.inc
 [remote "origin"]
 	url = https://example.com/git
+
+; include only if the hostname of the machine matches some-hostname
+[includeIf "hostname:some-hostname"]
+	path = foo.inc
 ----
 
 Values
diff --git a/Documentation/git-var.adoc b/Documentation/git-var.adoc
index e813ab4fd2..fc2def16d3 100644
--- a/Documentation/git-var.adoc
+++ b/Documentation/git-var.adoc
@@ -86,6 +86,8 @@ endif::git-default-pager[]
 
 `GIT_HOSTNAME`::
     The hostname of the machine, as reported by the operating system.
+    This is the hostname matched by `includeIf "hostname:..."` (see
+    linkgit:git-config[1]).
 
 Most path values contain only one value. However, some can contain multiple
 values, which are separated by newlines, and are listed in order from highest to
diff --git a/config.c b/config.c
index e0bb29b53d..c891f63e60 100644
--- a/config.c
+++ b/config.c
@@ -316,6 +316,21 @@ static int include_by_branch(struct config_include_data *data,
 	return ret;
 }
 
+static int include_by_hostname(const char *cond, size_t cond_len)
+{
+	int ret;
+	char my_host[HOST_NAME_MAX + 1];
+	char *pattern;
+
+	if (xgethostname(my_host, sizeof(my_host)))
+		return 0;
+
+	pattern = xmemdupz(cond, cond_len);
+	ret = !wildmatch(pattern, my_host, 0);
+	free(pattern);
+	return ret;
+}
+
 static int add_remote_url(const char *var, const char *value,
 			  const struct config_context *ctx UNUSED, void *data)
 {
@@ -411,6 +426,8 @@ static int include_condition_is_true(const struct key_value_info *kvi,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "hostname:", &cond, &cond_len))
+		return include_by_hostname(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 507b8ebd06..01069237ba 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -524,4 +524,48 @@ test_expect_success 'conditional include, worktree without repository but explic
 	test_must_fail nongit git --git-dir=nonexistent config get foo.bar
 '
 
+test_expect_success 'conditional include, hostname' '
+	hostname=$(git var GIT_HOSTNAME) &&
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:${hostname}a"]
+		path = bar12
+	EOF
+	cat >>.git/bar12 <<-EOF &&
+	[test]
+		twelve=12
+	EOF
+
+	test_must_fail git config test.twelve &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$hostname"]
+		path = bar12
+	EOF
+	echo 12 >expect &&
+	git config test.twelve >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'conditional include, hostname, wildcard' '
+	hostname=$(git var GIT_HOSTNAME) &&
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:${hostname}a*"]
+		path = bar13
+	EOF
+	cat >>.git/bar13 <<-EOF &&
+	[test]
+		thirteen = 13
+	EOF
+
+	test_must_fail git config test.thirteen &&
+
+	cat >>.git/config <<-EOF &&
+	[includeIf "hostname:$hostname*"]
+		path = bar13
+	EOF
+	echo 13 >expect &&
+	git config test.thirteen >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.43.0

