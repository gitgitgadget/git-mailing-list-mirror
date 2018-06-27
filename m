Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 062EA1F597
	for <e@80x24.org>; Wed, 27 Jun 2018 04:47:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932413AbeF0Eq5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 00:46:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63474 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751404AbeF0Eq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 00:46:56 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F04B4F1C8;
        Wed, 27 Jun 2018 00:46:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; s=sasl; bh=07nV
        SSRCZG/SNjFbaFn8FfQgyMM=; b=ROXyYThOuYs3aIo0zAV8sG8tPO2hXRfxXiPI
        ZGtxZNiXB9Q9lLdcJFhascXtfOE85tgrNmCNl/mSQB4apAhyXGkO/uR68d28GXlW
        Q+s2mQvT+ggT64rdcGAI2FhHNsupZCKUqw6kqwTrQnwQbnv1PhaFUI2cShA9xtoL
        OzV0XZE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
        B4aduqL2RvdaM9HRqb0zfGCutmAXAzrLnM0w0BzWZ+Mg2uLXNHEK6prf9Q7RlQ1D
        l8eO2XwA/eWrF0IdNh7EM0wEJcZHqD5zA21fw5zWLbsKn477mEcgZ7CKxp+a+xN9
        q/2IZehwf0X2zpFLc/wgeQ8doD+oAkc7DMQTYzae5Qg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 285894F1C7;
        Wed, 27 Jun 2018 00:46:56 -0400 (EDT)
Received: from morphine.paradise.teonanacatl.net (unknown [47.202.87.169])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 884D14F1C2;
        Wed, 27 Jun 2018 00:46:54 -0400 (EDT)
From:   Todd Zullinger <tmz@pobox.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/2] dir.c: fix typos in core.excludesfile comment
Date:   Wed, 27 Jun 2018 00:46:52 -0400
Message-Id: <20180627044652.12080-2-tmz@pobox.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180627044652.12080-1-tmz@pobox.com>
References: <20180627044652.12080-1-tmz@pobox.com>
X-Pobox-Relay-ID: 1E2D6B3E-79C5-11E8-85BC-0DFB1A68708C-09356542!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make it easier to find references to core.excludesfile and the default
$XDG_CONFIG_HOME/git/ignore path.

Signed-off-by: Todd Zullinger <tmz@pobox.com>
---
I noticed the typo in core.excludesfile and $XDG_CONFIG_HOME while I was
verifing the previous change to clarify the documentation matched the code.
Fixing these minor issues in the comments will hopefully make it easier for
others to find the right places in the code in the future.

 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index fe9bf58e4c..363a4837ae 100644
--- a/dir.c
+++ b/dir.c
@@ -2497,7 +2497,7 @@ void setup_standard_excludes(struct dir_struct *dir)
 {
 	dir->exclude_per_dir = ".gitignore";
 
-	/* core.excludefile defaulting to $XDG_HOME/git/ignore */
+	/* core.excludesfile defaulting to $XDG_CONFIG_HOME/git/ignore */
 	if (!excludes_file)
 		excludes_file = xdg_config_home("ignore");
 	if (excludes_file && !access_or_warn(excludes_file, R_OK, 0))
-- 
2.18.0

