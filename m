Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98ECD1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 00:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfJLAaN (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 20:30:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59744 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbfJLAaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 20:30:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F1BB2A6B8;
        Fri, 11 Oct 2019 20:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gScyWMCLjAJwFaOR0RiucM+1/qk=; b=JMH/Vc
        QSXVgegesX/ofmO/+jvOntGnCaftFAX//0QWrc+MXrQFzAwb6CVR+piR+gYyo4mQ
        0jNwxnodcROQf7dUtAu5PUl/cHz0PfZK2Mdbry4+hEKmMWbhJtVwusIakawa4qqA
        WeAsOarg0BLC/bzXz/yPGN7OX29I4Jbe4yUPQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mmdAZEPW7VPt9L2zpz3lpfGPN165EH8I
        iHiOCOhpTBB/Oz6KY7PEk3QyJTlQqV1Uv9jyYuz4nzZxHGIKPqQeo65EpQkSTRb7
        b34TyQMTGCF0enLqDXSfvkEkTbLof2vuUYzeJld24JjqXJuB4Ig4EVNtkDT7vO4r
        TjJYOtAjlK4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12EA72A6B6;
        Fri, 11 Oct 2019 20:30:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6CE0F2A6B4;
        Fri, 11 Oct 2019 20:30:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     wambui.karugax@gmail.com, git@vger.kernel.org
Subject: Re: [Outreachy] [PATCH] blame: Convert pickaxe_blame defined constants to enums
References: <xmqqsgnzj4vs.fsf@gitster-ct.c.googlers.com>
        <20191011184441.103527-1-jonathantanmy@google.com>
Date:   Sat, 12 Oct 2019 09:30:07 +0900
In-Reply-To: <20191011184441.103527-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Fri, 11 Oct 2019 11:44:41 -0700")
Message-ID: <xmqqk19ag60g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 725C3D44-EC87-11E9-9722-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> > Also, I have a slight preference for putting "= 02" on the BLAME_COPY
>> > line but that is not necessary.
>> 
>> That is absolutely necessary; it is not like "we do not care what
>> exact value _COPY gets; it can be any value as long as it is _MOVE
>> plus 1", as these are used in set of bits (and again, I do not think
>> it is such a brilliant idea to use enum for such a purpose).
>
> Good point.

Doesn't that also show that enums are not quite a good fit for set
of bits (i.e. 1<<n)?

