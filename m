Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CBAF1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 20:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeJWEnd (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 00:43:33 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41020 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbeJWEnd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 00:43:33 -0400
Received: by mail-ed1-f66.google.com with SMTP id x31-v6so39212479edd.8
        for <git@vger.kernel.org>; Mon, 22 Oct 2018 13:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oQZ1PrnKpZLn+VJuEjDpXFOi2wBoTm7OGvW5SJ/9Hso=;
        b=hwfwFAX+DtFkZzgF2Z0esWrfvzc2aGVyOL9ePalF8GoUD42M9L/irwnVcNXozLLthe
         OeBLebcU1ccSX7/r5pl2PM9UqzVENc3+5InZhQiTIvhffhTJi53IjxOxYLVp+4ril24Q
         GcCrP/iTXANTsUQSy/d017uEmgmSBpAXwaRT73EUN+/Vj2xaVTfcDE/toU/L81+pg+9y
         xNkkOhS64rWgML7qzLFkL0PeFFzdHbCFpWAFxjXTanfYCMOIhPGFAZKUDPfKbBhyuDIH
         Slmok2vQ8P0+AA0Kppoq/mxQciAx06msUFXB6QGOTUvrmsW/Hrj/l45W8lvm2Kftgil0
         iQpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oQZ1PrnKpZLn+VJuEjDpXFOi2wBoTm7OGvW5SJ/9Hso=;
        b=m6troYOFK2aK89wybg0PV8xtOqYj/0hfCCZs8+7DYHOpn+iOMPlAF/lQNYkqTvq9vK
         DIXeTuSCVZ5ZASDBoZmVA/v72NsrpqfkdsnqdZhmhI082/m2ADnf0G8iikz6sPMpRXPc
         1MIcI6in2ZxQE8pcqqBACvynoqFrXtaJZLY6dN+/LvmNLQkR124V4wZQvwHrZEdtkXNI
         gJ5MdFar+28h0qRAJU47l0naieBb2L/e/A6Yl95XscMPl72eHQS95eJ6Fu6HW6ULr04f
         ONjPf/hHr+x5l8sli7ckve26u3epYO4AjiujocbF77vOzNIAGPYVYmVkpMtfAj8ypV67
         mzlg==
X-Gm-Message-State: ABuFfogyjJ440AJfS0B+RAWgl6NSL4cxBTlHxeUsdwGytJljfk9WX+FT
        6X+AvOE4tKGd/tTv3t1xB4pSDNqk
X-Google-Smtp-Source: ACcGV62+a9fSOxPnc59HqyuOdSg1Btkzj4lnAOoKd0zhs8HJLH81jqvaOjhTvHBM2ilmKC24EqGulQ==
X-Received: by 2002:a17:906:5583:: with SMTP id y3-v6mr1606503ejp.79.1540239811412;
        Mon, 22 Oct 2018 13:23:31 -0700 (PDT)
Received: from localhost.localdomain (x4db968d4.dyn.telefonica.de. [77.185.104.212])
        by smtp.gmail.com with ESMTPSA id h21-v6sm16882228eda.23.2018.10.22.13.23.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Oct 2018 13:23:30 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0?= <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/8] lib-rebase: loosen GETTEXT_POISON check in fake editor
Date:   Mon, 22 Oct 2018 22:22:36 +0200
Message-Id: <20181022202241.18629-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.19.1.681.g6bd79da3f5
In-Reply-To: <20181022202241.18629-1-szeder.dev@gmail.com>
References: <20181022153633.31757-1-pclouds@gmail.com>
 <20181022202241.18629-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fake editor script created by 't/lib-rebase.sh' recognizes GETTEXT
POSION output when the first line of the file to be edited consists
solely of the GETTEXT POISON magic string as a comment.  However, a
later patch will include additional text after that magic string, so
that check won't work anymore.

So instead of expecting an exact match in the first line, check
whether there are any lines starting with the commented out magic
string.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/lib-rebase.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-rebase.sh b/t/lib-rebase.sh
index 25a77ee5cb..530f8ec0a8 100644
--- a/t/lib-rebase.sh
+++ b/t/lib-rebase.sh
@@ -29,7 +29,7 @@ set_fake_editor () {
 	*/COMMIT_EDITMSG)
 		test -z "$EXPECT_HEADER_COUNT" ||
 			test "$EXPECT_HEADER_COUNT" = "$(sed -n '1s/^# This is a combination of \(.*\) commits\./\1/p' < "$1")" ||
-			test "# # GETTEXT POISON #" = "$(sed -n '1p' < "$1")" ||
+			! grep -q "^# # GETTEXT POISON #" ||
 			exit
 		test -z "$FAKE_COMMIT_MESSAGE" || echo "$FAKE_COMMIT_MESSAGE" > "$1"
 		test -z "$FAKE_COMMIT_AMEND" || echo "$FAKE_COMMIT_AMEND" >> "$1"
-- 
2.19.1.681.g6bd79da3f5

