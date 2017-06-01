Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBDEE2027C
	for <e@80x24.org>; Thu,  1 Jun 2017 10:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbdFAKhS (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 06:37:18 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38232 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbdFAKhR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 06:37:17 -0400
Received: by mail-wm0-f43.google.com with SMTP id n195so26169732wmg.1
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 03:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lQjTs3vE+baLYM36eM3o/kGIKBDmMqw2qWr2VKHsra4=;
        b=WyKBG8ia+pQZh8cDdQhPs/kJh89XQJcJ4clCbyxfQTPtIx/1tY3PDfnoFSLmreQrGc
         s9J/SWeGp+8B3p0INRioKkr9bzw5ntBWhIV9JZZatdo341CevJBG/e24OowWdbWgWs9Z
         7hN6RzNubKEt6OwkX9+v0eF4GCp7A0OX8uogc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lQjTs3vE+baLYM36eM3o/kGIKBDmMqw2qWr2VKHsra4=;
        b=DI/iKzHJtX2YDwSOrw/ejar6I8AfRI/LwbB3Z3mvsCRDbBYKdMomHiYSirjurJcTOo
         plMOCcXvzMJDzJp7zKcVbcYH5/qCkj/cVbWj2bLboujQZKKEnyv2XKH5KzqByDD7Cs/M
         ypUKF1EvqS6V5cgNAVw42NhD1WvI5rD9Ii5BfoCTXS8zBZzBb0bl1/yY4c1E7SLAJgX7
         Sz+cnvlsedHBtYZ/SkP7V2FXXgS50fbWtxafvuSY87JP00M8wCRaeJc2qmVDPMu4qu2K
         /FZtxKKbp2ma4h50kV5+S7VE/l10aN0+mJM1Jmq1V8pf7PQAY8e4Mz32QTYAe/Z2mcce
         no9A==
X-Gm-Message-State: AODbwcBGLWnj5Wlpf2TXd3E6ZLO3ilGOW3c59cZwye+CWdb6OJEnpJRG
        l5XWOo2NcwP4jp7AhIVi2g==
X-Received: by 10.28.173.85 with SMTP id w82mr8078812wme.98.1496313436190;
        Thu, 01 Jun 2017 03:37:16 -0700 (PDT)
Received: from PC5175.ad.datcon.co.uk ([2620:104:4001:73:11a1:8b48:e9ab:4ccd])
        by smtp.gmail.com with ESMTPSA id m14sm39495514wmi.2.2017.06.01.03.37.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Jun 2017 03:37:15 -0700 (PDT)
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] docs: fix formatting and grammar
Date:   Thu,  1 Jun 2017 11:37:03 +0100
Message-Id: <20170601103703.12216-1-adam@dinwoodie.org>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20170601095520.GA25777@dinwoodie.org>
References: <20170601095520.GA25777@dinwoodie.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When compiling the documentation, asciidoc thinks a backtick surrounded
by whitespace shouldn't be interpreted as marking the start or end of a
literal.  In most cases, that's useful behaviour, but in the git-pull
documentation it means asciidoc is failing to correctly detect which
text should be monospaced and which shouldn't.

To avoid this, remove the extraneous spaces from the text to be
monospaced.  It would also be possible to fix the formatting by
switching to asciidoc's ++ monospace format markers and still have the
space characters included in the monospace text, but the spaces aren't
necessary and not having them keeps the markup simpler.

Also include a minor grammar fix suggested by Jeff while we're changing
these lines.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
Helped-by: Jeff King <peff@peff.net>
---
 Documentation/git-pull.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 942af8e0f..1d90dd17b 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -159,7 +159,7 @@ present while on branch `<name>`, that value is used instead of
 
 In order to determine what URL to use to fetch from, the value
 of the configuration `remote.<origin>.url` is consulted
-and if there is not any such variable, the value on `URL: ` line
+and if there is not any such variable, the value on the `URL:` line
 in `$GIT_DIR/remotes/<origin>` file is used.
 
 In order to determine what remote branches to fetch (and
@@ -167,7 +167,7 @@ optionally store in the remote-tracking branches) when the command is
 run without any refspec parameters on the command line, values
 of the configuration variable `remote.<origin>.fetch` are
 consulted, and if there aren't any, `$GIT_DIR/remotes/<origin>`
-file is consulted and its `Pull: ` lines are used.
+file is consulted and its `Pull:` lines are used.
 In addition to the refspec formats described in the OPTIONS
 section, you can have a globbing refspec that looks like this:
 
-- 
2.12.3

