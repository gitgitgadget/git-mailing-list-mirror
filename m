Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF51E20281
	for <e@80x24.org>; Sat, 23 Sep 2017 23:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751522AbdIWXwN (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 19:52:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50110 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751355AbdIWXwN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 19:52:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B852FB18EF;
        Sat, 23 Sep 2017 19:52:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rgokr5LERP3UCZwtM/e5QrSH8q0=; b=bw3xwU
        SuMhq74tjAFwfDad+cjeaM3w+yCZKgpqVNGyHQ7D6EG6k+QPbZOGNe7epXSCl25X
        WCOg/Le/E2kBefP7rSmjmKceBKd3zG8IwYEMlT1LLkARi9tK7Mtio4fBGZCfKuD7
        ZsrvJ4gu2BJ1JXougRIV9zktfJgYYLsCk5VpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uJ/mtGIpzkn9qMeP+dMc9EOnqPElEI3C
        VtVqYIpt1ueCAcLbA9xyir6ubXNY4Rja9vVwtE6jlPo0TOuPxcx1DVe80hmLsI5m
        Tx0Om6+MtrN9djidCCReU7UIDXR2aEc1xTZDGCDJ3IwDYa+c78F+JaVsUGychN/m
        uh4ZcJOd7LY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B1E96B18EE;
        Sat, 23 Sep 2017 19:52:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 20A33B18ED;
        Sat, 23 Sep 2017 19:52:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Subject: Re: [PATCHv2] Documentation/config: clarify the meaning of submodule.<name>.update
References: <20170922213740.GL27425@aiede.mtv.corp.google.com>
        <20170922225250.19705-1-sbeller@google.com>
        <20170922225855.GM27425@aiede.mtv.corp.google.com>
Date:   Sun, 24 Sep 2017 08:52:10 +0900
In-Reply-To: <20170922225855.GM27425@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Fri, 22 Sep 2017 15:58:55 -0700")
Message-ID: <xmqq1smxj7md.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 37F8110C-A0BA-11E7-BE34-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Stefan Beller wrote:
>
>> Reported-by: Lars Schneider <larsxschneider@gmail.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>>  Documentation/config.txt | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> Jonathan writes:
>
>>> You'll want to update Documentation/gitmodules.txt, too.
>>
>> No. /grumpycat
>>
>> It should already be fine, as I read it as if it is only relevant to 
>> "git submodule update" there, already:
>>
>>   submodule.<name>.update::
>> 	Defines the default update procedure for the named submodule,
>> 	i.e. how the submodule is updated by "git submodule update"
>> 	command in the superproject. This is only used by `git
>> 	submodule init` to initialize the configuration variable of
>> 	the same name. Allowed values here are 'checkout', 'rebase',
>> 	'merge' or 'none'. See description of 'update' command in
>> 	linkgit:git-submodule[1] for their meaning. Note that the
>> 	'!command' form is intentionally ignored here for security
>> 	reasons.
>
> I disagree.  Actually, I think the git-config(1) blurb could just
> point here, and that the text here ought to be clear about what
> commands it affects and how an end user would use it.

I tend to agree with the consolidation.  It's not like this patch
makes things worse, but as we've already diverted our attention to
this area and took time to review, if it is a simple update we can
make before we apply, that is better than having to remember and
come back to patch the result of this step further.

In any case, thanks for reporting, attempting to improve and
reviewing, all.
