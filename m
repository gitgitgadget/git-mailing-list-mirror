Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69DE31F463
	for <e@80x24.org>; Mon,  9 Sep 2019 19:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731905AbfIIT5U (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 15:57:20 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63947 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731185AbfIIT5U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 15:57:20 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3D5E52AFDC;
        Mon,  9 Sep 2019 15:57:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ymFSHNcHKnhUPU09GCGuyxd9I5E=; b=DjBaea
        CsDFC9Dm1C8CpNMcuP5JSVQjU8e+yW/MfSzy88LucQt+JE09ys0CnZZeysozcaE6
        CIhGawI9fUOmuWffPBAFsCVoIvQ0WprWH/vlRWgtf5uhIH7LhOL0W2gZLpRZiG91
        i0JJZUVvYs0wy4l9xYhdsBp1Jg64gnt6ZmbkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=QH4PyMGhGnLEG3fQSREz1+nB4mIxsy50
        v0Ni4YmKTkGHgR6fYDWKKpnsh7oItoY9E2sY+nVM1SDD+MV6XEj8AIlkT5L/6Ivn
        bw/wMafM4hTOsWSW+7x95qa+sIjXyFdfcJ7J8RhJtY+vO4KmaE69XoNsJocsphjy
        WXfkRBSvt+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 293002AFDA;
        Mon,  9 Sep 2019 15:57:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7E28D2AFD8;
        Mon,  9 Sep 2019 15:57:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Sep 2019, #01; Sat, 7)
References: <xmqqd0gcm2zm.fsf@gitster-ct.c.googlers.com>
        <20190909185829.GA88988@dentonliu-ltm.internal.salesforce.com>
Date:   Mon, 09 Sep 2019 12:57:17 -0700
In-Reply-To: <20190909185829.GA88988@dentonliu-ltm.internal.salesforce.com>
        (Denton Liu's message of "Mon, 9 Sep 2019 11:58:29 -0700")
Message-ID: <xmqqo8zti6oy.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 074A6080-D33C-11E9-B7B5-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> On Sat, Sep 07, 2019 at 10:26:53AM -0700, Junio C Hamano wrote:
>> * dl/complete-cherry-pick-revert-skip (2019-08-27) 3 commits
>>  - status: mention --skip for revert and cherry-pick
>>  - completion: add --skip for cherry-pick and revert
>>  - completion: merge options for cherry-pick and revert
>> 
>>  The command line completion support (in contrib/) learned about the
>>  "--skip" option of "git revert" and "git cherry-pick".
>> 
>>  Will merge to 'next'.
>
> Did we end up deciding whether or not we were going to drop "status:
> mention --skip for revert and cherry-pick"?

If you are not convinced it is a good idea, we can easily drop it
(and I do not mind dropping it---I am not convinced it is a good
idea myself).

>> * dl/remote-save-to-push (2018-12-11) 1 commit
>>  - remote: add --save-to-push option to git remote set-url
>> 
>>  "git remote set-url" learned a new option that moves existing value
>>  of the URL field to pushURL field of the remote before replacing
>>  the URL field with a new value.
>> 
>>  Anybody who wants to champion this topic?
>>  I am personally not yet quite convinced if this is worth pursuing.
>
> Perhaps it's time to drop this topic?

OK.  Thanks.
