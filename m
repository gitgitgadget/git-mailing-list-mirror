Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E31A020372
	for <e@80x24.org>; Sun,  8 Oct 2017 08:48:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbdJHIsd (ORCPT <rfc822;e@80x24.org>);
        Sun, 8 Oct 2017 04:48:33 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:56713 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751009AbdJHIsb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Oct 2017 04:48:31 -0400
Received: by mail-wm0-f65.google.com with SMTP id l68so16278651wmd.5
        for <git@vger.kernel.org>; Sun, 08 Oct 2017 01:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OVi1iIxetOZ9e6bVvmKsVVzVi5f4wmz/mdrK/e8XGnw=;
        b=Vs3/9Uf2q1VraAaOlEsgycfFYZL/wv+c1lusV6Bcsp2Slm+fdF7A/LWhOnSJmnI4WK
         kk8WTiEeHetpOhfoAhcnj2kLhTAJCVAKcKEz8hWCM4xFQT3swICGLQ9SH4LwtKna92qm
         ngDVSkD7xsoNvrHdLnKj/Z1bj/Hp1SG2cvC6fOdKUaHHV5bRYZ8BGEl/8YqF+qLk6W8j
         6GLbdC51/ecNFaps6tlRdoP3yZ0VHf7SuekWQtsLrpGtR+tOac1Wy8HZfOH2L5Q0Nqv9
         kzECbNGzIoHaMQh2DBuPTFGkL5Zcy10Lt7BOsjLn5XUioTYfhp7VDmU1/m3/1E32Jfb9
         SFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVi1iIxetOZ9e6bVvmKsVVzVi5f4wmz/mdrK/e8XGnw=;
        b=aKQnCPt2Xsx4E94bCzqp4u3w9hANrcacv0M2yeruUFZ81L3sHLIt4cfPPPkqs+ByfQ
         f4Q90BX3UENgAUrnAr1ZixmdEnsr+bBNfenu1+ntiGH/FZ5T7SHnHHvXBc+0nnkyW+li
         HA5vcRf36oDEBnw5O7m4QC01dafQXX4Xe2AhDMA9fnmKDcuLAuCXe40LezfIUX0q3LX1
         aCHCFmXiM5+et89olw1hmvx/QaSeaEQZ7eqyRJoIyUUaAyT6LgHyOpaVESdB5p9NNCrp
         xbF9x4FrhY7duRd357GBImfFQCkvfTrDzIK8j1USXcDGE1XzErEQDmnB5MA7V2yywM0m
         s1Ng==
X-Gm-Message-State: AMCzsaX31m4nvcXHVWijRL1E8A6sGLY5SI4O3PhXoYVSJ3fB+KuKc+C3
        X4fPjlG9eCndOX/r69/ZykfR/sE9GS8=
X-Google-Smtp-Source: AOwi7QBkFPM1WP/3p+v7acTZ5nCnVBNL0t9cVYSCQMWvz3h1yyBw4Rr2Kwv9Ji7WHGwluDaP5D4MQw==
X-Received: by 10.28.224.87 with SMTP id x84mr5148288wmg.118.1507452510024;
        Sun, 08 Oct 2017 01:48:30 -0700 (PDT)
Received: from localhost.localdomain ([2a02:aa16:5782:c100:c938:fbb7:46f8:2405])
        by smtp.gmail.com with ESMTPSA id l9sm3565708wrf.70.2017.10.08.01.48.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 08 Oct 2017 01:48:29 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Vasco Almeida <vascomalmeida@sapo.pt>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Jacques Viviers <jacques.viviers@gmail.com>,
        m4sk1n <m4sk1n@o2.pl>, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] submodule: avoid sentence-lego in translated string
Date:   Sun,  8 Oct 2017 10:48:24 +0200
Message-Id: <20171008084824.5331-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.15.0.rc0.37.gd35688db1
In-Reply-To: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
References: <CANYiYbGHBDGMEjbrvX_ayXkXkciT3GgL4seM_X1NmWtud2upcg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We currently build an error message like "entry is a %s, not a commit",
where the placeholder will be replaced with "blob", "tag" or "tree".
Apart from those three placeholder words not being translated, in some
languages it might be awkward or impossible to ensure a grammatically
correct end result.

Shorten the error message to "entry is not a commit". We will still
error out, we will still give a hint about what is wrong, but we will
not be as explicit as before.

Alternatively, we could have different switch-cases for the different
types and pick one of three different error messages. We might still
want a `default` and maybe more tests. So go for this simpler approach
instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
I browsed the diff of the .pot and found an addition that looked a bit
translation-unfriendly. Maybe something like this?

 submodule.c                    | 4 ++--
 t/t5531-deep-submodule-push.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/submodule.c b/submodule.c
index 63e7094e1..3d91dbfd5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -796,8 +796,8 @@ static int check_has_commit(const struct object_id *oid, void *data)
 		cb->result = 0;
 		return 0;
 	default:
-		die(_("submodule entry '%s' (%s) is a %s, not a commit"),
-		    cb->path, oid_to_hex(oid), typename(type));
+		die(_("submodule entry '%s' (%s) is not a commit"),
+		    cb->path, oid_to_hex(oid));
 	}
 }
 
diff --git a/t/t5531-deep-submodule-push.sh b/t/t5531-deep-submodule-push.sh
index 39cb2c1c3..e4c98bbc5 100755
--- a/t/t5531-deep-submodule-push.sh
+++ b/t/t5531-deep-submodule-push.sh
@@ -305,7 +305,7 @@ test_expect_success 'submodule entry pointing at a tag is error' '
 	git -C work commit -m "bad commit" &&
 	test_when_finished "git -C work reset --hard HEAD^" &&
 	test_must_fail git -C work push --recurse-submodules=on-demand ../pub.git master 2>err &&
-	test_i18ngrep "is a tag, not a commit" err
+	test_i18ngrep "is not a commit" err
 '
 
 test_expect_success 'push fails if recurse submodules option passed as yes' '
-- 
2.15.0.rc0.37.gd35688db1

