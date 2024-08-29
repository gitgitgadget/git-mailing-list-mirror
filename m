Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A9A1BAECB
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 22:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968865; cv=none; b=d0/4D5mXmvbIveO2DimshF2zDp/lO7RyASY9oMT4COJnwgErhTUkinReELyEZEsnQZYjWb0rqx7MUZdgMRd6FYAONHLz9ly4SueebLMezYpMTps+1BmCGDzrc3d6cZ2qHiCsNLtZbpXexH/q8J2rf/r3aaCuk3wl3gBqaMVV3vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968865; c=relaxed/simple;
	bh=mXR26tK+eyCvZzbTMyJMjpW87WrENVOQhBOvhDicVvg=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=ZEhm0LXbpHoNGLffl3XuQLQjkCvoXoHEIAp4FzwUm8duBVp+1PhwO0xrITr/UqSuhASsmR7E5Gzf0uLyTNasMkQcEMTtfXOGMbJ3Yvjh1xdtJ2ph2bCWnFcXdmAQMmcA9RIGPdoegk2VcC1+SjRW7mRswUbFTzbKebBZHg35J7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=RPnEu4Xo; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="RPnEu4Xo"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id jn9LsUlt9x2dSjn9Msl32Q; Thu, 29 Aug 2024 22:57:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1724968673; bh=YUB6Xq6ptR11wGXdQstANzScKw+HFvccE4BoirLyvA4=;
	h=Date:To:Cc:From:Subject;
	b=RPnEu4XoBdz3FDUa07VSA2gL4sVxEe7kxZmwcU+wBgBbSynPJ5sIL12rJLRPpq4u1
	 ozQbX1AA1UQvZYltq/9wWBQmN4Yl2OD4l5Tx1YYdykwTWs7qh5FunXWDgbJnC5dUBS
	 SfB5itmpzo1So2pMvfEZAFKwHNkyJHLKCDhb1hqbUNN8X0DwX/lMSJq85KQsSWfZKv
	 B/nbsv2dGBcQQjlYp7JNnJVEq0JAXKwqG7TJtWBZd/SxZ4QVpexgzt2b7cLsSULEyF
	 P/34DEjJuy1Ok1cn+0ac6WXleyxmSdsK8zjdGk0/R5Foahs/xzvKhrvKthUXjKHD1h
	 hrf2Wq/GUPlgA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GMarEfNK c=1 sm=1 tr=0 ts=66d0eee1
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=cltIsxnoqMMrNDaYa_sA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <d8c5e920-aff7-4e4b-af77-0d3193466b57@ramsayjones.plus.com>
Date: Thu, 29 Aug 2024 22:57:50 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] compat/terminal: mark parameter of git_terminal_prompt()
 UNUSED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOXbVsvHK9eZcYZxMb9HGvAaV3obEpM2XA8JOLh5sGT9/ICCJguuke1OGcfjFIc2bm59Ct4GFI51gmd88+yu56ailG7L0niqV+/Mm1b3JCZkWvkivlSL
 L/zp/vrfWe0IU/JplaQMamsjfGJaduy8D/ahtbdhbdRGVURqFAKBw74AM62BDtXx6rxN8MvKXRK0vLf21DRe/eJLQjkDYr1YQ3g=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi,

The 'seen' branch fails to compile on cygwin (but its fine on Linux), due
to an unused parameter. I haven't looked too hard at the code (at first
blush, it seemed to me that it should not even be trying to compile that
code, but ...), I simply added an UNUSED to fix the build. ;)

So, this may not be the correct 'fix' for this, but I thought I should
report it here, since I don't have time to look into this now. sorry! :(

ATB,
Ramsay Jones

 compat/terminal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/terminal.c b/compat/terminal.c
index 0afda730f2..d54efa1c5d 100644
--- a/compat/terminal.c
+++ b/compat/terminal.c
@@ -594,7 +594,7 @@ void restore_term(void)
 {
 }
 
-char *git_terminal_prompt(const char *prompt, int echo)
+char *git_terminal_prompt(const char *prompt, int echo UNUSED)
 {
 	return getpass(prompt);
 }
-- 
2.46.0
