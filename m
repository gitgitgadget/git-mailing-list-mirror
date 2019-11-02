Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 20D4B1F454
	for <e@80x24.org>; Sat,  2 Nov 2019 03:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbfKBDZS (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Nov 2019 23:25:18 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53118 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727297AbfKBDZS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Nov 2019 23:25:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 96E279B280;
        Fri,  1 Nov 2019 23:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2cPcuVN5qZ4wmaJfti3KSYdzO4g=; b=Smy7Gv
        imoGwBOQN4NyU0fnTjqM2lizv7xwCp9XgCUh6n3Pv5+2jXX+Vfd1059nNTZ8f8i9
        6ZITB+RGZlEot5uSguewFYHSqt7rQdS5UgIni3D4G17JlfMAXVAKvlya96et1ynl
        yLBUI2jS10kurOXZzJ+O6pycbGfXInZdPb3Tk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hu19E2yxA5LHdlREqQF3xl6g7rI97EDA
        DY2gSeOV5Z1ls1fBdMapyYRwzomMNKdJ44mp0joIvZbz7/9OsjVTUeuvUSX2+G/q
        jZ1mWuTyTjS0ZxMDcY9L/Lb7vxsmrE1uF4W7WuV1Fau4mqxNs7O95LO8nVuvwWa5
        D9egL2gunu8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FECC9B27F;
        Fri,  1 Nov 2019 23:25:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFB909B27E;
        Fri,  1 Nov 2019 23:25:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc1
References: <xmqqeez2fzsy.fsf@gitster-ct.c.googlers.com>
        <CABPp-BGV=5FuMfq1pYbbHCMMvyVGQPS_8yTjqhKoqrm7O1KFow@mail.gmail.com>
Date:   Sat, 02 Nov 2019 12:25:12 +0900
In-Reply-To: <CABPp-BGV=5FuMfq1pYbbHCMMvyVGQPS_8yTjqhKoqrm7O1KFow@mail.gmail.com>
        (Elijah Newren's message of "Tue, 29 Oct 2019 23:56:50 -0700")
Message-ID: <xmqqh83n559j.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 62B0639E-FD20-11E9-BCCA-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Hi Junio,
>
> A couple questions on the release notes...
>
> On Thu, Oct 24, 2019 at 1:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>> Git 2.24 Release Notes (draft)
>> ==============================
>>
>> Updates since v2.23
>> -------------------
>>
>> Backward compatibility note
>>
>>  * Although it is not officially deprecated, "filter-branch" is
>>    showing its age and alternatives are available.  From this release,
>>    we started to discourage its uses and hint people about
>>    filter-repo.
>
> What do you mean by deprecation, then?
>
> My understanding has always been that deprecation meant "supported but
> discouraged", which is exactly what we're doing.

You probably want to question the "officially" part.  My
understading is that some vocal members of the community
may be advocating for the official deprecation, and I am
more or less in agreement, but haven't heard from enough
folks to make it "official" community consensus just yet.
