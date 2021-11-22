Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D11DC433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 17:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhKVRkZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 12:40:25 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65336 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239939AbhKVRkY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 12:40:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1D458107837;
        Mon, 22 Nov 2021 12:37:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=v
        A76S8D9zI8qU/6hYZ+qmt3+sE7B2mwyCb9RNoGd7/E=; b=uDK5kpPHCYyVDeCu3
        /wvN76ddDH9Ge4SO0m5zqjlzZ56iChl3H2irALR5n25dvcsoRANm4Y2tPdjBv+/M
        xbfSd0UkmkjvUadAaYQfum852LmkECQQUhSE4yDTpggMO62BvMv14HMu4f0h3ef9
        5zku1M2UHO5XzeVfq5nXxzoqVM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 146C0107836;
        Mon, 22 Nov 2021 12:37:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AB36107835;
        Mon, 22 Nov 2021 12:37:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: preparing for 2.34.1
Date:   Mon, 22 Nov 2021 09:37:15 -0800
Message-ID: <xmqqr1b8gkhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5CB8A30-4BBA-11EC-ABBC-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a few topics [*] to fix regressions introduced in the
previous cycle, which should be in 2.34.1 and I've merged them to
'master'. I hope we can merge them to 'maint' (which now point at
2.34) and tag 2.34.1 in a few days.

After that, in yet another few days, we will see most of the stalled
topics ejected from the tree, the tip of 'next' rewound, and we will
start the cycle toward 2.35 by starting to take new topics, by the
beginning of the next week at the latest.

Thanks.



* ab/update-submitting-patches (2021-11-13) 1 commit
  (merged to 'next' on 2021-11-19 at b44f4d0eb0)
 + SubmittingPatches: fix Asciidoc syntax in "GitHub CI" section

 Doc fix.


* ev/pull-already-up-to-date-is-noop (2021-11-18) 1 commit
  (merged to 'next' on 2021-11-19 at 2d8f0cd000)
 + pull: should be noop when already-up-to-date

 "git pull" with any strategy when the other side is behind us
 should succeed as it is a no-op, but doesn't.


* hm/paint-hits-in-log-grep (2021-11-19) 1 commit
  (merged to 'next' on 2021-11-19 at e146d25c7c)
 + Revert "grep/pcre2: fix an edge case concerning ascii patterns and UTF-8 data"

 "git grep" looking in a blob that has non-UTF8 payload was
 completely broken when linked with certain versions of PCREv2
 library in the latest release.


