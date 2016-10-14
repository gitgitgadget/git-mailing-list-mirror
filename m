Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B93591F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 16:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752203AbcJNQsW (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 12:48:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54503 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750922AbcJNQsU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2016 12:48:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 490E344D25;
        Fri, 14 Oct 2016 12:48:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E8ZMcIFNXPIrUjEbZVeNsQDAEPY=; b=gGUoh2
        6LoVdcujkbpKVmQgBD3Jh5DFtSOd1Q++pxTC5BwjdiUK2M7bhhaDyICf0/OlTcXu
        JOlLh3H5zt2q7rfv8/QafjBtAuzh2BqdA4MCPSp16R/UVnZ0CkmcomENid+KNZ50
        M2inj9ANf9+aaOF6YO3cZcp19tuRCl+sbM+To=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SopZ9zlB0eFqgTWFash0he791ZRObZfh
        ymZSdaeDzr6FYb1gO9lGvMdto1Y0OfxqL5G2K8xBuVNT32FsXkQFWvTTpsQhb187
        8+ErRtVHknkwoJww3z3fm2ONgegcIPxQDVv+TK+sUWZLAZJFm8ig5BsBDoE9Ng23
        tqq0NXqXRUU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EA7044D1E;
        Fri, 14 Oct 2016 12:48:19 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAFA144D1B;
        Fri, 14 Oct 2016 12:48:18 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     Heiko Voigt <hvoigt@hvoigt.net>,
        David Turner <David.Turner@twosigma.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Uninitialized submodules as symlinks
References: <fd5bcf57f92944c0b7f6f2f8342c342c@exmbdft7.ad.twosigma.com>
        <20161013161017.GC29710@book.hvoigt.net>
        <20161013193558.GC1698@ikke.info>
Date:   Fri, 14 Oct 2016 09:48:16 -0700
In-Reply-To: <20161013193558.GC1698@ikke.info> (Kevin Daudt's message of "Thu,
        13 Oct 2016 21:35:58 +0200")
Message-ID: <xmqqr37izxkf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 02668942-922E-11E6-B4C5-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> On Thu, Oct 13, 2016 at 06:10:17PM +0200, Heiko Voigt wrote:
>> On Fri, Oct 07, 2016 at 06:17:05PM +0000, David Turner wrote:
>> > Presently, uninitialized submodules are materialized in the working
>> > tree as empty directories.  We would like to consider having them be
>> > symlinks.  Specifically, we'd like them to be symlinks into a FUSE
>> > filesystem which retrieves files on demand.
>> 
>> How about portability? This feature would only work on Unix like
>> operating systems. You have to be careful to not break Windows since
>> they do not have symlinks.
>
> NTFS does have symlinks, but you need admin right to create them though
> (unless you change the policy).

That sounds like saying "It has, but it practically is not usable by
Git as a mechanism to achieve this goal" to me.



