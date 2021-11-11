Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAB2C433F5
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC2A61267
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234228AbhKKXtz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:49:55 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58170 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229952AbhKKXtz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 18:49:55 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0FED0E3782;
        Thu, 11 Nov 2021 18:47:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Un1Rr77hE2QkvypsR6Tn+rbk/o+NBuWQhZ1k8Z
        IkT3M=; b=q7DgctB15eUd1ODKn6Gvll1x8ILKpT2JXqQ/YnWapGqvTo2SmbItp5
        O2kzxzLp9RzwPq19CRuYa595OWgP+oXAL7ebMV7d4RW0sXKDi4P/hP46lvCzldPQ
        DMzqvxJ9mZaYH8mh3EKRx3C8DS8GCZMoUSgXsj7tGpbCxlpIADITQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CAA8CE3780;
        Thu, 11 Nov 2021 18:47:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CAE90E377F;
        Thu, 11 Nov 2021 18:47:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] trace2: increment event format version
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
        <xmqqh7cijnwx.fsf@gitster.g> <YY2h5lO90vo3Dy42@google.com>
Date:   Thu, 11 Nov 2021 15:47:01 -0800
In-Reply-To: <YY2h5lO90vo3Dy42@google.com> (Josh Steadmon's message of "Thu,
        11 Nov 2021 15:06:14 -0800")
Message-ID: <xmqqczn6jlvu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB5FA872-4349-11EC-9B7C-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> On 2021.11.11 15:03, Junio C Hamano wrote:
>> Josh Steadmon <steadmon@google.com> writes:
>> 
>> > In 64bc752 (trace2: add trace2_child_ready() to report on background
>> > children, 2021-09-20), we added a new "child_ready" event. In
>> > Documentation/technical/api-trace2.txt, we promise that adding a new
>> > event type will result in incrementing the trace2 event format version
>> > number, but this was not done. Correct this in code & docs.
>> >
>> > Signed-off-by: Josh Steadmon <steadmon@google.com>
>> > ---
>> >  Documentation/technical/api-trace2.txt | 4 ++--
>> >  trace2/tr2_tgt_event.c                 | 2 +-
>> >  2 files changed, 3 insertions(+), 3 deletions(-)
>> 
>> Hmph, it seems to me that this is better done before the release,
>> or am I mistaken?
>
> Ideally yes, although I am not sure if there is anyone using traces who
> strongly depends on the accuracy of the evt field.

Relieving us from having to keep track of the actual users is the
point of documenting to making promises ;-)

> For release-blocking
> fixes (for lack of a better term), should I have sent this patch
> differently?

I do not think so.

Thanks.
