Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E69F1F453
	for <e@80x24.org>; Sat, 22 Sep 2018 14:12:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbeIVUGB (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 16:06:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50581 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeIVUGB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 16:06:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id s12-v6so5655110wmc.0
        for <git@vger.kernel.org>; Sat, 22 Sep 2018 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwn4qv98aMccIuVyCzmQEk2eavKe5psOhP4ZGMZTFdg=;
        b=eOLst0HVZ0JgXzHSgUFz3/HeNtdTJgMLjDfnCi4YjFwJVAOePtcEMOGQWKuW6p9sYz
         W/k+Gt/oe1ddjouwQcNB4UzhmJmHaGLo3YYmiNZYt6QGlj6hefZXviT6VvJ+hrAerB46
         14UIvxf2EogAOkWM8cvIa9FXYO9c/gcnESVp2IC1izeE3R1HBs99AulStJ2zseFa2CRH
         R2ftDmxJHUN/lS+Z7Bzavs/qO7Iea0Cjr7RX8m/5v+S3KbMIkPVcKqCWAZnu460XTUYg
         oB4GNSvH1HJrzV4fAOwGjmrMpRD4vUEf5tALmV5CLpmzEKv7v8P7PcqDorcDWLdfPeKP
         Ej0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwn4qv98aMccIuVyCzmQEk2eavKe5psOhP4ZGMZTFdg=;
        b=Jabs15FyLvW4BZ3Zd2L2XFCD6S54O+BYVu1MF0TnOpDAPGZ3PthGPPfBfDaji0reFa
         Vk8diXEN5lRe714RmP9a+TEBX3OakILAgV19lZlhd974WwdYcg2/5qbDz2e6uUOg4OCu
         zJoYy+s9LdAagGiQdQKpEMCJXXteWXkLP9zYthF85BCOLAX90uYHfPdSzF7U6fYJPVoV
         rf3vqQK9BRdQVi06qOXSwygjtb/XusdBL6n918PFwHUULQ9GTdNUSgDV3bAOx4OqcER0
         2MyB/W9FgF1o65XhY7rYGsMKQw4fIB3KqUHc+VwvoA82m9x/Pxi8Vj205WLfPqSR+HdX
         29zA==
X-Gm-Message-State: APzg51AI7yWxmX3LliWC/qnUwFam+0LI2t9ikKTH8wCbyVnJvO+a7YIJ
        v/pP4SokEgeprU2ifaKK5HIWXFTh
X-Google-Smtp-Source: ACcGV60hEx2YXLNUTQ1d2rVeJxV4G0804A6qJhMIZW5kkmN83e7jY+DED/xnzYf6+BmazxvDd+ivnA==
X-Received: by 2002:a1c:e54:: with SMTP id 81-v6mr1710618wmo.84.1537625535711;
        Sat, 22 Sep 2018 07:12:15 -0700 (PDT)
Received: from localhost.localdomain (x4dbe3ca5.dyn.telefonica.de. [77.190.60.165])
        by smtp.gmail.com with ESMTPSA id n17-v6sm5501550wmc.13.2018.09.22.07.12.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 22 Sep 2018 07:12:14 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH] ref-filter: don't look for objects when outside of a repository
Date:   Sat, 22 Sep 2018 16:11:45 +0200
Message-Id: <20180922141145.10558-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.0.355.geb876cd9d6
In-Reply-To: <20180922124215.0c8172d1@pc09.procura.nl>
References: <20180922124215.0c8172d1@pc09.procura.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command 'git ls-remote --sort=authordate <remote>' segfaults when
run outside of a repository, ever since the introduction of its
'--sort' option in 1fb20dfd8e (ls-remote: create '--sort' option,
2018-04-09).

While in general the 'git ls-remote' command can be run outside of a
repository just fine, its '--sort=<key>' option with certain keys does
require access to the referenced objects.  This sorting is implemented
using the generic ref-filter sorting facility, which already handles
missing objects gracefully with the appropriate 'missing object
deadbeef for HEAD' message.  However, being generic means that it
checks replace refs while trying to retrieve an object, and while
doing so it accesses the 'git_replace_ref_base' variable, which has
not been initialized and is still a NULL pointer when outside of a
repository, thus causing the segfault.

Make ref-filter more careful and only attempt to retrieve an object
when we are in a repository.  Also add a test to ensure that 'git
ls-remote --sort' fails gracefully when executed outside of a
repository.

Reported-by: H.Merijn Brand <h.m.brand@xs4all.nl>
Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---

I'm not quite sure that this is the best place to add this check...
but hey, it's a Saturday afternoon after all ;)

 ref-filter.c         | 3 ++-
 t/t5512-ls-remote.sh | 6 ++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/ref-filter.c b/ref-filter.c
index e1bcb4ca8a..3555bc29e7 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1473,7 +1473,8 @@ static int get_object(struct ref_array_item *ref, int deref, struct object **obj
 		oi->info.sizep = &oi->size;
 		oi->info.typep = &oi->type;
 	}
-	if (oid_object_info_extended(the_repository, &oi->oid, &oi->info,
+	if (!have_git_dir() ||
+	    oid_object_info_extended(the_repository, &oi->oid, &oi->info,
 				     OBJECT_INFO_LOOKUP_REPLACE))
 		return strbuf_addf_ret(err, -1, _("missing object %s for %s"),
 				       oid_to_hex(&oi->oid), ref->refname);
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index bc5703ff9b..7dd081da01 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -302,4 +302,10 @@ test_expect_success 'ls-remote works outside repository' '
 	nongit git ls-remote dst.git
 '
 
+test_expect_success 'ls-remote --sort fails gracefully outside repository' '
+	# Use a sort key that requires access to the referenced objects.
+	nongit test_must_fail git ls-remote --sort=authordate "$TRASH_DIRECTORY" 2>err &&
+	test_i18ngrep "^fatal: missing object" err
+'
+
 test_done
-- 
2.19.0.355.geb876cd9d6

