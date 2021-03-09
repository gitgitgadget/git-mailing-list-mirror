Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DC5C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF6F3652C0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 18:04:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbhCISDf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 13:03:35 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58460 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbhCISDL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 13:03:11 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 05E3A10EE69;
        Tue,  9 Mar 2021 13:03:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=l
        92APgVQ9wHzh0Z/W9PJFpdHiP4=; b=DE31Nv5FRVd9eQNhlqCU64DBkQbU/1tEB
        eDj/fUAGAdZ7k4M+LxQ1lG3JvbomL7uniBastNZPNp+yDidzuznZBhVq51qi2MeY
        5tfLXzRZ24ifyFlwoRg8YRckq8sK16dxpKJvF+OW9+rTsxooRF3ZqCwytN+AlpDJ
        ltd+5AQlSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=bc1
        mphhvhk0D/KFWLF9WHVAJkQdCrQiN6QnYQ090tEjEDQ+U3wIagNNoAIiJj2Y8CsX
        vzDm6Bdu+aXdUlDDwKDF91dSt+O6vv1ACZmLROcvvhCMBkxWsLjGvTPJzyd08+iF
        chXs/ZwHVxyFAPRWIFq0sBpHw1uAFLDwNWJtY5X8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DDB4210EE67;
        Tue,  9 Mar 2021 13:03:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F7A310EE64;
        Tue,  9 Mar 2021 13:03:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: [ANNOUNCE] Git v2.30.2 and below for CVE-2021-21300
Date:   Tue, 09 Mar 2021 10:03:06 -0800
Message-ID: <xmqqim6019yd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B419642C-8101-11EB-BAB4-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The latest maintenance release Git v2.30.2, together with releases
for older maintenance tracks v2.17.6, v2.18.5, v2.19.6, v2.20.5,
v2.21.4, v2.22.5, v2.23.4, v2.24.4, v2.25.5, v2.26.3, v2.27.1,
v2.28.1 and v2.29.3, is now available at the usual places.

These maintenance releases are to addresses the security issues
CVE-2021-21300.  Please update.

The credit for these releases all goes to Matheus Tavares and
Johannes Schindelin.  I didn't have to do anything but tagging their
result, cutting releases, and sending out this announcement.

The tarballs are found at:

    https://www.kernel.org/pub/software/scm/git/

The following public repositories all have a copy of the 'v2.30.2'
tag and the 'maint' branch that the tag points at:

  url = https://kernel.googlesource.com/pub/scm/git/git
  url = git://repo.or.cz/alt-git.git
  url = https://github.com/gitster/git

----------------------------------------------------------------

Git v2.30.2 Release Notes
=========================

This release merges up the fixes that appear in v2.17.6, v2.18.5,
v2.19.6, v2.20.5, v2.21.4, v2.22.5, v2.23.4, v2.24.4, v2.25.5,
v2.26.3, v2.27.1, v2.28.1 and v2.29.3 to address the security
issue CVE-2021-21300; see the release notes for these versions
for details.

----------------------------------------------------------------

Git v2.17.6 Release Notes
=========================

This release addresses the security issues CVE-2021-21300.

Fixes since v2.17.5
-------------------

 * CVE-2021-21300:
   On case-insensitive file systems with support for symbolic links,
   if Git is configured globally to apply delay-capable clean/smudge
   filters (such as Git LFS), Git could be fooled into running
   remote code during a clone.

Credit for finding and fixing this vulnerability goes to Matheus
Tavares, helped by Johannes Schindelin.
