Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED2AC433E0
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:18:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56D022571
	for <git@archiver.kernel.org>; Thu, 24 Dec 2020 06:18:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgLXGSJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Dec 2020 01:18:09 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51105 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgLXGSI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Dec 2020 01:18:08 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A19ED11BB56;
        Thu, 24 Dec 2020 01:17:26 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rPKjxKhBiqELr46D8jKoeX7APLI=; b=MWzcVe
        FR6cfhLfmn1T/biL0YKkdpZXbMwdtgm6d4PjBNXHKScdch8qOQ5iLe1ybZG7ll+U
        2XPQUpM64iI0sNByVcxslU642njD6s/+p4kS9nX8RF36QmpSysgW9bp6BRYiK33n
        6LeWlCfl06H6/8qptG8yoNda2he8xmuEo+0jI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AybXaErCWLMa4UPe6AMplPMiwIL/JYWp
        sJQgAU4vBdSvkh8Uxk0a4XWaWk8S7dGW4d1OWLHs2mohZVmUlMeR8U8F7a0c8ZpS
        SC0C5oao/OkA54lqc0gBSdgG/dtAgJ1o9x8rtTpAtYy47jwysctJcttvtb6CzC88
        dCBIbMwu0dM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 86B8011BB55;
        Thu, 24 Dec 2020 01:17:26 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D5B8411BB54;
        Thu, 24 Dec 2020 01:17:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Seth House <seth@eseth.com>
Subject: Re: [PATCH v5 1/1] mergetool: add automerge configuration
References: <20201223045358.100754-1-felipe.contreras@gmail.com>
        <20201223045358.100754-2-felipe.contreras@gmail.com>
        <xmqqblekabof.fsf@gitster.c.googlers.com>
        <5fe352e3968f6_198be2083@natae.notmuch>
        <xmqqblek8e94.fsf@gitster.c.googlers.com>
        <5fe3dd62e12f8_7855a2081f@natae.notmuch>
        <xmqqv9cs3uxo.fsf@gitster.c.googlers.com>
        <5fe3f083f27cd_7855a20885@natae.notmuch>
Date:   Wed, 23 Dec 2020 22:17:22 -0800
In-Reply-To: <5fe3f083f27cd_7855a20885@natae.notmuch> (Felipe Contreras's
        message of "Wed, 23 Dec 2020 19:36:03 -0600")
Message-ID: <xmqqim8r4tjh.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AFF9BE2E-45AF-11EB-9EAD-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Yup, I already mentioned UI mistake so you do not have to repeat
>
> You said it was a UI mistake, not me. I am a different mind than yours.

Yes, but the point is that I do not need to nor particularly want to
hear your opinion on the behaviour of "git merge-file".  I know (and
others reading the thread on the list also know) that the exit code
of the command is misdesigned already.

> I communicated that fact after you, so I did not repeat anything,
> because I hadn't said that before. *You* did, not *me*.

Again, please realize that on list discussion is a team effort to
come up together a better design of a shared solution.  And if you
already know that (I don't read your mind ;-), please act like you
do, too.

Thanks.

