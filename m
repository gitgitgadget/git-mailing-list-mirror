Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 507A8C433DB
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2763261493
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 17:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhBKRVj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 12:21:39 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:65241 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232228AbhBKRUR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 12:20:17 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E8DD211D29A;
        Thu, 11 Feb 2021 12:19:30 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jFOEQ0aAvGF7zhAZGnw+ZFAbR3Q=; b=ShvLRX
        UPMPgRGjq+yPSZcg7i+S/07j4nwUuPDWOmcadgMnsg6AZv319k9cyamVY1lxVEx4
        +QkRZtIaHlhceP9/Fuyze8ud8H/qVVRsjXNRCv2Sbt4upMAcexLUTScPFhkVCCbk
        AXLT8KF1t8oFFYS3IHYUFi2sRMsdK21ImW0EY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cPxkOXanh3ylFmU+Sec8X/NxZFYQm+Ri
        rhZXuBftRTh2qtEhKUclN+A2DuKZpqU+/eRo9Z0vJpkhxGoCzFAaMLvZDN6CfTfR
        Yswy1SwkLvcf6sfPDaetsFfeQkYqkIPYrhS1g/wftbUVF+YtzsMC8hBFN+n+n9pW
        JrVXc5zH3OE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D120911D298;
        Thu, 11 Feb 2021 12:19:30 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2262011D296;
        Thu, 11 Feb 2021 12:19:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Charvi Mendiratta <charvi077@gmail.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        christian.couder@gmail.com, phillip.wood123@gmail.com
Subject: Re: [PATCH v3 00/11][Outreachy] Improve the 'fixup [-C | -c]' in
 interactive rebase
References: <20210207181439.1178-1-charvi077@gmail.com>
        <20210210113650.19715-1-charvi077@gmail.com>
Date:   Thu, 11 Feb 2021 09:19:26 -0800
In-Reply-To: <20210210113650.19715-1-charvi077@gmail.com> (Charvi Mendiratta's
        message of "Wed, 10 Feb 2021 17:06:40 +0530")
Message-ID: <xmqqeehmy129.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BB90686-6C8D-11EB-BC8C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Charvi Mendiratta <charvi077@gmail.com> writes:

> This patch series is build on the top of "cm/rebase-i" in the 'next' branch and
> improves it. It fixup the source code of 'fixup [-C | -c]' command in the
> sequencer, do some fixes in rebase -i, improves the 'fixup_-C' like commands
> in lib-rebase.sh, update the test-script 't3437' and fixes a typo in the
> documentation.
>
> Changes from v2 :
> * Update the rebase-todo help
> * Remove the changes and resets to fixup_-* command
> * Update the documentation of FAKE_LINES
> * Move the changes of "unnecessary curly braces in test" to the other patch
>   (from v2-9/11 to v2-5/11)
>
> Thanks all for the suggestions.

Thanks.  Looking good.  Unless there is any other nits, let's
declare victory and merge the two topics down to 'next' and then to
'master' for the next release?
