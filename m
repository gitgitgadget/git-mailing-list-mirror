Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B4CC433F5
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7260EE9
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 06:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbhJXGH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 02:07:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59422 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbhJXGH6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 02:07:58 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ACEEAEC203;
        Sun, 24 Oct 2021 02:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PEh8DVtOo2TLA2dNtHDuuVVDjjr+6hKFy6zFXg
        lTV2o=; b=RKDKils6sRUpA199ql8ayvvG74qn+2u7LIXNpL30ul0Q2rpJmiua6W
        ZfDgZswWxkW26Xsh/YO5N6mLr4aeINBD2Il6HY7i+EJG9K1/tqaHUHRJnLnEQInU
        /c70+Gzdejy7YsCnx7PcDnWZLWzeZ9FgJiZjbOcL1GD503mcwYnK8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4C61EC202;
        Sun, 24 Oct 2021 02:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 13415EC201;
        Sun, 24 Oct 2021 02:05:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     Atharva Raykar <raykar.ath@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Subject: Re: [PATCH v3 0/1] submodule: correct an incorrectly formatted
 error message
References: <m27df9lvm1.fsf@gmail.com>
        <20211023125722.125933-1-kaartic.sivaraam@gmail.com>
Date:   Sat, 23 Oct 2021 23:05:35 -0700
In-Reply-To: <20211023125722.125933-1-kaartic.sivaraam@gmail.com> (Kaartic
        Sivaraam's message of "Sat, 23 Oct 2021 18:27:21 +0530")
Message-ID: <xmqq7de3555c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 68461BEC-3490-11EC-9C71-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:

> Hi Atharva,
>
> Sorry for the delay in sending this. Got held up with other work.
>
> On 21/09/21 10:17 pm, Atharva Raykar wrote:
>>>
>>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>>> index 414fcb63ea..236da214c6 100644
>>> --- a/builtin/submodule--helper.c
>>> +++ b/builtin/submodule--helper.c
>>> @@ -2775,7 +2775,7 @@ struct add_data {
>>>   };
>>>   #define ADD_DATA_INIT { .depth = -1 }
>>>
>>> -static void show_fetch_remotes(FILE *output, const char *sm_name, const char *git_dir_path)
>>> +static void show_fetch_remotes(struct strbuf *msg, const char *sm_name, const char *git_dir_path)
>> 
>> I like the change from using a strbuf instead of passing the output
>> stream and printing to it. But maybe we should rename this function, now
>> that it doesn't really 'show' anything? Probably something like
>> 'append_fetch_remotes()'?
>
> That's a good point. I've taken your suggestion into account in this v3.
>
> Find the details of the v3 of this patch below.

Looking good.

Let's declare victory and merge it down to 'next' and then to
'master'.

Thanks, both.  Will replace.
