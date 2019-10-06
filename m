Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82FE31F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 00:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfJFAEM (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:04:12 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62783 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbfJFAEM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:04:12 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5ADD579010;
        Sat,  5 Oct 2019 20:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=irwP9sQU9VxHHtt3hO+ieBCPSwo=; b=iFE3ey
        I9GiizjJca6ukDMLs23mld21KZDNxzHs52axXsvdPxe3nvFrX4rgUsRwLSBIRmSu
        2p4FSaHCEZhFn7TfQXPu7GfS5kcmbGsHzzxHs6EVZdVR1RjYOSbwWFjtUfCCjGOC
        Mjv7Sj4HdxeDGpuYeNHHlOnwq8tiUIkN/z62w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CQ3VM1OdB0xS3mpCjLZH6uVyeLQc/4PY
        EeTyFx46YRSSbRZWoS5thfJgcsIaK0Yt5eb6xmVnxb6wXZRFUv7RJqvjFw1RebTg
        sYJnS91vWhGtDg9J39aBRmh7XENc0GZAL3NO+vkLdh22rr2LwD2LufeOvLp76f/k
        8Akby2W1Up4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 52AF27900F;
        Sat,  5 Oct 2019 20:04:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8250E7900C;
        Sat,  5 Oct 2019 20:04:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>, git@vger.kernel.org
Subject: Re: [PATCH v2 18/19] OFFSETOF_VAR macro to simplify hashmap iterators
References: <20190924010324.22619-1-e@80x24.org>
        <20190924010324.22619-19-e@80x24.org>
        <xmqqr23t8g0t.fsf@gitster-ct.c.googlers.com>
        <20191004025115.GA26605@dcvr>
        <xmqqk19l89xt.fsf@gitster-ct.c.googlers.com>
        <20191004172603.GA7215@dcvr>
Date:   Sun, 06 Oct 2019 09:04:05 +0900
In-Reply-To: <20191004172603.GA7215@dcvr> (Eric Wong's message of "Fri, 4 Oct
        2019 17:26:03 +0000")
Message-ID: <xmqqmuee68p6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0E4777E-E7CC-11E9-BD21-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> That said, there could be other compilers which don't set
> __GNUC__ and have the same problem as clang.  But maybe those
> compilers are too buggy and we already ignore invalid warnings
> on those compilers.

Perhaps.
