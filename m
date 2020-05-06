Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F2B0C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 03:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38AF62075E
	for <git@archiver.kernel.org>; Wed,  6 May 2020 03:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XhIFTkgi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEFD50 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 23:57:26 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62657 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbgEFD5Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 23:57:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E9B85A250;
        Tue,  5 May 2020 23:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=omzMMmnEMiqI224WvnXStTjrkuA=; b=XhIFTk
        gie65DfReGRW0I32iujPEy8pKkys54h5dELJ3rnPjNw72b+adfwfTBj/KWA+eGIj
        fHQaFYigebCVFzC/OSHd/ZQd0wplo+2qOcgfNJfuRSpXCGhhh7r4OE0Y4so6Asfj
        LRaXAnj0CNYnEJhj+DKSDGV0BDLlmQ0nMvY4c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CFxY+cM6nQFbQr84VZwtOVAbcmAX2z1o
        culg3TOasBz2vuTchuJQme63Adn2/heaSDQUUCXqzaIEjo4Fgt1JSbn6jClGHOYA
        x8Nh5LiQ2Wmc1xEZtYLSD5rWOfkyj3w0nHdDJVmvGD6HDpfeBQf6zIQGKRCdX574
        BFJs6iSx9aY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26A375A24C;
        Tue,  5 May 2020 23:57:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A5BC35A24B;
        Tue,  5 May 2020 23:57:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH] Doc: reference the "stash list" in autostash docs
References: <0b898ca26b0399e9f14b9170f6586014dee80cf5.1588683624.git.liu.denton@gmail.com>
        <xmqq8si6b55l.fsf@gitster.c.googlers.com>
        <20200505225901.GA1454@generichostname>
Date:   Tue, 05 May 2020 20:57:24 -0700
In-Reply-To: <20200505225901.GA1454@generichostname> (Denton Liu's message of
        "Tue, 5 May 2020 18:59:01 -0400")
Message-ID: <xmqqmu6l90m3.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B1D4380A-8F4D-11EA-BE97-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Hi Junio,
>
> Sorry, I noticed a typo when reading this patch over.
>
> On Tue, May 05, 2020 at 11:36:22AM -0700, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>> 
>> > In documentation pertaining to autostash behavior, we refer to the
>> > "stash reflog". This description is too low-level as the reflog refers
>> > to an implementation detail of how the stash works and, for end-users,
>> > they do not need to be aware of this at all.
>> >
>> > Change references of "stash reflog" to "stash list", which should be
>
> s/ be$//

Amended.
