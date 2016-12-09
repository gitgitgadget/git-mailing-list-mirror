Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FA51FBB0
	for <e@80x24.org>; Fri,  9 Dec 2016 00:26:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbcLIA0X (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 19:26:23 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62837 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753882AbcLIAZt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 19:25:49 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C04B757542;
        Thu,  8 Dec 2016 19:25:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qitOsUFMgpIeZVa/ohZg8psgkyk=; b=Jut2HY
        pR/e1hWjIYF21OJCwsUIyGss6MJH+s2t4VZ/Z4L51JW++thwv5qI5jW18HQ/Ae+Z
        8vDQjezDeZVLJDWbU06fe14XiAUMA8WOR3jCTKbrd/zRsWPSvniS0/wd0aeCckbx
        ug7t16FNBO2LDGcZKigv4Xn+ZSzjDaoYXXOCI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jKSBshoToxaKYG5QJLnd9mOU/WYpwv/v
        cKT65z0FwQtm41jzVdjr7RsjbkEtRdwe75dC1ne/gTM1rnq1jokAgSzXmSr+FzUm
        orC6EcH2AXLOyGnpWxRzykZecbD59eOt2K7HIcpd99qGo0kbNWsI1eBtFJ28LZht
        skm69IdpKvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8EB857540;
        Thu,  8 Dec 2016 19:25:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39D885753E;
        Thu,  8 Dec 2016 19:25:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com
Subject: Re: [PATCH v2 00/16] pathspec cleanup
References: <1481061106-117775-1-git-send-email-bmwill@google.com>
        <1481223550-65277-1-git-send-email-bmwill@google.com>
Date:   Thu, 08 Dec 2016 16:25:30 -0800
In-Reply-To: <1481223550-65277-1-git-send-email-bmwill@google.com> (Brandon
        Williams's message of "Thu, 8 Dec 2016 10:58:54 -0800")
Message-ID: <xmqqk2barls5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FE25BD82-BDA5-11E6-9B54-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Will queue, but with fixes on issues spotted by my pre-acceptance
mechanical filter squashed in, to fix style issues in the
destination of code movements.

 pathspec.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pathspec.c b/pathspec.c
index 08abdd3922..cabc02e79b 100644
--- a/pathspec.c
+++ b/pathspec.c
@@ -68,7 +68,7 @@ static struct pathspec_magic {
 	const char *name;
 } pathspec_magic[] = {
 	{ PATHSPEC_FROMTOP, '/', "top" },
-	{ PATHSPEC_LITERAL,'\0', "literal" },
+	{ PATHSPEC_LITERAL, '\0', "literal" },
 	{ PATHSPEC_GLOB,   '\0', "glob" },
 	{ PATHSPEC_ICASE,  '\0', "icase" },
 	{ PATHSPEC_EXCLUDE, '!', "exclude" },
@@ -290,8 +290,8 @@ static void strip_submodule_slash_expensive(struct pathspec_item *item)
 			item->len--;
 			item->match[item->len] = '\0';
 		} else {
-			die (_("Pathspec '%s' is in submodule '%.*s'"),
-			     item->original, ce_len, ce->name);
+			die(_("Pathspec '%s' is in submodule '%.*s'"),
+			    item->original, ce_len, ce->name);
 		}
 	}
 }
@@ -364,10 +364,10 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
 	}
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_CHEAP)
-	    strip_submodule_slash_cheap(item);
+		strip_submodule_slash_cheap(item);
 
 	if (flags & PATHSPEC_STRIP_SUBMODULE_SLASH_EXPENSIVE)
-	    strip_submodule_slash_expensive(item);
+		strip_submodule_slash_expensive(item);
 
 	if (magic & PATHSPEC_LITERAL) {
 		item->nowildcard_len = item->len;


