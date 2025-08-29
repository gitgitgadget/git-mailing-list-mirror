Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDEC5322C9F
	for <git@vger.kernel.org>; Fri, 29 Aug 2025 15:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756480899; cv=none; b=XvgR+s2y7hyXC75akFHNAfuY92M7HaKGoNMR/WicmpA+BLrBUReM7Odb5KvKuyud8UZTFmwDBTB/j/huZgJwU38cfKhmHq2E8B5Nwulyb3hrngi+W8Qgt4l8mMTTVHljgz1saUWLEUW/c9er7eDYEJPw2dWwxOrDWXA051huXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756480899; c=relaxed/simple;
	bh=6Drzd7bGQ/ssdhASo8f3Gq1eBYmaTjfAuePRX8A50QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l3fs4jDcet/9O2T7mx/dY6VC3WsN7MytbRZZCsjVPv0r1usH0xfzZhj3O8K4+dg8Q2aq/hQYPaQfA4LzGAUldQHgZK5O+2Qi8CPNnvneX19HF6TK3a6HShZgg2pYhLqnr/HAHAcD/3vBZZtC7CsR6r9Tn4p50ZeAny9C3C5IuwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Tg2Tgm0l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZS4M7WJ/; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Tg2Tgm0l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZS4M7WJ/"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2944614000AF;
	Fri, 29 Aug 2025 11:21:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Fri, 29 Aug 2025 11:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756480896;
	 x=1756567296; bh=g/wkL43m9sjOlxT/L2G/AkCcLGYn/H7shvLm2ZuT6lQ=; b=
	Tg2Tgm0lm+a/f9J7rzyjuLT+YRkIu9uZWDvuyXkOuTNTw8d+TG2010EDx/kBGauB
	AwrcqIGpmf1sS5/q2IW/E4g+Doe97zuOUheOYknSAdfwaPRPLGkFfsQOAqTFgWYn
	9MDmDvaUcNo+1mvWhXanRsC3yDv0c63Oq3Xu8vqR37tuPK7GsMcOH5+qBawQLwxG
	YexrZTm/WCRbPXARXjYtP8Jjt3CdvGlkqU6MAczab20zfOqfrbACD1ktyMPGqcHg
	OpbysZQS+pCh/IvueizG7nkTTAyDiv4O4kvPJ25zUdAMUhMpOsQuCcYRmz8Kkl28
	GU6wD8KXYHeW6t/0uI5+Yw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756480896; x=
	1756567296; bh=g/wkL43m9sjOlxT/L2G/AkCcLGYn/H7shvLm2ZuT6lQ=; b=Z
	S4M7WJ/CXY8dNDU8HMK6cAAY+mEN6i9wR6q01ozn50PinHzBidL0ftceV73RDFMk
	OyQrc0DISzE0GYEgKw5MuDqj5HdRMLz/BpUOnHZX0baqt23VgF+PKze3nymnLfcB
	RkM/c9521j7ISBMMEkFrcGt38YPC5eH7G6aeBVEe2Cf/mMsLwKskr9JcgsUCok3o
	2Ms+EjsRfoo6xRN3fridPobCOP7zHV0QLNe+Z8QccDQDJThDdlTSjwdDF31HWVOQ
	u65v/4GXhMPuar+4Qsp3H3S7A/9qs3/GqOOdHoDRczJzyBLv3BSLYltpa/m+vbiE
	cRTKSPxZn8y0fCb61svMA==
X-ME-Sender: <xms:f8WxaJ6oGdVkz4xWzvdf-HRmFYpjrEJgMELS__Zn43zVoxuwsPhTN5k>
    <xme:f8WxaKLHkHOpUIwS9fay-Ki6vM4UZBtT599zfbHonNr4AdxPLngVJ61SScLHcxuxn
    AYGuiVuO2Tu6954ng>
X-ME-Received: <xmr:f8WxaJ4PI7ZHYE8OgGDJw881O6rStyQu5AxPkZN7tWx1V_pOYcgiWilQlhQloiRd0xe4VImvo---iIBD0KS5eQAHi-TD0a3Zum2SfNQClUH5xS1RgZtKRdmHcg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddukeegvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtth
    gvrhhnpeeigedvffevvddvteejtdeiieegjeejlefguefgveelhfetvdeiieetheevtdei
    tdenucffohhmrghinhepghhithdqshgtmhdrtghomhdpkhgvrhhnvghlrdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtth
    hopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gvpdhrtghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:f8WxaNwV_-BgAnaGyCTHxkpSprh8NTzI-qH5FxVnyDuxH6VmtA2A9g>
    <xmx:f8WxaNZ3ofPXGopxG1e07wxdLsZ6fLTH-3Z46hRZkP94ehypDUPDjA>
    <xmx:f8WxaPRThUgIHHQ2O79eaeA7DHd8xPuXCDSfxNUokL8k3kQmz74skw>
    <xmx:f8WxaHy3UArFSxMdWw7JFzacA08h2lsmgusUcHaGtmbhsK44z_bbNQ>
    <xmx:gMWxaDa5f24nC4DpQoydTBtZxBMjCwLLTZ69MQJBvpLjhWN3PSMGG49h>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 Aug 2025 11:21:34 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/4] you-still-use-that??: improve breaking changes troubleshooting
Date: Fri, 29 Aug 2025 17:21:02 +0200
Message-ID: <cover.1756480827.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1756311355.git.code@khaugsbakk.name>
References: <cover.1756311355.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Based on the recent i-still-use-that reports about whatchanged, improve
the error reporting with this command in mind:

1. Give more possible actions instead of just (only) asking them to send
   an email
2. Hint how to replace their git-whatchanged(1) use with git-log(1)
3. Minor documentation changes

Also:[1] an alternative to linking to www.git-scm.com (in patch 1/4) is
to move this document to a regular installed man page:

    gitbreaking-changes(7)

[1]: Not mentioned on the v1 cover letter

§ What the errors now look like

    $ ./git pack-redundant
    'git pack-redundant' is nominated for removal.
    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20pack-redundant
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this
    $ ./git whatchanged
    'git whatchanged' is nominated for removal.

    hint: You can replace 'git whatchanged <opts>' with:
        git log <opts> --raw --no-merges

    If you still use this command, here's what you can do:

    - read https://git-scm.com/docs/BreakingChanges.html
    - check if anyone has discussed this on the mailing
      list and if they came up with something that can
      help you: https://lore.kernel.org/git/?q=git%20whatchanged
    - send an email to <git@vger.kernel.org> to let us
      know that you still use this command and were unable
      to determine a suitable replacement

    fatal: refusing to run without --i-still-use-this

§ Changes in v2

These are also posted on the patches.

• Patch 1/4:
  • Change send-an-email bullet point
  • Change the area
  • Use www.git-scm.com, not simply git-scm
• Patch 2/4:
  • Fix whitespace error (I should have used `ci/check-whitespace.sh
    v2.51.0`)
  • Add missing colon (:) to footnote
  • Expand on footnote; a sentence is enough to summarize the difference

Kristoffer Haugsbakk (4):
  you-still-use-that??: help the user help themselves
  whatchanged: tell users the git-log(1) equivalent
  whatchanged: remove not-even-shorter clause
  BreakingChanges: remove claim about whatchanged reports

 Documentation/BreakingChanges.adoc |  2 +-
 Documentation/git-whatchanged.adoc |  8 ++++++--
 builtin/log.c                      |  6 +++++-
 builtin/pack-redundant.c           |  2 +-
 git-compat-util.h                  |  2 +-
 usage.c                            | 33 +++++++++++++++++++++++-------
 6 files changed, 40 insertions(+), 13 deletions(-)

Interdiff against v1:
diff --git a/builtin/log.c b/builtin/log.c
index 2f9e5e5a898..5dbb90c014d 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -542,7 +542,7 @@ int cmd_whatchanged(int argc,
 	opt.revarg_opt = REVARG_COMMITTISH;
 	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
 
-        if (!cfg.i_still_use_this)
+	if (!cfg.i_still_use_this)
 		you_still_use_that("git whatchanged",
 				   _("\n"
 				     "hint: You can replace 'git whatchanged <opts>' with:\n"
diff --git a/usage.c b/usage.c
index c661561b149..7545a616453 100644
--- a/usage.c
+++ b/usage.c
@@ -397,7 +397,9 @@ NORETURN void you_still_use_that(const char *command_name, const char *hint)
 		  "- check if anyone has discussed this on the mailing\n"
 		  "  list and if they came up with something that can\n"
 		  "  help you: https://lore.kernel.org/git/?q=%s\n"
-		  "- send an email to <git@vger.kernel.org>\n"
+		  "- send an email to <git@vger.kernel.org> to let us\n"
+		  "  know that you still use this command and were unable\n"
+		  "  to determine a suitable replacement\n"
 		  "\n"),
 		percent_encoded.buf);
 	strbuf_release(&percent_encoded);
Range-diff against v1:
1:  e81023edb2d ! 1:  6803e2cc6c3 usage: help the user help themselves
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    usage: help the user help themselves
    +    you-still-use-that??: help the user help themselves
     
         Give the user a list of suggestions for what to do when they run a
         deprecated command.
    @@ Commit message
     
         Also drop “Thanks” since it now would require a new paragraph.
     
    -    [1]: git-scm has a disclaimer for these internal documents that says
    -        that “This information is specific to the Git project”.  That’s
    +    [1]: www.git-scm.com has a disclaimer for these internal documents that
    +        says that “This information is specific to the Git project”.  That’s
             misleading in this particular case.  But users are unlikely to get
    -        discouraged from reading about why they (or their programs) cannot
    -        run a command any more; it clearly concerns them.
    +        discouraged from reading about why they (or their programs) cannot run a
    +        command any more; it clearly concerns them.
     
    +    Helped-by: Eric Sunshine <sunshine@sunshineco.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
      ## Notes (series) ##
    -    An alternative to linking to git-scm is to move this document to a
    -    regular installed man page:
    +    v2:
    +
    +    I had second thoughts about the bullet point about send-an-email.
    +    Change it to the one Eric Sunshine proposed;[1] make sure to spell
    +    out that you can send an email conditioned on not finding a suitable
    +    replacement.
    +
    +    Also change the area to something more pointed.
    +
    +    And also use a clear URL to refer to www.git-scm.com.
    +
    +    [1]: https://lore.kernel.org/git/CAPig+cQkVP57n_FE6dJ0uxvai-J7usxKFp8gzfEbPY=Ytsd6=Q@mail.gmail.com/
    +
    +    • Change send-an-email bullet point
    +    • Change the area
    +    • Use www.git-scm.com, not simply git-scm
    +
    +    v1:
    +
    +    An alternative to linking to www.git-scm.com is to move this document to
    +    a regular installed man page:
     
             gitbreaking-changes(7)
     
    @@ usage.c: void bug_fl(const char *file, int line, const char *fmt, ...)
     +		  "- check if anyone has discussed this on the mailing\n"
     +		  "  list and if they came up with something that can\n"
     +		  "  help you: https://lore.kernel.org/git/?q=%s\n"
    -+		  "- send an email to <git@vger.kernel.org>\n"
    ++		  "- send an email to <git@vger.kernel.org> to let us\n"
    ++		  "  know that you still use this command and were unable\n"
    ++		  "  to determine a suitable replacement\n"
     +		  "\n"),
     +		command_name, percent_encoded.buf);
     +	strbuf_release(&percent_encoded);
2:  5407c0955af ! 2:  2f3ac952980 whatchanged: tell users the git-log(1) equivalent
    @@ Commit message
             • https://lore.kernel.org/git/1011073f-9930-4360-a42f-71eb7421fe3f@chrispalmer.uk/#t
             • https://lore.kernel.org/git/9fcbfcc4-79f9-421f-b9a4-dc455f7db485@acm.org/#t
             • https://lore.kernel.org/git/83241BDE-1E0D-489A-9181-C608E9FCC17B@gmail.com/
    -    [2] The error message on 2.51.0 does tell them to report it, unconditionally
    -    [3]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
    +    [2]: The error message on 2.51.0 does tell them to report it, unconditionally
    +    [3]: You only get different outputs if you happen to have empty
    +         commits (no changes)[4]
    +    [4]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +
    +    Review found a whitespace error in the prev. patch version.  I found a
    +    broken footnote and wanted to expand on the last footnote.
    +
    +    • Fix whitespace error (I should have used `ci/check-whitespace.sh
    +      v2.51.0`)
    +    • Add missing colon (:) to footnote
    +    • Expand on footnote; a sentence is enough to summarize the difference
    +
      ## Documentation/git-whatchanged.adoc ##
     @@ Documentation/git-whatchanged.adoc: Shows commit logs and diff output each commit introduces.
      
    @@ Documentation/git-whatchanged.adoc: Shows commit logs and diff output each commi
     
      ## builtin/log.c ##
     @@ builtin/log.c: int cmd_whatchanged(int argc,
    - 	opt.revarg_opt = REVARG_COMMITTISH;
      	cmd_log_init(argc, argv, prefix, &rev, &opt, &cfg);
      
    --	if (!cfg.i_still_use_this)
    + 	if (!cfg.i_still_use_this)
     -		you_still_use_that("git whatchanged");
    -+        if (!cfg.i_still_use_this)
     +		you_still_use_that("git whatchanged",
     +				   _("\n"
     +				     "hint: You can replace 'git whatchanged <opts>' with:\n"
    @@ usage.c: NORETURN void you_still_use_that(const char *command_name)
      		  "- read https://git-scm.com/docs/BreakingChanges.html\n"
      		  "- check if anyone has discussed this on the mailing\n"
     @@ usage.c: NORETURN void you_still_use_that(const char *command_name)
    - 		  "  help you: https://lore.kernel.org/git/?q=%s\n"
    - 		  "- send an email to <git@vger.kernel.org>\n"
    + 		  "  know that you still use this command and were unable\n"
    + 		  "  to determine a suitable replacement\n"
      		  "\n"),
     -		command_name, percent_encoded.buf);
     +		percent_encoded.buf);
3:  5fad164d7d1 = 3:  a074e7be422 whatchanged: remove not-even-shorter clause
4:  f1bf0ea3846 = 4:  9196c3c7e33 BreakingChanges: remove claim about whatchanged reports

base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
-- 
2.51.0.16.gcd94ab5bf81

