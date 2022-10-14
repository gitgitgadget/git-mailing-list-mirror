Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F048C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 19:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJNTG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 15:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbiJNTG2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 15:06:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B61D440F
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 12:06:27 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 305B215FFF8;
        Fri, 14 Oct 2022 15:06:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bhPEg1PYAj5mMePPQrbmQ/j0yVLpKRc3ods0Si
        GIeNo=; b=GP6iYVpBtUSHjGr91evqbNm+9XpN/zMGcnU/JhIrbs5vl65mYDhNtb
        aO9jPN1U01vnAqf0cTTA/giyxwTMC2ZI+fCYb9ZcRtFol4pCNsae6i05IyxQpseP
        PdaMsP0w33tPucWGl4VEP0NEiDXUQSUffbRJQ0OfWeD+9nlXdR+tM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 27EC015FFF7;
        Fri, 14 Oct 2022 15:06:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 89FFC15FFF6;
        Fri, 14 Oct 2022 15:06:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
        <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
        <xmqqv8om9yaz.fsf@gitster.g>
        <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
        <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
Date:   Fri, 14 Oct 2022 12:06:25 -0700
In-Reply-To: <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
        (Eric Sunshine's message of "Fri, 14 Oct 2022 12:58:24 -0400")
Message-ID: <xmqqh7068bta.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4D6372D6-4BF3-11ED-888F-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Oct 14, 2022 at 12:35 PM Derrick Stolee
> <derrickstolee@github.com> wrote:
>> On 10/14/2022 12:15 PM, Junio C Hamano wrote:
>> > "nsengaw4c via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> >> Cc: Christian Couder  <christian.couder@gmail.com>
>> >> Cc: Hariom Verma <hariom18599@gmail.com>
>> >
>> > What are these C: lines for?  I do not think the message I am
>> > responding to is Cc'ed to them.  There may be a special incantation
>> > to tell GitGitGadget to Cc to certain folks, but adding Cc: to the
>> > log message trailer like this does not seem to be it---at least it
>> > appears that it did not work that way.
>>
>> GitGitGadget will read the "cc:" lines from the end of the pull request
>> description, not the commit messages. I'm pretty sure they will be
>> ignored if there are other lines after them.
>
> For Wilberforce's edification for future submissions, presumably the
> reason that the CC: in the pull-request's description didn't work is
> because the CC: line wasn't the last line in the description? Does
> there need to be a blank line before the CC: line? Is it okay to list
> multiple people on the same CC: line as done in this case, or is that
> also a problem?

Ah, now I can see why the round v4 is CC'ed to you and Derrick on
the list.  The pull-request text (visible in GitHub UI in the top
most box of https://github.com/git/git/pull/1362) ends with two
lines of cc: that list you two.  The one named Christian and Hariom
were not at the end and was ignored by GGG, it seems.

