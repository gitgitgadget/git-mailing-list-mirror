Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ADF846F
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 03:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732504446; cv=none; b=FIEbI3DFKQbEhsjYpImazwuiFi/pjfLt/R7SSWOKmM4ZT4RvisnHXYwtx+7cXzGmA3R1gR4gaSCMh1SETQ/4o6DioUzMwXSQQFkIGre6xisQEqwRiwN6GEQ5XoAcb5dY1rOgREbAFOt/USY4JSk9PDmTnAtpRPWS+c/CQ9f2Byc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732504446; c=relaxed/simple;
	bh=hLtWX6PaP66E8Hsqp+MwBCNdyRydc3m736Fa82BDisc=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vB3FnaRZA/ZAy4WGVTKANWCTv+Q59Z6rkucA41ijIPPovbDk2p/UCN6EkihoBr3pMUjiKQv1Jxf5Qj6P57LhZ2iKv5oXPj1ibwkDM+j8L9ov4aZZxNXZkzjMGpxDLd4E7sgLufZp2Xc559FqVdKCco90ERsyussB7qh50CDedGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mfbejh85; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mfbejh85"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 272032540164;
	Sun, 24 Nov 2024 22:14:03 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Sun, 24 Nov 2024 22:14:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1732504443; x=1732590843; bh=zGXnbkNd9JQrgjGgXmgANfpEak9ZLlbA+DM
	rZuU5Rso=; b=Mfbejh85VvKwTY9wSz/P3SwrBIE9VlHDPnjQaSmq4kPhusp4eBk
	ieFRM4wlYRIFmJq13Wfe6ocPKbW5V/PVxcVS5EpRZFStw9wsrGwbp7kULbRk/fH7
	O4Wiy5BdBsJlQnY4VyCXOiOs4pAIXVEDIHAJOKfy7j4BywRwsU8VoiSdj1HKTIDf
	Hh5mZZ5e+E+n2nwwTwI81ywXuMhm3/XyMt1fvQTr9HS8sqB/TMTkwJUQkQX8Zvrh
	KBK/NpESJ7sTu4yMvdcac3i0eeBAb/AlI3F01nxuji1JZJK6+XLuBR3czVWTaFKJ
	pGoA6b+wrTqvLY0X0pSTsNvh5Xm8pY0Gb0w==
X-ME-Sender: <xms:eutDZ41gbv-S1CT5HPDplfHCnhDVXoit0sBlmZ-4RpIo1nTVTh57YA>
    <xme:eutDZzHmr3yYNJ_EDbtWv8cuDHFiRDsQKY9l_9v-greqvtm9sEPY0qkp-uHOpaM_G
    b1iJYB9L_Ewmj3-GA>
X-ME-Received: <xmr:eutDZw5hQcpu1g2fE3KVOgJofVHzNUfRkq53kZ0EWATs-j1xU6LN8ZQAHwKjFyW-S2gxT3ud2XHeu2RFDGu3eqpCtoZZhmckOcCQSV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvffujghffffkfgggtgesthdtredttdertdenucfh
    rhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtg
    homheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiuedvlefggfef
    kedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthht
    ohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eutDZx1T1LyB0ysk3OTxXzcXoFjuVOCFt-8g8yKweS2nPw0wpo6RpQ>
    <xmx:eutDZ7E1EyrLRaQlrMUKZ5B1hqqK52PgNBQiQ7DmpxBAwnf3hSQEIQ>
    <xmx:eutDZ69-fapPRUCD9rO_4xUrj56d9MWuzZlSn9Aq7mwRjNVIwLDNgw>
    <xmx:eutDZwm8MVX4WODmxBQgbm_BykFMI3GnD6sIjo8VCOi7fcG7PHwVfw>
    <xmx:eutDZzBrz9EAFhELvWMAS_PVsfkqtAdppWUQ4X2dTpyNFSiTS_EfAraD>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Nov 2024 22:14:02 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] doc: option value may be separate for valid reasons
In-Reply-To: <xmqqjzct9db8.fsf@gitster.g> (Junio C. Hamano's message of "Sun,
	24 Nov 2024 18:43:55 +0900")
References: <xmqqjzct9db8.fsf@gitster.g>
Date: Mon, 25 Nov 2024 12:14:01 +0900
Message-ID: <xmqqh67w6m4m.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Even though `git help cli` recommends users to prefer using
"--option=value" over "--option value", there can be reasons why
giving them separately is a good idea.  One reason is that shells do
not perform tilde expansion for `--option=~/path/name` but they
expand `--options ~/path/name` just fine.

This is not a problem for many options whose option parsing is
properly written using OPT_FILENAME(), because the value given to
OPT_FILENAME() is tilde-expanded internally by us, but some commands
take a pathname as a mere string, which needs this trick to have the
shell help us.

I think the reason we originally decided to recommend the stuck form
was because an option that takes an optional value requires you to
use it in the stuck form, and it is one less thing for users to
worry about if they get into the habit to always use the stuck form.
But we should be discouraging ourselves from adding an option with
an optional value in the first place, and we might want to weaken
the current recommendation.

In any case, let's describe this one case where it is necessary to
use the separate form, with an example.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/gitcli.txt         | 9 +++++++++
 Documentation/gitcredentials.txt | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
index 7c709324ba..bd62cbd043 100644
--- a/Documentation/gitcli.txt
+++ b/Documentation/gitcli.txt
@@ -90,6 +90,15 @@ scripting Git:
    for long options.  An option that takes optional option-argument must be
    written in the 'stuck' form.
 
+ * Despite the above suggestion, when Arg is a path relative to the
+   home directory of a user, e.g. ~/directory/file or ~u/d/f, you
+   may want to use the separate form, e.g. `git foo --file ~/mine`,
+   not `git foo --file=~/mine`.  The shell will expand `~/` in the
+   former to your home directory, but most shells keep the tilde in
+   the latter.  Some of our commands know how to tilde-expand the
+   option value even when given in the stuck form, but not all of
+   them do.
+
  * When you give a revision parameter to a command, make sure the parameter is
    not ambiguous with a name of a file in the work tree.  E.g. do not write
    `git log -1 HEAD` but write `git log -1 HEAD --`; the former will not work
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index 71dd19731a..35a7452c8f 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -242,6 +242,12 @@ Here are some example specifications:
 [credential]
 	helper = "foo --bar='whitespace arg'"
 
+# store helper (discouraged) with custom location for the db file;
+# use `--file ~/.git-secret.txt`, rather than `--file=~/.git-secret.txt`,
+# to allow the shell to expand tilde to the home directory.
+[credential]
+	helper = "store --file ~/.git-secret.txt"
+
 # you can also use an absolute path, which will not use the git wrapper
 [credential]
 	helper = "/path/to/my/helper --with-arguments"

Interdiff:
  diff --git a/Documentation/gitcli.txt b/Documentation/gitcli.txt
  index e484be9a36..bd62cbd043 100644
  --- a/Documentation/gitcli.txt
  +++ b/Documentation/gitcli.txt
  @@ -92,13 +92,12 @@ scripting Git:
   
    * Despite the above suggestion, when Arg is a path relative to the
      home directory of a user, e.g. ~/directory/file or ~u/d/f, you
  -   may want to use the separate form, e.g. `git credential-store
  -   --file ~/sec/rit`, not `git credential-store --file=~/sec/rit`.
  -   The shell will expand `~/` in the former to your home directory,
  -   but most shells keep the tilde in the latter.  Some of our
  -   commands know how to tilde-expand the option value internally,
  -   but not all.  The `--file` option of `credential-store` is an
  -   example that it needs shell's help to tilde-expand its value.
  +   may want to use the separate form, e.g. `git foo --file ~/mine`,
  +   not `git foo --file=~/mine`.  The shell will expand `~/` in the
  +   former to your home directory, but most shells keep the tilde in
  +   the latter.  Some of our commands know how to tilde-expand the
  +   option value even when given in the stuck form, but not all of
  +   them do.
   
    * When you give a revision parameter to a command, make sure the parameter is
      not ambiguous with a name of a file in the work tree.  E.g. do not write
  diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
  index f6ce923f25..35a7452c8f 100644
  --- a/Documentation/gitcredentials.txt
  +++ b/Documentation/gitcredentials.txt
  @@ -243,7 +243,8 @@ Here are some example specifications:
   	helper = "foo --bar='whitespace arg'"
   
   # store helper (discouraged) with custom location for the db file;
  -# tilde expansion often requires the filename as a separate argument.
  +# use `--file ~/.git-secret.txt`, rather than `--file=~/.git-secret.txt`,
  +# to allow the shell to expand tilde to the home directory.
   [credential]
   	helper = "store --file ~/.git-secret.txt"
   
-- 
2.47.0-496-g788c9fe963


