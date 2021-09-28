Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176CBC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:22:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED69E611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 16:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241733AbhI1QXu (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 12:23:50 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56239 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241662AbhI1QXu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 12:23:50 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5337A15EAB8;
        Tue, 28 Sep 2021 12:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4PT1Zc+xiAFB8N4hLoGuP5wdE8BZ8LL4UszFUj
        AdrII=; b=dAF3d29sC0h6NkwXLAC+vrnl6YG+97GPymp/+z+7Kdf6k60N+Ldo86
        8koiKhdvQ9Kw5vqiPLf2fJJVcH+REHdsXz0Ekm35crUfOjsGJVBxVC8pziI5BOzV
        7/v9JddBZSaA0XOgMViNGdMzWxdxh/x5eeGhxwGoNLoKQ9gC5h16M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CA9915EAB5;
        Tue, 28 Sep 2021 12:22:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA93715EAAF;
        Tue, 28 Sep 2021 12:22:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     "Dr. Matthias St. Pierre" <Matthias.St.Pierre@ncp-e.com>,
        git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH] blame: document --color-* options
References: <d918fe0de6b04d8d848050d4aedbe060@ncp-e.com>
        <20210925121817.1089897-1-bagasdotme@gmail.com>
        <xmqq5yulregh.fsf@gitster.g>
        <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com>
Date:   Tue, 28 Sep 2021 09:22:06 -0700
In-Reply-To: <fe78329d-07a7-bdf3-2bda-13def35f3de3@gmail.com> (Bagas Sanjaya's
        message of "Tue, 28 Sep 2021 12:43:13 +0700")
Message-ID: <xmqq4ka4n00h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 39A857B8-2078-11EC-B068-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> On 28/09/21 02.44, Junio C Hamano wrote:
>> Nowhere in "git blame --help" output we mention anything about
>> "metadata", so the readers of this new description will be left
>> puzzled what the word means in the context of this command.
>> We would need to pick words or phrases that readers can link easily
>> with the description of "THE PORCELAIN FORMAT" section.
>
> In git-blame(1), we only describe output format for "THE PORCELAIN
> FORMAT" as well as "INCREMENTAL OUTPUT", but not default format.
>
> On the other hand, --color-* options only works on default format, not
> the others.

Sorry for skipping a level of logical progression in the suggestion.

While I do not think we want to add another section for the default
format, if we were to add such a section, the new description should
use phrases that would have been used, and such a section would not
use a new and unclear "metadata" in the description.  Instead it
would use phrases that the users can look for elsewhere in the same
documentation.

What is colored is the summary of the commit the line came from
(abbreviated commit object name, plus the author name and time by
default) plus the line number, I think.

Thanks.
