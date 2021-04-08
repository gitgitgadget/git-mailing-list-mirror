Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E18BC433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA2E61181
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:04:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhDHVEn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:04:43 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54373 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232091AbhDHVEn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:04:43 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23957B3C0A;
        Thu,  8 Apr 2021 17:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QKiDzVjpv08vHlja6vvm8a45zws=; b=QE/HRO
        U9DMkWR4+ehXLJYjW06ouNJ1c05Ow5I+5V2OBJrHFWWZAMtW/V297oPJSttQXFSy
        HCtmUd7dPlFKjMPh7WwVtCoect9QgwJVXgT5bvwU9io2MY2BpaT9Mphyh6ztKhIE
        Zgk6ZpjhkOMM7y4O5xeG5KutTGklzxVJ+l/2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ErbaJzh/yaPjoWoEQHSHOjLUzoO0XgOV
        Sq4hWHu7etPE2+wkZgflDLiWYpzdFnvWE2sepyYRKWXboPFR6eKJBDM+h5CaQPa9
        KJ9nBC1SQdiVYiE3FEeQEnv0REnCf5UQQp2HneyD6YxKB6fpF1mzYTqSzRjLulub
        9hUj9AApja0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1ADB6B3C09;
        Thu,  8 Apr 2021 17:04:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9640EB3C08;
        Thu,  8 Apr 2021 17:04:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Georgios Kontaxis <geko1702+commits@99rst.org>,
        Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v5] gitweb: redacted e-mail addresses feature.
References: <pull.910.v4.git.1616396267010.gitgitgadget@gmail.com>
        <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <20210329014744.GA2813@dcvr>
        <8330ef0d7195de461f961d72f90998fa.squirrel@mail.kodaksys.org>
        <20210408171648.GA7133@dcvr>
Date:   Thu, 08 Apr 2021 14:04:29 -0700
In-Reply-To: <20210408171648.GA7133@dcvr> (Eric Wong's message of "Thu, 8 Apr
        2021 17:16:48 +0000")
Message-ID: <xmqqmtu8sd2a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02F605DC-98AE-11EB-A340-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Georgios Kontaxis <geko1702+commits@99rst.org> wrote:
>> > Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com> wrote:
>> >> Introduce an 'email-privacy' feature which redacts e-mail addresses
>> >> from the generated HTML content
>> >
>> Eric Wong wrote:
>> > A general reply to the topic: have you considered munging
>> > addresses in a way that is still human readable, but obviously
>> > obfuscated?
>> ...
>> > I also considered Unicode homographs which can look identical
>> > to replacement characters, too; but rejected that idea since
>> > it would cause grief for legitimate users who would not notice
>> > the homograph when pasting into their mail client.
>
> As a data point, none of the homograph@ candidates I posted here
> on Mar 29 have attracted any attempts on my mail server.

That is an interesting observation.  All homograph@ non-addresses,
if a human corrected the funnies in their spelling, would have hit
whoever handles @80x24.org mailboxes.

I take it to mean that as a future direction, replacing <redacted>
with the obfuscated-but-readable-by-humans homographs is a likely
improvement that would help human users while still inconveniencing
the crawlers.  It may however need some provision to prevent casual
end-users from cutting-and-pasting these homographs, as you said in
your original mention of the homograph approach.

But other than that, does the patch look reasonable?

Thanks.
