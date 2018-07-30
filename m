Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6DA81F597
	for <e@80x24.org>; Mon, 30 Jul 2018 20:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbeG3WXx (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 18:23:53 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:55581 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbeG3WXx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 18:23:53 -0400
Received: by mail-it0-f65.google.com with SMTP id p7-v6so1195789itf.5
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 13:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GBNSUyV+6y0ja1+K+etGW5jjG6a7kwJdf/waIymgXH4=;
        b=plfSsx7U+jZqTpN2ZJeSqGuFT0LLP+kkuHa2jKB3RYpnUfv7VcmrH9N8qvtfw/Zznb
         T7Z51uKN/VZIse+Tn0mwRLPRAAj49ewrWTjUdfg+j9m/Wihi3QjTH2KwNYt2j8UDhDF7
         jR8cah2Q+jyevDSD6VFciVNc9tT4nU2pJodOButf59DAiWYwQZmWO+d5n16h9avh2bB5
         Qf1MvHBTmLzzVZ9/DNtLs5ms8xMhOb1DfcBAVZuk3yddjzsvCXhv+gsgmEFJc51SI0T9
         ViGChSVYhQYx2H5Nl407Wtd1alkd1ZV9ec64ojFJQIqfPJmn3LFNtE4l02xL/6EcbV+K
         CNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=GBNSUyV+6y0ja1+K+etGW5jjG6a7kwJdf/waIymgXH4=;
        b=L549MxAYAYk4XQAfcAUTCaolbyZctkXaMRQUTLBe1949Ok9f1Lvw64C9eB8b3nfJc9
         ZBosu05bP1w6U9FraIfvDN9r3oSjOrKJOM3Q93AqxC8v0A80bVGfXRUdSQBL0Eis1jeE
         +3PlYn8gwr3NKfvPX2Clf/nCcIBzKj7jN8hfX3Ymq8AQqdBqJ85G2FpLng6cQZeUrdy8
         V4aWqiiTZPfLncaib5svrRLOuIiztMIQV5rrNKAToDefykUcZFq/Uz7DWV4ryILQep4w
         TAMzpQsJN0lqW0BVLL/m6kCETFMjVLIozUiDdJtSXC6ujfKFMC9brAVhmPqU8bQ4Kj8r
         IFlg==
X-Gm-Message-State: AOUpUlHcl3eAYuMajCpv9GmOPCDLkaQmrdntSqEtkOpf69Yj22IIRPyQ
        ZxsqgqxoxK5gBvr0RDmLUijedzzH
X-Google-Smtp-Source: AAOMgpeQEVDBEDU8YqznStIT+ujD6x7RH/jZouCv305dSwVq7tMpG1g921LQtQNy4Z4Ebd+9Ph+/nQ==
X-Received: by 2002:a24:ac5c:: with SMTP id m28-v6mr782729iti.120.1532983628100;
        Mon, 30 Jul 2018 13:47:08 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id p70-v6sm302222itb.3.2018.07.30.13.47.07
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 30 Jul 2018 13:47:07 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] mw-to-git/t9360: fix broken &&-chain
Date:   Mon, 30 Jul 2018 16:46:46 -0400
Message-Id: <20180730204646.32312-1-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad
In-Reply-To: <https://public-inbox.org/git/20180730190612.GB156463@aiede.svl.corp.google.com/>
References: <https://public-inbox.org/git/20180730190612.GB156463@aiede.svl.corp.google.com/>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

Jonathan's discovery[1] of a broken &&-chain in a contrib/subtree test
prompted me to check other tests bundled in contrib/. This was the
only other problem found. Unlike the subtree &&-chain case, this
breakage is at the top-level, thus was caught by the normal
--chain-lint mechanism, not the subshell linter.

[1]: https://public-inbox.org/git/20180730190612.GB156463@aiede.svl.corp.google.
com/

 contrib/mw-to-git/t/t9360-mw-to-git-clone.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
index 22f069db48..cfbfe7ddf6 100755
--- a/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
+++ b/contrib/mw-to-git/t/t9360-mw-to-git-clone.sh
@@ -247,7 +247,7 @@ test_expect_success 'Test of resistance to modification of category on wiki for
 	wiki_editpage Notconsidered "this page will not appear on local" false &&
 	wiki_editpage Othercategory "this page will not appear on local" false -c=Cattwo &&
 	wiki_editpage Tobeedited "this page have been modified" true -c=Catone &&
-	wiki_delete_page Tobedeleted
+	wiki_delete_page Tobedeleted &&
 	git clone -c remote.origin.categories="Catone" \
 		mediawiki::'"$WIKI_URL"' mw_dir_14 &&
 	wiki_getallpage ref_page_14 Catone &&
-- 
2.18.0.597.ga71716f1ad

