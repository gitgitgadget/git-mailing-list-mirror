Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447CFC433EF
	for <git@archiver.kernel.org>; Thu,  7 Apr 2022 16:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbiDGQut (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Apr 2022 12:50:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238015AbiDGQup (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Apr 2022 12:50:45 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B2F326F5
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 09:48:43 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ACEEA10A452;
        Thu,  7 Apr 2022 12:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dsyZWeQID+2D
        ulasBgtFgRWLB/Tp0agw6hpCBdZ/31Y=; b=dRCmNzUDdH9e6O92yRMm0ckRUpX6
        gE0tOTFHhUlzXl7imIv2SadqEPUI6EA6lZ9T24G7t8WeXbNmYd7KH+kGLKNxKXWR
        Z5PZACiYltaLS9fEPCl7FaGmguJTir6EFVnU6iaqrmnFVIn/MEmGnoAcdqnysIJk
        6iEOFcuKDl4Lboo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A465E10A450;
        Thu,  7 Apr 2022 12:48:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CC60910A44F;
        Thu,  7 Apr 2022 12:48:41 -0400 (EDT)
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
Date:   Thu, 07 Apr 2022 09:48:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2204071407160.347@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Thu, 7 Apr 2022 14:09:26 +0200 (CEST)")
Message-ID: <xmqqilrku9ef.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 94BD2D30-B692-11EC-A700-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 6 Apr 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> Junio: We're in the RC period, but perhaps this change if we're ever
>> going to make it would be good to make around that time of patch
>> slowdown. I.e. for the first batch after release.
>
> Good thinking about the first batch after release. However, please do s=
end
> such cleanups really only after the release. The reason for the patch
> slowdown is that we want to be able to focus on making a rock-solid
> v2.36.0. This here patch series is very much a distraction at this poin=
t.

OK.

FWIW, I have it near the tip of 'seen', but if any fix that is more
urgent than these changes need to be added to 'next' and down to
'master' makes the version queued no longer apply, I will drop it
immediately, instead of spending cycles to figure out if it is worth
resolving the conflict and requeuing it in 'seen' during the -rc
period ;-)

