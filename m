Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E545CC433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 19:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236421AbiADTAq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 14:00:46 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54931 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbiADTAp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 14:00:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA6FB1755D1;
        Tue,  4 Jan 2022 14:00:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sL6Zkex6ORmkAVkRcZprZeC64gyQ81t5dK1fpZ
        SLxes=; b=tRl2WJn+EpQV9zJRRd2JMMWsPxhgVRkG0CxqEeFI6Y0NnaC/tCxaUh
        vnOwJf+UodaI+WZHd1oLK/lTI8Q7TYy/6LM57FqBMaYqsoAn0u2F1hoTEWRE+HtR
        AoPu31TmwDtD3OnKneTeTiYWRB60YZU0sl/brXNnUxs57CEQFk8gY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E1F811755D0;
        Tue,  4 Jan 2022 14:00:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 086281755CE;
        Tue,  4 Jan 2022 14:00:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v3 1/2] name-rev: deprecate --stdin in favor of
 --annotate-text
References: <pull.1171.v2.git.git.1640759021.gitgitgadget@gmail.com>
        <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
        <55ec2a5fa3e748b7e5f9ef871214563ba2b28adf.1641221261.git.gitgitgadget@gmail.com>
        <77e18a78-ddfe-0337-deaf-bb9dfb63a495@iee.email>
Date:   Tue, 04 Jan 2022 11:00:39 -0800
In-Reply-To: <77e18a78-ddfe-0337-deaf-bb9dfb63a495@iee.email> (Philip Oakley's
        message of "Tue, 4 Jan 2022 13:25:12 +0000")
Message-ID: <xmqqo84re36w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C8789C0-6D90-11EC-B80F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

>>  --stdin::
>> +	This option is deprecated in favor of 'git name-rev --annotate-stdin'.
>> +	They are functionally equivalent.
>> +
>> +--annotate-stdin::
>>  	Transform stdin by substituting all the 40-character SHA-1
>>  	hexes (say $hex) with "$hex ($rev_name)".  When used with
>>  	--name-only, substitute with "$rev_name", omitting $hex
>> -	altogether.  Intended for the scripter's use.
>> +	altogether.
>
> Is there a preferred order for the old/new variant documentation?

If the surrounding list has a natural order of its own, e.g.  the
list is sorted alphabetically to help people locate an item by name,
it is OK to have old and new in that order and older one may appear
before the newer one.

But otherwise it may make sense to show the newer one first with the
mention of the older one as if it were a side note, especially when
they can appear next to each other like the one we are looking at, I
would think.

I do not think we have written preference.  It probably would help
to have a short paragraph in the coding guidelines document.

Thanks.


