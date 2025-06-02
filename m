Received: from avasout-peh-002.plus.net (avasout-peh-002.plus.net [212.159.14.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82B182D0
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 22:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748903792; cv=none; b=jUWZCzdP2OmsvtcaHIgVNS9ACKnCjY08HmGqr069+VGjh2KmHx2VNbf5xZhLEKYf1QNvaSIac7wVIGkJUn5bBWWfVBv8XdKD5ZRbpBWWYUfu4FIZPylMo/tYZlz9MY3uR6ukyTJ5zebHLVgIaCwJA13nl55k+8O+8EG7RbwrEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748903792; c=relaxed/simple;
	bh=P5LZ1GlrDHCx8KYoG93nuPyN4yLmInNMrsK27j8M4hQ=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=L9kId+MeSL/shuGF2Ei1XFYBvQ1I28gZMURL96G1+BCCAObtZ4lLX3BQ9CMslNcqlCVlyVe5RGeF3GrvbLC92SHnQsRSOFVQpvkOg/q838t40Jwu9INQerJa1AxqUfSYBFsiuy/zNTKJBxPVrhpA2UKXCnoT6bBHOqhL4b7hiMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=afwIiGuf; arc=none smtp.client-ip=212.159.14.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="afwIiGuf"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id MDiYu62u8rWcqMDiZuFnNy; Mon, 02 Jun 2025 23:33:20 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1748903600; bh=GBIXrlnGYnD5teO3+E+AYHMgBrG5WRJoGvr2atdtH3Y=;
	h=Date:To:Cc:From:Subject;
	b=afwIiGufHDybXbCPcgBX/JHp+KUb2icyvq4k30W1mWjhuZ33Nx5Xc6MA9Cpwi2B7e
	 qZ+kfwr5M5CbBaqTciNxABmfb7xlZIdolyCay32VCS6ZU8tbA6Nslqr0TlldSkLuCo
	 2foQECFQ59aXZ+gLr9OWHdPrWYEfJuXbnSc+AqdID3dLB4/+gxt1WDuo3RCtxP/C6b
	 e35QUDX53zpk5b3mf2hgXd1ZTi0LbHYHU8TvftWhH9/vh426g32E3ESDIIPlArUvVm
	 PPds6qVf3svygO8yPuovjnqEZvTRX2RdLKwtLSBIGuX2CGbhO7e2uNO1CxH7Y5yYoV
	 kNno+ySSaVIAQ==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=OonsyD/t c=1 sm=1 tr=0 ts=683e26b0
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=-mJ8-IuZv3Gpng4woFoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <771677b1-2ce5-40ce-a704-752ff57ba0d3@ramsayjones.plus.com>
Date: Mon, 2 Jun 2025 23:33:18 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Adam Dinwoodie <git@dinwoodie.org>, Junio C Hamano <gitster@pobox.com>,
 jayatheerthkulkarni2005@gmail.com
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: v2.25.0-rc0 test failure on cygwin
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfN18OEic+gdG5YboQpNgQzBwh1xXzmkkKYR6VV50FFuI4Mq4K5Mgr2IYW9U6MG5JwqwuBo77tZFB8oI0vvkR4ItvJ29a0nr8iLb8cadxUhrE3ByJ0sYt
 gVqKu/plKEiOYz7ibBUo1Q2AObMdOZK8F10nWW+U3ehnL5CDyIe9ObJUzRDzCCKWV9MJ45DwTw1v54L0jTEI7Abd3yvfaarh8GY=


I noticed on Friday, while testing the v2.25.0-rc0 build, that test t6137
failed on cygwin:

  $ tail test-out-2-50-rc0 
  Test Summary Report
  -------------------
  t6137-pathspec-wildcards-literal.sh              (Wstat: 256 (exited 1) Tests: 25 Failed: 11)
    Failed tests:  2, 7, 9, 11, 14-15, 17, 19, 21, 23, 25
    Non-zero exit status: 1
  Files=1023, Tests=30946, 21783 wallclock secs (19.08 usr 42.17 sys + 4031.65 cusr 12965.78 csys = 17058.68 CPU)
  Result: FAIL
  make[1]: *** [Makefile:78: prove] Error 1
  make[1]: Leaving directory '/home/ramsay/git/t'
  make: *** [Makefile:3286: test] Error 2
  $ 

A quick squint at the failing tests made it clear that the failure was
caused by the cygwin build treating a quoted glob character sequence
(e.g. '\*') as a directory separator char followed by a glob character.

To show this, I quickly hacked up a patch which causes the test to pass:


  diff --git a/abspath.h b/abspath.h
  index 4653080d5e..a5e30a3033 100644
  --- a/abspath.h
  +++ b/abspath.h
  @@ -27,7 +27,7 @@ char *prefix_filename_except_for_dash(const char *prefix, const char *path);
   
   static inline int is_absolute_path(const char *path)
   {
  -	return is_dir_sep(path[0]) || has_dos_drive_prefix(path);
  +	return /*is_dir_sep(path[0])*/ path[0] == '/' || has_dos_drive_prefix(path);
   }
   
   /**
  diff --git a/path.c b/path.c
  index 3b598b2847..f000b9ffff 100644
  --- a/path.c
  +++ b/path.c
  @@ -1223,13 +1223,15 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
   	end = src + offset_1st_component(src);
   	while (src < end) {
   		char c = *src++;
  +#ifdef DUMMY
   		if (is_dir_sep(c))
   			c = '/';
  +#endif
   		*dst++ = c;
   	}
   	dst0 = dst;
   
  -	while (is_dir_sep(*src))
  +	while (/*is_dir_sep(*src)*/ *src == '/')
   		src++;
   
   	for (;;) {
  @@ -1247,10 +1249,10 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
   			if (!src[1]) {
   				/* (1) */
   				src++;
  -			} else if (is_dir_sep(src[1])) {
  +			} else if (/*is_dir_sep(src[1])*/ src[1] == '/') {
   				/* (2) */
   				src += 2;
  -				while (is_dir_sep(*src))
  +				while (/*is_dir_sep(*src)*/ *src == '/')
   					src++;
   				continue;
   			} else if (src[1] == '.') {
  @@ -1258,10 +1260,10 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
   					/* (3) */
   					src += 2;
   					goto up_one;
  -				} else if (is_dir_sep(src[2])) {
  +				} else if (/*is_dir_sep(src[2])*/ src[2] == '/') {
   					/* (4) */
   					src += 3;
  -					while (is_dir_sep(*src))
  +					while (/*is_dir_sep(*src)*/ *src == '/')
   						src++;
   					goto up_one;
   				}
  @@ -1269,11 +1271,11 @@ int normalize_path_copy_len(char *dst, const char *src, int *prefix_len)
   		}
   
   		/* copy up to the next '/', and eat all '/' */
  -		while ((c = *src++) != '\0' && !is_dir_sep(c))
  +		while ((c = *src++) != '\0' && !(/*is_dir_sep(c)*/ c == '/'))
   			*dst++ = c;
  -		if (is_dir_sep(c)) {
  +		if (/*is_dir_sep(c)*/ c == '/') {
   			*dst++ = '/';
  -			while (is_dir_sep(c))
  +			while (/*is_dir_sep(c)*/ c == '/')
   				c = *src++;
   			src--;
   		} else if (!c)

In other words, in 'is_absolute_path()' and 'normalize_path_copy_len()', then
just disable the '\' character as a path separator! ;)

This was just to demonstrate the problem, not a serious patch, of course!

I was away for the weekend and was expecting to see a patch to fix this
on Gfw when I got back, but to my surprise there has been no mention of
it on the mailing list (having now waded through the backlog!).

To be clear, I can not imagine that this test passes on Gfw. However, this
should have been failing the windows CI for ages, so ... perhaps I don't
have a sufficiently vivid imagination. :)

Anyway, the patch below 'fixes' the issue on cygwin.

Thanks.

ATB,
Ramsay Jones


---- >8 ----
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Date: Mon, 2 Jun 2025 22:51:33 +0100
Subject: [PATCH] t6137: disable 'quoted glob' pathspecs on cygwin

The backslash in a 'quoted glob' character is treated as a directory
separator character on cygwin, which causes all such tests to fail.
Skip all such tests on cygwin using the !CYGWIN prerequisite. While
here, fix a few test titles as well.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 t/t6137-pathspec-wildcards-literal.sh | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/t/t6137-pathspec-wildcards-literal.sh b/t/t6137-pathspec-wildcards-literal.sh
index 20abad5667..229e48282e 100755
--- a/t/t6137-pathspec-wildcards-literal.sh
+++ b/t/t6137-pathspec-wildcards-literal.sh
@@ -39,7 +39,7 @@ test_expect_success 'add wildcard *' '
 	)
 '
 
-test_expect_success 'add literal \*' '
+test_expect_success !CYGWIN 'add literal \*' '
 	git init test-asterisk-literal &&
 	(
 		cd test-asterisk-literal &&
@@ -125,7 +125,7 @@ test_expect_success 'add wildcard f*' '
 	)
 '
 
-test_expect_success 'add literal f\*' '
+test_expect_success !CYGWIN 'add literal f\*' '
 	git init test-f-lit &&
 	(
 		cd test-f-lit &&
@@ -156,7 +156,7 @@ test_expect_success 'add wildcard f**' '
 	)
 '
 
-test_expect_success 'add literal f\*\*' '
+test_expect_success !CYGWIN 'add literal f\*\*' '
 	git init test-fdstar-lit &&
 	(
 		cd test-fdstar-lit &&
@@ -184,7 +184,7 @@ test_expect_success 'add wildcard f?z' '
 	)
 '
 
-test_expect_success 'add literal \? literal' '
+test_expect_success !CYGWIN 'add literal \? literal' '
 	git init test-q-lit &&
 	(
 		cd test-q-lit &&
@@ -227,7 +227,7 @@ test_expect_success 'add wildcard hello?world' '
 	)
 '
 
-test_expect_success 'add literal hello\?world' '
+test_expect_success !CYGWIN 'add literal hello\?world' '
 	git init test-hellolit &&
 	(
 		cd test-hellolit &&
@@ -241,7 +241,7 @@ test_expect_success 'add literal hello\?world' '
 	)
 '
 
-test_expect_success 'add literal [abc]' '
+test_expect_success !CYGWIN 'add literal \[abc\]' '
 	git init test-brackets-lit &&
 	(
 		cd test-brackets-lit &&
@@ -280,7 +280,7 @@ test_expect_success 'commit: wildcard *' '
 	)
 '
 
-test_expect_success 'commit: literal *' '
+test_expect_success !CYGWIN 'commit: literal \*' '
 	git init test-c-asterisk-lit &&
 	(
 		cd test-c-asterisk-lit &&
@@ -313,7 +313,7 @@ test_expect_success 'commit: wildcard f*' '
 	)
 '
 
-test_expect_success 'commit: literal f\*' '
+test_expect_success !CYGWIN 'commit: literal f\*' '
 	git init test-c-flit &&
 	(
 		cd test-c-flit &&
@@ -328,7 +328,7 @@ test_expect_success 'commit: literal f\*' '
 	)
 '
 
-test_expect_success 'commit: wildcard pathspec limits commit' '
+test_expect_success 'commit: wildcard f**' '
 	git init test-c-pathlimit &&
 	(
 		cd test-c-pathlimit &&
@@ -346,7 +346,7 @@ test_expect_success 'commit: wildcard pathspec limits commit' '
 	)
 '
 
-test_expect_success 'commit: literal f\*\*' '
+test_expect_success !CYGWIN 'commit: literal f\*\*' '
 	git init test-c-fdstar-lit &&
 	(
 		cd test-c-fdstar-lit &&
@@ -379,7 +379,7 @@ test_expect_success 'commit: wildcard ?' '
 	)
 '
 
-test_expect_success 'commit: literal \?' '
+test_expect_success !CYGWIN 'commit: literal \?' '
 	git init test-c-qlit &&
 	(
 		cd test-c-qlit &&
@@ -411,7 +411,7 @@ test_expect_success 'commit: wildcard hello?world' '
 	)
 '
 
-test_expect_success 'commit: literal hello\?world' '
+test_expect_success !CYGWIN 'commit: literal hello\?world' '
 	git init test-c-hellolit &&
 	(
 		cd test-c-hellolit &&
-- 
2.49.0
