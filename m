Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 707901F731
	for <e@80x24.org>; Thu,  8 Aug 2019 19:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390280AbfHHTAH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 15:00:07 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51685 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732375AbfHHTAH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 15:00:07 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3649E824B0;
        Thu,  8 Aug 2019 15:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=KYH3/8P++CD20I1NPye8zJruuTo=; b=PjeR7o
        h84KGUUq6c+J9Rn90CwpOd+XsXXjcLi/IEK4U6fjs62GCyjZ9DgJ75w+0VMShNrL
        BKKG+Vp5Sc6QRY0xxEDdJXjPOV+sKRlpBr2DMCyysAbvnvjIEtPysvqoKWMtzVVG
        13WuQIWBoaTv2KJmqAzNrBTqDLEyEp9393+z8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=b+tqljIVDNsRV/e8RZlHOWnr1xC4y1Te
        5idhUOgUovadTkKY+Fy+8NKzooMN+ZDVZGPqmrCJOZ0Y47wv7hvP/ZhV35NuQmmX
        CkIDimAMgZCiBA4/QiWMOKDuyN15ZtO70TnwYlp7flojBQy2KcEt88Kq902VcptT
        R3uZCYPQq24=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E5AF824AF;
        Thu,  8 Aug 2019 15:00:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 391498249F;
        Thu,  8 Aug 2019 14:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        carenas@gmail.com,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= 
        <avarab@gmail.com>, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 5/5] repo-settings: create feature.experimental setting
References: <pull.292.v2.git.gitgitgadget@gmail.com>
        <pull.292.v3.git.gitgitgadget@gmail.com>
        <2e153fac22dc5c27fc85efc802785edc0c9d78ad.1564515324.git.gitgitgadget@gmail.com>
        <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
Date:   Thu, 08 Aug 2019 11:59:56 -0700
In-Reply-To: <CABPp-BGppXSt9i4SXTizgPXap-YgHBwHTVrvwDpg98zvpYRwcQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 8 Aug 2019 11:34:29 -0700")
Message-ID: <xmqqd0hffpoz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B819B9CA-BA0E-11E9-A312-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> --- a/Documentation/config/merge.txt
>> +++ b/Documentation/config/merge.txt
>> @@ -54,7 +54,8 @@ merge.directoryRenames::
>>         moved into the new directory.  If set to "conflict", a conflict
>>         will be reported for such paths.  If merge.renames is false,
>>         merge.directoryRenames is ignored and treated as false.  Defaults
>> -       to "conflict".
>> +       to "conflict" unless `feature.experimental` is enabled and the
>> +       default is "true".
>
> I have a hard time parsing that changed sentence.  Perhaps something like:
>    ...unless `feature.experimental` is enabled in which case the
> default is "true".
> ?

That reads better.

But I am not sure about the wisdom of controlling between conflict
and true with this feature macro in the first place.

Between "conflict" and "true", the former forces the end user to
verify (or allows the end user to veto) the auto resolution by the
heuristics and is always a safer if more cumbersome option.  It's
not like blindly trusting the directory rename heuristics is the
bright future for all users, is it?

I would not set rerere.autoUpdate to true when feature.experimental
is set; for exactly the same reason, I do not find it reasonable to
set this to true with feature.experimental macro.

> ...
>> diff --git a/repo-settings.c b/repo-settings.c
>> index af93696343..e0673938c0 100644
>> --- a/repo-settings.c
>> +++ b/repo-settings.c
>> @@ -34,6 +34,18 @@ void prepare_repo_settings(struct repository *r)
>>                 free(strval);
>>         }
>>
>> +       if (!repo_config_get_maybe_bool(r, "merge.directoryrenames", &value))
>> +               r->settings.merge_directory_renames = value ? MERGE_DIRECTORY_RENAMES_TRUE : 0;
>
> Shouldn't that be "MERGE_DIRECTORY_RENAMES_NONE" instead of "0"?
>
>> diff --git a/repository.h b/repository.h
>> index e7a72e2341..b8e52dd48f 100644
>> --- a/repository.h
>> +++ b/repository.h
>> @@ -19,6 +19,20 @@ enum untracked_cache_setting {
>>         UNTRACKED_CACHE_WRITE = 2
>>  };
>>
>> +enum merge_directory_renames_setting {
>> +       MERGE_DIRECTORY_RENAMES_UNSET = -1,
>> +       MERGE_DIRECTORY_RENAMES_NONE = 0,
>> +       MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
>> +       MERGE_DIRECTORY_RENAMES_TRUE = 2,
>> +};
>
> Thanks for adding these; makes things much nicer.  :-)
>
>
> Cheers,
> Elijah
