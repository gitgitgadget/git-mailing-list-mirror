Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA3C433E0
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A6C1207F9
	for <git@archiver.kernel.org>; Wed, 20 May 2020 23:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jwAOJzPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETX4Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 19:56:25 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50120 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgETX4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 19:56:25 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 38019D4F6C;
        Wed, 20 May 2020 19:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=/0rZskIkD3MFHp0B1hhXnQS0e8U=; b=jwAOJz
        PO8yDdR9evvXjLRvPKdkZpVzEHT7PcrVmtS7uIf4icxs56yGVELhTIEW0X5gkRHF
        Ik1ljFLl6czeI0WhMoIjjuld1KNnP6BRWE4oXUd/4wjQ1IkEfiSjuQnnAXCHEHaq
        N3+7c/HP0juEGUrYVFrjhe8iVJUWDHzEq80G4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lxk94fy13WxO/hG+GJY3B2xLVw5NEEJy
        lUGFmJOVmgznlrrQ3fnoTJAioRrxxI9qtlU77YDO/7i3V8lOqSx9aVCqLb6l004y
        basf0ykCTMVGCKMsjxJbL6/zNpl9aMvKp5XgzjGNnpp73lRUAClZmyUnDZlzNhnO
        alDYNDJitKI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 301AED4F6B;
        Wed, 20 May 2020 19:56:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 73FDAD4F69;
        Wed, 20 May 2020 19:56:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: How do Git on Linux users launch/read the user-manual?
References: <8142f64b-9b5e-3637-21a2-3671dd65a42e@iee.email>
        <xmqqtv0athz5.fsf@gitster.c.googlers.com>
        <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email>
Date:   Wed, 20 May 2020 16:56:18 -0700
In-Reply-To: <6dd15666-1e3e-e9b2-d98b-396d58f241cd@iee.email> (Philip Oakley's
        message of "Wed, 20 May 2020 22:50:24 +0100")
Message-ID: <xmqqpnaytb31.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80B01C9A-9AF5-11EA-9DF0-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> Hi Junio,
>
> On 20/05/2020 22:27, Junio C Hamano wrote:
>> Philip Oakley <philipoakley@iee.email> writes:
>>
>>> I can then browse that directory to find user-manual.html and open it
>>> from there (because I know it is there!).
>>>
>>> How do Git on Linux users launch/read the user-manual?
>> Start from the same starting point
>>
>> $ git help -w git
>>
>> and then navigate to the link to "Git User Manual"?
>>
> And then what? Is it always some .html viewer, or viewing the raw .txt
> file, or something else? (it isn't the man view..)

"git help -w" is showing stuff in the web browser, and when you open
git(1), which is rendered in HTML, and visit "Git User's Manual"
link in it, the experience would be no different from those viewing
via the browser on Windows---$(htmldir)/user-manual.html is where
the rendered HTML version of the user-manual is.

Or are you asking something else?

