Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6CF2C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 18:47:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbiGUSro (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 14:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGUSrn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 14:47:43 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2CA21260
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 11:47:42 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 605AD138FBC;
        Thu, 21 Jul 2022 14:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OLgJb3SI81cZfFgIO4k6+ispVInCHOD1/s7zfO
        1FS5Q=; b=JrZLqG6PJksfzwU19HVXy8d14KeWATosZE1wbwpZmS4Xv76IECRm1i
        e5eGxW3bbJiVdNKApidohE0MVAALuxgS835za6+neAger3uJBIABHvCvDmqPOKNQ
        wMOGZFPrDFfiNkXsjMJf1zpj4lRwpiyNoTdkDs35tQBdoD4J3fYfI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54846138FBB;
        Thu, 21 Jul 2022 14:47:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1A92138FBA;
        Thu, 21 Jul 2022 14:47:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Amir Montazery <amir@ostif.org>
Cc:     git@vger.kernel.org
Subject: Re: Coordinated Security Audit for git. Contacts needed
References: <CADKuG0uzh3syzgfiPLepiTLXNzkoYhLFX1h-DE3C7c8j6HXALQ@mail.gmail.com>
        <xmqq8romicil.fsf@gitster.g>
        <CADKuG0vVGsC9tFr8bUrC48yhhkyg0Rrafyf39TYhPNXE1ak6mA@mail.gmail.com>
Date:   Thu, 21 Jul 2022 11:47:39 -0700
In-Reply-To: <CADKuG0vVGsC9tFr8bUrC48yhhkyg0Rrafyf39TYhPNXE1ak6mA@mail.gmail.com>
        (Amir Montazery's message of "Thu, 21 Jul 2022 13:06:41 -0500")
Message-ID: <xmqqmtd2gv5g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 993938D2-0925-11ED-B7F6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amir Montazery <amir@ostif.org> writes:

>> There is no "community meetings" other than the informal "stand-up"
>> irc discussion that is biweekly.  The log of the latest is at
>> https://colabti.org/irclogger/irclogger_log/git-devel?date=2022-07-18
>> but generally speaking we are not into "synchronous" communication.

The next one is on Aug 1st, it seems, according to https://tinyurl.com/gitCal

    The Git Standup is currently happening every two weeks at 18:00 UTC
    in the #git-devel channel on irc.libera.chat and its log can be
    found at https://j.mp/gitdevlog

Coming to it may be a good way to "get to know" some folks who work
on the project.

> ... If anyone is interested in providing some direction
> or help with the source code review, supply chain security, or
> customizing a new setup of CodeQL for git, please let me know.

All new code (with a small exception) go through the patch review on
this list, so reviewing patches posted here and archived at

    https://lore.kernel.org/git/

with special focus on the security aspect (which is the forte of
you folks) may be great.  A patchwork instance that captures the
traffic can be seen at

    https://patchwork.kernel.org/project/git/list/

I am not sure what the best place to start in auditing existing
codebase, though.

Even though linking with libraries that are unpatched for known
vulnerabilities and/or are compromised would be a problem for
end-users, because we as the project only make sourc releases and do
not make binary distribution, supply-chain issues may not be as big
an issue to the project.  Our friends at the "Git for Windows"
project does one for their platform, and may use your help in the
area, though.

Thanks.
