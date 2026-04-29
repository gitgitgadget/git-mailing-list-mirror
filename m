Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DF5387348
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 08:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777450978; cv=none; b=Fnnb7oP5w0/wckVXE/arKhrtyuzJIhXyoEjs+YEMERFgezMyIiFrtv7a5Zy2qOLtdzuduuw7MDIk3R7w9J4bm4BBM3awNSRU20IPylRye3t+IYBbLgk4SNxglP+DLPiTkozi4gn42Ct3KfsMDNXdfLIEiPlnWGl9t4JkDrNRXGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777450978; c=relaxed/simple;
	bh=7o5f+cEVnp57zxLUFxKSpH/TOYswZVPJUanNO7yDJPw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=EhWctO81d9gMg9KkUKbGA1VuSQx7pt43AkDA3eA3skbZf9HN69vdjCCB1Xz39TTV2Vr/wIxXK3hA2KAUlxdLhfXAZrSugPUCfhkWwtPKoS1zI/IjHVNZQC6kSO/+IBusCmB6tUJ8jQ57ZOjDHOOZ1ycR8ZtGWMSK4v2j7CAobI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGcnB8we; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGcnB8we"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-8acb3daf2aaso193928566d6.0
        for <git@vger.kernel.org>; Wed, 29 Apr 2026 01:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777450975; x=1778055775; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YCf/DxeWciyGEfGXKO1rdMTvqM8MF9Khy9qdfLqFgpQ=;
        b=FGcnB8weIHa52vImxHNQ7miSWc4ledfiRN0BdDh1V0ufxvb/50zBvRFMRsN9Bvj6oU
         Q7ylgd0WsO4CbsuGnAHkmjZ8asPp+94WPbqVYUBw2D3n3poXTBbSFh77yHd/PB+4U+dz
         XHCb4RPCPe142fKVB7ajGNmwAeXZJji1MMEEHjls3m8IT//lRgKBpt7MCU2moMiKpX4n
         /NWLgloIL13hRd6fQ9j282S4/GmwOyk7me/Y1DdKAOQ1vACZu3Pp0eKCFhXaaVAILjEZ
         EoIZnZKqbOM6g4NEG0EICoDqaxTUXDzd9Tsk2TVr+xt4BR0wcjhfZYmuX7Z0Dsl6WREM
         JVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777450975; x=1778055775;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YCf/DxeWciyGEfGXKO1rdMTvqM8MF9Khy9qdfLqFgpQ=;
        b=Ttu9j7py1qFVLqPHzw5lfDjaNCKhGGMEy2VCdfWZ7OHYJe30sx5jI9C/mc8hRkzcp4
         nCCxwR7PstOnxKFlhr9AMGZE+tbzUtlniB4lQ6KhpyaMU1nbsiThFUP6LtkgmxwzN9S2
         F55IXcKtVLwKcBRRuw9O7sTs+sG8eSWRtL5msp88wYHOpbgyXUPFOEy5kr78lhc0awb5
         FxZZTf7g///Dwi4rdb6afkvrYxow4VrhA2ljnnE1USyc6THMNhKWeXXLdRZOqBEmwxgc
         kKILsIoZs+AWz3k95z7AmpBMBz7DEm3QNgOnzk8ZvZ22z/LNb9GYN7u31N67LpfRTI0k
         V99g==
X-Gm-Message-State: AOJu0YxTtUL/fKZ28K7k29M9/bEEkMz8UtdyL5lVfFQM7f6rjo+xQBp8
	5lpA5QfcX1ww0f1idUHZiHc3mnCWc993UA2CLgNOU6nYg2VTBtTo/ID452Ucig==
X-Gm-Gg: AeBDiesQPkPBWfTjI8Nq7f+ODQ4cjWk+aDrjLS9a3roTJShXDp/VYDJ2PDm0elaYzPb
	xD/BUrO8caC/sUt6YLhhqFb58KTaDjLYsPnVdOONsjECPVXLD+NpRDmSUI4s1FyZBR8kBIRARxt
	d10HqZJz724CmNJ14RvYaX+GRtpX9HjNAsRSPVciFr7xi7B8bzwvddMMbWJkQRFgB+Fx6RInJ5R
	rYWdteRIlzjZBU1AV69Rku5wcyZrw0RKtIGtCm+gCbqs/PtklBRIEYct7oPsyz+2NQ3dTtc6k/M
	kMrOAwGkV5ayV/P6YxMEAPgAgxTi/vNw6ERSV47lmgH0MBECio8SN1AlQ3pp/mAhHKDHABcyF+X
	iZGDftjgmtEXWgcQb8EPg707BJpSGIL4231hdlZDef+FLjgx5btzexfuR25BPAIEjrkvouYKfl0
	oLiT0RkJldFylqMcZ+WAWhwiGApwHmNgiwNZNHNMTU+BIz1g==
X-Received: by 2002:a0c:f413:0:b0:899:efbf:9292 with SMTP id 6a1803df08f44-8b3e30a7233mr113923086d6.43.1777450975359;
        Wed, 29 Apr 2026 01:22:55 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.183.83])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b3ef70b10asm13007236d6.13.2026.04.29.01.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 01:22:54 -0700 (PDT)
Message-Id: <pull.2100.v2.git.1777450974159.gitgitgadget@gmail.com>
In-Reply-To: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>
References: <pull.2100.git.1777299669889.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 29 Apr 2026 08:22:54 +0000
Subject: [PATCH v2] t5564: use a short path for the SOCKS proxy socket
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
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The SOCKS proxy test introduced in 0ca365c2ed4 (http: do not ignore
proxy path, 2024-08-02) creates a Unix domain socket in
`$TRASH_DIRECTORY`. When the trash directory path is long (e.g.
when running from a deeply nested worktree), the socket path can
exceed the 108-character limit for `struct sockaddr_un.sun_path` on
Linux, causing the test to fail with "Path length ... is longer
than maximum supported length (108)".

We cannot work around this using the chdir trick our own socket code
employs, because both sides of the connection are outside our control:
the socket is created by socks4-proxy.pl via Perl's IO::Socket::UNIX,
and the client side is libcurl.

Use `mktemp -d` to create a unique temporary directory with a short
path, and place the socket inside it. This avoids collisions between
concurrent test runs (e.g. `--stress`) and tmpdir-race vulnerabilities
that a static `/tmp` path would be susceptible to.

Helped-by: Jeff King <peff@peff.net>
Assisted-by: Claude Opus 4.6
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t5564: use a short path for the SOCKS proxy socket
    
    When trying to run the entire test suite in a slightly deeper path than
    usual, I was surprised to see that this test failed due to our old
    friend, the 108 character limit of Unix sockets.
    
    Changes since v1:
    
     * Uses mktemp -d now, to handle --stress better (thanks, Jeff!)

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2100%2Fdscho%2Favoid-too-long-unix-socket-path-in-socks-proxy-test-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2100/dscho/avoid-too-long-unix-socket-path-in-socks-proxy-test-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2100

Range-diff vs v1:

 1:  16826e612c ! 1:  256b76a999 t5564: use a short path for the SOCKS proxy socket
     @@ Commit message
          Linux, causing the test to fail with "Path length ... is longer
          than maximum supported length (108)".
      
     -    Move the socket to `$TMPDIR` (defaulting to `/tmp`) where the path
     -    is short, following the same approach used in t7528 for the SSH
     -    agent socket in b7fb2194b96 (t7528: work around ETOOMANY in OpenSSH
     -    10.1 and newer, 2025-10-23).
     +    We cannot work around this using the chdir trick our own socket code
     +    employs, because both sides of the connection are outside our control:
     +    the socket is created by socks4-proxy.pl via Perl's IO::Socket::UNIX,
     +    and the client side is libcurl.
      
     +    Use `mktemp -d` to create a unique temporary directory with a short
     +    path, and place the socket inside it. This avoids collisions between
     +    concurrent test runs (e.g. `--stress`) and tmpdir-race vulnerabilities
     +    that a static `/tmp` path would be susceptible to.
     +
     +    Helped-by: Jeff King <peff@peff.net>
          Assisted-by: Claude Opus 4.6
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
     @@ t/t5564-http-proxy.sh: start_socks() {
       # proxy string passed to curl.
      +# Use a short path for the socket to avoid exceeding the 108-character
      +# Unix domain socket limit when the trash directory path is long.
     -+SOCKS_SOCK="${TMPDIR:-/tmp}/git-test-socks-%30.sock"
     ++SOCKS_TMPDIR=$(mktemp -d)
     ++SOCKS_SOCK="$SOCKS_TMPDIR/%30.sock"
      +
       test_lazy_prereq SOCKS_PROXY '
       	test_have_prereq PERL &&
     @@ t/t5564-http-proxy.sh: start_socks() {
       test_atexit '
       	test ! -e "$TRASH_DIRECTORY/socks.pid" ||
       	kill "$(cat "$TRASH_DIRECTORY/socks.pid")"
     -+	rm -f "$SOCKS_SOCK"
     ++	rm -rf "$SOCKS_TMPDIR"
       '
       
       # The below tests morally ought to be gated on a prerequisite that Git is


 t/t5564-http-proxy.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t5564-http-proxy.sh b/t/t5564-http-proxy.sh
index 3bcbdef409..b4d95b12ca 100755
--- a/t/t5564-http-proxy.sh
+++ b/t/t5564-http-proxy.sh
@@ -50,14 +50,20 @@ start_socks() {
 
 # The %30 tests that the correct amount of percent-encoding is applied to the
 # proxy string passed to curl.
+# Use a short path for the socket to avoid exceeding the 108-character
+# Unix domain socket limit when the trash directory path is long.
+SOCKS_TMPDIR=$(mktemp -d)
+SOCKS_SOCK="$SOCKS_TMPDIR/%30.sock"
+
 test_lazy_prereq SOCKS_PROXY '
 	test_have_prereq PERL &&
-	start_socks "$TRASH_DIRECTORY/%30.sock"
+	start_socks "$SOCKS_SOCK"
 '
 
 test_atexit '
 	test ! -e "$TRASH_DIRECTORY/socks.pid" ||
 	kill "$(cat "$TRASH_DIRECTORY/socks.pid")"
+	rm -rf "$SOCKS_TMPDIR"
 '
 
 # The below tests morally ought to be gated on a prerequisite that Git is
@@ -70,7 +76,8 @@ old_libcurl_error() {
 
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
