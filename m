Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3B9A1F453
	for <e@80x24.org>; Wed, 23 Jan 2019 05:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbfAWFGZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 00:06:25 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34721 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbfAWFGY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 00:06:24 -0500
Received: by mail-pl1-f194.google.com with SMTP id w4so536177plz.1
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 21:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=IZ8mdEK22Pj1VoQHBxtCd0iH0ktJ9irsWIGCgEvHl5M=;
        b=LzEftPODja1JpE9PaAeCqFML/rZbfpc1i7VcAovmrU9kVk6lilzK55//Rpycvh57D7
         iBBGYc6kQTf0ON+2swvVgQVvqXN1QHGMJmW+MoH+y8bOTr+LZn1mbHotZUKqLJmRmES2
         sB/4I3v4qlHyU+Lywu/ynxmLiEM8blHlur12CWa862pGulyq6tDPS25m5gfhrrqS7Ogn
         SDKOGYvpyeF4L//skvYieNn3WnlFgdFXSXSyhlPCHF7ZBIL0p4q12Dq2jxkj/mi0lTmw
         cfi0/1kRWN3CwDVzfd1ASpvrivvCyaogqqU3qqlZ8ezBmf83TYoU9lY6LJx7MgQ8Tn+a
         9vIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=IZ8mdEK22Pj1VoQHBxtCd0iH0ktJ9irsWIGCgEvHl5M=;
        b=k52CNtc/mbz9QGUpys4CtKb6zBlG6ICoMEoGc/Kipivct3vSqZTB4ZRKe9M8AL/VRM
         wk0QtqaYFXoYKvr3si4rT1HbAYYeN9WT/J3BaqwzNxSBTEHVWf6Yc+R5m7BwNHUT21Sl
         DH2xDD26zI4m/0C0ewAqRTd5ri0xSNw/hOfvI2zHucg3xIAmku/WW+9dlaOkBfqJ6fU+
         sy+ZKNJCz/qjbMOU0etvFdaGrAXI0IiPu5BAWKfX9GWsfz2MzmziAqgDTc3eFcFS5o88
         cJ6cA3V7sOeuU8xBk5kO3jmMk0SICsh17e8Pgu4h3QpsIlAzNJtRBJ9quPMTNRmP7m3x
         hFYQ==
X-Gm-Message-State: AJcUukcvMx3seHdgLMJxUBJLAokH0RV4LY1oP9uVDTD2LuIv8FmYfeJe
        9htQ9Wx7VVIvrWYdptNlyfIxCeIt
X-Google-Smtp-Source: ALg8bN5QsJQWxEZAgP/dBOFHlrPtP8+nNuhKAXi6dmX1MjsfoCW7nO4wADIrZ/BD7BtngyBpZ7v6cA==
X-Received: by 2002:a17:902:4a0c:: with SMTP id w12mr843329pld.8.1548219983507;
        Tue, 22 Jan 2019 21:06:23 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id u8sm27307891pfl.16.2019.01.22.21.06.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Jan 2019 21:06:23 -0800 (PST)
Date:   Tue, 22 Jan 2019 21:06:21 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com
Subject: [PATCH v6 2/4] t7600: clean up 'merge --squash c3 with c7' test
Message-ID: <2b982fd6a1f443696b82a79cabedc16f6307d89b.1548219737.git.liu.denton@gmail.com>
References: <cover.1545745331.git.liu.denton@gmail.com>
 <cover.1548219737.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1548219737.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This cleans up the original test by removing some unnecessary braces and
removing a pipe.

Helped-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7600-merge.sh | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/t/t7600-merge.sh b/t/t7600-merge.sh
index 106148254d..d879efd330 100755
--- a/t/t7600-merge.sh
+++ b/t/t7600-merge.sh
@@ -233,8 +233,7 @@ test_expect_success 'merge --squash c3 with c7' '
 	cat result.9z >file &&
 	git commit --no-edit -a &&
 
-	{
-		cat <<-EOF
+	cat >expect <<-EOF &&
 		Squashed commit of the following:
 
 		$(git show -s c7)
@@ -242,8 +241,8 @@ test_expect_success 'merge --squash c3 with c7' '
 		# Conflicts:
 		#	file
 		EOF
-	} >expect &&
-	git cat-file commit HEAD | sed -e '1,/^$/d' >actual &&
+	git cat-file commit HEAD >tmp &&
+	sed -e '1,/^$/d' <tmp >actual &&
 	test_cmp expect actual
 '
 
-- 
2.20.1.3.ge68552ea27.dirty

