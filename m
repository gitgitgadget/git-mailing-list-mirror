Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC2F6C433F5
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786A61164
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 16:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbhJOQic (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 12:38:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55159 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241451AbhJOQiS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 12:38:18 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4772EFEEEE;
        Fri, 15 Oct 2021 12:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Fy0cMewW16/h
        aQj62Nf3vUEJK4JW70j27ZxQedaw3g4=; b=G7ze4z+f9EsnVuSJzn3JFsJhhfuu
        X7ozz+sGcglBr4ekBqgSxskCnFSa0ZNa3jEqiOTiDmcXl2p/wa5NQu3gRhj6c2KX
        kv61S7qQahVUmPa37+pre5G5qbFAV3xYkKZGfGEySQlz+CEP13hc4KWokVRJgfNt
        dcNtVis/1KTQh2I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D7E2FEEED;
        Fri, 15 Oct 2021 12:36:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6222AFEEEC;
        Fri, 15 Oct 2021 12:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v3 1/2] "lib-diff" tests: make "README" and "COPYING"
 test data smaller
References: <cover-v2-0.5-00000000000-20211005T170031Z-avarab@gmail.com>
        <cover-v3-0.2-00000000000-20211015T092605Z-avarab@gmail.com>
        <patch-v3-1.2-02342124582-20211015T092605Z-avarab@gmail.com>
Date:   Fri, 15 Oct 2021 09:36:09 -0700
In-Reply-To: <patch-v3-1.2-02342124582-20211015T092605Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 15 Oct
 2021 11:30:16
        +0200")
Message-ID: <xmqqilxy8cue.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 00F8B154-2DD6-11EC-BFD9-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>  t/.gitattributes              |   1 -
>  t/lib-diff-data.sh            |  22 +++
>  t/lib-diff.sh                 |   2 +
>  t/lib-diff/COPYING            | 361 ----------------------------------
>  t/lib-diff/README             |  46 -----
>  t/t4003-diff-rename-1.sh      |   4 +-
>  t/t4005-diff-rename-2.sh      |   4 +-
>  t/t4007-rename-3.sh           |   5 +-
>  t/t4008-diff-break-rewrite.sh |   4 +-
>  t/t4009-diff-rename-4.sh      |   4 +-
>  10 files changed, 34 insertions(+), 419 deletions(-)
>  create mode 100644 t/lib-diff-data.sh
>  delete mode 100644 t/lib-diff/COPYING
>  delete mode 100644 t/lib-diff/README

Good.  Directly borrowing a test material from the source directory
was an easy hack that worked for us for a reasonably long time, but
when it started to become a maintenance burden, we should have done
something like this, instead of applying the same kind of laziness
when 459b8d22 (tests: do not borrow from COPYING and README from the
real source, 2015-02-15) tried to correct the mess that was caused
by earlier laziness.

Thanks.
