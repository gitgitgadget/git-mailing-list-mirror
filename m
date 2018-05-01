Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 965EC215F4
	for <e@80x24.org>; Tue,  1 May 2018 18:40:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756328AbeEASki (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 May 2018 14:40:38 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:40681 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756289AbeEASkg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 May 2018 14:40:36 -0400
Received: by mail-wm0-f68.google.com with SMTP id j5so20369352wme.5
        for <git@vger.kernel.org>; Tue, 01 May 2018 11:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=g30CkEC4TtkPXybTaNqgCrkX5ZJqmTT/EGUXjCjQIACQWieQVsAyb14hhyzPeUqPmD
         E1GmxLkB6uw2Z253jJwt35XmBM4omjVGfTt1lPB+raW3v8jL6idigQwQE+7AUzbvgGVZ
         YwcaUPnZJ5ME7PPyvGU+uX1zmGbExKhCXb9DZ2iat33qq52sFfQhZZgzxRV5BZ8V/aZ3
         t3nrXawlR8tbvcWFyyvDI9zeafDtruqfwE4PzVuHPC90U/X0w+suTPi1c9HvzHnO9ZRL
         ZQxb5yrmNKEuIfUDpLWdTIvdIyhqQpocEYIHg2AudxDNG8xS+i6a0vHcldAWrpxwV9Yt
         Ybrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5Prnr6gVzoaDi0OEFGAOCRl9RbY2eQ6UNNL5A29Q1II=;
        b=NbJglyvty1mXRuVUTpoY7fE9La+rsKR6Yl2gzp5COc+8okPpnljCY2mzvYBqwu+vga
         CMYKEbEvez7XV5ArKdpFf+I7cZbLNAL2oP8iNa+gri9FgPYkwUSPIeN4CxIl8rMrA5qn
         2ThS39T0rudX6BZ5wzep0A0R7osRGEbRVcrZY1Q5BiWmSIgMuJK9jIo6GlgCzC1b+ASL
         aEY779ceQx9StmB0vTKRxNPmqYsMkxN5Ll3w2WkMsgvgCl+nxkhnWePr5qTSe4aFH8oW
         opZA6gEWaP9/SOVbQvGjN+sOwgx3y2ibhMfr7vADKzi089FOeuDeA4hRaeoCwxlnyiRk
         ZK6w==
X-Gm-Message-State: ALQs6tABvnjueijXP1ONxRHNP24PYQhcF5RWR8DsEyFgmrm5Cfo8Mlvw
        aaT82boeB7uDzm6MoSMkJnTA3zlY
X-Google-Smtp-Source: AB8JxZo9ZAALtWCM+7OijZ6siJqmkq8W9fSvp3nfHsz2/zcevC4y2pyLTcky+cJ/8FDsDQaACSVKGA==
X-Received: by 10.28.125.74 with SMTP id y71mr10026310wmc.89.1525200034929;
        Tue, 01 May 2018 11:40:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id b57-v6sm15366920wra.9.2018.05.01.11.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 May 2018 11:40:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <stolee@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] sha1-name.c: remove stray newline
Date:   Tue,  1 May 2018 18:40:05 +0000
Message-Id: <20180501184016.15061-2-avarab@gmail.com>
X-Mailer: git-send-email 2.17.0.290.gded63e768a
In-Reply-To: <20180501184016.15061-1-avarab@gmail.com>
References: <20180501184016.15061-1-avarab@gmail.com>
In-Reply-To: <20180501120651.15886-1-avarab@gmail.com>
References: <20180501120651.15886-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This stray newline was accidentally introduced in
d2b7d9c7ed ("sha1_name: convert disambiguate_hint_fn to take
object_id", 2017-03-26).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 sha1-name.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sha1-name.c b/sha1-name.c
index 5b93bf8da3..cd3b133aae 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -346,7 +346,6 @@ static int show_ambiguous_object(const struct object_id *oid, void *data)
 	struct strbuf desc = STRBUF_INIT;
 	int type;
 
-
 	if (ds->fn && !ds->fn(oid, ds->cb_data))
 		return 0;
 
-- 
2.17.0.290.gded63e768a

