Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 905ACC433EF
	for <git@archiver.kernel.org>; Wed,  6 Apr 2022 17:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238685AbiDFRSx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Apr 2022 13:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238776AbiDFRSN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Apr 2022 13:18:13 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228E845C205
        for <git@vger.kernel.org>; Wed,  6 Apr 2022 08:14:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4799712F957;
        Wed,  6 Apr 2022 11:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hc2acSWOb7q0dyxyNI5qFOew8JDm3H/isYIvJZ
        O+caI=; b=ni/aUmHNwufysIBd4DqK9+3UE6Zt4VEkhvs44YDjjFT1HHAeIR4yuH
        Ca3hYQYFPZV8LPS1MSjfE9CHqTrfFok037v9oF8vyjJF/sxaWGYMyXT5YShtmZRk
        DdHRky5rV0RJw/TUjTc9H3xX7An/EpZ0DFxl1SKrH8OrWhsQN5pBI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3C79612F956;
        Wed,  6 Apr 2022 11:14:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 965B712F955;
        Wed,  6 Apr 2022 11:14:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        whydoubt@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v2] blame: report correct number of lines in progress
 when using ranges
References: <20220404182129.33992-1-eantoranz@gmail.com>
        <b2f5d6af-8da1-3a3a-cc21-848c14a8fb98@gmail.com>
        <8622e48c-9f34-c644-4016-02c3795ac1e9@iee.email>
Date:   Wed, 06 Apr 2022 08:14:42 -0700
In-Reply-To: <8622e48c-9f34-c644-4016-02c3795ac1e9@iee.email> (Philip Oakley's
        message of "Tue, 5 Apr 2022 10:42:41 +0100")
Message-ID: <xmqqsfqq1bx9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49AFA7F4-B5BC-11EC-8CB7-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> On 05/04/2022 08:34, Bagas Sanjaya wrote:
>> On 05/04/22 01.21, Edmundo Carmona Antoranz wrote:
>>> When using ranges, use their sizes as the limit for progress
>>> instead of the size of the full file.
>>
>> The progress limit is defined by number of affected lines, right?
>
> I'd also wondered about 'their', thinking it was 'the files', rather
> than 'the ranges' [within those files].
>
> perhaps: s/their/range/

I actually think that it is obvious that "their" refers to the
ranges and not the file.  Between "the ranges" and "the file", only
the former is plural that "their" could possibly refer to.  Also,
"instead ... the full file" makes the sentence nonsensical if it
referred to the "file"---"we must use the number of lines in the
file, instead of the number of lines in the file" simply would not
make much sense.

But I do not object to being more explicit.

> "When using ranges, use the range sizes as the limit for progress' ..
