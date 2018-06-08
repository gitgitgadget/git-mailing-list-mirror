Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5C451F403
	for <e@80x24.org>; Fri,  8 Jun 2018 22:42:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753125AbeFHWmm (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 18:42:42 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45142 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753221AbeFHWmA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 18:42:00 -0400
Received: by mail-wr0-f193.google.com with SMTP id o12-v6so14757091wrm.12
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 15:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TFNT3csRYKKvxtwcQHHVu919JnGv4rZ8XbHWVjuRf5U=;
        b=vBTUJnMsfzeggLg0I2/hwwvD5i4ThbjFW3YSeu1bhXdWDrtr5T1LCsGcX8s+Gvy3lA
         upP3143vA0kQhttJSaqMu1B4tCIR11ksrCKsCbnmN783DJypgu6D/Lq6eJF2nZsVEdyf
         Oc+ww2kvU9z6eeirGMfCrgsKpCbDavoE8PN7bR9iIXHmMBbC7wUjtt9gvIN0lccgQ6sI
         gtjF4D+MuhqqV2lj+PMcBBvZNZmQd81a4WmdW9TG/BkalHunBPQ8nOiBuXVhgOBz7TF9
         T1aLa04r02Mb3o2gkrG9IUi0GeKO/EnjmNgkvijqBGNQ4mU057RUAFZ+p6yE5jQD/j4T
         /4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TFNT3csRYKKvxtwcQHHVu919JnGv4rZ8XbHWVjuRf5U=;
        b=Q6HOE50vH7Gqc8GBS/t/8Pj/tqw9KAYxcy3/e8Jh3Npfjr0et+MXsKkOxQsKNfhVbX
         WXQPqOv3mazkqoPRFsKiWbvK51+x8+/FY/Qklib48E72Ily7zcH0aqdzMLWjmWxpi2Y2
         gQr2axYMYFE6/l3dZERjRvVduQZ3SagoBT8LS1m/Dcwzd3Id3q2B2UN5qxe7C7efNTLT
         67z4DBvcT1GfQ267esun++KgoqUds78JEh1P11zQoV27R5u3i78hTxTzvHei8hGvAijM
         BotbjMEL6I8wiXu2Pgp0uPgGZH40764IiCathZq5XePsQtAmxkewE9xdQBiex0NR8/+0
         IlKw==
X-Gm-Message-State: APt69E1RZLftXDnWZcd+s85umcvHZm4gY7btIUiqG4C1cDR2HVyJX38a
        lPhrTgm422JqXLFb+xpdiyXfmN1c
X-Google-Smtp-Source: ADUXVKJjHWj3GEY2mvniD+ZhoGlvdcfi9516ufjXhWCE8SoafWw+x4ziWjrU4LjNSq9HDpLAA6ID1g==
X-Received: by 2002:adf:9405:: with SMTP id 5-v6mr7008303wrq.283.1528497718430;
        Fri, 08 Jun 2018 15:41:58 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id w15-v6sm36350010wro.52.2018.06.08.15.41.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 15:41:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, dstolee@microsoft.com,
        git@jeffhostetler.com, peff@peff.net, johannes.schindelin@gmx.de,
        jrnieder@gmail.com, Linus Torvalds <torvalds@linux-foundation.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/20] blame: fix a bug, core.abbrev should work like --abbrev
Date:   Fri,  8 Jun 2018 22:41:22 +0000
Message-Id: <20180608224136.20220-7-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180608224136.20220-1-avarab@gmail.com>
References: <20180608224136.20220-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 84393bfd73 ("blame: add --abbrev command line option and make it
honor core.abbrev", 2011-04-06) first released with v1.7.6 "git blame"
has supported both core.abbrev and --abbrev to change the abbreviation
length.

Initially output wouldn't alter the abbreviation length to account for
the boundary commit. This was changed in 91229834c2 ("blame: fix
alignment with --abbrev=40", 2017-01-05) first released with v2.11.1.

That change had a bug which I'm fixing here. It didn't account for the
abbreviation length also being set via core.abbrev, not just via the
--abbrev command-line option.

So let's handle that. The easiest way to do that is to check if the
global default_abbrev variable (-1 by default) has been set by
git_default_core_config(), and if so pretend we had the --abbrev
option is set, in lieu of making everything that uses the "abbrev"
variable now read that OR default_abbrev).

The reason I'm documenting these past behaviors is that whatever our
desires with --porcelain people do parse the human-readable "git
blame" output, and for any machine use are likely to use
core.abbrev=40 or --abbrev=40. Documenting how the format has changed
over time will help those users avoid nasty surprises.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-blame.txt | 8 +++++++-
 builtin/blame.c             | 2 ++
 t/t0014-abbrev.sh           | 7 ++++++-
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 7b562494ac..d6cddbcb2e 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -92,7 +92,13 @@ include::blame-options.txt[]
 Because of this UI design, the only way to get the full SHA-1 of the
 boundary commit is to use the `--porcelain` format. With `--abbrev=40`
 only 39 characters of the boundary SHA-1 will be emitted, since one
-will be used for the caret to mark the boundary.
+will be used for the caret to mark the boundary. This behavior was
+different before 2.11.1, git would then emit the 40 character if
+requested, resulting in unaligned output.
++
+Before 2.19, setting `core.abbrev=40` wouldn't apply the above rule
+and would cause blame to emit output that was unaligned. This bug has
+since been fixed.
 
 
 THE PORCELAIN FORMAT
diff --git a/builtin/blame.c b/builtin/blame.c
index 4202584f97..6ab08561d1 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -868,6 +868,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	} else if (show_progress < 0)
 		show_progress = isatty(2);
 
+	if (default_abbrev >= 0)
+		abbrev = default_abbrev;
 	if (0 < abbrev && abbrev < GIT_SHA1_HEXSZ)
 		/* one more abbrev length is needed for the boundary commit */
 		abbrev++;
diff --git a/t/t0014-abbrev.sh b/t/t0014-abbrev.sh
index 77f15d5b0b..934c54a96b 100755
--- a/t/t0014-abbrev.sh
+++ b/t/t0014-abbrev.sh
@@ -135,7 +135,12 @@ do
 	test_expect_success "blame core.abbrev=$i and --abbrev=$i with boundary" "
 		# See the blame documentation for why this is off-by-one
 		git -c core.abbrev=$i blame A.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
-		test_byte_count = $i blame &&
+		if test $i -eq 40
+		then
+			test_byte_count = 39 blame
+		else
+			test_byte_count = $i blame
+		fi &&
 		git blame --abbrev=$i A.t | cut_tr_d_n_field_n 1 | nocaret >blame &&
 		if test $i -eq 40
 		then
-- 
2.17.0.290.gded63e768a

