Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E6BC433EF
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 23:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiD0XYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 19:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbiD0XYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 19:24:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BEDB854
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 16:20:57 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 734131A2C48;
        Wed, 27 Apr 2022 19:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4TJqVIXeI9vCjByJisFO1CNpg1MMYYiqQvYLI/
        2sedA=; b=PO2l4QvyMYToLDEnqG+KeBTz2ZXa+SuHue4i2f8koC15jUiJkau2hK
        QAn4uADXMmSvO26l9TS5ylxxnlSP0sfMpczjsZJS9xJEk+Dz88JE2Ihws8OII3hY
        xfYyYHxkRchUCahn3RdNQstRIVbiUkBAnCK3TJbJ9oti7AULiq9cc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6CA401A2C47;
        Wed, 27 Apr 2022 19:20:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 208871A2C46;
        Wed, 27 Apr 2022 19:20:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Orgad Shaneh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of
 warn_if_uninitialized
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
        <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
        <kl6lfslyp3ti.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 27 Apr 2022 16:20:49 -0700
In-Reply-To: <kl6lfslyp3ti.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 27 Apr 2022 15:19:21 -0700")
Message-ID: <xmqqee1ijepa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AD8D73B2-C680-11EC-A352-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
>> index 2c87ef9364f..1a8e5d06214 100644
>> --- a/builtin/submodule--helper.c
>> +++ b/builtin/submodule--helper.c
>> @@ -2026,7 +2026,6 @@ struct update_data {
>>  	.references = STRING_LIST_INIT_DUP, \
>>  	.single_branch = -1, \
>>  	.max_jobs = 1, \
>> -	.warn_if_uninitialized = 1, \
>>  }
>>  
>>  static void next_submodule_warn_missing(struct submodule_update_clone *suc,
>>
>> base-commit: 6cd33dceed60949e2dbc32e3f0f5e67c4c882e1e
>> -- 
>> gitgitgadget
>
> This was clearly a mistake on my part :( The fix looks good to me,
> thanks!

Will merge the fix down in preparation for 2.36.1 and later.

Thanks, both.
