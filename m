Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81831F454
	for <e@80x24.org>; Mon,  4 Nov 2019 03:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfKDDhq (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 22:37:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54804 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfKDDhp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 22:37:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AFE9B891B6;
        Sun,  3 Nov 2019 22:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8d1X52vWkyKQRzx7pwKsF9EIoGo=; b=DFvdKq
        WKQi5NtU3pMzWps3AmiF/mHE3uZRPzqojacMtARtjuteMWzakSHBkmveM/9e48r/
        XIqkbypyqwFasCoowCAnmVinNgtKzl34/P5D/rNcIufdHrL5Sv6zin7xlRbkerP9
        ltVTaMJKbGYCJZCRHrMlgO+nvCKW+L0on1+cM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=f/H+TQ0fuIfQrz3ihPYaW5Fln6D+Eni6
        7fgAXCFluYNKzS2IEz2DWVy3I4D9KEufednwvRwpO9U5rti1sMFuob8SJGyQqgDs
        XpW2XpNqqg4JwcVYqhnMVkLkoOwb95LV7zxXa3UI8+xpZgB+TwrzcUXlqfwkdpw/
        KVHhE3afK8I=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A8EE891B5;
        Sun,  3 Nov 2019 22:37:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AFBBC891AD;
        Sun,  3 Nov 2019 22:37:37 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] git-shortlog.txt: mention commit filtering options
References: <20191030203603.27497-1-me@yadavpratyush.com>
        <xmqqftj64yv2.fsf@gitster-ct.c.googlers.com>
        <20191102225045.zxxomy357zctxhfh@yadavpratyush.com>
Date:   Mon, 04 Nov 2019 12:37:35 +0900
In-Reply-To: <20191102225045.zxxomy357zctxhfh@yadavpratyush.com> (Pratyush
        Yadav's message of "Sun, 3 Nov 2019 04:20:45 +0530")
Message-ID: <xmqq7e4g1fcw.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72568036-FEB4-11E9-ABE2-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pratyush Yadav <me@yadavpratyush.com> writes:

>> How does "git log --help" handle the corresponding part of its
>> documentation?  
>> 
>> 	... goes and looks ...
>> 
>> I wonder if it is better to just include rev-list-options.txt like
>> "git-log.txt" does, instead of adding these four lines?
>
> Quoting from my initial email [0] about this topic:
>
>   rev-list-options.txt is a rather large file and I'm not sure if 
>   including it in both git-log and git-shortlog would be a good idea. 
>   The way I see it, git-log is the "primary" log interface, and 
>   git-shortlog is a "secondary" log interface, so git-log warrants such 
>   a large man page, but git-shortlog doesn't especially since most 
>   options are repeated. So maybe it is a better idea to just include a 
>   pointer to git-rev-list in the shortlog man page. 

OK, so you also wondered the same thing and reached a different
conclusion.

Given that

 - "rev-list-options" being large is more or less irrelevant, if you
   want to give users of "short-log" an easy access to these rich
   options.  We already do so for users of "log".

 - "include" files are designed to reduce readers' mental load by
   avoding one level of indirection and also to reduce the risk of
   documentaiton going stale by avoiding repeated text in multiple
   places, and that

 - if description in parts of included file only applies to one
   including file but not others, ifdef/ifndef mechanism can be used
   to customize the contents (see how rev-list-options.txt is
   included in pages for both "log" and "rev-list", and parts of it
   are shown conditionally with "ifndef::git-rev-list[]" and
   friends; diff-options.txt and its users give you more examples to
   follow).

it is not such a bad idea to include the rev-list-options.txt.

More importantly, having a pointer to git-rev-list page may omit
what is available to users of "shortlog" (options described inside
"ifndef::git-rev-list[]" in rev-list-options.txt are not visible to
them) and/or describe what is not available to users of "shortlog"
(those described inside "ifdef::git-rev-list[]" may not in general
apply to the "log" family of commands).

Thanks.
