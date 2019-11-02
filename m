Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 082091F454
	for <e@80x24.org>; Sat,  2 Nov 2019 05:50:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKBFuk (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Nov 2019 01:50:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58083 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKBFuj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Nov 2019 01:50:39 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB2542FC1C;
        Sat,  2 Nov 2019 01:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FQwG/ddpQL2nS19QNqLF4fwg/cE=; b=DU2Qll
        0CITJCBL0xi3NShF9unBlc0dApzLLoNkw8H1RrbHowv78DyfDwZKUC2VtdY7oRBC
        AzKXmerSJvl7UOCIWl1nCypLKvr9JjpZzn2cggI7FmppSimcyowlY9J3nQQobOow
        fOQRQeO2a2aysDNTHELi/2M/GlolQmoIaOwNU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E3bHS4yc11YAk75NG4cjo8sbZ5qBB3NG
        PiLC75rCAVfGcc1KO709EP//y99Kf/nxVqL4WeECOINGxi0/MQZa0MU/1HnRBYVL
        SsADdVmBI/MimPrSLwNFDMMM3p81Kz11wMOIeJ5OZJ+mcp7KdF0yOqGlgEv+kRgv
        81fuNqdiZA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C08E12FC1B;
        Sat,  2 Nov 2019 01:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2F5752FC19;
        Sat,  2 Nov 2019 01:50:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Ralf Thielow via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Corentin BOMPARD <corentin.bompard@etu.univ-lyon1.fr>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/1] fetch.c: fix typo in a warning message
References: <pull.441.git.1572554506.gitgitgadget@gmail.com>
        <70f10fe44716e50765a9d8f7794116f390f09dbc.1572554506.git.gitgitgadget@gmail.com>
        <20191031225310.GA211076@google.com>
Date:   Sat, 02 Nov 2019 14:50:36 +0900
In-Reply-To: <20191031225310.GA211076@google.com> (Jonathan Nieder's message
        of "Thu, 31 Oct 2019 15:53:10 -0700")
Message-ID: <xmqqzhhe3jyr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1A6C7C2-FD34-11E9-A921-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> Ralf Thielow wrote:
>
>> Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
>> ---
>>  builtin/fetch.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>>  				if (source_ref) {
>> -					warning(_("multiple branch detected, incompatible with --set-upstream"));
>> +					warning(_("multiple branches detected, incompatible with --set-upstream"));
>
> Long line.


Thanks, both.  This close to the final, I am reluctant to touch any
string inside _(), so let's postpone it to the next cycle, though.
