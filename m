Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC191F4C0
	for <e@80x24.org>; Wed, 23 Oct 2019 06:10:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732234AbfJWGKC (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Oct 2019 02:10:02 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55533 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725852AbfJWGKC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Oct 2019 02:10:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CC4758D26A;
        Wed, 23 Oct 2019 02:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=f
        XbSZP99P7vGGsrU5fnWrq6xas8=; b=mY29v4w/qqgo4XWdrkvLx2gH05SWDevwU
        hkmnGPUCqV136SJoJVkTZ8dRGeL5fplqXjG162JSxUskwTuj7rySaaF3Y0kTCmYU
        KnHgAxAsfbxuvHKM2uQW0El/lUhV4kCPy2eed0U7ePyD9S13p8ZGoKslafDCqxeh
        XZLC16QVOs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=Ckw
        DlO10TSvQWDCTqFdzL+rHgJYbLL0g4ll0T7jEApqaatRB2w8b6xEh3EqDm6Em+i6
        HTNZF3kTMWPFdKaKPLVXbDRXfqXJOAUhfcw2y6Z8K20EjKS02KknMiZxlgWORSMI
        nyl354YCQgqDgDH3TLpCOpyUqGC7sJMa69XP/Rwk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C4CA68D269;
        Wed, 23 Oct 2019 02:10:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D3AAA8D261;
        Wed, 23 Oct 2019 02:09:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [PATCH] doc: am --show-current-patch gives an entire e-mail message
Date:   Wed, 23 Oct 2019 15:09:56 +0900
Message-ID: <xmqqwocwgfgr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BDEE0DE6-F55B-11E9-9ED3-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The existing wording gives an impression that it only gives the
contents of the $GIT_DIR/rebase-apply/patch file, i.e. the patch
proper, but the option actually emits the entire e-mail message
being processed (iow, one of the output files from "git mailsplit").

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-am.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index fc3b993c33..fc5750b3b8 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -177,7 +177,7 @@ default.   You can use `--no-utf8` to override this.
 	untouched.
 
 --show-current-patch::
-	Show the patch being applied when "git am" is stopped because
+	Show the entire e-mail message "git am" has stopped at, because
 	of conflicts.
 
 DISCUSSION
-- 
2.24.0-rc0-248-ga4c21000fb

