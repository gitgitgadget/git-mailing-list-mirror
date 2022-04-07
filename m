Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 920A8C433F5
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 17:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346645AbiDGRy4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 13:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346008AbiDGRyy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 13:54:54 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BA922EBFE
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 10:52:53 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6740017CE04;
        Thu,  7 Apr 2022 13:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uQEgvSEXCJ/4ekrh6yTCimjS+6FYWR5llZn7iB
        nUKLM=; b=A2oNnMExiCFNHiiL4Pocbup56KkVo+UuUknnMfxnha/ze6hniF9lsi
        DkH5HrxqVVl6hb86hoXusfSFxMFk7g958I0MNiNkpeuPL6nvhwNeCwAHrK25zaAZ
        w6NyIJN58XAjoDnRJZ4+6ATEpFao9PE8j5YBC/Ei93wkSlMEJPnCc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5FEDC17CE02;
        Thu,  7 Apr 2022 13:52:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B3E6317CE00;
        Thu,  7 Apr 2022 13:52:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/3] run-command.h: rename "env_array" to "env"
References: <Ybtb6Shdj56ACdub@coredump.intra.peff.net>
        <cover-0.3-00000000000-20220406T104134Z-avarab@gmail.com>
        <nycvar.QRO.7.76.6.2204071407160.347@tvgsbejvaqbjf.bet>
        <xmqqilrku9ef.fsf@gitster.g>
Date:   Thu, 07 Apr 2022 10:52:48 -0700
In-Reply-To: <xmqqilrku9ef.fsf@gitster.g> (Junio C. Hamano's message of "Thu,
        07 Apr 2022 09:48:40 -0700")
Message-ID: <xmqqpmlssrv3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A43EF66-B69B-11EC-AFFD-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> Good thinking about the first batch after release. However, please do send
>> such cleanups really only after the release. The reason for the patch
>> slowdown is that we want to be able to focus on making a rock-solid
>> v2.36.0. This here patch series is very much a distraction at this point.
>
> OK.
>
> FWIW, I have it near the tip of 'seen', but if any fix that is more
> urgent than these changes need to be added to 'next' and down to
> 'master' makes the version queued no longer apply, I will drop it
> immediately, instead of spending cycles to figure out if it is worth
> resolving the conflict and requeuing it in 'seen' during the -rc
> period ;-)

To be fair, I actually do appreciate an early heads-up to warn
against other contributors to think twice before adding more uses of
the env-array and consider if a different approach without using the
env-array would result in better code.  It would have been better to
stress on such an early warning aspect of the series by marking the
series explicitly "not for application during -rc".

The true -rc freeze where nothing goes into 'next' (unless it is a
regression fix for this cycle) starts tomorrow at -rc1; I think I've
picked up everything relevant that have been posted in the past few
days.

Thanks.
