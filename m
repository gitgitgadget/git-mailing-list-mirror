Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D7AC433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27D020756
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 00:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T9lJb7Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgHLAs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 20:48:28 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65080 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbgHLAs1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 20:48:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2AA3A86144;
        Tue, 11 Aug 2020 20:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Fds5FqZ0sFplkp5Rin7yQgCybBg=; b=T9lJb7
        Hre1wgCipTXcpuCg2uXOMPCMl9nKYeDG1L6RUIkpX8cGe735Jgsg6NAvZKbioofg
        xdQabWvjb4ObpUN4PwKxHVq/Akc/Kn1/p1eECyX8RNzZpm5ZKzEaVoIL4J/jRBR+
        /Ra/748vFlyLzWvy1KWRyWC1+VPLMsnXJ98WQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TMYS38V1i0A0Eidm8MAxx+wk1L2l6qxU
        k5/bcqDaNW1/DgEVm7IO25tulmJj2lSUSDbzyLp8L/X79YUWHigh7Px+slkS4OUA
        0c+wo2NPKmpAjZ5AqGEmJ06drFj8X3OWOfqWgbSZICuj6/LQHDrgAQgGopY6DaDZ
        Tmk5DxDPVPw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 226BE86143;
        Tue, 11 Aug 2020 20:48:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4C8686142;
        Tue, 11 Aug 2020 20:48:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH  2/3] doc/git-log: describe --diff-merges=off
References: <20200805220832.3800-1-sorganov@gmail.com>
        <20200805220832.3800-3-sorganov@gmail.com>
        <xmqq8sek917j.fsf@gitster.c.googlers.com>
Date:   Tue, 11 Aug 2020 17:48:22 -0700
In-Reply-To: <xmqq8sek917j.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 11 Aug 2020 17:06:56 -0700")
Message-ID: <xmqqzh707kq1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 868C369A-DC35-11EA-A2DC-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Sergey Organov <sorganov@gmail.com> writes:
>
>> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> ---
>>  Documentation/git-log.txt | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
>> index 9ccba65469d7..f3727c786453 100644
>> --- a/Documentation/git-log.txt
>> +++ b/Documentation/git-log.txt
>> @@ -145,7 +145,6 @@ combined-diff option or with `--no-diff-merges`).
>>  	rename or copy detection have been requested).
>>  
>>  -m::
>> ---diff-merges::
>
> Shouldn't this "--diff-merges" be removed from here?

Sorry, my eyes.  Yes, you are removing it from here.

All is well, then.
