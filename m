Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE84140E34
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382897; cv=none; b=APuATAROdXWy8JjQyVPUFKymk9yvGzA6Qm84DGv/0XdqqHY4i4uydf7ZbehiaXndtEDj+VrP94dn9Qv5TSE2jUZN8w4pFvQjGAGY1+FNYP7VFC9rVy6RyvGQZEZiPPXfCmVydmLYGBEpmrQaOlUteFklYbQMCf2v4eZkR3KcCik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382897; c=relaxed/simple;
	bh=eKeSnO79GEUxZ5B85p73cjMfp4hLAyn12zPYcYCC0nA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFYDt+dGgmw2rv24rMMLeOs9Q8vyWC71fzjEV668nL/kzg0qSpkZhvBPqGP8emhh06igc0/xnM6Y2sU5+EToXrEhKcYPWvr7Ly0t3/smv5YzZ28PI2sD6F5Z+RRgVVC0devX+hxnVsaY/S5sSp0meNvw/gY6JG2K9uVkET3OXlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=dVxIlOr7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aUZJW1IB; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="dVxIlOr7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aUZJW1IB"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 5DA3A14000D5;
	Tue,  1 Jul 2025 11:14:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 01 Jul 2025 11:14:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1751382894;
	 x=1751469294; bh=QZKJXwfUWJYFQoomfWJrpDXDCT++xKriXKJfHOFYYz8=; b=
	dVxIlOr7q7L9e0v/jLSLSsUzpGC7OMrIuEYePZn+U4/ThHahXdvcyNV7aloV5pD0
	1eLtuTutcOwUuO2D2wNNMQNRUNB8NJ8DWXkvThQa8OFKrh2A7s4QdAurwcuYOnma
	pxcGeg2ViN35Yzm5WWa6fBkP6bbq5Z9UQcB9ZOtVtI/uBbkpU/Pmwm8s5cVOLTg5
	4qApihQrmyTGc6bqScb1O9EVq0kYUUKkGJ1G4iK5ADDipkYBZ/8PTFrAmi39oSMn
	xJDqqz5TM/Kzuqa3DUay2ElPqoLGa1mLav5BTgnlMRb5BvFK3bygo2rtTNFew38N
	tBuzg1BaMuVGJxDNL3PLJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1751382894; x=
	1751469294; bh=QZKJXwfUWJYFQoomfWJrpDXDCT++xKriXKJfHOFYYz8=; b=a
	UZJW1IBXXOS9NEe1GHKjzieNehOStI0yxrjM9NfpNlvbtWVKJsUdo3S0ue4Kp2zW
	mkqA+4DBRF1JPY327ptydTCkoMiiaY/3C6XzpnNUQ8kB/hhYzlCWiImCJPR1KYz6
	j9lL+0albZL+l1BzIX81HALyjdTH4Cj2xdLZ5MXiTPoZdTMp2bHw1XsxB6FyfqXW
	GAxHtHZaairl5ISjGM8183O5XMffY0KzTx/lwnbGxnoUKdl0/Oous7ABNAlQqXvL
	VR2yOk9snaDUW1YoYW73NyGaCcIBps5cxpDg0dk6RjXqTe9dHsRK4oCHMhQ1sz7t
	lPfV/05husJgrdUhhSWiA==
X-ME-Sender: <xms:bftjaDUzAmc_UWexyNztJmjtFRRDztjzoQi8Qem7gv5Yzu345efu--I>
    <xme:bftjaLmHw0h1snW7kvHmZDFizMmMPInv8Tdv2lLeJweIa1pwe5MYA3UplnKq09D51
    pXmkNylViwVH3DRuw>
X-ME-Received: <xmr:bftjaPZXHSvp_7iJ4blNN46tdMfgIzqp-2eJgKd9jWewnMRMlJHmqyCd74T0Rn_-zQSDIygoB5sgHjcUsCWGJVmKME1z2OJJ3A9hrJc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddugeekhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:bvtjaOXjMGiwSUL22cOdDl_8xrnVCf7IcDSrSmiXNUXUdvjqE5sDYg>
    <xmx:bvtjaNmK8DJTDY9qD3gswDREK6PcSoQClMpbtlnu9jgAAxWFD9ifZQ>
    <xmx:bvtjaLewHHyAlGfxhW2A9eOuMfGhvWHvgCK6Gprb6vShfcubTq1m0Q>
    <xmx:bvtjaHE5TazX9q8_kmRA9HzQedAPDMNqRO6OqR-LvRw1FkPtHIAl0w>
    <xmx:bvtjaPS5zUDh-wiCfrI5K_lRK28swtkFwEGe8TjxcUWxeOiV8OKVEQu9>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Jul 2025 11:14:52 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/5] doc: config: update for the ps/config-subcommands series
Date: Tue,  1 Jul 2025 17:14:27 +0200
Message-ID: <cover.1751382830.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.136.g907b27ebd9e
In-Reply-To: <cover.1751310455.git.code@khaugsbakk.name>
References: <cover.1751310455.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Update git-config(1) according to the ps/config-subcommands series
(fe3ccc7aab (Merge branch 'ps/config-subcommands', 2024-05-15)):

1. Document `--show-names`
2. Document `--value`
3. Mention `--value` throughout instead of the deprecated
   `value-pattern`
4. Mention `--url` in the synopsis

§ Changes in v2

• Unbreak t/t0450-txt-doc-vs-help.sh caused by source/doc synopsis being
  out of synch
• I missed some `--value=<value>` in patch 2/5
• Add acks from Patrick
  • Link: https://lore.kernel.org/git/aGOx3C7-9NNi7h8Z@pks.im/
• Use area=config for patches that touch both the source code (builtin)
  and the doc

Kristoffer Haugsbakk (5):
  doc: config: document --[no-]show-names
  config: use --value=<pattern> consistently
  doc: config: document --[no-]value
  doc: config: use --value instead of value-pattern
  config: mention --url in the synopsis

 Documentation/git-config.adoc | 28 +++++++++++++++++++++-------
 builtin/config.c              | 12 ++++++------
 2 files changed, 27 insertions(+), 13 deletions(-)

Interdiff against v1:
diff --git a/builtin/config.c b/builtin/config.c
index f70d6354772..5efe2730106 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -17,9 +17,9 @@
 
 static const char *const builtin_config_usage[] = {
 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
-	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>"),
+	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
+	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
 	N_("git config remove-section [<file-option>] <name>"),
 	N_("git config edit [<file-option>]"),
@@ -33,17 +33,17 @@ static const char *const builtin_config_list_usage[] = {
 };
 
 static const char *const builtin_config_get_usage[] = {
-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
+	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
 	NULL
 };
 
 static const char *const builtin_config_set_usage[] = {
-	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
+	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
 	NULL
 };
 
 static const char *const builtin_config_unset_usage[] = {
-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
+	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
 	NULL
 };
 
Range-diff against v1:
1:  7d66a5403b3 ! 1:  3c90ec17459 doc: config: document --[no-]show-names
    @@ Commit message
     
         [1]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
     
2:  a52322528da ! 2:  fa183e470c5 doc: config: use --value=<pattern> consistently
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: config: use --value=<pattern> consistently
    +    config: use --value=<pattern> consistently
     
         This option was introduced in a series of commits from fe3ccc7aab (Merge
         branch 'ps/config-subcommands', 2024-05-15).  But two styles were used
    @@ Commit message
         Use (2) consistently throughout since it’s a pattern in the general
         case (`value` sounds more generic).
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Unbreak t/t0450-txt-doc-vs-help.sh caused by source/doc synopsis being
    +      out of synch
    +    • Replaced the rest that I missed
    +
      ## Documentation/git-config.adoc ##
     @@ Documentation/git-config.adoc: SYNOPSIS
      --------
    @@ Documentation/git-config.adoc: SYNOPSIS
      'git config rename-section' [<file-option>] <old-name> <new-name>
      'git config remove-section' [<file-option>] <name>
      'git config edit' [<file-option>]
    +
    + ## builtin/config.c ##
    +@@
    + 
    + static const char *const builtin_config_usage[] = {
    + 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
    +-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
    +-	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
    +-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
    ++	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
    ++	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
    ++	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
    + 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),
    + 	N_("git config remove-section [<file-option>] <name>"),
    + 	N_("git config edit [<file-option>]"),
    +@@ builtin/config.c: static const char *const builtin_config_list_usage[] = {
    + };
    + 
    + static const char *const builtin_config_get_usage[] = {
    +-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<value>] [--fixed-value] [--default=<default>] <name>"),
    ++	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp=<regexp>] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
    + 	NULL
    + };
    + 
    + static const char *const builtin_config_set_usage[] = {
    +-	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<value>] [--fixed-value] <name> <value>"),
    ++	N_("git config set [<file-option>] [--type=<type>] [--comment=<message>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
    + 	NULL
    + };
    + 
    + static const char *const builtin_config_unset_usage[] = {
    +-	N_("git config unset [<file-option>] [--all] [--value=<value>] [--fixed-value] <name>"),
    ++	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
    + 	NULL
    + };
    + 
3:  f8407f331e0 ! 3:  c85b42e3331 doc: config: document --[no-]value
    @@ Commit message
         Document this option and the negated form according to the current
         convention.[2]
     
    -    † 1: `--value` is a replacement for the `value-pattern`
    +    [1]: `--value` is a replacement for the `value-pattern`
             positional argument
         [2]: https://lore.kernel.org/git/xmqqcyct1mtq.fsf@gitster.g/
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-config.adoc ##
4:  e895215e0cd ! 4:  e5eee1a0541 doc: config: use --value instead of value-pattern
    @@ Commit message
         The deprecated modes have been quarantined in the “Deprecated Modes”
         section.  So let’s only use `--value=<pattern>` in the rest of the doc.
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Documentation/git-config.adoc ##
5:  ac3257a934d ! 5:  8300e0fc349 doc: config: mention --url in the synopsis
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    doc: config: mention --url in the synopsis
    +    config: mention --url in the synopsis
     
         4e513890008 (builtin/config: introduce "get" subcommand, 2024-05-06)
         introduced `get` and `--url` but didn’t add `--url` to the synopsis.
     
    +    Acked-by: Patrick Steinhardt <ps@pks.im>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    +
    + ## Notes (series) ##
    +    v2:
    +    • Unbreak t/t0450-txt-doc-vs-help.sh caused by source/doc synopsis being
    +      out of synch
    +
      ## Documentation/git-config.adoc ##
     @@ Documentation/git-config.adoc: SYNOPSIS
      --------
    @@ Documentation/git-config.adoc: SYNOPSIS
      'git config set' [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>
      'git config unset' [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>
      'git config rename-section' [<file-option>] <old-name> <new-name>
    +
    + ## builtin/config.c ##
    +@@
    + 
    + static const char *const builtin_config_usage[] = {
    + 	N_("git config list [<file-option>] [<display-option>] [--includes]"),
    +-	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] <name>"),
    ++	N_("git config get [<file-option>] [<display-option>] [--includes] [--all] [--regexp] [--value=<pattern>] [--fixed-value] [--default=<default>] [--url=<url>] <name>"),
    + 	N_("git config set [<file-option>] [--type=<type>] [--all] [--value=<pattern>] [--fixed-value] <name> <value>"),
    + 	N_("git config unset [<file-option>] [--all] [--value=<pattern>] [--fixed-value] <name>"),
    + 	N_("git config rename-section [<file-option>] <old-name> <new-name>"),

base-commit: cf6f63ea6bf35173e02e18bdc6a4ba41288acff9
-- 
2.50.0.136.g303b50f9132

