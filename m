Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD79202DD
	for <e@80x24.org>; Fri, 20 Oct 2017 01:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751352AbdJTBE1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Oct 2017 21:04:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62661 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751311AbdJTBE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Oct 2017 21:04:26 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C3311A037D;
        Thu, 19 Oct 2017 21:04:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PBcflsY2q2sL
        b+uVCvBDq9sO96k=; b=NlToEpccDh2jtdEQspD6jt+qIEzwtjy0AT6JSo3mAc2b
        MlYMnQcveX/1XKD8kaVACYe2yhm1sbaNwIwgfkQLCvamUoFnHI83fPsdbTA6/wRq
        IIS3lBt3/WTt4/ULW4Xf16wcFhAIAXZjVnOdaoWXthqUgojPWgr/2x4VKKR4cko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AxgSl/
        Wj09/W2aDLdoyxCdGqcVJfWPqntu7w+owFdlqAe1ciRrd8xlOnblGLluLUs1xVNE
        rUhWenHdi4u5UfVKyVHEhMlx+vWdGHJBAjLTGjkdjEJSL4EOwYFJNTsVl6jHsCUR
        w3knSuN5hoSVoAxcxaFd84i+pgBotG/m/Lc/I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B64A9A037C;
        Thu, 19 Oct 2017 21:04:25 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08494A037A;
        Thu, 19 Oct 2017 21:04:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Thomas Rikl <trikl@online.de>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [Alt. PATCH] ls-remote: deprecate -h as short for --heads
References: <63fe2a84-d991-9165-32c0-8087d8513ce6@online.de>
        <CAN0heSpPWWdWY4d1wCdRH8TjcmD3kAiSffL0-_9kJWkm5P2EkA@mail.gmail.com>
        <4d110305-0826-6fd1-91a5-c1ebd0b1e80b@web.de>
        <774f08bd-3172-0083-1544-e5f68f6798fa@web.de>
        <xmqqk1ztmkbn.fsf@gitster.mtv.corp.google.com>
        <26112a15-f02c-a910-c8bb-794ca84dc1e5@web.de>
        <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net>
Date:   Fri, 20 Oct 2017 10:04:23 +0900
In-Reply-To: <20171019203249.76uu3b6ferquitcr@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 19 Oct 2017 16:32:49 -0400")
Message-ID: <xmqqlgk6iq94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D5C3136-B532-11E7-B67D-8EF31968708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Oct 19, 2017 at 08:26:47PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-re=
mote.txt
>> index 5f2628c8f8..82622e7fbc 100644
>> --- a/Documentation/git-ls-remote.txt
>> +++ b/Documentation/git-ls-remote.txt
>> @@ -29,6 +29,9 @@ OPTIONS
>>  	These options are _not_ mutually exclusive; when given
>>  	both, references stored in refs/heads and refs/tags are
>>  	displayed.
>> ++
>> +*NOTE*: -h without any other parameters shows a short help text inste=
ad
>> +of any refs.
>
> Yuck. This "we only treat -h as special in certain cases" rule is
> sufficiently magical that I don't think we want to advertise and lock
> ourselves into it.

Hmph.  I think it is way too late to be worried about "locked into"
the convention---hasn't the "git cmd -h" been with us forever?

Besides, I personally feel that there is nothing magical in the rule
that is "we always treat 'git $cmd -h' as asking for short help, but
individual subcommand may choose to use -h for, perhaps to be
compatible with other tools and conventions, in other situations".
