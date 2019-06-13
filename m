Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F3F51F462
	for <e@80x24.org>; Thu, 13 Jun 2019 22:22:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfFMWWW (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 18:22:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:51867 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbfFMWWW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 18:22:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4DF4E62625;
        Thu, 13 Jun 2019 18:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=aQAQyvl4tfPmtQwA3bmcMf67Bxc=; b=EkiHBe
        wn6ItVYk81PWcm0TSZA3ROwLxbTbreG4OCNkq1Sjn3dzMJO/OGEDBZvnrdoJPLHy
        Dum1qy/pjfh81Cj+QCPhLh7DCJgwBxfuW6zM3PpcrCuPYkiU8NSOIjyqflkhaPd7
        Q2T26/JDz041WgnjdFrXL9hkjdh6VBx2fP0q8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RA5cJljVz/KxQDlGEz/+ok22vDoSBALJ
        tFrnSi2k/GiW75ru4YkGWYbYNPexWqROnk9OcbAdKi5Sd6mtxVMcfjhGyLVKAuDO
        RSRxJ/FQdDAs2Vf6ty/A9DdRhWm05xhL2fS8HEs+lGXeLCZY5n4+1ne2BjK6hAw+
        wA7WL27j3O8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45C5762624;
        Thu, 13 Jun 2019 18:22:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B69F662622;
        Thu, 13 Jun 2019 18:22:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
        <20190609044907.32477-3-chriscool@tuxfamily.org>
        <20190609092259.GB24208@szeder.dev>
        <20190613171913.GA14055@sigill.intra.peff.net>
        <20190613175236.GF31952@szeder.dev>
        <20190613190229.GB27217@sigill.intra.peff.net>
Date:   Thu, 13 Jun 2019 15:22:14 -0700
In-Reply-To: <20190613190229.GB27217@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 13 Jun 2019 15:02:30 -0400")
Message-ID: <xmqqh88tunvt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B37D342A-8E29-11E9-BA2A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > I know there are testing philosophies that go to this level of
>> > white-box testing, but I don't think we usually do in Git. A unit
>> > test of oidmap's externally visible behavior seems like the right
>> > level to me.
>> 
>> That's a good point...  but then why does 't0011-hashmap.sh' do it in
>> the first place?  As far as I understood this t0016 mainly follows
>> suit of t0011.
>
> I'd make the same argument against t0011. :)

Yeah, I tend to agree.  It is not a good excuse that somebody else
alerady has made a mistake.

> I think there it at least made a little more sense because we truly are
> hashing ourselves, rather than just copying out some sha1 bytes. But I
> think I'd still argue that if I updated strhash() to use a different
> hash, I should not have to be updating t0011 to change out the hashes.

True, too.
