Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 59B5320A10
	for <e@80x24.org>; Sun,  1 Oct 2017 23:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751148AbdJAXhR (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Oct 2017 19:37:17 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53713 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750969AbdJAXhQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2017 19:37:16 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33635A0492;
        Sun,  1 Oct 2017 19:37:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fkS0ru2ry6dupcCvjjF2kFNhXok=; b=iFalDt
        7u2nXXifQFK4y3KQrLKgrIrh+/x6g3BnyfF1/NJBlNfi2O7gOFHRhrw8eywlw64D
        IA5lwro7df1lRuKT86VCPKPtRCfW4ZLrKl/rU6OYkFIr10SDZw1VaD4c+CLytpeD
        4XqGQupmyK9S2niIug4p5Fvyr82dh0Z7DUei8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gkCahFb+EGCkhhTA6RvyJ+PDf1Wcz8Lk
        t27Oduz+G8GnOkcoBNYe/B5uNyAvebieZLeeWHl25obVQGJRBcqlFIGAYdgBJ99E
        6fq8WjAW8/ZnFOiTKX7Id5HUweVbta/LfneVL/FrCP1zNw4RzPiO0P/bXotHEAXO
        cTQNhpj8oe8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2AA66A0490;
        Sun,  1 Oct 2017 19:37:16 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8E022A048F;
        Sun,  1 Oct 2017 19:37:15 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Stephan Beyer <s-beyer@gmx.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3] clang-format: add a comment about the meaning/status of the
References: <20170929224505.GN19555@aiede.mtv.corp.google.com>
        <20171001154425.5568-1-s-beyer@gmx.net>
Date:   Mon, 02 Oct 2017 08:37:14 +0900
In-Reply-To: <20171001154425.5568-1-s-beyer@gmx.net> (Stephan Beyer's message
        of "Sun, 1 Oct 2017 17:44:25 +0200")
Message-ID: <xmqqpoa6tp79.fsf_-_@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74E41D34-A701-11E7-B791-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stephan Beyer <s-beyer@gmx.net>

Having a .clang-format file in a project can be understood in a way that
code has to be in the style defined by the .clang-format file, i.e., you
just have to run clang-format over all code and you are set.

This unfortunately is not yet the case in the Git project, as the
format file is still work in progress.  Explain it with a comment in
the beginning of the file.

Additionally, the working clang-format version is mentioned because the
config directives change from time to time (in a compatibility-breaking way).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * So here is a counter-proposal in a patch form.  I agree that my
   earlier suggestion was unnecessarily verbose; this one spends
   just as many lines and not more than the v2 round of Stephan's
   patch.

 .clang-format | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.clang-format b/.clang-format
index 56822c116b..7670eec8df 100644
--- a/.clang-format
+++ b/.clang-format
@@ -1,4 +1,8 @@
-# Defaults
+# This file is an example configuration for clang-format 5.0.
+#
+# Note that this style definition should only be understood as a hint
+# for writing new code. The rules are still work-in-progress and does
+# not yet exactly match the style we have in the existing code.
 
 # Use tabs whenever we need to fill whitespace that spans at least from one tab
 # stop to the next one.
-- 
2.14.2-820-gefeff4fbff

