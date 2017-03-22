Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 831C920323
	for <e@80x24.org>; Wed, 22 Mar 2017 20:08:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751323AbdCVUIN (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 16:08:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52969 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751027AbdCVUIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 16:08:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3DA37EFBF;
        Wed, 22 Mar 2017 16:08:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=ifYy
        4NMMiC67GcEKcF2jo8AxeuU=; b=JcPLqlrktMZnKnLHSW9Z3jn4EMmBDTVU2Dgr
        KFsX/7nswRZZixv4TMAZNqQMQz882Y1knp4mxCLAriExxdETPTWrEq+acIuGMEue
        UPhCcjqbJwByOM3Y2Zr5D4BUI7tIW9Cf05uhhjuOOVnUvZ065mo6mm8iE2T7zgvU
        h5ANyBE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        bdG/cQEWJuNv7Z+xJYaWmOPMC6+For6NflYnMYen2lsd0MX/jHiQ1f4XNKQ3rcMn
        fKN6cBXYp8Xd9aMgR3YoYS3eRLu5x5ZRGOi+UrGeaDIeutVt00R8EJrWWCbrmEkM
        GJcOCwKdXCylvuZL1BiHySGFVHIm2JHR9sNCqS9I0yU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DB68A7EFBE;
        Wed, 22 Mar 2017 16:08:08 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 490967EFBC;
        Wed, 22 Mar 2017 16:08:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jan Palus <jan.palus@gmail.com>
Subject: [PATCH 1/3] t5615: fix a here-doc syntax error
Date:   Wed, 22 Mar 2017 13:08:03 -0700
Message-Id: <20170322200805.23837-2-gitster@pobox.com>
X-Mailer: git-send-email 2.12.1-430-gafd6726309
In-Reply-To: <20170322200805.23837-1-gitster@pobox.com>
References: <20170322173528.ho43ulndlozq35tu@kalarepa>
 <20170322200805.23837-1-gitster@pobox.com>
X-Pobox-Relay-ID: 44663E02-0F3B-11E7-A145-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jan Palus <jan.palus@gmail.com>

This came as part of jk/quote-env-path-list-component and was merged
to 2.11.1 and later.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This should be applied on top of 5e74824f ("t5615-alternate-env:
 double-quotes in file names do not work on Windows", 2016-12-21)

 t/t5615-alternate-env.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t5615-alternate-env.sh b/t/t5615-alternate-env.sh
index 26ebb0375d..d2d883f3a1 100755
--- a/t/t5615-alternate-env.sh
+++ b/t/t5615-alternate-env.sh
@@ -77,6 +77,7 @@ test_expect_success 'mix of quoted and unquoted alternates' '
 	check_obj "$quoted:$unquoted" <<-EOF
 	$one blob
 	$two blob
+	EOF
 '
 
 test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
-- 
2.12.1-430-gafd6726309

