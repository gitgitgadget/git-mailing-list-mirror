Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 41E8220248
	for <e@80x24.org>; Sun, 17 Mar 2019 12:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfCQMvh (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 08:51:37 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41145 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbfCQMvh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 08:51:37 -0400
Received: by mail-pg1-f194.google.com with SMTP id k11so9492572pgb.8
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HZHcFcAQqiOAG/16bkwm/OVEz9Emv15HkJL7F/f1PA0=;
        b=YoVCiz7PqEdW+0yKOTsa9qqKW0GoNT+Jw4DM+jatH8HImj6y54L/FtPIb4xotivU00
         V5yVCdKOxweGGbUw+g8VD+Rzznlwb+VqSALChsbH1cwaLw03nBrF4HHH3KWwlbADUOZH
         R84QVNGAMLWixgfs4SkszV1ZmhNUqDzajFLISmb/6wLNCDsyVmRd2KRSeRwC2/jhw0fW
         Zgo/u3fZU6HfT/rHWNRdkBZOBHFNibF4dVrohExaqsoKE4Kruz++rPlQpIRE0xUjFxHY
         DJONVOCKQv4rsoApU8qqtEg9yogm/pfaopaUS30smVojeNbE+zRK6nJ5QBi7fFkKoRMT
         tDzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HZHcFcAQqiOAG/16bkwm/OVEz9Emv15HkJL7F/f1PA0=;
        b=ZwrkLJdDwrIquR1faSonx9vqiNZ1DugeeCi8nM278E1HeVKoh5snEI1G2JQMos9wmZ
         gdldJp0nAqBGGGlZT3n5PauxKBJN6l/eUw9Fqtud3+St9ytmJCYmHYhP0/KQclXaS58D
         syf2+lKPFFhE2NsQB+S1Q4yHPV7ta7ypZWrNCCcNY7I3q7cWNtX3SDpf7MBpPs3CU5We
         t8bbTIfm2uK9TePj2DTLnwdktU/AOoplJEdBMNy4/c0jS4L87jX96b17SOxMekYyT2Rj
         CtNA25RVoae/jp1RS41Br1BXtTwoYBaIQRsJZTTH/ghpUnJXVFXVLrfkasXHhMXBcLZR
         4oEg==
X-Gm-Message-State: APjAAAUKAwbFJI8iIW5zR++mJeUkSyQ+u3fs9FqIm0dWDhYk25/igEyc
        q5f6payWgPiEoj/w5X4L1Jj+QR23
X-Google-Smtp-Source: APXvYqwjWI659EFc7TbifDFsDD5Kj263oLItwDPUDHlNIsIa0GvkD79i4QBt3MvsXJct+AW8QhETew==
X-Received: by 2002:a62:5ac3:: with SMTP id o186mr12417042pfb.147.1552827096481;
        Sun, 17 Mar 2019 05:51:36 -0700 (PDT)
Received: from ash ([171.226.148.85])
        by smtp.gmail.com with ESMTPSA id 6sm2879554pfi.53.2019.03.17.05.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 05:51:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Mar 2019 19:51:30 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sunshine@sunshineco.com,
        szeder.dev@gmail.com, Elijah Newren <newren@gmail.com>,
        eckhard.s.maass@googlemail.com,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        jacob.keller@gmail.com, phillip.wood123@gmail.com,
        rybak.a.v@gmail.com
Subject: [PATCH v4 19/26] switch: add short option for --detach
Date:   Sun, 17 Mar 2019 19:49:19 +0700
Message-Id: <20190317124926.17137-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.548.gd3c7d92dc2
In-Reply-To: <20190317124926.17137-1-pclouds@gmail.com>
References: <20190308095752.8574-1-pclouds@gmail.com>
 <20190317124926.17137-1-pclouds@gmail.com>
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
index d72e28aabb..a14133b474 100644
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
2.21.0.548.gd3c7d92dc2

