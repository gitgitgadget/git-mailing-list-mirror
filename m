Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C49C620248
	for <e@80x24.org>; Fri, 15 Mar 2019 16:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729427AbfCOQAQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Mar 2019 12:00:16 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:35910 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbfCOQAQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Mar 2019 12:00:16 -0400
Received: by mail-wm1-f42.google.com with SMTP id e16so6626134wme.1
        for <git@vger.kernel.org>; Fri, 15 Mar 2019 09:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O2CFz7V9Qay5xspCJr+iwzVrnflA4NTgAyx9dGsuJlo=;
        b=J4j0gBB4FRDXV1rcZOcISvHSzwMZy72yCJcoAcQd8LFhZHIzrPpEKJ1QoXaR9x4uYD
         zfKvrq5TSi9P0GlbftwC2t9be2dpD6K0e5EsV4J+qh736iKO4REX3c2p2bep+UjDKMOV
         AeEdy+PwEj3ZvFBZzrHYQDa1lp4Ei825mKdPzckTxQ7VYqekPdoaLqgsBPKSXWwSyT2i
         JH4DYI3G0fMGmrshKrK15JKOuSJtslLUC8TUkNggndwbtFiKPrTLydRIufdU90y+Ug66
         BcRhrOPqrhHGdQSgrm3HVvcB21eiTeB3Jrz9Gy+XPiFG6SrH7Yo7DrnxCazei5v5ntDd
         2N/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O2CFz7V9Qay5xspCJr+iwzVrnflA4NTgAyx9dGsuJlo=;
        b=Kkh3W9xRewFs7t8jLngCNBPnU3fPrbqfQd38BAcRjeyudlqv4fpl7FczC+S7wPSH/S
         YAV4Js35d+9iJmYcHt4nwCliay1OooRCVDAYNjtBNAW0trUR7wgoGNI93PzAycph3ce6
         ZgR9HksgSuI41RGWafT5fWq/h3jwtl0hsYELcrONiDCWU89vE8MjVg7gbRGGJxtHDCvE
         ray7T2Em2uZ55qmKsfM9ZsjlhySeUVvtVIc5FMo1QMYxW/QsDgEBRKTp0pVu69eFf8Tu
         NLotWtr7XhXaZxskNoN+sutrB4rupxPl8xRq47xIEXdPrCrRrOR6M2wE3VGNjjHhbZ0T
         bJbw==
X-Gm-Message-State: APjAAAWd1wncqoJfQftXSyatLyuRtXjDwYSqr35tIojE9aPB7BdJ1/eJ
        3zz216Zk1IZ8vi0Pl0q9IMm+z59b+UU=
X-Google-Smtp-Source: APXvYqyFsobwbXJaHwNeri2XnsQxyJinqYtIfYxpXEDUZU0CSj+uqkNKbr5WesN2bYV5aMwzBufjEQ==
X-Received: by 2002:a05:600c:22d9:: with SMTP id 25mr2512857wmg.59.1552665613346;
        Fri, 15 Mar 2019 09:00:13 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a18sm467766wmm.14.2019.03.15.09.00.12
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 15 Mar 2019 09:00:12 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/8] gc: convert to using the_hash_algo
Date:   Fri, 15 Mar 2019 16:59:53 +0100
Message-Id: <20190315155959.12390-3-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.360.g471c308f928
In-Reply-To: <20190314123439.4347-1-avarab@gmail.com>
References: <20190314123439.4347-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's been a lot of changing of the hardcoded "40" values to
the_hash_algo->hexsz, but we've so far missed this one where we
hardcoded 38 for the loose object file length.

This is because a SHA-1 like abcde[...] gets turned into
objects/ab/cde[...]. There's no reason to suppose the same won't be
the case for SHA-256, and reading between the lines in
hash-function-transition.txt the format is planned to be the same.

In the future we may want to further modify this code for the hash
function transition. There's a potential pathological case here where
we'll only consider the loose objects for the currently active hash,
but objects for that hash will share a directory storage with the
other hash.

Thus we could theoretically have e.g. 1k SHA-1 loose objects, and 1
million SHA-256 objects. Then not notice that we need to pack them
because we're currently using SHA-1, even though our FS may be
straining under the stress of such humongous directories.

So assuming that "gc" eventually learns to pack up both SHA-1 and
SHA-256 objects regardless of what the current the_hash_algo is,
perhaps this check should be changed to consider all files in
objects/17/ matching [0-9a-f] 38 or 62 characters in length (i.e. both
SHA-1 and SHA-256).

But none of that is something we need to worry about now, and
supporting both 38 and 62 characters depending on "the_hash_algo"
removes another case of SHA-1 hardcoding.

As noted in [1] I'm making no effort to somehow remove the hardcoding
for "2" as in "use the first two hexdigits for the directory
name". There's no indication that that'll ever change, and somehow
generalizing it here would be a drop in the ocean, so there's no point
in doing that. It also couldn't be done without coming up with some
generalized version of the magical "objects/17" directory. See [2] for
a discussion of that directory.

1. https://public-inbox.org/git/874l84ber7.fsf@evledraar.gmail.com/

2. https://public-inbox.org/git/87k1mta9x5.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 8c2312681ce..733bd7bdf46 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -156,6 +156,7 @@ static int too_many_loose_objects(void)
 	int auto_threshold;
 	int num_loose = 0;
 	int needed = 0;
+	const unsigned hexsz_loose = the_hash_algo->hexsz - 2;
 
 	dir = opendir(git_path("objects/17"));
 	if (!dir)
@@ -163,8 +164,8 @@ static int too_many_loose_objects(void)
 
 	auto_threshold = DIV_ROUND_UP(gc_auto_threshold, 256);
 	while ((ent = readdir(dir)) != NULL) {
-		if (strspn(ent->d_name, "0123456789abcdef") != 38 ||
-		    ent->d_name[38] != '\0')
+		if (strspn(ent->d_name, "0123456789abcdef") != hexsz_loose ||
+		    ent->d_name[hexsz_loose] != '\0')
 			continue;
 		if (++num_loose > auto_threshold) {
 			needed = 1;
-- 
2.21.0.360.g471c308f928

