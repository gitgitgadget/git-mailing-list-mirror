Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BDC433B4
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 01:11:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E070E6121E
	for <git@archiver.kernel.org>; Wed, 14 Apr 2021 01:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233061AbhDNBMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 21:12:05 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53637 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbhDNBME (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 21:12:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 03113125610;
        Tue, 13 Apr 2021 21:11:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=O
        5FkjA/scoOvjtxgE85aBtkipng=; b=T0kpSqtR2cp0H1EWb3rJBp8yWZpfAYfuP
        CTqnnDE6KyVzep1raVo5W0gK9I9aNDki4ngJxImn1xNyVsLklRXfXsnHeyhaC7dS
        qnsn5Im8KRTWH5QUylyDAC9s9DBLvN8l78eHKbXiWtkZTc0Z9N+qPe/5/EtTdYJr
        xGEJYGq7wc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :date:message-id:mime-version:content-type; q=dns; s=sasl; b=bub
        1cT24a0YLLqF4ARuYe5C3ZPMRSv9TggHPHZqOW9IVKsgTe97G0HQdLi9MMo3rs9N
        HdWwNk+2EBtC+iK8+IkCy10oQHej5FB8FsczdjySyTgK88I55im4cV3j7asOLBOR
        amiOWNiYlbjTvAzCns0dJ/uHpLc1qGaMxJuKN6PU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id F095712560F;
        Tue, 13 Apr 2021 21:11:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3D2FC12560E;
        Tue, 13 Apr 2021 21:11:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: What's cooking (draft for #4's issue this month)
Date:   Tue, 13 Apr 2021 18:11:39 -0700
Message-ID: <xmqqmtu1zn3o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5EC52B40-9CBE-11EB-B87E-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A handful of topics have been merged to 'master' as the 9th batch of
this cycle.

    54a3917115 The ninth batch
    e0d4a63c09 Merge branch 'vs/completion-with-set-u'
    e6545201ad Merge branch 'ab/detox-config-gettext'
    a9414b86ac Merge branch 'gk/gitweb-redacted-email'
    8446b388b1 Merge branch 'cc/test-helper-bloom-usage-fix'
    2279289e95 Merge branch 'ab/send-email-validate-errors'
    4c6ac2da2c Merge branch 'tb/precompose-prefix-simplify'
    1d5fbd45c4 Merge branch 'fm/user-manual-use-preface'
    7b55441db1 Merge branch 'ab/perl-do-not-abuse-map'
    0623669fc6 Merge branch 'tb/pack-preferred-tips-to-give-bitmap'
    f63add4aa8 Merge branch 'jk/ref-filter-segfault-fix'

And a few topics have been merged to 'next'.

    cdadb2c621 Merge branch 'hn/reftable-tables-doc-update' into next
    bbe18a7b3a Merge branch 'jk/pack-objects-bitmap-progress-fix' into next
    41713a32bd Merge branch 'ah/merge-ort-ubsan-fix' into next
    35fb0e853d Merge branch 'ab/userdiff-tests' into next
    eb80d55a8c Merge branch 'ar/userdiff-scheme' into next

On 'seen' there are many topics that have not seen adequately
reviews; some tests are broken near its tip (I think they pass the
selftests by themselves).

    0e76df05ca Merge branch 'ps/rev-list-object-type-filter' into seen
    956fbceb2e ### breaks 6112 6113
    c007303ad4 Merge branch 'bc/hash-transition-interop-part-1' into seen
    4813f16161 ### breaks 0031

