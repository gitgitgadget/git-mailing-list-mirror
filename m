Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DD4E1FBB0
	for <e@80x24.org>; Tue, 22 Nov 2016 17:44:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933014AbcKVRns (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Nov 2016 12:43:48 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52955 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933001AbcKVRnp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2016 12:43:45 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 23C4B4E667;
        Tue, 22 Nov 2016 12:43:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q4u3ldqd4AEwodVvWSj5MbRug3U=; b=bnvwPg
        vyCAirLubsSXun7sSXOncqmn+DnpuwfdDPibsTnkbErUeLjJopfqvb0d0jGpdkqU
        3ARZIHk7NvS5yQKjea04HRLly+QwCj26d+lMcPnDdYiKgcoCI0j84M+n51kSOw0N
        yuDnid3Z7fMl94y9zPiql8qbTwmVfqOWiW7g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tgmzOruJfHa21yB7q+uhO7Eu0tT0vxAE
        w+mHCYFuE2FVFOVKYEbruE3gDD3qFBAqIQB6raNjboF3hfYxsEnZd0Iwa9GQ0eGE
        Hw+HCZuHpTU3Sn9+esKpaiGK6ni3O5JK1+wpbxcsRDs+Hl0uREBw2nA3/1rv7c0m
        GEd5eSclha4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B8964E665;
        Tue, 22 Nov 2016 12:43:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6711E4E664;
        Tue, 22 Nov 2016 12:43:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/2] push: fix --dry-run to not push submodules
References: <1479172735-698-1-git-send-email-bmwill@google.com>
        <1479408364-150268-1-git-send-email-bmwill@google.com>
        <1479408364-150268-3-git-send-email-bmwill@google.com>
        <CAGZ79kY1x1HWJFjiyFdMFh8S_Y1F0ecLB5-JPb+nPE0gujfF-A@mail.gmail.com>
        <20161117190255.GK66382@google.com>
Date:   Tue, 22 Nov 2016 09:43:42 -0800
In-Reply-To: <20161117190255.GK66382@google.com> (Brandon Williams's message
        of "Thu, 17 Nov 2016 11:02:55 -0800")
Message-ID: <xmqqk2bvquk1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36299960-B0DB-11E6-AE34-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 11/17, Stefan Beller wrote:
>> On Thu, Nov 17, 2016 at 10:46 AM, Brandon Williams <bmwill@google.com> wrote:
>> 
>> >                                 sha1_array_clear(&commits);
>> > -                               die("Failed to push all needed submodules!");
>> > +                               die ("Failed to push all needed submodules!");
>> 
>> huh? Is this a whitespace change?
>
> That's odd...I didn't mean to add that lone space.

Is that the only glitch in this round?  IOW, is the series OK to be
picked up as long as I treak this out while queuing?
