Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7138C1F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755432AbcHXPps (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 11:45:48 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51699 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753078AbcHXPpq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 11:45:46 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 619D0384A2;
        Wed, 24 Aug 2016 11:45:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/I6vziGy51wwKFnnkPWGkjsS6No=; b=PXjYdo
        gEojiu7XCOEUXYkPcLV4cZwht14o6HhUPmqIdtMANuW0wO2GQkAf2PlBzqkmkaGY
        HjeiI/l2BTK2+shk9yIVyB0V6HMa5WkqQihKedZ0HC/TI1j+gMjV7F5+/pgG60Cr
        jDUdpc/Cf74OFsfPmSzg1GEf/LfEizunYEOCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bejZ3vwcxLh2GgjYDrrhY/r1gAe4yJxb
        28TBEXKAg3UuT/XaCigY7g+5loMLF32z3Ki+SPgDQ2LFgTInSdk9eKl2XOvDy6w/
        u3EPd9abRJWJF0KcvemJgxLFpIDHUu3iy44/+ryV+C9HNqBhGyV2lMdmHKsTyEsb
        AzCvyzZK3Lo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58A15384A1;
        Wed, 24 Aug 2016 11:45:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CCF303849D;
        Wed, 24 Aug 2016 11:45:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jean-Noel Avila <jn.avila@free.fr>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH 1/3] i18n: fix typos for translation
References: <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com>
        <20160821145039.12121-1-jn.avila@free.fr>
        <xmqqk2f7xyfe.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 24 Aug 2016 08:45:41 -0700
In-Reply-To: <xmqqk2f7xyfe.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 23 Aug 2016 09:06:13 -0700")
Message-ID: <xmqqshturx0a.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1387C02-6A11-11E6-8444-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

And here is the second one, using wording suggested by Jiang.

-- >8 -- 
From: Jean-Noel Avila <jn.avila@free.fr>
Date: Sun, 21 Aug 2016 16:50:38 +0200
Subject: [PATCH] i18n: fix git rebase interactive commit messages

For proper i18n, the logic cannot embed english specific processing.

Signed-off-by: Jean-Noel Avila <jn.avila@free.fr>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-rebase--interactive.sh | 45 +++------------------------------------------
 1 file changed, 3 insertions(+), 42 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index e2da524..7e558b0 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -404,51 +404,12 @@ pick_one_preserving_merges () {
 
 this_nth_commit_message () {
 	n=$1
-	case "$n" in
-	1) gettext "This is the 1st commit message:";;
-	2) gettext "This is the 2nd commit message:";;
-	3) gettext "This is the 3rd commit message:";;
-	4) gettext "This is the 4th commit message:";;
-	5) gettext "This is the 5th commit message:";;
-	6) gettext "This is the 6th commit message:";;
-	7) gettext "This is the 7th commit message:";;
-	8) gettext "This is the 8th commit message:";;
-	9) gettext "This is the 9th commit message:";;
-	10) gettext "This is the 10th commit message:";;
-	# TRANSLATORS: if the language you are translating into
-	# doesn't allow you to compose a sentence in this fashion,
-	# consider translating as if this and the following few strings
-	# were "This is the commit message ${n}:"
-	*1[0-9]|*[04-9]) eval_gettext "This is the \${n}th commit message:";;
-	*1) eval_gettext "This is the \${n}st commit message:";;
-	*2) eval_gettext "This is the \${n}nd commit message:";;
-	*3) eval_gettext "This is the \${n}rd commit message:";;
-	*) eval_gettext "This is the commit message \${n}:";;
-	esac
+	eval_gettext "This is the commit message #\${n}:"
 }
+
 skip_nth_commit_message () {
 	n=$1
-	case "$n" in
-	1) gettext "The 1st commit message will be skipped:";;
-	2) gettext "The 2nd commit message will be skipped:";;
-	3) gettext "The 3rd commit message will be skipped:";;
-	4) gettext "The 4th commit message will be skipped:";;
-	5) gettext "The 5th commit message will be skipped:";;
-	6) gettext "The 6th commit message will be skipped:";;
-	7) gettext "The 7th commit message will be skipped:";;
-	8) gettext "The 8th commit message will be skipped:";;
-	9) gettext "The 9th commit message will be skipped:";;
-	10) gettext "The 10th commit message will be skipped:";;
-	# TRANSLATORS: if the language you are translating into
-	# doesn't allow you to compose a sentence in this fashion,
-	# consider translating as if this and the following few strings
-	# were "The commit message ${n} will be skipped:"
-	*1[0-9]|*[04-9]) eval_gettext "The \${n}th commit message will be skipped:";;
-	*1) eval_gettext "The \${n}st commit message will be skipped:";;
-	*2) eval_gettext "The \${n}nd commit message will be skipped:";;
-	*3) eval_gettext "The \${n}rd commit message will be skipped:";;
-	*) eval_gettext "The commit message \${n} will be skipped:";;
-	esac
+	eval_gettext "The commit message #\${n} will be skipped:"
 }
 
 update_squash_messages () {
-- 
2.10.0-rc1-130-gf5df0f2

