Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925E82C0294
	for <git@vger.kernel.org>; Sat,  2 May 2026 05:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777699742; cv=none; b=LCUPHn4c0iEguFqOcO/IqIuUwQTfb37gjUBApP76/674L8mZMJVnXLclufLmBb0N40odp0lh6fdg2KCq2rf2GOG/F1UpDdn/Vdx3LmdNSLGooSXA+/fYHme+N9IjeqzAXRq0r6Lj2UH9T3KsoviGMoHMNZASsahRXR0Ana9x0AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777699742; c=relaxed/simple;
	bh=L7tb54BrNrXlW51LVic54tEw0mnWQ+eFglmwfZpMwBc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=FCF5BXu4UjF9tTB4Uo1C+zaNXLGow9NJAX3O06RFmm4K7TuJVLIKxc3LsaCUxhtKBxGEfO4j31VXsGC42GAHV/uOEqTmjgiaV3+yhQ4OuBToEhBlAo8Gjj+i4W9EAaRDH+cbXlqX0dypKK549BHZ5PA+jA/k+HCw0GXfrJf4dog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFE6XFx5; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFE6XFx5"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-8ea8563c693so293913585a.2
        for <git@vger.kernel.org>; Fri, 01 May 2026 22:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777699734; x=1778304534; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q7Ugk2AQ5UmfgXOyPtlW1aQhDLsVaRnHKFdVEvVbZgE=;
        b=gFE6XFx5swU9FFLbJqF6GJxmcztXYQJRKi6nPV5rC6NSuN86QkPxLREQ7nuy5fzgCQ
         kWouh4brOrXJGbSEqf83qBfYWKAnTm9zcjUbYGO543BmMJIsOnBZtClgfeqDJ+2YjOcM
         1PgLStrs3YESZmDvQteBlUGRidbDlIHwADNFKvm8JiA4MIBTRz+DWXhN0V3LYaZqP9CS
         257w7d+g5xr4kqbP/vdCgnLeERs7AfanpQaAVvstYwHBz7FC0anVG+tbI/UgE22Nrunn
         T2uLkXEVjXXmBPMwVTP360O03WHT6Q+qZcF421RmUZCKXc/ZbwYN+4e+/KTyyxUThSVa
         sniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777699734; x=1778304534;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q7Ugk2AQ5UmfgXOyPtlW1aQhDLsVaRnHKFdVEvVbZgE=;
        b=hSDvw6AJ4e0E1tI0B1tVlgJ3oFrxJrUVPPicaxQvcvjjX75i5qZInvTtZOuPyO0c5L
         wD+5UzDHuVcRiDNYBpNMxdghgRxHdfeXNIXS/qjY8QsmhqrCk/ekzx2uhxSU+n0QK6nM
         v4SVlBEBMAJ0ce9niH26d+XVVap9/anLv8pFxXDwtLjqZdq7JlViWUmr2ANcH4Hh8eVZ
         Cl03QnmM7y3hIUUGaT01yy4SJkplgeQzcPsK+twz2g3NPcNSAuSwVXqqZb5MwEqBm25Z
         OWeLZsZmnObJD9T9n6QrcQxN1EsMn0rVmks4BL5elvzeU6if+FYh2uHm9Ry8QOrV6iia
         +NCQ==
X-Gm-Message-State: AOJu0Yz1VdIyHLP3tkjq3kLBDK9i6yGk+TGZd6KQmes5SRed88RJgBnC
	IBoBKSUgDjDASVodifNYOwSnHwPKd5zHEFMZQyfBeLZe8rYqMNTYUVjLMYgxNg==
X-Gm-Gg: AeBDieuuHoi0ELs9cRBBH/GnEQU++iv653Gk2yiN5vTiE97SUBLyGw+A8n1rFYJzRgS
	6QRmzA/4bxIGt6VudCI7xNf+EsjVzumUxZKYVemPV1CDLil8Y4zOp/zM0P0bskf3+FAIW5rGxqM
	seXxZT067Y67Ox/zbE1j4KI63kdIpnm3N0VRBggL9cGbTOO+sZS33E/8vN7pQ5WZijh6Hmsokr1
	ytzvzUxMKG9XYwRac/Yry7/t8NiLS5Nh7GvWYuECUENPMD4AkX4Zpi7IFrMTLqEZC2SmAUtHs+Q
	DcmiWDfLsMpZVZBn7ON2dZqnS7Yve+LkO/4wTIJ8To0B6tqWCqNTusE1hG2+AORO5mZIIyUkvgd
	rrQT8bukyUXyM80+PJq+kyDVFokURH45lLUTbiZg+SCH0PHwNoYBpqZgg6MyW3UNA2nVGTYt3F8
	c6qe0SiOFPACVMjXe8QPUs1wX9eVnNoxtLKmN15uM=
X-Received: by 2002:a05:620a:1709:b0:8d9:8c28:a945 with SMTP id af79cd13be357-8fd17d4961bmr352862185a.40.1777699733711;
        Fri, 01 May 2026 22:28:53 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.224.103])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8fc2c91b976sm391856685a.39.2026.05.01.22.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 22:28:53 -0700 (PDT)
Message-Id: <ce41d2ec50effb277246c459d328a9d5d720ed3a.1777699722.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
References: <pull.1715.v2.git.git.1777677310.gitgitgadget@gmail.com>
	<pull.1715.v3.git.git.1777699722.gitgitgadget@gmail.com>
From: "Matheus Afonso Martins Moreira via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 02 May 2026 05:28:42 +0000
Subject: [PATCH v3 8/8] t9904: add tests for the new url-parse builtin
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Torsten =?UTF-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
    Ghanshyam Thakkar <shyamthakkar001@gmail.com>,
    Matheus Moreira <matheus@matheusmoreira.com>,
    Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>

Test git URL parsing, validation and component extraction
on all documented git URL schemes and syntaxes.

Add IPv6 host coverage in URL form:

    ssh://[::1]/path
    ssh://user@[::1]:1234/path
    git://[::1]:9418/path
    http://[2001:db8::1]/path
    https://[2001:db8::1]/path

In URL form the brackets are kept in the host component (RFC 3986
syntax for IPv6 literals).

Also exercise the bracketed scp short forms that t5601-clone.sh
covers via parse_connect_url:

    [host]:path
    [host:port]:path
    [::1]:repo
    user@[::1]:repo
    user@[host:port]:path

In scp form, brackets are kept for IPv6 literals (two or more inner
colons) and stripped for plain hostnames or host:port pairs.

Suggested-by: Torsten Bögershausen <tboegi@web.de>
Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
---
 t/meson.build        |   1 +
 t/t9904-url-parse.sh | 319 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 320 insertions(+)
 create mode 100755 t/t9904-url-parse.sh

diff --git a/t/meson.build b/t/meson.build
index 7528e5cda5..41b389a472 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -1114,6 +1114,7 @@ integration_tests = [
   't9901-git-web--browse.sh',
   't9902-completion.sh',
   't9903-bash-prompt.sh',
+  't9904-url-parse.sh',
 ]
 
 benchmarks = [
diff --git a/t/t9904-url-parse.sh b/t/t9904-url-parse.sh
new file mode 100755
index 0000000000..8a369d2040
--- /dev/null
+++ b/t/t9904-url-parse.sh
@@ -0,0 +1,319 @@
+#!/bin/sh
+#
+# Copyright (c) 2024 Matheus Afonso Martins Moreira
+#
+
+test_description='git url-parse tests'
+
+. ./test-lib.sh
+
+test_expect_success 'git url-parse -- ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/repository/path" &&
+	git url-parse "ssh://user@example.com/repository/path" &&
+	git url-parse "ssh://example.com:1234/repository/path" &&
+	git url-parse "ssh://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- git syntax' '
+	git url-parse "git://example.com:1234/repository/path" &&
+	git url-parse "git://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- http syntax' '
+	git url-parse "https://example.com:1234/repository/path" &&
+	git url-parse "https://example.com/repository/path" &&
+	git url-parse "http://example.com:1234/repository/path" &&
+	git url-parse "http://example.com/repository/path"
+'
+
+test_expect_success 'git url-parse -- scp syntax' '
+	git url-parse "user@example.com:/repository/path" &&
+	git url-parse "example.com:/repository/path"
+'
+
+test_expect_success 'git url-parse -- username expansion - ssh syntax' '
+	git url-parse "ssh://user@example.com:1234/~user/repository" &&
+	git url-parse "ssh://user@example.com/~user/repository" &&
+	git url-parse "ssh://example.com:1234/~user/repository" &&
+	git url-parse "ssh://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - git syntax' '
+	git url-parse "git://example.com:1234/~user/repository" &&
+	git url-parse "git://example.com/~user/repository"
+'
+
+test_expect_success 'git url-parse -- username expansion - scp syntax' '
+	git url-parse "user@example.com:~user/repository" &&
+	git url-parse "example.com:~user/repository"
+'
+
+test_expect_success 'git url-parse -- file urls' '
+	git url-parse "file:///repository/path" &&
+	git url-parse "file://"
+'
+
+test_expect_success 'git url-parse -c scheme -- ssh syntax' '
+	test ssh = "$(git url-parse -c scheme "ssh://user@example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://user@example.com/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://example.com:1234/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- git syntax' '
+	test git = "$(git url-parse -c scheme "git://example.com:1234/repository/path")" &&
+	test git = "$(git url-parse -c scheme "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- http syntax' '
+	test https = "$(git url-parse -c scheme "https://example.com:1234/repository/path")" &&
+	test https = "$(git url-parse -c scheme "https://example.com/repository/path")" &&
+	test http = "$(git url-parse -c scheme "http://example.com:1234/repository/path")" &&
+	test http = "$(git url-parse -c scheme "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c scheme -- scp syntax' '
+	test ssh = "$(git url-parse -c scheme "user@example.com:/repository/path")" &&
+	test ssh = "$(git url-parse -c scheme "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- ssh syntax' '
+	test user = "$(git url-parse -c user "ssh://user@example.com:1234/repository/path")" &&
+	test user = "$(git url-parse -c user "ssh://user@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- git syntax' '
+	test "" = "$(git url-parse -c user "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- http syntax' '
+	test "" = "$(git url-parse -c user "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "https://example.com/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c user "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c user -- scp syntax' '
+	test user = "$(git url-parse -c user "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c user "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c password -- http syntax' '
+	test secret = "$(git url-parse -c password "https://user:secret@example.com:1234/repository/path")" &&
+	test secret = "$(git url-parse -c password "http://user:secret@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c password "https://user@example.com/repository/path")" &&
+	test "" = "$(git url-parse -c password "https://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- ssh syntax' '
+	test example.com = "$(git url-parse -c host "ssh://user@example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://user@example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- git syntax' '
+	test example.com = "$(git url-parse -c host "git://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- http syntax' '
+	test example.com = "$(git url-parse -c host "https://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "https://example.com/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com:1234/repository/path")" &&
+	test example.com = "$(git url-parse -c host "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c host -- scp syntax' '
+	test example.com = "$(git url-parse -c host "user@example.com:/repository/path")" &&
+	test example.com = "$(git url-parse -c host "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- ssh syntax' '
+	test 1234 = "$(git url-parse -c port "ssh://user@example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://user@example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "ssh://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- git syntax' '
+	test 1234 = "$(git url-parse -c port "git://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- http syntax' '
+	test 1234 = "$(git url-parse -c port "https://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "https://example.com/repository/path")" &&
+	test 1234 = "$(git url-parse -c port "http://example.com:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- scp syntax' '
+	test "" = "$(git url-parse -c port "user@example.com:/repository/path")" &&
+	test "" = "$(git url-parse -c port "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- ssh syntax' '
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://user@example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "ssh://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- git syntax' '
+	test "/repository/path" = "$(git url-parse -c path "git://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "git://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- http syntax' '
+	test "/repository/path" = "$(git url-parse -c path "https://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "https://example.com/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com:1234/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "http://example.com/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- scp syntax' '
+	test "/repository/path" = "$(git url-parse -c path "user@example.com:/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "example.com:/repository/path")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - ssh syntax' '
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://user@example.com/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - git syntax' '
+	test "~user/repository" = "$(git url-parse -c path "git://example.com:1234/~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion - scp syntax' '
+	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository")" &&
+	test "~user/repository" = "$(git url-parse -c path "example.com:~user/repository")"
+'
+
+test_expect_success 'git url-parse -c path -- username expansion strips query and fragment' '
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository?query")" &&
+	test "~user/repository" = "$(git url-parse -c path "ssh://example.com/~user/repository#fragment")" &&
+	test "~user/repository" = "$(git url-parse -c path "git://example.com/~user/repository?query")" &&
+	test "~user/repository" = "$(git url-parse -c path "user@example.com:~user/repository?query")"
+'
+
+test_expect_success 'git url-parse -- ssh syntax with IPv6' '
+	git url-parse "ssh://user@[::1]:1234/repository/path" &&
+	git url-parse "ssh://user@[::1]/repository/path" &&
+	git url-parse "ssh://[::1]:1234/repository/path" &&
+	git url-parse "ssh://[::1]/repository/path" &&
+	git url-parse "ssh://[2001:db8::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -- git syntax with IPv6' '
+	git url-parse "git://[::1]:9418/repository/path" &&
+	git url-parse "git://[::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -- http syntax with IPv6' '
+	git url-parse "https://[::1]:1234/repository/path" &&
+	git url-parse "https://[::1]/repository/path" &&
+	git url-parse "http://[2001:db8::1]/repository/path"
+'
+
+test_expect_success 'git url-parse -c host -- IPv6 in URL form' '
+	test "[::1]" = "$(git url-parse -c host "ssh://user@[::1]:1234/repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "ssh://[::1]/repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "ssh://[2001:db8::1]/repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "git://[::1]/repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "https://[2001:db8::1]/repository/path")"
+'
+
+test_expect_success 'git url-parse -c port -- IPv6 in URL form' '
+	test 1234 = "$(git url-parse -c port "ssh://user@[::1]:1234/repository/path")" &&
+	test "" = "$(git url-parse -c port "ssh://[::1]/repository/path")" &&
+	test 9418 = "$(git url-parse -c port "git://[::1]:9418/repository/path")"
+'
+
+test_expect_success 'git url-parse -- scp syntax with IPv6' '
+	git url-parse "[::1]:repository/path" &&
+	git url-parse "user@[::1]:repository/path" &&
+	git url-parse "[2001:db8::1]:repo"
+'
+
+test_expect_success 'git url-parse -- scp syntax with bracketed hostname' '
+	git url-parse "[myhost]:src" &&
+	git url-parse "user@[myhost]:src"
+'
+
+test_expect_success 'git url-parse -- scp syntax with bracketed host:port' '
+	git url-parse "[myhost:123]:src" &&
+	git url-parse "user@[myhost:123]:src"
+'
+
+test_expect_success 'git url-parse -c host -- scp+IPv6' '
+	test "[::1]" = "$(git url-parse -c host "[::1]:repository/path")" &&
+	test "[::1]" = "$(git url-parse -c host "user@[::1]:repository/path")" &&
+	test "[2001:db8::1]" = "$(git url-parse -c host "[2001:db8::1]:repo")"
+'
+
+test_expect_success 'git url-parse -c path -- scp+IPv6' '
+	test "/repository/path" = "$(git url-parse -c path "[::1]:/repository/path")" &&
+	test "/repository/path" = "$(git url-parse -c path "[::1]:repository/path")" &&
+	test "/repo" = "$(git url-parse -c path "[2001:db8::1]:repo")"
+'
+
+test_expect_success 'git url-parse -c host,port,path -- scp [host:port]:src' '
+	test myhost = "$(git url-parse -c host "[myhost:123]:src")" &&
+	test 123 = "$(git url-parse -c port "[myhost:123]:src")" &&
+	test "/src" = "$(git url-parse -c path "[myhost:123]:src")"
+'
+
+test_expect_success 'git url-parse -c host,path -- scp [host]:src' '
+	test myhost = "$(git url-parse -c host "[myhost]:src")" &&
+	test "/src" = "$(git url-parse -c path "[myhost]:src")"
+'
+
+test_expect_success 'git url-parse -c user -- scp with user@ and brackets' '
+	test user = "$(git url-parse -c user "user@[::1]:repo")" &&
+	test user = "$(git url-parse -c user "user@[myhost:123]:src")" &&
+	test user = "$(git url-parse -c user "user@[myhost]:src")"
+'
+
+test_expect_success 'git url-parse -- scp+IPv6 with username expansion' '
+	test "~user/repo" = "$(git url-parse -c path "[::1]:~user/repo")" &&
+	test "~user/repo" = "$(git url-parse -c path "user@[::1]:~user/repo")"
+'
+
+test_expect_success 'git url-parse fails on invalid URL' '
+	test_must_fail git url-parse "not a url"
+'
+
+test_expect_success 'git url-parse helpful error for absolute local path' '
+	test_must_fail git url-parse "/abs/path" 2>err &&
+	test_grep "is not a URL" err &&
+	test_grep "file:///" err
+'
+
+test_expect_success 'git url-parse helpful error for relative local path' '
+	test_must_fail git url-parse "./rel" 2>err &&
+	test_grep "is not a URL" err &&
+	test_grep "absolute path" err
+'
+
+test_expect_success 'git url-parse fails on unknown -c component name' '
+	test_must_fail git url-parse -c bogus "https://example.com/repo"
+'
+
+test_expect_success 'git url-parse fails on URL missing host' '
+	test_must_fail git url-parse "https://"
+'
+
+test_expect_success 'git url-parse with no URL prints usage' '
+	test_must_fail git url-parse 2>err &&
+	test_grep "usage:" err
+'
+
+test_done
-- 
gitgitgadget
