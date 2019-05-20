Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A6B1F462
	for <e@80x24.org>; Mon, 20 May 2019 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbfETVx0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 May 2019 17:53:26 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37810 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbfETVx0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 May 2019 17:53:26 -0400
Received: by mail-wm1-f68.google.com with SMTP id 7so800146wmo.2
        for <git@vger.kernel.org>; Mon, 20 May 2019 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=re919G5EiPff6sSQMEG3RHfnP97frjXQ577syAaw1NA=;
        b=dquAnUl4bypv511k6Xjt7iUYH7oNum4o3WJQZ7UUlAJP+BBPk0kdz9A1wt81GodupP
         +Vw6nQIVKIn7IrbJGk00RfzwrF+UpZTpwtux5G2iIKV9/xRUXC3Jdz0egxxrxwmCcERm
         LLtl+h52PPyTXIAfyMx08qRA7ryUMmSIiY08zaNq8D3MNJt1hzMh4zrMcGVoA0wQs7W2
         PT5op3bfvT2HX3g6Vs4SkZI3eD3zf2C9SImC3CCUGcGUfB5ov4Fc1kr9iC9xJM7Se0sE
         sjbdA8TxGd3qtMl7ANPtJ5ocACeK60WMrPnTtVeesxV8jaOdSmlXXuEFriJ9B/hbiBPD
         2Z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=re919G5EiPff6sSQMEG3RHfnP97frjXQ577syAaw1NA=;
        b=Q2Pl2pNIMlWgm5FcNZu76eo39GicpSZpEuQ6GfubdCvr3DG3ATNq+JURGWthw9LqjX
         np1uZabkKvnn6G81zXGNdNIfeVaFjq9Dk2DMukCoI+CqRi5DBq7TP02NRtNF7s2ryW8X
         o1yWSnX6DNmILh6NhwQYuVPYlagCRJb3up7eoB4UfvYvTE+ypy677vHFfgmel2S4L3gV
         Aq0DGOB1+MDqqpgSnVuEShojfru13ex9QGafoHJEBCMHN7gJSKKK7SPSEhQbRHYDZSeM
         gxw0gPBzDIO+TLFow+ICAaSXniMzM9897s1gqEbxQAYvXbXzPzINTg5jkfxcDoA2JlEw
         H/Ow==
X-Gm-Message-State: APjAAAXnv5nDNXo9m1uUxHYZ7uwD+QAaTXQJe+jc46SCP4R3v0Vu+Zfs
        S+fVcSg0YypftNxL+wvlJDtKZQi/
X-Google-Smtp-Source: APXvYqzHZyaZINr4GziNRDaDv+upixvGSeFjjUh0em91f7hAkHLPRMfw8JGTTZzfmbBR/tTQf+ik+w==
X-Received: by 2002:a7b:cb01:: with SMTP id u1mr793780wmj.153.1558389203820;
        Mon, 20 May 2019 14:53:23 -0700 (PDT)
Received: from vm.nix.is ([2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n63sm600249wmn.38.2019.05.20.14.53.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 20 May 2019 14:53:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Adam Roben <aroben@apple.com>,
        Bryan Larsen <bryan.larsen@gmail.com>,
        Matthias Urlichs <smurf@smurf.noris.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] hash-object doc: stop mentioning git-cvsimport
Date:   Mon, 20 May 2019 23:53:10 +0200
Message-Id: <20190520215312.10363-2-avarab@gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a
In-Reply-To: <20190520215312.10363-1-avarab@gmail.com>
References: <20190520215312.10363-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a reference to git-cvsimport in the intro. As can be seen from
the history of this command[1] it was originally intended for use with
git-cvsimport, but how it uses it (and that it uses it at all) is
irrelevant trivia at this point.

1. See 7672db20c2 ("[PATCH] Expose object ID computation functions.",
   2005-07-08) and 8b8840e046 ("[PATCH] cvsgit fixes: spaces in
   filenames and CVS server dialog woes", 2005-08-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-hash-object.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 814e74406a..df9e2c58bd 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -18,9 +18,7 @@ Computes the object ID value for an object with specified type
 with the contents of the named file (which can be outside of the
 work tree), and optionally writes the resulting object into the
 object database.  Reports its object ID to its standard output.
-This is used by 'git cvsimport' to update the index
-without modifying files in the work tree.  When <type> is not
-specified, it defaults to "blob".
+When <type> is not specified, it defaults to "blob".
 
 OPTIONS
 -------
-- 
2.21.0.1020.gf2820cf01a

