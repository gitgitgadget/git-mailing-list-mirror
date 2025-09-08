Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CD1C3BFC
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757345945; cv=none; b=jFgok8QuDIMheUm5ARS0nOCcUtiGGirFTNSx31NOY2wlOcXRZRvIFgjaPWmX0hnVUIx0XnEtqsnVDJ0t5xwAY0AvmUAtcnqlDkKxGxyV4K7eU7ueyt9Bs/2tYNkDpnPgkpnUs+wGqumnfGDPBi6szNEBjgN13Qc0ztZuoQQf+qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757345945; c=relaxed/simple;
	bh=iYWOjXAEAP8GhlaLCJ6DUZ1M5u40fJ85y5KEc01sd3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uyKT3tsL9/xkSPJvIZCTPMyhSusucX9dhWIpXbzlFQazti2TK8hrmOwVRdDPtroab41zPl1DaZ3aJHZ8uOxXyhfdchE46lhWIEyc+jVfRaZ/SaJwWjSeKbVvuFm07HGpdwB3eXnGRxcaYMH3nSsuuikJoRRqwBbG4+ncHCS5Ivs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=b/GMA84s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EJrIkEZ4; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="b/GMA84s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EJrIkEZ4"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 0723DEC0211;
	Mon,  8 Sep 2025 11:39:02 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 08 Sep 2025 11:39:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1757345942;
	 x=1757432342; bh=ZdYoUY8W2yu230gWSaxWhQCv3kY57vlmtEHE8XU516I=; b=
	b/GMA84swJrMfZ4oyVOURsHO2oi87k4pTrHfmA1t7kvqLhBlvYPsPxaFxlf3cK2G
	BS0e9oanP7XRnXfZGdjNCca4y3ZQW3FsA/AZAaAWZ+buO0xnlTr4Rae+ZophAmg0
	S+ijIrqwKyx8G6vmuMLeLLjcrOXha0fvaOR9Ui9XjyOzgxoahTHZtagw/hUD3wTj
	8jwOKm4ftmZvHY6xws76i23Bw8CH/uvGZPLUNn6TLS1CKNAbjffeIHTXOfyPYzuJ
	pRt42asg6KU5IBq3Fp9j4mEsNcZur2xpm3Nml25cmNxy/cdXJ1DZLiFci9nWzI2S
	gHEiFMSup7rKoNqcsgjwVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757345942; x=
	1757432342; bh=ZdYoUY8W2yu230gWSaxWhQCv3kY57vlmtEHE8XU516I=; b=E
	JrIkEZ4xm9mXxUCwJgp1GyjBUNlzCdEN92Glakuz2qbdltnTL5W09q08lI00tgF5
	F97p1VQLbCaLiaJon/FpI1ELgJcdVnsN4BSGNyV3krUG+ycDSYfqhKEYhPWMAzAY
	tUs3B0aRhAJr9TcuRshXXsd4Eqv2DDBVspmJwMQ2fHDwW6QS3y9RsQWGG3J+fZ2p
	23gCPwtQGMqx6ZTw7Omxx9dQ3M2zAvZ5MN69KyOpNCosVDGFbd8+0zzIFDPxvtYi
	yCJcWWqyxRWT0HihGR8j2hT3muydq8cLTAwuPSdmj5kTyq6HmB6iOdxprXzawhxf
	lZQoleYhFRnp5DpbbG3mw==
X-ME-Sender: <xms:lfi-aMnr9Oz0AgAVwpL-1_nrhha5hG5RXSG9ozRP_2FfR01qoqst6b8>
    <xme:lfi-aGYIVQlD8UMFvZVbqkttn1QE7XiL7LFtWbM1KNzeoRFKVVxKmRL5K-5fj4oce
    LaVW84r6Su-_KHpTQ>
X-ME-Received: <xmr:lfi-aHNF6GlQzDW76sxxSCjFBucHJiuZEo9AzzxUQcLNYJyqunWeDm5DfVUVmC8YWrdlriFwXBgprFO5KYdhHLfzcrEcQABRG7DEWkg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddujeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepudelgfeuieeuteekleeifeegudefheetkefhjeffkedvueehtdevhfekieekhffg
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedune
    curfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhk
    sehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepphgvfhhfsehpvghf
    fhdrnhgvth
X-ME-Proxy: <xmx:lfi-aLYZkDPaU-tLkM_u93PTSl9hDE9Ja9I08ClTlKd2Asy75IkHlw>
    <xmx:lfi-aF3E0kGG9_lP86ZosWHsQZrqrL_uY_Ilp08LjAazJKPiOI6D8A>
    <xmx:lfi-aBc90Jb573kclvsAaSK3Is-6XKTi_D267yyiJOn6ugu78vfOOA>
    <xmx:lfi-aGGT7aseBDFVQDn3hQY6Br7ZwroWtEIuzFbpy-RcDHmhZz-E3Q>
    <xmx:lfi-aC0IZc6NqmRn43jx__I_kSJ27IbjgWcPpqDtQM6Ec514d6_yJbC7>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Sep 2025 11:39:00 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Eric Sunshine <sunshine@sunshineco.com>,
	peff@peff.net
Subject: [PATCH v3 3/8] git: allow alias-shadowing deprecated builtins
Date: Mon,  8 Sep 2025 17:36:14 +0200
Message-ID: <eec01cbac16596c5e117843ae86956e1f66ec097.1757345711.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.16.gcd94ab5bf81
In-Reply-To: <cover.1757345711.git.code@khaugsbakk.name>
References: <cover.1756480827.git.code@khaugsbakk.name> <cover.1757345711.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

git-whatchanged(1) is deprecated and you need to pass
`--i-still-use-this` in order to force it to work as before.
There are two affected users, or usages:

1. people who use the command in scripts; and
2. people who are used to using it interactively.

For (1) the replacement is straightforward.[1]  But people in (2) might
like the name or be really used to typing it.[3]

An obvious first thought is to suggest aliasing `whatchanged` to the
git-log(1) equivalent.[1]  But this doesn’t work and is awkward since you
cannot shadow builtins via aliases.

Now you are left in an uncomfortable limbo; your alias won’t work until
the command is removed for good.

Let’s lift this limitation by allowing *deprecated* builtins to be
shadowed by aliases.

The only observed demand for aliasing has been for git-whatchanged(1),
not for git-pack-redundant(1).  But let’s be consistent and treat all
deprecated commands the same.

[1]:

        git log --raw --no-merges

     With a minor caveat: you get different outputs if you happen to
     have empty commits (no changes)[2]
[2]: https://lore.kernel.org/git/20250825085428.GA367101@coredump.intra.peff.net/
[3]: https://lore.kernel.org/git/BL3P221MB0449288C8B0FA448A227FD48833AA@BL3P221MB0449.NAMP221.PROD.OUTLOOK.COM/

Based-on-patch-by: Jeff King <peff@peff.net>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3 (new):
    
    Prerequisite for telling the user that they can alias `whatchanged` to
    `git log --raw --no-merged`.
    
    Link: https://lore.kernel.org/git/cover.1756311355.git.code@khaugsbakk.name/T/#md434b0968f499263262fb1805d82b788b8349d9a
    
    > I think that is good advice, but... it won't do anything until we
    > actually drop the whatchanged command, since until then we'll refuse to
    > override the command (even the crippled --i-still-use-this one).
    >
    > We'd need something like the patch here:
    
    ❦
    
    The
    
        test_file_not_empty expect
    
    is here because the git(1) command could fail.  Make sure that it did
    indeed output anyhing on stdout.  (Or if a previous redirect to `expect`
    outputted something it should be completely different to `actual` in any
    case)
    
    I don’t know if this is just a waste.

 Documentation/config/alias.adoc |  3 ++-
 git.c                           | 19 +++++++++++++++++++
 t/t0014-alias.sh                | 17 +++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/alias.adoc b/Documentation/config/alias.adoc
index 2c5db0ad842..3c8fab3a95c 100644
--- a/Documentation/config/alias.adoc
+++ b/Documentation/config/alias.adoc
@@ -3,7 +3,8 @@ alias.*::
 	after defining `alias.last = cat-file commit HEAD`, the invocation
 	`git last` is equivalent to `git cat-file commit HEAD`. To avoid
 	confusion and troubles with script usage, aliases that
-	hide existing Git commands are ignored. Arguments are split by
+	hide existing Git commands are ignored except for deprecated
+	commands.  Arguments are split by
 	spaces, the usual shell quoting and escaping are supported.
 	A quote pair or a backslash can be used to quote them.
 +
diff --git a/git.c b/git.c
index 39dc9f8ec0f..a452ce3f9e9 100644
--- a/git.c
+++ b/git.c
@@ -807,6 +807,12 @@ static void execv_dashed_external(const char **argv)
 		exit(128);
 }
 
+static int is_deprecated_command(const char *cmd)
+{
+	return !strcmp(cmd, "whatchanged") ||
+	       !strcmp(cmd, "pack-redundant");
+}
+
 static int run_argv(struct strvec *args)
 {
 	int done_alias = 0;
@@ -814,6 +820,19 @@ static int run_argv(struct strvec *args)
 	struct string_list_item *seen;
 
 	while (1) {
+		/*
+		 * Allow deprecated commands to be overridden by aliases. This
+		 * creates a seamless path forward for people who want to keep
+		 * using the name after it is gone, but want to skip the
+		 * deprecation complaint in the meantime.
+		 */
+		if (is_deprecated_command(args->v[0]) &&
+		    alias_lookup(args->v[0])) {
+			if (!handle_alias(args))
+				break;
+			done_alias = 1;
+			continue;
+		}
 		/*
 		 * If we tried alias and futzed with our environment,
 		 * it no longer is safe to invoke builtins directly in
diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
index 854d59ec58c..89bedb9f73b 100755
--- a/t/t0014-alias.sh
+++ b/t/t0014-alias.sh
@@ -55,4 +55,21 @@ test_expect_success 'tracing a shell alias with arguments shows trace of prepare
 	test_cmp expect actual
 '
 
+can_alias_deprecated_builtin () {
+	cmd="$1" &&
+	# some git(1) commands will fail for `-h` (the case for
+	# git-status as of 2025-09-07)
+	test_might_fail git status -h >expect &&
+	test_file_not_empty expect &&
+	test_might_fail git -c alias."$cmd"=status "$cmd" -h >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'can alias-shadow deprecated builtins' '
+	for cmd in $(git --list-cmds=deprecated)
+	do
+		can_alias_deprecated_builtin "$cmd" || return 1
+	done
+'
+
 test_done
-- 
2.51.0.16.gcd94ab5bf81

