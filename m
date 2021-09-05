Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C99C433F5
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5057760ED8
	for <git@archiver.kernel.org>; Sun,  5 Sep 2021 19:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbhIETTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Sep 2021 15:19:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50982 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232870AbhIETTE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Sep 2021 15:19:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03B5D16BDD8;
        Sun,  5 Sep 2021 15:18:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=n4EVEdsWvSniUZ6W0CUoBz3VvzVRoLJtKIj5fc
        Il+XQ=; b=P5f2QbhZghC1L9hmOEnZD0GH2wkcPbzKtEnauX2kykHeyDvAtWBfuY
        LkNr+dmNY9TVQ9QJNVSPByy0n1fkD7qIMwIFX+oY8kh+fU+0LEICL+sQIhzkCGj2
        eiHfBM9cvrhJiR6IS1Fk8TCEQADlhTmAQVFgoikezUJ0xHUmNNqfo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F035416BDD7;
        Sun,  5 Sep 2021 15:18:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3A80916BDD5;
        Sun,  5 Sep 2021 15:17:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, felipe.contreras@gmail.com,
        =?utf-8?B?w4Z2?= =?utf-8?B?YXIgQXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH RESEND v3] make: add INSTALL_STRIP option variable
References: <20210905110417.35702-1-bagasdotme@gmail.com>
Date:   Sun, 05 Sep 2021 12:17:56 -0700
In-Reply-To: <20210905110417.35702-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Sun, 5 Sep 2021 18:04:18 +0700")
Message-ID: <xmqqwnnuesrf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FAC52280-0E7D-11EC-8BA1-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

>  [QUESTION]: I squashed Junio's suggestion patch to produce this patch,
>  and I want to credit his work. In such situation, what should I do the
>  right way? For now I add From: line and S-o-b trailer with his
>  identity, in addition to my S-o-b.

As far as I'm concerned, everything we see in this resulting patch
(like studying how we should sift $(ALL_PROGRAMS) into two classes,
one that can be stripped and the other that shouldn't be) came from
your brain.  I may have helped you in writing it down in a better
form but I see it within the usual "Helped-by:".

Applying this to the same base as the previous iteration of the
topic that I queued in 'seen', and running "git range-diff" between
them, I see that there is no difference at all, so I'll keep the one
I already have, but I probably should correct the authorship
information for it (I failed to notice you had in-body From: header
that shifts the blame for this change on me---you should be the
author of this change).

IOW, here is what I would expect in a situation like this.

-- >8 --
From: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] make: add INSTALL_STRIP option variable

Add $(INSTALL_STRIP), which allows passing stripping options to
$(INSTALL).

For this to work, installing executables must be split to installing
compiled binaries and scripts portions, since $(INSTALL_STRIP) is only
meaningful to the former.

Users can set this variable depending on their system. For example,
Linux users can use `-s --strip-program=strip`, while FreeBSD users can
simply set to `-s` and choose strip program with $STRIPBIN.

Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
index d1feab008f..ebef4da50c 100644
--- a/Makefile
+++ b/Makefile
@@ -465,6 +465,9 @@ all::
 # the global variable _wpgmptr containing the absolute path of the current
 # executable (this is the case on Windows).
 #
+# INSTALL_STRIP can be set to "-s" to strip binaries during installation,
+# if your $(INSTALL) command supports the option.
+#
 # Define GENERATE_COMPILATION_DATABASE to "yes" to generate JSON compilation
 # database entries during compilation if your compiler supports it, using the
 # `-MJ` flag. The JSON entries will be placed in the `compile_commands/`
@@ -3004,7 +3007,8 @@ mergetools_instdir = $(prefix)/$(mergetoolsdir)
 endif
 mergetools_instdir_SQ = $(subst ','\'',$(mergetools_instdir))
 
-install_bindir_programs := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X)) $(BINDIR_PROGRAMS_NO_X)
+install_bindir_xprograms := $(patsubst %,%$X,$(BINDIR_PROGRAMS_NEED_X))
+install_bindir_programs := $(install_bindir_xprograms) $(BINDIR_PROGRAMS_NO_X)
 
 .PHONY: profile-install profile-fast-install
 profile-install: profile
@@ -3013,12 +3017,17 @@ profile-install: profile
 profile-fast-install: profile-fast
 	$(MAKE) install
 
+INSTALL_STRIP =
+
 install: all
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(bindir_SQ)'
 	$(INSTALL) -d -m 755 '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(ALL_PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(PROGRAMS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
+	$(INSTALL) $(SCRIPTS) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
 	$(INSTALL) -m 644 $(SCRIPT_LIB) '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
-	$(INSTALL) $(install_bindir_programs) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(INSTALL_STRIP) $(install_bindir_xprograms) '$(DESTDIR_SQ)$(bindir_SQ)'
+	$(INSTALL) $(BINDIR_PROGRAMS_NO_X) '$(DESTDIR_SQ)$(bindir_SQ)'
+
 ifdef MSVC
 	# We DO NOT install the individual foo.o.pdb files because they
 	# have already been rolled up into the exe's pdb file.
-- 
2.33.0-408-g8e1aa136b3

