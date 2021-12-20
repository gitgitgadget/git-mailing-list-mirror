Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82101C433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 15:55:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237686AbhLTPzl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 10:55:41 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56457 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237485AbhLTPzl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 10:55:41 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id BA12716DDE5;
        Mon, 20 Dec 2021 10:55:38 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=94hZxJTqW/7GkahRpwvO0yQtTLabxmlAyIalaD
        4LE1g=; b=Ha28tYAtZH5oB2K2W77ubJTewhLTJ/DiwNkbH232TLl9glGnBpI8c/
        GgRhmVh/30s4j4Q0Z1DhS6B0BFEqUo7pJbPEbuUTs/bja+o37ZWO9SuZewoVJvO7
        vWbAvKPbQkkp2VgPG4Ywe02DS0VCURxwFTf9jqDKP3vzlYTqpt5ZI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id B365416DDE2;
        Mon, 20 Dec 2021 10:55:38 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0FCE616DDDE;
        Mon, 20 Dec 2021 10:55:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] merge: allow to pretend a merge into detached HEAD is
 made into a branch
References: <xmqqbl1ezq5j.fsf@gitster.g> <87a6gyiamm.fsf@osv.gnss.ru>
Date:   Mon, 20 Dec 2021 07:55:33 -0800
In-Reply-To: <87a6gyiamm.fsf@osv.gnss.ru> (Sergey Organov's message of "Sat,
        18 Dec 2021 11:24:17 +0300")
Message-ID: <xmqq35mnz2x6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 44A8F7A0-61AD-11EC-A1BD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> ...
> consider to introduce something like "--into-name=<name>" instead, that
> will do this renaming unconditionally.

Excellent.

In the scenario I illustrated in the proposed log message, I used a
throw-away temporary working area to prepare the history for a real
branch, and detached HEAD is the perfect match for such a temporary
working area.  But it should not be a crime to use a real temporary
branch for such use case.

Thanks.
