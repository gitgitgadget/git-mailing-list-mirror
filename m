Return-Path: <SRS0=cWhr=D6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8085AC4363A
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD6052168B
	for <git@archiver.kernel.org>; Fri, 23 Oct 2020 16:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Dw+6eTY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751201AbgJWQDu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Oct 2020 12:03:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65529 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S464906AbgJWQDu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Oct 2020 12:03:50 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 892A3F0A6D;
        Fri, 23 Oct 2020 12:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=XUiQaIlaxl7s
        MhxOnUenpy+of5A=; b=Dw+6eTY06PDp0OsGcsGVuFSnzeDivMKWQ64p6bAePnqd
        uxYL0GGCIFOrSY4vJ8kJdXqfMkuo6cThd0/y34uJSJ/hx5kqY07S+Ha8NynOAMtM
        bUBYGhgG/fx+pGflsrUJI11Vt7dpNrrAp5aOovhL9btAz1XkGVTSOEzsPkbUu0s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A3cJR1
        Y3CfpvYkZvCJQB5vGreL0ajS+HqTOYytwg2lOa3Jr5CCBKD4uUusCD3gkMKf7TVx
        Qun9ANkcQL3qLd4H1IIZxBVZijbTEG+qmS2zhg+ARXq+1mV+xVLL8X8vs2RTlyxq
        uMX4xp0XKY60pzgmuXaIhBUaBY1Sfo+B4fZEk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 806F5F0A6A;
        Fri, 23 Oct 2020 12:03:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C7DD2F0A69;
        Fri, 23 Oct 2020 12:03:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     git@vger.kernel.org, Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: ak/corrected-commit-date, was Re: What's cooking in git.git
 (Oct 2020, #03; Mon, 19)
References: <xmqqr1put77h.fsf@gitster.c.googlers.com>
        <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com>
Date:   Fri, 23 Oct 2020 09:03:44 -0700
In-Reply-To: <685afed6-f01f-5d22-80d4-00fdc11caf0a@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 23 Oct 2020 16:39:30
 +0200")
Message-ID: <xmqqv9f1gc9r.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 546FAABE-1549-11EB-AB50-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> On 19.10.2020 at 20:13, Junio C Hamano wrote:
>
>> * ak/corrected-commit-date (2020-10-08) 10 commits
>>   - doc: add corrected commit date info
>>   - commit-reach: use corrected commit dates in paint_down_to_common()
>>   - commit-graph: use generation v2 only if entire chain does
>>   - commit-graph: implement generation data chunk
>>   - commit-graph: implement corrected commit date
>>   - commit-graph: add a slab to store topological levels
>>   - commit-graph: return 64-bit generation number
>>   - commit-graph: consolidate fill_commit_graph_info
>>   - revision: parse parent in indegree_walk_step()
>>   - commit-graph: fix regression when computing Bloom filters
>>   The commit-graph learned to use corrected commit dates instead of
>>   the generation number to help topological revision traversal.
>>   How ready is this?
>
> I am reviewing this patch series; it looks good, in a few places
> explanation in the commit message needs improvement.
>
> I think we could in patch 07/10 get a better performance for GDOV
> (overflow chunk for generation numbers) writing with an alternate=20
> approach, but that might wait for subsequent patch series.

Thanks.
