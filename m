Received: from avasout-ptp-004.plus.net (avasout-ptp-004.plus.net [84.93.230.250])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BDD4C81
	for <git@vger.kernel.org>; Mon,  9 Sep 2024 01:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.93.230.250
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725845225; cv=none; b=UUQyy+XU/IsiAX2DprOSq05d6jytK5L1vAcSZzm5Ah9XDL2vAn1QYTGV0pn6IpY+3eZUWcvzGEULjOohXB3PCwW25iyGmyvqc7vP1Gpp8x4TZ58OvbYaL6+tIWCeF/WclI0kTboELuDQXZUaUsNe5S//oE17yQIPgOnO/GaUvyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725845225; c=relaxed/simple;
	bh=pMAXzec6cjp/mEHPvu+V+PT0QQ4WCvLARlGHS4/vk5g=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=iv1QyX2zUHfFL+XWTNW8zyG4yY6BCJx4xJlbkf0/D7WrIeoP884OBqAyIE1ljX6HipozWBD8jFv32wAv0TAywHa5idAdPqQ2sB/4WQjfZkg/05bU9h19UepIP4fGcog+LO0AMOXzSdo8Ef2M6nSAQNrSOW675dvLHI62U++JG4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=U+m7xGlP; arc=none smtp.client-ip=84.93.230.250
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="U+m7xGlP"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id nT89sTeVcvENUnT8As3622; Mon, 09 Sep 2024 02:23:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725845031; bh=8FLE/QzQGT2VuFjeJjGeKtcjGKUth8xi7J1tQeSa/mc=;
	h=Date:To:Cc:From:Subject;
	b=U+m7xGlPNqWcE419jx5kezPm72JFNS0WpO7IkaduUP+snvkHYCTFrRv+MDcgQ1DNG
	 NrRwrstHnUxCH4W9q6D3dVDvQCnDIRcC+fuwRK6safnuqYDTyLL0XvIVPEOfVfJWq9
	 mAjM1ULLCM6If1AMhqMWEN9byJDhnOFGDt+NN4aij6QknMR95F5+8gKVOI9j7eaB37
	 lxUCfWtbnAn1u3qVVqdIA8a74satXozJ4xzHnddGyJjHJSaqDRqa1+6wVkIBJAdrhZ
	 TkSvCF4TktSBwWnPfHqaT7hr/GoessZrcf4nNl/l2BYjdNughliwbhPSDeTGVNOTfc
	 OaBAgBYn6lgnA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=T9svTOKQ c=1 sm=1 tr=0 ts=66de4e27
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=A1X0JdhQAAAA:8 a=EBOSESyhAAAA:8 a=R_XcQylrSi0jIeP7C5EA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <e3339b4d-dab1-4247-b70e-d3224bab1b6b@ramsayjones.plus.com>
Date: Mon, 9 Sep 2024 02:23:48 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: GIT Mailing-list <git@vger.kernel.org>, Jeff King <peff@peff.net>,
 Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config section
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfMhItYliCSTdlt5XvHpm0m+wZRgK1+1S4jaN4/22h4n5h8XgCE6KLdAU/bMwoW9TW6ZqMlyMWpcH0EFpfWJUpmGofnXg9lgqciP6ieXBR9tnT+YQZsEn
 CmQk0IeZv3nN76oM0z6L4FPLYV7XGnsd6OmtyQDSXR5wNj7d2ckTf5M2WUpzt44F4lbOpvc276D4oerp7yQI7Exjg+nuUenjUjw=


If neither HAVE_DEV_TTY nor GIT_WINDOWS_NATIVE is set, while compiling
the 'compat/terminal.c' code, then the fallback code calls the system
getpass() function. Unfortunately, this ignores the 'echo' parameter of
the git_terminal_prompt() function, since it has no way to implement that
functionality. This results in a less than optimal user experience on
cygwin, which does not define either of those build flags.

However, cygwin does have a functional '/dev/tty', so that it can build
with HAVE_DEV_TTY and benefit from the improved user experience.

The improved git_terminal_prompt() function that comes with HAVE_DEV_TTY
is used in the git_prompt() function, which in turn is used by the
'git credential', 'git bisect' and 'git help' commands. In addition to
git_terminal_prompt(), read_key_without_echo() is likewise improved and
used by the 'git add -p' command.

While using the 'git credential fill' command, for example:

  $ printf "%s\n" protocol=https host=example.com path=git | ./git credential fill
  Username for 'https://example.com': user
  Password for 'https://user@example.com':
  protocol=https
  host=example.com
  username=user
  password=pass
  $

The 'user' name is now echoed while typing (the password isn't), where this
wasn't the case before.

When using the auto-correct feature:

  $ ./git -c help.autocorrect=prompt fred
  WARNING: You called a Git command named 'fred', which does not exist.
  Run 'grep' instead [y/N]? n
  $ ./git -c help.autocorrect=prompt fred
  WARNING: You called a Git command named 'fred', which does not exist.
  Run 'grep' instead [y/N]? y
  fatal: no pattern given
  $

The user can actually see what they are typing at the prompt. Similar
comments apply to 'git bisect':

  $ ./git bisect bad master~1
  You need to start by "git bisect start"

  Do you want me to do it for you [Y/n]? y
  status: waiting for both good and bad commits
  status: waiting for good commit(s), bad commit known
  $ ./git bisect reset
  Already on 'master-tmp'
  $

  $ ./git bisect start
  status: waiting for both good and bad commits
  $ ./git bisect bad master~1
  status: waiting for good commit(s), bad commit known
  $ ./git bisect next
  warning: bisecting only with a bad commit
  Are you sure [Y/n]? n
  $ ./git bisect reset
  Already on 'master-tmp'
  $

The read_key_without_echo() function leads to a much improved 'git add -p'
command, when the 'interactive.singleKey' configuration is set:

  $ cd ..
  $ mkdir test-git
  $ cd test-git
  $ git init -q
  $ echo foo >file
  $ git add file
  $ echo bar >file
  $ ../git/git -c interactive.singleKey=true add -p
  diff --git a/file b/file
  index 257cc56..5716ca5 100644
  --- a/file
  +++ b/file
  @@ -1 +1 @@
  -foo
  +bar
  (1/1) Stage this hunk [y,n,q,a,d,e,p,?]? y

  $

Note that, not only is the user input echoed, but that it is immediately
accepted (without having to type <return>) and the program exits with the
hunk staged (in this case) or not.

In order to reap these benefits, set the HAVE_DEV_TTY build flag in the
cygwin configuration section of config.mak.uname.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

After more testing, I removed the RFC from this patch and actually wrote
a commit message. (I wasn't sure if I should mark this with v2 as well?).

I was a bit surprised that this went unnoticed for so long, but I don't
use 'git credential' (shh-agent is all I need), 'git add -p' (vim works
for me!) or used the help.autocorrect=prompt. I have used 'git bisect'
many, many times (of course), but I don't recall ever seeing either of
those prompts! This goes for Linux as well as cygwin. :)

ATB,
Ramsay Jones

 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 904bcf3598..d5112168a4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -248,6 +248,7 @@ ifeq ($(uname_O),Cygwin)
         else
 		NO_REGEX = UnfortunatelyYes
         endif
+	HAVE_DEV_TTY = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.46.0
