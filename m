Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A6C61F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeIAATY (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:24 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33849 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727502AbeIAATY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:24 -0400
Received: by mail-wr1-f65.google.com with SMTP id g33-v6so12274937wrd.1
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iyGsuOUXB6Kwdc8uF5NUCsu+HB+pqs4AvzsS3xgO/ks=;
        b=nO2IlWRdm/tWi5jiPomIndw+gIOZoZ9cSdKrYyhRjfHZei4rgWvjkQ6cxIEV40MOa4
         m3KyLZJ0KO+xWz7+1deqzpVodOYz8RXawl2+r++oQYwa9ogBId1//sipiGF09qbc2czw
         F4xmA6bqSDmGmBaeacjHMgchJOkVTegD16uZRFTpr8eFdX6RAFgCKrk/714ExwJYetfG
         SyGyjBeZWSFRu4HjaTR1Fs16yXJ+Wt9owBDC0ukcNA012K1TAcxjidScS2LoS0alXN9s
         DSw0v36mdM42CiMkNBo/6Rsn0OlLj3cUKqw5LyKE4TX0224NjnYUX4VKSqFdVyvqXSKZ
         Tq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iyGsuOUXB6Kwdc8uF5NUCsu+HB+pqs4AvzsS3xgO/ks=;
        b=WKsvcWc7Ygz64hcMNI9RIY0TkKVVawM6vv9HSVm5YzD0vrxjC65AULR6+iB+3Y5mkj
         8P7w5n49Q8sSrnFEP8JSZivVxW/gNyh4Kw6I50nH2LiS7IE5vWu4AM1E5JsoND9K1vdM
         LC6brAxfHc5j7urEIsPgQKgA4RjRNXmKfBpHkcyf7kmbKLSnldCcIixraLPDaK5FqydM
         h/Wya3lOP2XVLvO0ZQktsUdUhLkLk/lUAJ/A3sLbEZpg3xN1JNOPYn/86pTPJrT8BGsG
         +wN8XcUxOr9hUvYqDwFnhae4RG9VJk67ejbr8WXi1m2+ZlmME69g9LrrzRLi8hg43DGv
         rCTw==
X-Gm-Message-State: APzg51CUKCZP5G9PEg6ULQZuJcIW8J039UqNAzl1dFt0f0di1nY7xnZK
        u/5s1Ngd0615LUZWyDjiVdQwJzZQDQo=
X-Google-Smtp-Source: ANB0Vda8R6xtlmpCuM54kpkOvzptkzdO3T3a97UAKC0Ie5FpsK5kXJlZ4Bz9/jsnZYdwj81YuVd1bg==
X-Received: by 2002:adf:a708:: with SMTP id c8-v6mr2114606wrd.56.1535746219625;
        Fri, 31 Aug 2018 13:10:19 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/9] fetch: change "branch" to "reference" in --force -h output
Date:   Fri, 31 Aug 2018 20:09:56 +0000
Message-Id: <20180831201004.12087-2-avarab@gmail.com>
X-Mailer: git-send-email 2.19.0.rc1.350.ge57e33dbd1
In-Reply-To: <20180830201244.25759-1-avarab@gmail.com>
References: <20180830201244.25759-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The -h output has been referring to the --force command as forcing the
overwriting of local branches, but since "fetch" more generally
fetches all sorts of references in all refs/ namespaces, let's talk
about forcing the update of a a "reference" instead.

This wording was initially introduced in 8320199873 ("Rewrite
builtin-fetch option parsing to use parse_options().", 2007-12-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/fetch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 61bec5d213..b0706b3803 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -114,7 +114,7 @@ static struct option builtin_fetch_options[] = {
 		 N_("append to .git/FETCH_HEAD instead of overwriting")),
 	OPT_STRING(0, "upload-pack", &upload_pack, N_("path"),
 		   N_("path to upload pack on remote end")),
-	OPT__FORCE(&force, N_("force overwrite of local branch"), 0),
+	OPT__FORCE(&force, N_("force overwrite of local reference"), 0),
 	OPT_BOOL('m', "multiple", &multiple,
 		 N_("fetch from multiple remotes")),
 	OPT_SET_INT('t', "tags", &tags,
-- 
2.19.0.rc1.350.ge57e33dbd1

