Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E0AC433EF
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D65361056
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 23:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbhJUXTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 19:19:45 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53846 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbhJUXTo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 19:19:44 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A66B9163C74;
        Thu, 21 Oct 2021 19:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SVVp3ijZU/Xt
        gkzjKfNIXocL1CkmtnF1R1A8jMvKNH8=; b=drDAq4s/aY7AA9eeidVOcZ1Dduwc
        Xy7lkEi2LX2b+7D+bNqC2ivzATHcTl1UhKogmNYt1CXvnmAILqhdaNqnwnrEq0K3
        +ZFhPnDk2WRmIJzzVJKO+4msd1Y7QGWYsZc33ZUb6KvlvarGDlgoq2b6imRunwFr
        HZPgY32GtHpvtIQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9F5F5163C73;
        Thu, 21 Oct 2021 19:17:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0B71E163C72;
        Thu, 21 Oct 2021 19:17:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] git-sh-setup: remove "sane_grep", it's not needed
 anymore
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
        <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com>
Date:   Thu, 21 Oct 2021 16:17:23 -0700
In-Reply-To: <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Thu, 21 Oct
 2021 21:58:00 +0200")
Message-ID: <xmqqwnm6ge7w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D0DB126-32C5-11EC-AF0C-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> 2. The SANE_TEXT_GREP added in 71b401032b9 (sane_grep: pass "-a" if
>    grep accepts it, 2016-03-08) isn't needed either, none of these grep
>    uses deal with binary data.

For all other users, I think the above applies well, but the one in
filter-branch deals with end-user contents, so we cannot say
"contents of the tag cannot be binary".

Not that I care about filter-branch too deeply ;-)
