Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E217F208CD
	for <e@80x24.org>; Fri, 18 Aug 2017 16:31:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752294AbdHRQbg (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Aug 2017 12:31:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58920 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750984AbdHRQbf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Aug 2017 12:31:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D617ABFD6;
        Fri, 18 Aug 2017 12:31:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sgqXFBSAvhS2
        cjsKXbH8Jah9RCE=; b=DsuwLE0TNRM7/eaQg3GCGlQeLYjwRJ7XoVroKPCt4aAS
        3UbaPJMMufS84zJPeG689B/LaPOuVhJq6BoowR3ikmoJNif0Ro/SPhL5huMpcNWV
        mWQK9PfwPcQu5LHKspvk7vtJfVfCigWMB1rDrqr+ZTkxsjbMwR1zAgqSJ1bU35s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Duh6IW
        SQti/k84AgnJppLyn3B2b9SYWc+EaD2dDhOJYtaDxXcn4bWoHnHNhvabwntPiD4V
        7jFV6Pm9x3BBR12jTK3aqYqj6epUFakfOBMUrfFO2l80j9MMkrJbo7vtdhdzcfD4
        FGf+5wL0H9Tf37+xMnfniZGAyR6dhQgdcYTvY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86149ABFD4;
        Fri, 18 Aug 2017 12:31:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E964DABFD2;
        Fri, 18 Aug 2017 12:31:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     martin.agren@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH v4 2/3] builtin/branch: stop supporting the use of --set-upstream option
References: <xmqqy3qluck4.fsf@gitster.mtv.corp.google.com>
        <20170817025425.6647-1-kaarticsivaraam91196@gmail.com>
        <20170817025425.6647-2-kaarticsivaraam91196@gmail.com>
        <xmqqo9reezjx.fsf@gitster.mtv.corp.google.com>
        <69172c47-0af4-4c74-a20b-82da537ad9ee@gmail.com>
Date:   Fri, 18 Aug 2017 09:31:27 -0700
In-Reply-To: <69172c47-0af4-4c74-a20b-82da537ad9ee@gmail.com> (Kaartic
        Sivaraam's message of "Fri, 18 Aug 2017 08:09:44 +0530")
Message-ID: <xmqqmv6wdehs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AFBC9BB2-8432-11E7-9023-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Monday 14 August 2017 02:20 PM, Kaartic Sivaraam wrote:
>>
>> On Wednesday 09 August 2017 12:03 AM, Martin =C3=85gren wrote:
>>>
>>> Maybe the final note could be removed? Someone who is looking up
>>> --set-upstream because Git just "crashed" on them will only want to k=
now
>>> what they should do instead. Our thoughts about the future are perhap=
s
>>> not that interesting.
>>
>> I thought it's better to document it to avoid people from getting=20
> surprised
>> when the options *starts working* again.
>
> I hope that explains the reason.

That is something we can say we _actually_ repurpose the option.
Until then, it is merely noise that distracts the users.
