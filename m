Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E293D1719
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777299674; cv=none; b=OGLW+7+RPAkyAdd6+3jzn5cTyg0BmmUG1tb/F56U/7TTurzQ6Sl3u7TXIIUMypJwRvT1YU8n2NI3DoAGPp5tQx7vdgjv0LTKug/O8zEB74pNE/7ATohgoTn3eXHsw9cNIHzmW3gwy73J+ar/gPQGyjuxKlqBcHweI0NmVdHAumY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777299674; c=relaxed/simple;
	bh=gpVh/GOLk+WWmieEXO9ZzXkBc2c9J5bw/IwbZEZNM/s=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s4zC48n/UlbbM5/KmLUKAHhaAAxw1GBZJ2cCTSgjr2HHeoS3+KJliZ5/W+p8jQrEvOV+bb2qPQV0OHUgvij9mnavCyiyueBFqn73hzoxM6mOlK71Evz/0QcSTgt2aghkCOwnpbyLNXLwl3Bg9kipRKP/xfbESW+cUnj5gUC/z6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AwC+ikcv; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwC+ikcv"
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2d9916deb14so18181396eec.0
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 07:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777299672; x=1777904472; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ea4K4PgQiAGkR/iq3xoKShSQdwSM9ioQ7vPhgj3SnVQ=;
        b=AwC+ikcvWxqzlcDIr+8bGsF5/eySGZiF5lgeXmr1XntTi6nAhyi+WuvBzlyCG/w4Mq
         zcHfxgMVhMvdwHBPSF2McmYmB7PWx9NhKqrH86+QfBotJjK95IsfStlvNN38rL4GImcW
         6wAoM7JdPe2OSO/y4DV7U+6PpwjZaEmeZQzoaIECoRPv7uvfCsBM5m8tiVFk0KFHhb0A
         TOCNnn9DEcfrxgxSa0dEagO91L52yws29guHRAjcX2oUiT75TkqLhDsQGVDR3XRZHlRR
         RoI5Js47jW2JzsJwIa+l+g7nywAfjXI3y1RRtPKo3moeQ1Sq9/kP+Tl90W6OLvRDCa6H
         zScg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777299672; x=1777904472;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ea4K4PgQiAGkR/iq3xoKShSQdwSM9ioQ7vPhgj3SnVQ=;
        b=eY1u4ef+0VHy055X6nQPEYw+mlMCirLNzcBn18+ILg0gOeNZUi72uZ7WU1025IDsr8
         xjlp2HWKVLAAuTfab5JMr+Iii3Un1SZJUCgqrEN0MAkQ1I63JUeOUXOtuXhC33HfQpO8
         dnQDOB/30Kbbm4/FJtGY0jM43c0YwfqMMwR4SWvSPv0tCW20fapmbFSt8PqNfkxYXHO6
         23Nu5GwEmifRVfCigjHw2dk/iqX+15awsd2lQcGsqMYIBDb3QIz9246vN4MAnOLJXw1D
         OIAWtMOCBFBAGkb5Jl0hUf/fcA0aVfJVRZP0uM9EEPTZoRNWxeNh7eSOKGRdWeI7/flA
         1wzg==
X-Gm-Message-State: AOJu0YyDSO/YWmoOWNG6WgvaRuUFleDJy2xZylH8u7Zx06iGbU6Xu/UZ
	qkxMqR/gZaeKnS+X6TPTFy4qRSDQNijCAlmFWG80C9SqUcqLLVmJ1LGgwLlgHQ==
X-Gm-Gg: AeBDieuT9SiHVIFUFMaBQ8wEuxwYlDxthj0BQXQ+INoJtLuKq+DG6Ru24Acc7WYQegW
	qqMYHhjh5V+oSZsCPErggozmd6MgcXppCLJISGU7IzkVc7MCrYqRG6oFtTpIt/7kIRmUc+GbX0E
	5C/Op304b9EzonJe/mn5DgeIDHSDVVdn8+Odrb166FIqkkKvSkqU4R1IyAual87JyxX/ioZYwmr
	NTWRAVLz/jSqOXNefOtAP4t73WX2Mmo0roAfbyb3s2YZfgC0XEttRo1zCMWcpikVLGiNAKaieP4
	VYELv8lRSGSoce27y1WF/VH9SlRGhzyuDY4K0vwOTMxjX+q6i7CLfs29MrY8YDeuaUiBAI1JK46
	AoNkNaV+hRgDCi9J2J2eXvtocNWOPdL5UDf+YxsPbPmvY7cL0RG5abKJYVH5Z2hwcL8CGPWufp8
	4S5/Iuowg4J1Q7PfWP7H4ADG3Ue984LztOLg==
X-Received: by 2002:a05:7301:3808:b0:2d8:7302:d21 with SMTP id 5a478bee46e88-2e479724538mr23771569eec.16.1777299671693;
        Mon, 27 Apr 2026 07:21:11 -0700 (PDT)
Received: from [127.0.0.1] ([68.220.61.4])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e539fa244csm43062321eec.2.2026.04.27.07.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:21:11 -0700 (PDT)
Message-Id: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 27 Apr 2026 14:21:09 +0000
Subject: [PATCH] t5564: use a short path for the SOCKS proxy socket
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The SOCKS proxy test introduced in 0ca365c2ed4 (http: do not ignore
proxy path, 2024-08-02) creates a Unix domain socket in
`$TRASH_DIRECTORY`. When the trash directory path is long (e.g.
when running from a deeply nested worktree), the socket path can
exceed the 108-character limit for `struct sockaddr_un.sun_path` on
Linux, causing the test to fail with "Path length ... is longer
than maximum supported length (108)".

Move the socket to `$TMPDIR` (defaulting to `/tmp`) where the path
is short, following the same approach used in t7528 for the SSH
agent socket in b7fb2194b96 (t7528: work around ETOOMANY in OpenSSH
10.1 and newer, 2025-10-23).

Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t5564: use a short path for the SOCKS proxy socket
    
    When trying to run the entire test suite in a slightly deeper path than
    usual, I was surprised to see that this test failed due to our old
    friend, the 108 character limit of Unix sockets.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2100%2Fdscho%2Favoid-too-long-unix-socket-path-in-socks-proxy-test-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2100/dscho/avoid-too-long-unix-socket-path-in-socks-proxy-test-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2100

 t/t5564-http-proxy.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 3bcbdef409..cb7ede4ca4 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -50,14 +50,19 @@ start_socks() {
 
 # The %30 tests that the correct amount of percent-encoding is applied to the
 # proxy string passed to curl.
+# Use a short path for the socket to avoid exceeding the 108-character
+# Unix domain socket limit when the trash directory path is long.
+SOCKS_SOCK="${TMPDIR:-/tmp}/git-test-socks-%30.sock"
+
 test_lazy_prereq SOCKS_PROXY '
 	test_have_prereq PERL &&
-	start_socks "$TRASH_DIRECTORY/%30.sock"
+	start_socks "$SOCKS_SOCK"
 '
 
 test_atexit '
 	test ! -e "$TRASH_DIRECTORY/socks.pid" ||
 	kill "$(cat "$TRASH_DIRECTORY/socks.pid")"
+	rm -f "$SOCKS_SOCK"
 '
 
 # The below tests morally ought to be gated on a prerequisite that Git is
@@ -70,7 +75,8 @@ old_libcurl_error() {
 
 test_expect_success SOCKS_PROXY 'clone via Unix socket' '
 	test_when_finished "rm -rf clone" &&
-	test_config_global http.proxy "socks4://localhost$PWD/%2530.sock" && {
+	socks_proxy_url="socks4://localhost$(echo "$SOCKS_SOCK" | sed "s/%/%25/g")" &&
+	test_config_global http.proxy "$socks_proxy_url" && {
 		{
 			GIT_TRACE_CURL=$PWD/trace \
 			GIT_TRACE_CURL_COMPONENTS=socks \

base-commit: 94f057755b7941b321fd11fec1b2e3ca5313a4e0
-- 
gitgitgadget
