Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC226C433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D311207F9
	for <git@archiver.kernel.org>; Wed, 20 May 2020 14:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="RsQjqZxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgETOiA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 10:38:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59138 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETOiA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 10:38:00 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 24BC4D0D35;
        Wed, 20 May 2020 10:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=on2PapjKlAGLCEZuIa1E1vDX8Gs=; b=RsQjqZ
        xzP0gFqHQFTN/j3+fpmSb6QPzFoeLOdOARYS3+JMPUJdfiXvF324TAbR2ghT3x1+
        YSbiHnXNYJSZbW1aZNQ42XcrHtcS/wD51+XysBG7p92SZ6Onw0Xr+Pcq1U5WO8r0
        b45YrVlGqBAnFe/w/pvY9TfZztNk6meTrsrlc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lEITUuq4/7R91DrmLjuDZ2BhwvDWQoCO
        j4UuzOzpbGwN3Ivql+m3LzJ67yPsumuh+pBuEnDo54F/0dDceG+QcjN/kaYu2Dx4
        ol1nNnbuYIquXYYdID6OLcn9I4ZYmDj86xLW1ragCsgwll3tLnexgecvOgRMNawq
        9fmIH+MOjj0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C22ED0D34;
        Wed, 20 May 2020 10:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3F9A3D0D32;
        Wed, 20 May 2020 10:37:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [ANNOUNCE] Git v2.27.0-rc0
References: <xmqqy2punll7.fsf@gitster.c.googlers.com>
        <CA+kUOanbgUPgCer-sBjX6YROYvZAhzBTUtCnFvuYP1EWvo3VEA@mail.gmail.com>
        <xmqqwo57y0i5.fsf@gitster.c.googlers.com>
        <CA+kUOam31cLNftUx6rGz=bdpjo5Dqv_ahJ6jUnD8OGq6P6Ra3w@mail.gmail.com>
Date:   Wed, 20 May 2020 07:37:53 -0700
In-Reply-To: <CA+kUOam31cLNftUx6rGz=bdpjo5Dqv_ahJ6jUnD8OGq6P6Ra3w@mail.gmail.com>
        (Adam Dinwoodie's message of "Wed, 20 May 2020 15:14:17 +0100")
Message-ID: <xmqq8shmy8n2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7E060214-9AA7-11EA-B847-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> On Wed, 20 May 2020 at 00:21, Junio C Hamano <gitster@pobox.com> wrote:
>> Adam Dinwoodie <adam@dinwoodie.org> writes:
>>
>> >>       tests: when run in Bash, annotate test failures with file name/line number
>> >
>> > At least on Cygwin, this breaks the test output parsing of failures
>> > when running with prove.
>>
>> We'll revert this problematic topic out (which hasn't happened yet),
>> which I hopefully will be able to merge to 'master' before tagging
>> the -rc1 release candidate.
>>
>> If possible, could you test the result of merging e31600b0 (Revert
>> "tests: when run in Bash, annotate test failures with file name/line
>> number", 2020-05-15) into 'master'?
>
> I get a merge conflict due to 303775a25f ("t/test_lib: avoid naked
> bash arrays in file_lineno", 2020-05-07), but resolving that in the
> obvious fashion and the test summaries are working as expected again.

Wonderful.  Thanks.
