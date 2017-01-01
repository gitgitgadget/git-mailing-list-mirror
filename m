Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4AA452079E
	for <e@80x24.org>; Sun,  1 Jan 2017 02:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932093AbdAACcu (ORCPT <rfc822;e@80x24.org>);
        Sat, 31 Dec 2016 21:32:50 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50039 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932071AbdAACcu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 31 Dec 2016 21:32:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4BD1F5D0CA;
        Sat, 31 Dec 2016 21:32:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dDj3/YAGxGX/sMNdZQAOJHpHRdY=; b=FKU+vS
        Gmn5vJSoW08+Su5rtQy3SH8m1k5zrXgEBSA2I/s0K7AhGVf/1SutzN5sUYyICjzj
        j4sTwjZkGMU4osn7Mylk+LwItoBM5PitxXo1msK5k+z7UJqNNT9aZF4Kh+kicpLr
        1s58LJhbsS5qVPHNss4iEfID2iiYKX7btIfE8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SVuh3vkr//BBoqKSWUMMrFxmhwTTQE1g
        Oacg1peNaL/4LtLOVDe2XYxh1Zql3/Cv06eKigmfRsjoSXLuqji3oPBlgylorrMI
        gqh2B2ZWhsLQT2cfoAMFx926wl86mh/HuA7bvyERIoeAdmbuOSwGzFXXZbQOMLag
        6ieKwZLs6VM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4005D0C9;
        Sat, 31 Dec 2016 21:32:49 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9C7A75D0C8;
        Sat, 31 Dec 2016 21:32:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
        David Turner <novalis@novalis.org>
Subject: Re: [PATCH v3 00/23] Delete directories left empty after ref deletion
References: <cover.1483153436.git.mhagger@alum.mit.edu>
        <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net>
Date:   Sat, 31 Dec 2016 18:32:47 -0800
In-Reply-To: <20161231064746.6bvis76p5x5ubc2b@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 31 Dec 2016 01:47:46 -0500")
Message-ID: <xmqqr34n4ii8.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 95E60DF8-CFCA-11E6-AB6F-E17F7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Dec 31, 2016 at 04:12:40AM +0100, Michael Haggerty wrote:
>
>> This is a re-roll of an old patch series. v1 [1] got some feedback,
>> which I think was all addressed in v2 [2]. But it seems that v2 fell
>> on the floor, and I didn't bother following up because it was in the
>> same area of code that was undergoing heavy changes due to the
>> pluggable reference backend work. Sorry for the long delay before
>> getting back to it.
>
> I've read through the whole thing, and aside from a few very minor nits
> (that I am not even sure are worth a re-roll), I didn't see anything
> wrong. And the overall goal and approach seem obviously sound.
>
>> Michael Haggerty (23):
>
> I'll admit to being daunted by the number of patches, but it was quite a
> pleasant and easy read. Thanks.
>
> -Peff

Thanks, both.  These patches indeed were pleasant.
