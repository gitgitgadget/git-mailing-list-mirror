Received: from avasout-peh-004.plus.net (avasout-peh-004.plus.net [212.159.14.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D2A932
	for <git@vger.kernel.org>; Sat, 31 Aug 2024 14:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725116349; cv=none; b=cWwrxcP7xVbdy5oe9x/zoaO+JRk+H8FAwoJUGuTLMoLR4p5XubDQGQ3w5cktqM2H80ZtpgvwbA9rGs1u6vTYuWf4fsJXC9aLR6XOy8Lt8Ihh97G3SxNlw52qgbcHOL2mXWPgkZawPr1xgRE0AJrDXf85cL41dtJfYg60/4re95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725116349; c=relaxed/simple;
	bh=M9XymZ1+K0BUl0CvOULh1WZTaH/VZhk/PmjYaHLRP9U=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=J4ktxn86sPMQqJcv+TRM/7KqaojhDqXDfYULwDCUEcO+mib3ZOAd9orA5zbBzeVZq9wz/CaGaPQXzBiMRYe0o6VFoyUuB9wzsPkh8sjMGIM0gZsjS0jNLzequFuUmpszKK1bHX8eXUpbB5rg89P9p+chGCmqpMRe6LCB+41JyBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=jGRE4/w9; arc=none smtp.client-ip=212.159.14.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="jGRE4/w9"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id kPZ2sXhJKx2dSkPZ3slT7Q; Sat, 31 Aug 2024 15:58:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725116338; bh=vWyrEpWfh10lm1LW3FBIQ13Td50R9ySSk9ZbRfdmdyU=;
	h=Date:To:Cc:From:Subject;
	b=jGRE4/w9fuvzHLhkvZA0TUC+0I59jLerGFfefiJspgHAPjmTciv2o0t348ABFbKZo
	 KCe6VUx6I8/jjNJkjwuB37My0ovUQEzakG7TOzPCCKIqjMwFIkJb3TYXvvdvR+IO4k
	 FueF3Zg1A994891UL4i/4YrhkOm+ND2FD3KUYaBYoJ2X/BDj0ooNjIr5Ap1m2ICH0T
	 wDPLwRWUmvK06eGMYJFMoNEAbxR0/Hl/Yd8UutCbxIVuxRTB/mhzwSSJzzMl8kSCoH
	 21OLKan233dNUN3HamUVBh2jm3KIVHFDUxAG9BfIVApnBR4LVne2A233WMEdRipjhn
	 2w4mxxaIMjOPw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=GMarEfNK c=1 sm=1 tr=0 ts=66d32fb2
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=PKzvZo6CAAAA:8 a=EBOSESyhAAAA:8 a=d7MK3yTqj3rUFUKQ4nsA:9
 a=QEXdDO2ut3YA:10 a=q92HNjYiIAC_jH7JDaYf:22 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <ce1c1d66-e0eb-4143-b334-1a83c0492415@ramsayjones.plus.com>
Date: Sat, 31 Aug 2024 15:58:56 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2] compat/terminal: mark parameter of git_terminal_prompt()
 UNUSED
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKFa7jauPwDBOVKCt8wdUQsCfVx/v1oJIIxCrx6WTtaC3GlNLTPiLzd1fwiQj1GZ8BB/HWpJS99C2PWumO6yX8/Tfd36r/lr/qhu0j7dyQAOMnjBuhh3
 3gO8WORzDjCoGRemF94HG1KJT7qED6gOQlufpTc5Gr9zUy/rPSZoswEaOP4OcKpFGILYY8uMvtO0FSfrqSMCQjQQmt1TsvZuqFI=


If neither HAVE_DEV_TTY nor GIT_WINDOWS_NATIVE is set, the fallback
code calls the system getpass(). This unfortunately ignores the "echo"
boolean parameter, as we have no way to implement that functionality.
But we still have to keep the unused parameter, since our interface
has to match the other implementations.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi,

Sorry for being a bit tardy with this, but I'm up-to-my-ears! :)

I feel a bit sheepish about taking authorship of this patch, since Jeff
contributed way more than I did to the text! (I was going to count the
words to get a better metric, but I have to go out now; if I don't send
this now it will be tomorrow ...).

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
