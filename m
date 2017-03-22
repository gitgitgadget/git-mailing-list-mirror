Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 97B9B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751330AbdCVUIQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:08:16 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56149 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbdCVUIM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:08:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7CB587BAAA;
        Wed, 22 Mar 2017 16:08:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=vD/7
        Z83OqD3TejMrJ3FkHcNeHxo=; b=JuJkVG57S1L97XQeZsfXO46CRwMEuRhlTa3t
        ISYk9dMn0mIcUNVUSncI4X0OqupvBpQNzAKfwv4BmRG2o3rmIqOru3BcUCrCMYCG
        UdDE+gujjf87/kz4OKu3NGFUoN+ikZcRDN9EWpc/BqUYUbKWZ+hgVijT+nlhULaX
        LBGazw8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        LPYX31Auo/0P/BSZ+YFQXcjgV/OYEm2ZqtjG2bamSBEfDkjx8vq5VCK3X440Oi+D
        mGghjWu3pE3xz4VOUac1olXCIQKjbm68v6PFz3Mm0oClDf54DDOdkk0z9Yun9qfC
        YGU19YT5hRSXpqILrEDW/Og4+WcaFi01d8DpLLLSN+c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 754C07BAA9;
        Wed, 22 Mar 2017 16:08:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D4B6D7BAA8;
        Wed, 22 Mar 2017 16:08:09 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jan Palus <jan.palus@gmail.com>
Subject: [PATCH 2/3] t7406: fix here-doc syntax errors
Date:   Wed, 22 Mar 2017 13:08:04 -0700
Message-Id: <20170322200805.23837-3-gitster@pobox.com>
X-Mailer: git-send-email 2.12.1-430-gafd6726309
In-Reply-To: <20170322200805.23837-1-gitster@pobox.com>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
X-Pobox-Relay-ID: 4555A596-0F3B-11E7-8028-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jan Palus <jan.palus@gmail.com>

The came in an earlier sb/submodule-update-initial-runs-custom-script
topic that was merged to 2.12.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This should be applied on top of e7b37caf ("submodule update: run
   custom update script for initial populating as well", 2017-01-25)

 t/t7406-submodule-update.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 347857fa7c..a20df9420a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -442,9 +442,9 @@ test_expect_success 'submodule update - command in .git/config catches failure -
 '
 
 test_expect_success 'submodule update - command run for initial population of submodule' '
-	cat <<-\ EOF >expect
+	cat >expect <<-\EOF &&
 	Execution of '\''false $submodulesha1'\'' failed in submodule path '\''submodule'\''
-	EOF &&
+	EOF
 	rm -rf super/submodule &&
 	test_must_fail git -C super submodule update >../actual &&
 	test_cmp expect actual &&
-- 
2.12.1-430-gafd6726309

