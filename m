Received: from avasout-peh-003.plus.net (avasout-peh-003.plus.net [212.159.14.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F8F1A4E71
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 22:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.159.14.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725315531; cv=none; b=MZ7OsFft7wPULfojncCUWD5OwtGKMwZecEerMVKB/oPdblPTRMGBMdNfPHdQEwpjllLVKNBNiYyQ0OUQ94NCwTAF4fQ1ukWM6gtCJU6t2Z0U5sbRkk0smLzXQrTLuqplxYWKBWB1kliYULITlZX7puHcwHKKpJv1KXR0VyoB/h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725315531; c=relaxed/simple;
	bh=pSoMSXE8gdHOiynIZLAcw7gJt4iqKST/hVFFCpYonPc=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=s6J2PTAnLz10fXKHl1h/8lq1sY5b0C8emR8FLdoG+/v0dVMoa5CIaGgyHvu1kNyq6nVP1/9nR0k/wOPj3rIj+xFyDsCk9+8Fe38O1Kf6q3i0Msxo4JLphZGIBuCwQv1E7cEwp2k31IOCXrQeitxc+Thzvh2ATGzwV0atC74CUNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com; spf=none smtp.mailfrom=ramsayjones.plus.com; dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b=sRO7LRDW; arc=none smtp.client-ip=212.159.14.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ramsayjones.plus.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="sRO7LRDW"
Received: from [10.0.2.15] ([80.189.83.109])
	by smtp with ESMTPA
	id lFKhs4yP6AMaslFKjsyZTY; Mon, 02 Sep 2024 23:15:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
	t=1725315338; bh=gBaih9lNCC+NePo9iDvWdIhlBhd5kYfkOHY3IunlusY=;
	h=Date:To:Cc:From:Subject;
	b=sRO7LRDW7bkD1gyx7+NMJo/m7qL9imFUCRBOEYcXFyyOMtdaxCLJEVoouvXBrDLnB
	 8VS+ZQ2o4saijIfDfFfvpbne39R5p7zL9n9sD8ezD+rdCmCiu23Ejk8513v5/fj5SF
	 u42EJ8XkXjbXsELSMZt4uRGlVp9jt+bYxBs2/cHatlEdBGGZoNr8Oy+WnLmApnmIuF
	 RFU+th3ofltNlAoREgjI4itw0amWYfzfYIJmF41cSgOMZMsIcHGSXkWLe4nemy6Zng
	 bHPESaUf9FBiyv56KBpZ/YL9iJIV+wRIpq1DAINM+wsDuSZzxpmQMmRE/jvyXSVd7F
	 4AwN/SDzq19QA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.4 cv=JP6YsNKb c=1 sm=1 tr=0 ts=66d6390a
 a=oM5NSl/Bl4BpjFr0C8iQlQ==:117 a=oM5NSl/Bl4BpjFr0C8iQlQ==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=A1X0JdhQAAAA:8 a=KOSgFLSLcUMkL1eFw6wA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
Message-ID: <a59f53af-58f7-42f5-aefb-50a4d9f344c4@ramsayjones.plus.com>
Date: Mon, 2 Sep 2024 23:15:35 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: GIT Mailing-list <git@vger.kernel.org>
Cc: Jeff King <peff@peff.net>, Adam Dinwoodie <git@dinwoodie.org>
From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [RFC PATCH] config.mak.uname: add HAVE_DEV_TTY to cygwin config
 section
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfOYUoIaT+sba7VmzhaG6ZLML0JDqzhZhJZWdnCTqL8+TWYX/1u7HfRMwhnHdbM6+ozuKweHqlkl2m2Mzd16QAM6qp1CBpZKIyNLQzvixHl9FHXTbc5JO
 4/YAuhrFkXe+rqme1/MUnGRUD+5JBKwRAx21B5qjI+FJWMvlZ49Z4c0dR/1IjzbFAD5k0+qXSqmbNG6+ecvTgkQQn40OyWpuUog=


Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi,

I found a few minutes to try building with HAVE_DEV_TTY on cygwin tonight
and had a quick test:

  $ printf "%s\n" protocol=https host=example.com path=git | ./git credential fill
  Username for 'https://example.com': user
  Password for 'https://user@example.com': 
  protocol=https
  host=example.com
  username=user
  password=pass
  $ 

So, that seems to work. Actually, when I first tried, it didn't work at all,
because I typed 'git credential ...' not './git credential ...'! :)

Also, somewhat surprising, is that job control also works:

  $ printf "%s\n" protocol=https host=example.com path=git | ./git credential fill
  Username for 'https://example.com': 
  [1]+  Stopped                 printf "%s\n" protocol=https host=example.com path=git | ./git credential fill
  $ echo hhh
  hhh
  $ fg
  printf "%s\n" protocol=https host=example.com path=git | ./git credential fill
  user
  Password for 'https://user@example.com': 
  protocol=https
  host=example.com
  username=user
  password=pass
  $ 

The only difference between Linux and cygwin seems to be that cygwin does
not echo ^Z when back-grounding.

Still, I need to do a full test suite run, just to check for any regressions.
(Unfortunately, that takes about 6 hours to run, so I can't get to that soon).

Also, I should check other uses of these routines:

  $ git grep -n read_key_without_echo
  add-patch.c:1226:               int res = read_key_without_echo(&s->answer);
  compat/terminal.c:535:int read_key_without_echo(struct strbuf *buf)
  compat/terminal.c:602:int read_key_without_echo(struct strbuf *buf)
  compat/terminal.h:25:int read_key_without_echo(struct strbuf *buf);
  $ 

  $ git grep -n git_terminal_prompt
  compat/terminal.c:428:char *git_terminal_prompt(const char *prompt, int echo)
  compat/terminal.c:597:char *git_terminal_prompt(const char *prompt, int echo UNUSED)
  compat/terminal.h:22:char *git_terminal_prompt(const char *prompt, int echo);
  prompt.c:65:                    r = git_terminal_prompt(prompt, flags & PROMPT_ECHO);
  $ 

  $ git grep -n git_prompt
  builtin/bisect.c:401:           yesno = git_prompt(_("Are you sure [Y/n]? "), PROMPT_ECHO);
  builtin/bisect.c:913:   yesno = git_prompt(_("Do you want me to do it for you "
  credential.c:247:       r = git_prompt(prompt.buf, flags);
  help.c:712:                     answer = git_prompt(msg.buf, PROMPT_ECHO);
  prompt.c:45:char *git_prompt(const char *prompt, int flags)
  prompt.h:7:char *git_prompt(const char *prompt, int flags);
  $ 
  
So, 'add-patch', bisect and help (in addition to git-credential).

[Note: save_term() and restore_term() are not called outside of that TU, so
they could be marked static!]

Anyhow, just a quick heads up.

ATB,
Ramsay Jones


 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index d0cb2b8244..693dcd4714 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -250,6 +250,7 @@ ifeq ($(uname_O),Cygwin)
         else
 		NO_REGEX = UnfortunatelyYes
         endif
+	HAVE_DEV_TTY = YesPlease
 	HAVE_ALLOCA_H = YesPlease
 	NEEDS_LIBICONV = YesPlease
 	NO_FAST_WORKING_DIRECTORY = UnfortunatelyYes
-- 
2.46.0
