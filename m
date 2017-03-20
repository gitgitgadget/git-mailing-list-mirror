Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1749E20958
	for <e@80x24.org>; Mon, 20 Mar 2017 16:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754187AbdCTQGf (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 12:06:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55538 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754058AbdCTQFH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 12:05:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 06652794A6;
        Mon, 20 Mar 2017 11:57:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yOYXfazS4c5L
        jTZKQe7tiYmk9Wo=; b=A70iEhqpKqRYKgWjJyr70jKqul+AlQtFh3Erkv+O12xr
        n5VbadBcN7zZqnAxlmLW3Fw8zkvAbL/UIArU5+qcisW0BCKJ7r5uabXB20CLm3eE
        Q7Hp0wiO5dvrz/G6I6cWL1IdgAqEiTkcMWaWRXXFw4WcvxQWv3LnLCKL+awCHjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=bhWjuN
        Xx4PofPU7Ac33mmWX6WrcGbFy7uOiGqwjjAo7yLweEE5f2dCer2HhdWQcZK/H6BC
        A1pMobmZF0VJtJT3rXDWEGIBPFKDwpGbv794MOkxYwUdggCqM35F2ez4pkqs7RGN
        WfeNAUnIVUicbeelwHuwfgcYWWscman5ZkIzQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F2A26794A5;
        Mon, 20 Mar 2017 11:57:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5140E794A4;
        Mon, 20 Mar 2017 11:57:44 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Lars Hjemli <hjemli@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>
Subject: Re: [PATCH 0/8] Various changes to the "tag" command
References: <20170318103256.27141-1-avarab@gmail.com>
        <20170320042657.25x5gmh7uz5zgwzf@sigill.intra.peff.net>
Date:   Mon, 20 Mar 2017 08:57:43 -0700
In-Reply-To: <20170320042657.25x5gmh7uz5zgwzf@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 20 Mar 2017 00:26:57 -0400")
Message-ID: <xmqqefxsx7ns.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F4A11A42-0D85-11E7-8310-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Mar 18, 2017 at 10:32:48AM +0000, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:
>
>> This series incorporates and replaces all the "tag" patches I have
>> floating around the list, and adds a lot in the mix which discovered
>> while working on the initial two patches, but which made sense as
>> separate patches.
>
> I had a few small comments, and I agree with the points that Junio
> raised. But aside from that, it looks good to me.

Thanks for catching issues I missed, and thank you to both of you to
working their solution out quickly.  It seems that a final reroll
will be rather an uncontroversial one that can be merged to 'next'
and then to 'master' soonish.

Thanks for working on this.
