Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA5CE732E9
	for <git@archiver.kernel.org>; Thu, 28 Sep 2023 20:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjI1USy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Sep 2023 16:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjI1USx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Sep 2023 16:18:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E97194
        for <git@vger.kernel.org>; Thu, 28 Sep 2023 13:18:51 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2FD8D28E1E;
        Thu, 28 Sep 2023 16:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=p/fseuXQvDLgLIiEwNYfpjemW8IfPxy6MPaF/r
        qNz7U=; b=SNbfCB4v22Q41S5sdIXh8ydqMDZ6R9owz4wvVrNvkJ7PZxpFgzQxSP
        9UeEIn9qylTNk2kDyAVG3EW1V7wsWf4m5Ym48L7m9dbsjUuqNh7MYm21im+MTPGy
        2clMdSRAEK2MpDGZzXHs9dalmmnSatrknJ7dZXC27eOhGzo6ownVo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 282BF28E1C;
        Thu, 28 Sep 2023 16:18:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A483F28E1B;
        Thu, 28 Sep 2023 16:18:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Eric W. Biederman" <ebiederm@gmail.com>
Cc:     git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
In-Reply-To: <xmqqfs2zl2iy.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        27 Sep 2023 14:39:01 -0700")
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
        <20230927195537.1682-21-ebiederm@gmail.com>
        <xmqqfs2zl2iy.fsf@gitster.g>
Date:   Thu, 28 Sep 2023 13:18:46 -0700
Message-ID: <xmqqbkdmjbkp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3B0E464A-5E3C-11EE-BFFA-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Eric W. Biederman" <ebiederm@gmail.com> writes:
>
>> diff --git a/setup.c b/setup.c
>> index deb5a33fe9e1..87b40472dbc5 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -598,6 +598,25 @@ static enum extension_result handle_extension(const char *var,
>>  		}
>
> This line in the pre-context needed fuzzing, but otherwise the
> series applied cleanly on top of v2.42.0.
>
>> Subject: Re: [PATCH 21/30] repository: Implement extensions.compatObjectFormat
>
> "Implement" -> "implement" (many other patches share the same
> problem, none of which I fixed while queueing).


The topic when merged near the tip of 'seen' seems to break a few CI
jobs here and there.  The log from the broken run can be seen at

    https://github.com/git/git/actions/runs/6331978214

You may have to log-in there before you can view the details.

Thanks.

