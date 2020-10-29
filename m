Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4382BC55178
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 22:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E482151B
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 22:26:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nKseX72B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgJ2W0b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 18:26:31 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54458 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgJ2W0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 18:26:31 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EEEB67FA59;
        Thu, 29 Oct 2020 18:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=B
        sLBUSR6gy1mbMfZMni3losnC6w=; b=nKseX72Bk/TodmOLB2cgNNV9qge5DDr79
        pnXvDmRpTiChD9NNRh/EWVynM0s39s5K+Q7SXwaIg3+wN4d+VJbvXNlntJq5txr6
        UTzYtwl/zaX6nU6lOyQzd7BFvNeWUTodqX5uHLd93+CW3tEk3bQpR//C3Ll+/Xq3
        jOqiD5isSM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=mdqV1GP6ng0u25j6iLmP6/1SjhO1LlZbGyy3YniNWZPzNtt+q4ntgemL
        C2SNwD8Fvb7IJsLQWMw4vsCzb2xm+LPnBxZgrVyjDXIXSVsEqnURqlvW7bRvmFTI
        v3HNGh3ko/mGuF5Zf6NeOpf3s5f0ozWjNYybDFLZ2bojvnWAH/U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E5DFF7FA57;
        Thu, 29 Oct 2020 18:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6E8DB7FA56;
        Thu, 29 Oct 2020 18:26:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        git-packagers@googlegroups.com
Subject: [ANNOUNCE] Git v2.29.2
Date:   Thu, 29 Oct 2020 15:26:27 -0700
Message-ID: <xmqqlffo4qjw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9B64AB2-1A35-11EB-9BA7-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.29.2 is now available at the
usual places.  This is to fix the "--committer-date-is-author-date"
feature of "rebase" that was completely broken in v2.29.0 release.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.29.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.29.2 Release Notes
=========================

This release is primarily to fix brown-paper-bag breakages in the
2.29.0 release.

Fixes since v2.29.1
-------------------

 * In 2.29, "--committer-date-is-author-date" option of "rebase" and
   "am" subcommands lost the e-mail address by mistake, which has been
   corrected.

----------------------------------------------------------------

Changes since v2.29.1 are as follows:

Christian Couder (1):
      filter-branch doc: fix filter-repo typo

Jeff King (3):
      t3436: check --committer-date-is-author-date result more carefully
      am: fix broken email with --committer-date-is-author-date
      rebase: fix broken email with --committer-date-is-author-date

Junio C Hamano (1):
      Git 2.29.2

