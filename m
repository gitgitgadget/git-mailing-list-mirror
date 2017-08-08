Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7D8A620899
	for <e@80x24.org>; Tue,  8 Aug 2017 16:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752169AbdHHQ5L (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 12:57:11 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59732 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752092AbdHHQ5K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 12:57:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DFE5C91443;
        Tue,  8 Aug 2017 12:57:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WmaEJhPHo/z0H8T8TY1TiDQWqVw=; b=oxOQKh
        AY0BseWjAdeIKZ/7b6NcmMR+yrR9t4KfuEWH3Xg1tpNG3BjsEoxe8HNu4PcBJx0m
        fa9UuuPt/7wPCVFUUCtLBjIS3eEzjpT4WzX8r/QYbjPJwmeDx/X/1pr53pq39xPb
        TYkT0fpFNc48J0Sh3SxMOO0lQJSAUxwMo1Rxo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UocRpU9rvCqGpv+7z8rJhTraPdA0cT7A
        JScho7fTmvIRvWKC+JfpxpS9oSZ+6MHzvHfmRKKb6Fb84CypMhP6bCxQxqMowvKy
        L6lk0F3dhFl6BZAw5Rlw1qzcf981lI28tp8XvqXijMWZBTbVE9rR+/yTvedIhofr
        CJTiqFii0pI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D6C8891442;
        Tue,  8 Aug 2017 12:57:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 47FF991441;
        Tue,  8 Aug 2017 12:57:02 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org, Urs Thuermann <urs@isnogud.escape.de>
Subject: Re: [PATCH] git svn fetch: Create correct commit timestamp when using --localtime
References: <ygf8tiyx480.fsf@tehran.isnogud.escape.de>
        <xmqqlgmvni8x.fsf@gitster.mtv.corp.google.com>
        <20170808024239.GA2915@starla>
Date:   Tue, 08 Aug 2017 09:57:00 -0700
In-Reply-To: <20170808024239.GA2915@starla> (Eric Wong's message of "Tue, 8
        Aug 2017 02:42:39 +0000")
Message-ID: <xmqqfud2c80z.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 998C1E4C-7C5A-11E7-9BF7-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> Urs Thuermann <urs@isnogud.escape.de> writes:
>> 
>> > In parse_svn_date() prepend the correct UTC offset to the timestamp
>> > returned.  This is the offset in effect at the commit time instead of
>> > the offset in effect at calling time.
>> >
>> > Signed-off-by: Urs Thuermann <urs@isnogud.escape.de>
>> > ---
>> >  perl/Git/SVN.pm | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> Thanks; sounds sensible.  
>> 
>> Eric?
>
> Yep, seems alright.  Can you apply directly?
> Been a bit preoccupied as of late.  Thanks.

Surely, I'll just add your Reviewed-by: myself ;-)

Thanks.
