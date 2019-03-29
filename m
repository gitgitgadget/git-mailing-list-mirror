Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11E6920248
	for <e@80x24.org>; Fri, 29 Mar 2019 10:41:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbfC2Klz (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Mar 2019 06:41:55 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46953 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbfC2Kly (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Mar 2019 06:41:54 -0400
Received: by mail-pl1-f195.google.com with SMTP id y6so839702pll.13
        for <git@vger.kernel.org>; Fri, 29 Mar 2019 03:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KCO55dN6eRJEkmBD4w2O//zCdsQ/np5Lmd5eOykLekU=;
        b=kad/q2LdcILEP9jQs66zo7YiUqJDHYT+4GklFOUxvP+vGFirYzPXuTaAmhD+cfHpZT
         n/nJ5rqOO6Pyi5ExvD1mjfoH/URhkCd7lafTBJZ7yaxphhL0l95DfKfohpTpXUpgE3sh
         3g+5xA5ache9D+7ddWooOJ2wwoI56M3KmlGXqVAZN/uvClzMpEjmVC5mA9WIkeDdEqeQ
         TU9LENiaf4zy3Tad69r/cWdI5UiPgSb0GMbK0zm6ch/smkhP2osK/rP8ZslTb6yXNr5v
         /JpjvxhQpELOFh/M0ZKD9YG2ESOI9+shmq+X26BRaxNlhL3CEvuMI8pIlZcTjA+NMo3M
         njYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KCO55dN6eRJEkmBD4w2O//zCdsQ/np5Lmd5eOykLekU=;
        b=VR4jauFQI/MTWqVrUC3oZLvGB7VPod94eciHqz3DvD6633NbHGX7NquJjYgLjVN8Tp
         fuAhUPsPSsDjRJ6OVJZY6I33whReNTjQOugiS63PqsCwisuzrHZqF4/fdRgzF2l9PAFS
         uexD+dzRjYbkAQfla/amzFmeDu8fr/g3EhJrtyMiUTnf6Nxg4XPbN9rlW0q6DkDvaX6h
         vtqVk+cjoHMe9Z0jDv8QEqAOEl69QlntnqMwhd53V72RaTkk5k5HRM1hlDJcEqChLcMv
         fpiCWEMfFSJvMhuBAU0VtJoP1ngSiAQlcRcw+bnxPztZuNLF516dbUgzaXiddAZygj4E
         /bmg==
X-Gm-Message-State: APjAAAVgH1XETVf9x5D6cpturhf3hEGTd6CVrx3Kqt2teNlYhrObVXTJ
        9dgdci9Io5ALLx27Sc3nEr0=
X-Google-Smtp-Source: APXvYqwWF2o3bV9prUCxcLQy3uADAiOOz+6Z3dp5tGzW1oqvds8ZCOIb53kOwYI/QN1TV1AYHRa+GQ==
X-Received: by 2002:a17:902:a5c9:: with SMTP id t9mr46649990plq.196.1553856114210;
        Fri, 29 Mar 2019 03:41:54 -0700 (PDT)
Received: from ash ([171.236.209.43])
        by smtp.gmail.com with ESMTPSA id l64sm5824318pfj.173.2019.03.29.03.41.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 03:41:53 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Fri, 29 Mar 2019 17:41:48 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     eckhard.s.maass@googlemail.com, git@vger.kernel.org,
        gitster@pobox.com, jacob.keller@gmail.com, martin.agren@gmail.com,
        newren@gmail.com, phillip.wood123@gmail.com, rybak.a.v@gmail.com,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v6 20/27] switch: add short option for --detach
Date:   Fri, 29 Mar 2019 17:39:12 +0700
Message-Id: <20190329103919.15642-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190329103919.15642-1-pclouds@gmail.com>
References: <20190321131655.15249-1-pclouds@gmail.com>
 <20190329103919.15642-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git checkout" automatically detaches branches and --detach is not
that useful (--no-detach is more likely). But for "switch", you
may want to use it more often once you're used to detached HEAD. This
of course adds -d to git-checkout but it does not harm (yet?) to do it.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/checkout.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 4416b82bfd..11308ab80c 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1423,7 +1423,7 @@ static struct option *add_common_switch_branch_options(
 	struct checkout_opts *opts, struct option *prevopts)
 {
 	struct option options[] = {
-		OPT_BOOL(0, "detach", &opts->force_detach, N_("detach HEAD at named commit")),
+		OPT_BOOL('d', "detach", &opts->force_detach, N_("detach HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts->track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
 		OPT_STRING(0, "orphan", &opts->new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
-- 
2.21.0.479.g47ac719cd3

