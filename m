Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7DD1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 20:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbeIAAT0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 20:19:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45884 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727203AbeIAATZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 20:19:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id 20-v6so12234952wrb.12
        for <git@vger.kernel.org>; Fri, 31 Aug 2018 13:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yj7QjiRJ58NxQ/YSNwQeivo0IQ1l9Wx6mhlxw87sUcM=;
        b=k2LV3g9Eqn8jGKLJxe3RaAChMwb7ZpnaxPCb48Uj5ERWwfuDOTng+UEZ9+vsv4NNY5
         vGTJBFP1DnZBe3q3XG8+w8bWjzMtITMsFJqqZ3OKuoNQfCLlM45plTyGBmD/qrfBw929
         teJo34Qyhcn4gdrAHw84qPcZfuZr5DgZ3Eijh88Y+AlwzRUAHO/0wqxtOB5bbPQHdv6G
         s5vHD0OuPMekBba06GbaN176YRc9NguTSwfSNj2Ibi/vqlHupv7Sgv+TV9Z30y7cbxnu
         EV3z+BnrHl3jJrLqS0BUyB5Edn8QJaFZh7nMRm4ah8MS3TkkCahk9Wd4RQEyddLzt0Io
         isOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yj7QjiRJ58NxQ/YSNwQeivo0IQ1l9Wx6mhlxw87sUcM=;
        b=GDdCuJFKmDRHGHtC2vHlsOpl6xvRVX0EQSX2Mfl2wU/BL/AiSn5MDN2aMDhisiN7up
         oQSsiKgfPM8bST8sHDq36FeLl8tCIQID41DedNrVEDYQFVyGF7IXWruysnFhwpzUhtWt
         26cVoSPXQO1fVb0mQvk6bg47pojb3Kuy8SHFgpuwaq6TpPY+OO+jiAY4ZRhBy57vtKEe
         4M9JUvwzJb0npVtNtkeU8NcG9KxbiPtp5SX8H5k4u//hrC86cIGjVJw8THzCfNfe0GjY
         daSBXbu2tauIDxHnTkV4D7gpuhonl5vGkQ1/L5UfUx5GfD6K34jO2/nxcTOgSN91V1H5
         ZmIQ==
X-Gm-Message-State: APzg51AHJkngqEUHfzBqEl7IGrugf4ZtymKns5NLIfCMn2GMrRNV25Oy
        WqoHcgBGOtn4U+S6hJi0v6Wp2lLY3ZQ=
X-Google-Smtp-Source: ANB0VdYgWyJ2xPD9ME/0UA+BHgn/LQT3zb33IqytaREYG70QN0T6QEWyKR4DmbRvwISAVzbax5CNLg==
X-Received: by 2002:adf:ce90:: with SMTP id r16-v6mr11611343wrn.112.1535746220892;
        Fri, 31 Aug 2018 13:10:20 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id l16-v6sm4486753wmc.38.2018.08.31.13.10.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 13:10:20 -0700 (PDT)
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
Subject: [PATCH v5 2/9] push tests: make use of unused $1 in test description
Date:   Fri, 31 Aug 2018 20:09:57 +0000
Message-Id: <20180831201004.12087-3-avarab@gmail.com>
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

Fix up a logic error in 380efb65df ("push tests: assert re-pushing
annotated tags", 2018-07-31), where the $tag_type_description variable
was assigned to but never used, unlike in the subsequently added
companion test for fetches in 2d216a7ef6 ("fetch tests: add a test for
clobbering tag behavior", 2018-04-29).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5516-fetch-push.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 539c25aada..62d5059f92 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -969,7 +969,7 @@ test_force_push_tag () {
 	tag_type_description=$1
 	tag_args=$2
 
-	test_expect_success 'force pushing required to update lightweight tag' "
+	test_expect_success 'force pushing required to update $tag_type_description' "
 		mk_test testrepo heads/master &&
 		mk_child testrepo child1 &&
 		mk_child testrepo child2 &&
-- 
2.19.0.rc1.350.ge57e33dbd1

