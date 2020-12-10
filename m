Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519B8C4361B
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24134239FD
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 01:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731588AbgLJBFG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 20:05:06 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58745 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbgLJBE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 20:04:57 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 736941122D5;
        Wed,  9 Dec 2020 20:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=NWSYsCnECfA1K5Pr+7n29733oUg=; b=qTS4Cr
        TA+j8dXzF9iA6sCxJ/Ehh1EZ6DA3UBCGRznNzjlhyZK5rJFGEgjhHg/YMXZeN84b
        KPBc3/fhRICQ94Ru+HJ5Zp16bSDAQmKLJTac5tlS7MZcXUhOo9grEoQHrHGeSfJw
        15fhXOyOIqilNlyMnY+dZCOotOpCnX8sesWeU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j+EnPnzxrH+L0R0/FhkMirakE28nw8BX
        MTApJNCscrtts+wbm3b/iW3H92WpMlzL95aEDG/JjcE7sQBjsPXmOmRZIqsCVSmx
        5zXPgOGxM7TDAVWy3eAtfp1cQjxnBalOrHrW3T0LkDrIZlG7xIneJQgU8kxTx8lv
        vty5ELGt7vE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C2591122D4;
        Wed,  9 Dec 2020 20:04:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B71EB1122D2;
        Wed,  9 Dec 2020 20:04:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/4] Maintenance IV: Platform-specific background
 maintenance
References: <pull.776.v5.git.1606191405.gitgitgadget@gmail.com>
        <pull.776.v6.git.1607542142.gitgitgadget@gmail.com>
        <xmqqpn3izeit.fsf@gitster.c.googlers.com>
        <CAPig+cSciupmmupdgynfBO98EFke5fneC5W+k2vCo9Zkh3KF5w@mail.gmail.com>
Date:   Wed, 09 Dec 2020 17:04:12 -0800
In-Reply-To: <CAPig+cSciupmmupdgynfBO98EFke5fneC5W+k2vCo9Zkh3KF5w@mail.gmail.com>
        (Eric Sunshine's message of "Wed, 9 Dec 2020 19:49:27 -0500")
Message-ID: <xmqq5z5azd2r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E67B1CA-3A83-11EB-B83C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Dec 9, 2020 at 7:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> > Update in V6
>> > ============
>> >
>> >  * The Windows platform uses the tempfile API a bit better, including using
>> >    the frequency in the filename to make the test simpler.
>>
>> Are two fix-up patches from Eric that have been queued near the top
>> of ds/maintenance-part-4 still relevant?
>
> Both of the patches from Sunshine are still relevant atop Stolee's
> latest (v6), and they should apply cleanly (I would think) since v6
> didn't change anything related to those patches.

Yup, I tried rebasing these two and they applied cleanly, so I'll
include them in today's pushout (which I haven't finished yet).

I probably would not notice if the updated 4-patch series already
solved the issue in another way without causing the textual conflict
with your two fix-up patches, though ;-)

Thanks.


