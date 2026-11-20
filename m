Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795152785;
	b=fBKiuQFkCnq4AcFY/3iSAIpoHnN1kMNCP01BO2GHyCv7LWjFQnr1Zs4R3LIGnzdIYQqJ
	 kz6Zqc3CghT3IfTTCkP7jhhJ9QhgwQSVk8SufNB955PlESI3Uy8X+NCIC7TWtg1Cmge17
	 mmTloJvVSPw6QiWuBJ3RYCj/WGOHxx5mUsrvXN4kR3Eyyeux6dA8r+dopa6reXrDipX2P
	 QxskLGuIfLuVZFqWrQzWnw5fNiqa9gTefuTdFidOqVHOV4KOx5scikrUKoasMVKeGVqam
	 V3vkscMT8F6C2Mb7CB7L+QFSd7Azx1kG8tndB6PclvQRndPbD7/QarF0GyXhk1kyhfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795152785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:From:Date:
	 Subject:Fcc:Content-Type:Content-Transfer-Encoding:MIME-Version:To:
	 Cc;
	bh=H9ugJ1q46i876aQ/8hvUzJB2TuFOnsUDg0I8azy3igA=;
	b=aq0Wl5HwLzJ8hMX7NKp5gMZVrIAvmET3aCetuygM+WlpnCytLOKC0VS7NyrUBG9fVwQe
	 2bW+ArUepzmoOku2kVv4lKGZvLQRZGOW509/4FELtnYBuMK/qtdaUl65fnehmMvqVDQEb
	 BT0F2U/CV4rArAQ4FRGgOhcLYLZZYdToBfUfSHW/XUkfLs3mFr+zTOPjbh2/hqJezJ/oJ
	 WuFNc30yMfjJpVO2ull1V/senTX1UAq6o/pxO+T3FH3PaAKDQqCKpEKoPd7D4Z+RcyErs
	 DM6UYTIRu7oDLELjVzIVR+73dibDFGP/l/3hXSQlTLb+i4uVTcr67WL50jQrdxiweCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="H/pO3MIp";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22982606A320
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 05:33:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22982606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/pO3MIp
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b3a914e4c8so326679a91.0
        for <git@vger.kernel.org>; Thu, 19 Nov 2026 21:33:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795152784; x=1795757584; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=H9ugJ1q46i876aQ/8hvUzJB2TuFOnsUDg0I8azy3igA=;
        b=H/pO3MIpCjFZCMW0Ssp5Sh7uS5+9tsuuIeuxx5qrXlxTC0aBLfRtwwL/pvIsjgj0DV
         1tdJQAmTCc134uRWBT+20FpgUrLxUlJYVcV4C9c60cKPKy6VqT5RNTEEE4uJH61c+4Qf
         WIuOnAw7nxMMuytOwng3Z9fhQjnRlcqlONkdcBBO13Ly2zHExJD9hjnfK4UoqyJQBNTc
         wUds35K2fYHTvZnP+0u3DppyBcXCOJcgzjNSnML1sELCKTOb92hufUiqlKDQC2EbNpIO
         4I+np1josJ8YH7gRGr2UOlaEbClrzqMsB1z5DnOE7cEraZl8ibVl8qCFkDge9y26zwoy
         koBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795152784; x=1795757584;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=H9ugJ1q46i876aQ/8hvUzJB2TuFOnsUDg0I8azy3igA=;
        b=t8T46/eAvgX086sdYMw/8LN5tVpzYywCzwxZQ6GDE28xXOZeDeRbrfoZZezYKx7taG
         4DKMibpdparTEplb6qOwLB2B31oi1ABPNwlZa9o7pPNIMY3mr+rEi4xkexykfOpSJAX0
         Mnq9lrXRUyVsZnd3P3nxYIgqy1ZFAVDfLhk4AHylUfRMxSyt11khTyQamAIhWYAjh4Ve
         RtOWKyjfrvtwXvsDQQV41yYnvApHyBrcoO5Q3ar9XocS9IMqVZ9iunfPRhg//I3Y20sK
         RBM/vDg2v06S+W5CATDioECZ2gTUbT9tN3z+/uaZpk+CGh4lZPbRWULaSNFVzYiTTZMq
         9s5Q==
X-Gm-Message-State: APuU4Z8f5P2sjrWkHR+HpC6I/m+O1mfb7yHNLWVyxyjBQ3DtM0Aarcuj
	vW/dW5S1sHYzbLBTlFQQFKfv/lC2mE9d0MWRAO9RAaIi1P2O3KedzNPHAwcUzw==
X-Gm-Gg: AZFdTZe3ykXMqMEn+wTe4DNGJyji3GouvSMGS4HtA9fT3kgnf6DC3cQQ+QThZoRmSkT
	Au6FtJ4WjzjoywR6Swr4OVU+rgimwBkA7OVY+mO0HKV9N2GEBdBB0b1FY3/54B2aumSrJ+QuVnK
	QGnMSfCTDwa1En1wkSxGNE9jvnGOpJpgVxTUKW+r4SMNg5xz8V7pIejbagFqvxcex8a+nbWLwjA
	5S/ybs7L12GDfx+jxVpyoY8HtKMBoJRetsY08znrvHaPW8z1TqLntQ2gC4C5XDGKXMf1JsefOuO
	dyAaDSsSMtb5mV8TkJrE38Rq5XMHc1iUWMlpuTnuWUIqzopHseLAazLuDBAVBr0Mw9ZDoV6coCO
	8xjdATeXtjp8MNVYnqnKvWCo1xk0iA86BEsW5CrgOJe+cjY+nB+LrrZSUKxjL6/0wYcFLy4Cupo
	g3gD9NrPbzYVL0XhxkjNaHKxWP/uQCCcAvF0apLQo56111UiAwRWXVM55mq7JrTEg43ojnnQKFL
	+lY0F1ojYKuN+0M+7dIsQTLsF+D9FS0FmTO8QuC1YARDOevRN2AYJO8LmHn1W3htHlZ+iKr7VyG
	CtW4O0+QERbhBNwyJwnjiaUTCuzwF83vukWgTLwAu+JNLc4hUTnjULP0iPePICZ20Vy53dlg5E4
	kfHsXQ9U9
X-Received: by 2002:a17:90b:388c:b0:3b4:1877:8d35 with SMTP id 98e67ed59e1d1-3b41c975320mr1774274a91.52.1795152784228;
        Thu, 19 Nov 2026 21:33:04 -0800 (PST)
Received: from [127.0.0.1] (ec2-3-42-157-130.us-west-2.compute.amazonaws.com. [3.42.157.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b40f4312dfsm4273401a91.3.2026.11.19.21.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 21:33:03 -0800 (PST)
Message-Id: <pull.2321.git.1795152783221.gitgitgadget@gmail.com>
From: "Maik Riechert via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 05:33:03 +0000
Subject: [PATCH] dir: invalidate parents of stale cached directories
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Ilia K <ki.stfu@gmail.com>,
    Derrick Stolee <stolee@gmail.com>,
    Junio C Hamano <gitster@pobox.com>,
    Maik Riechert <letmaik@outlook.com>,
    Maik Riechert <letmaik@outlook.com>

From: Maik Riechert <letmaik@outlook.com>

After a failed fsmonitor query or a trivial response, "git status"
can report both an untracked directory and a directory below it,
for example "?? three/" and "?? three/deep/".

1cf98cb4d9 (fsmonitor: check the untracked cache after a trivial
response, 2026-11-09) added a stat check before writing the untracked
cache alongside a new fsmonitor token after these responses.  The check
invalidates stale directories, but does not propagate the invalidation
to their parents.

In normal mode, a parent's cached untracked list can contain "three/"
from a check-only scan of the child.  Writing the invalid child clears
its check_only flag.  The next cached walk then recurses into the child
and reports "three/deep/", while the parent's list still reports
"three/".

Invalidate ancestors too when DIR_SHOW_OTHER_DIRECTORIES is set, as
invalidate_one_component() does.  Leave all-files mode unchanged and
reuse the existing traversal without adding stat calls.

Add normal-mode regression tests for failed queries and trivial
responses.  Use fixed directory mtimes and force an index write without
scanning untracked files.

Signed-off-by: Maik Riechert <letmaik@outlook.com>
---
    dir: invalidate parents of stale cached directories

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2321%2Fletmaik%2Funtracked-cache-stale-dirs-parents-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2321/letmaik/untracked-cache-stale-dirs-parents-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2321

 dir.c                       |  6 +++++
 t/t7519-status-fsmonitor.sh | 46 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/dir.c b/dir.c
index 4f748800b1..633d259d7a 100644
--- a/dir.c
+++ b/dir.c
@@ -4094,6 +4094,12 @@ static int invalidate_stale_dirs(struct untracked_cache *uc,
 		strbuf_setlen(path, len);
 	}
 
+	if (nr_invalidated && ucd->valid &&
+	    (uc->dir_flags & DIR_SHOW_OTHER_DIRECTORIES)) {
+		invalidate_one_directory(uc, ucd);
+		nr_invalidated++;
+	}
+
 	return nr_invalidated;
 }
 
diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 27c3194ae0..3877140b77 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -388,6 +388,52 @@ test_expect_success UNTRACKED_CACHE 'untracked cache is checked after a trivial
 	)
 '
 
+for response in trivial failed
+do
+	test_expect_success UNTRACKED_CACHE,!MINGW "stale check-only directories invalidate parents after a $response response" '
+		test_when_finished "rm -rf stale-$response" &&
+		git init stale-$response &&
+		(
+			cd stale-$response &&
+			mkdir -p parent/three/deep &&
+			>parent/keep &&
+			>parent/three/deep/tracked &&
+			git add parent &&
+			git commit -m initial &&
+			git rm --cached parent/three/deep/tracked &&
+			git config core.untrackedCache true &&
+			git config status.showUntrackedFiles normal &&
+			git config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-none" &&
+			git config core.fsmonitorHookVersion 1 &&
+			test-tool chmtime =1000000000 . parent parent/three parent/three/deep &&
+			cat >../expect <<-\EOF &&
+			D  parent/three/deep/tracked
+			?? parent/three/
+			EOF
+			git status --porcelain >../actual &&
+			test_cmp ../expect ../actual &&
+
+			# Change only the check-only directory after caching it.
+			# Write the index without scanning untracked files.
+			test-tool chmtime +60 parent/three &&
+			if test "$response" = trivial
+			then
+				hook_version=1
+			else
+				# fsmonitor-all fails for version 2.
+				hook_version=2
+			fi &&
+			git -c core.fsmonitor="$TEST_DIRECTORY/t7519/fsmonitor-all" \
+				-c core.fsmonitorHookVersion=$hook_version \
+				update-index --force-write-index &&
+			git status --porcelain >../actual &&
+			test_cmp ../expect ../actual &&
+			git status --porcelain >../actual &&
+			test_cmp ../expect ../actual
+		)
+	'
+done
+
 # test that splitting the index doesn't interfere
 test_expect_success 'splitting the index results in the same state' '
 	write_integration_script &&

base-commit: f7de81456940dd6f3274e461149bba12965de609
-- 
gitgitgadget
