Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F9C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:47:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA526054E
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 06:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhKLGuJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 01:50:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55134 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbhKLGuH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 01:50:07 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DD7716830E;
        Fri, 12 Nov 2021 01:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rz8V4vH1Wigf
        n5GavJlGydOcq33BksQvto6qpCART2s=; b=QGGVleXoXK+qDVFaH5Kl+6Gfdvd2
        WOudJJUs3eV+Ml8LnZs9kQBvo9PJWtH6m+rzvInDLUe2XltAssN8UnzZ/+6MZmjk
        GcyQcPWSYjOhnyjpLYGHztLd30okjniT3p8iuT9MGjnuhrq3EYTQfIzRM8lisP7V
        BpSdaJeTq/EITuQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4683516830D;
        Fri, 12 Nov 2021 01:47:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD48416830C;
        Fri, 12 Nov 2021 01:47:14 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Aleen via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Aleen <aleen42@vip.qq.com>
Subject: Re: [PATCH 0/2] am: support --always option to am empty commits
References: <pull.1076.git.1636693095.gitgitgadget@gmail.com>
        <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de>
Date:   Thu, 11 Nov 2021 22:47:13 -0800
In-Reply-To: <6da5e984-1dcf-4c55-976c-49ffb8d128bf@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 12 Nov 2021 07:17:47 +0100")
Message-ID: <xmqqy25tj2fi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5ED21478-4384-11EC-BAA0-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 12.11.21 um 05:58 schrieb Aleen via GitGitGadget:
>> Since that git has supported the --always option for the git-format-pa=
tch
>> command to create a patch with empty commit message, git-am should sup=
port
>> applying and committing with empty patches.
>
> The symmetry is compelling, but "always" is quite generic.  I can see
> e.g. someone expecting "git am --always" to imply --keep-non-patch.

What symmetry?

> git commit and cherry-pick have --allow-empty, which is (a bit) more
> specific.  That seems to me a better option name to copy for a commit-
> creating command like git am.

That one I can believe, even though I do not necessarily think it is
a good idea to add such an option.
