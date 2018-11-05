Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2489B1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 07:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbeKEQjs (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:39:48 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:45481 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729000AbeKEQjs (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:39:48 -0500
Received: by mail-ed1-f68.google.com with SMTP id w39-v6so2179354edw.12
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 23:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=H0zgRHRONq4ej9DG03eOukaGrD/Dx5+bVyMvaEnmHYA=;
        b=unzUZpH+sHOAlVHd3Qhsmucfw7/2gROyjBee5FCjnvZsni860CQLFJcaN37yTOBx9C
         i9zKmM3+f0wvTagqYmJ4EETyhbcVteXmLLcGxkJYgs/iz3EEg2zjDMJCQg7i9YF/Q3pn
         0NysySFEX5HZ4fbxfPUj8qDytRSoA/C0YkKMZQDLuudoYc4YYesqTdZ1bgBuxNgKd5vb
         m+N3CSpStVKrfrr/puVU2U8DpQa0KO2cJCexTile6q7EqPz5yMuhO1H6XqktCzZXH1c1
         I25B8zEJk4pdtYHKyxQetcGUmIFsOrYvGDqNpUtUfG1R1Koc0h2Y719+eI43fTsXCts3
         06ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=H0zgRHRONq4ej9DG03eOukaGrD/Dx5+bVyMvaEnmHYA=;
        b=qnt56e4tRCZo15XWWa5j/oMNfsv4SP4PlYCgh1Cwq5UIIQDPWc9VEoSz/XuI7gygZQ
         Gl+bcKf5sui0ZRekm94EyZomMoWmRsh/Uqy9glHccEAvWhTACjxG2b/hLNQ8hP5Cr6jv
         fS1h1J3X0CSuTjgC9/vyxQBW+Wh/aD9edxft1MpkcCUDkRPERVxRy0+a17P2yaVPtqvo
         xLmBZlbsSB+x8LxLZ5cPcePVXpB/vF0xOEGdjl1Q4g0mNGeFeZIEwtfUrn46IM5ZHcFN
         PTDDV4SeRHSxZgX6koqF+QrV3IwaLyINVB1F+KohDcnUvAnHcjgqOAYO53cmN2cv6rxS
         xF9w==
X-Gm-Message-State: AGRZ1gJ1J8lT7s5D8M7LhSlKhl1iXbu/dvw//9ugijtohjOCtN3bNsk5
        apIhUSQ5PlSaSgwKzJ3IysHNo5tJ
X-Google-Smtp-Source: AJdET5dxyoxlAaXb06K93RNEkt3RKY9Cf+OKWb/nUubFFnhf77ntzX1FpRvB9TpWblZSzAejKokcEA==
X-Received: by 2002:aa7:d1d2:: with SMTP id g18-v6mr16977847edp.163.1541402490321;
        Sun, 04 Nov 2018 23:21:30 -0800 (PST)
Received: from evledraar (ip545586d2.adsl-surfen.hetnet.nl. [84.85.134.210])
        by smtp.gmail.com with ESMTPSA id o31-v6sm3646142eda.72.2018.11.04.23.21.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 23:21:29 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v5 01/12] sha1-file: rename algorithm to "sha1"
References: <20181025024005.154208-1-sandals@crustytoothpaste.net>
        <20181104234458.139223-1-sandals@crustytoothpaste.net>
        <20181104234458.139223-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181104234458.139223-2-sandals@crustytoothpaste.net>
Date:   Mon, 05 Nov 2018 08:21:28 +0100
Message-ID: <87a7mo7zwn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Nov 04 2018, brian m. carlson wrote:

> The transition plan anticipates us using a syntax such as "^{sha1}" for
> disambiguation.  Since this is a syntax some people will be typing a
> lot, it makes sense to provide a short, easy-to-type syntax.  Omitting
> the dash doesn't create any ambiguity; however, it does make the syntax
> shorter and easier to type, especially for touch typists.  In addition,
> the transition plan already uses "sha1" in this context.

The comment for git_hash_algo's "name" member in hash.h says:

	/*
	 * The name of the algorithm, as appears in the config file and in
	 * messages.
	 */
	const char *name;

Whereas this commit message just refers to a doesn't-yet-exist ^{$algo}
syntax. The hash-function-transition.txt doc also uses forms like sha1
or sha256 in config, not sha-1 or sha-256.

I don't have a point I'm leading up to here, other than a question of
whether we should be doing something closer to this:

diff --git a/hash.h b/hash.h
index 7c8238bc2e..8ae51ac410 100644
--- a/hash.h
+++ b/hash.h
@@ -67,10 +67,17 @@ typedef void (*git_hash_final_fn)(unsigned char *hash, git_hash_ctx *ctx);

 struct git_hash_algo {
 	/*
-	 * The name of the algorithm, as appears in the config file and in
-	 * messages.
+	 * The short name of the algorithm (e.g. "sha1") for use in
+	 * config files (see hash-function-transition.txt) and the
+	 * ^{$name} peel syntax.
 	 */
-	const char *name;
+	const char *short_name;
+
+	/*
+	 * The long name of the algorithm (e.g. "SHA-1") for use in
+	 * messages to users.
+	 */
+	const char *long_name;

 	/* A four-byte version identifier, used in pack indices. */
 	uint32_t format_id;
diff --git a/sha1-file.c b/sha1-file.c
index dd0b6aa873..5ad0526155 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -86,6 +86,7 @@ static void git_hash_unknown_final(unsigned char *hash, git_hash_ctx *ctx)

 const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 	{
+		NULL,
 		NULL,
 		0x00000000,
 		0,
@@ -97,7 +98,8 @@ const struct git_hash_algo hash_algos[GIT_HASH_NALGOS] = {
 		NULL,
 	},
 	{
-		"sha-1",
+		"sha1",
+		"SHA-1",
 		/* "sha1", big-endian */
 		0x73686131,
 		GIT_SHA1_RAWSZ,
