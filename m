Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C896FCCA47A
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiFPQuh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:50:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbiFPQue (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 12:50:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EB11B8A
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 09:50:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 717EC18F04B;
        Thu, 16 Jun 2022 12:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2J28dyRJhqH4
        iSJolEksxVw53bqvcQbrHuPAZdgw4Bg=; b=DeJeJrwWEFKe/Z/DKsS/ir3kh+J+
        7uIvfrSlJxZ8m6pf6upxkl2dXim2+Kci/+8y5nlFEUmLaLZ3xF1OH5xTUyFepOKY
        wDn7PLymQ8cTK8Du3UZViWyHuBQ743QHu56aH09HyvClNNU9ngXGb2AY32wnCNOB
        /FdoEHToVdMPWGI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 693B518F04A;
        Thu, 16 Jun 2022 12:50:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5E20318F049;
        Thu, 16 Jun 2022 12:50:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael J Gruber <git@grubix.eu>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] t3701: two subtests are fixed
References: <cf6aee9acadfb666de6b24b9ed63e1a65bfc009e.1655220242.git.git@grubix.eu>
        <nycvar.QRO.7.76.6.2206151649030.349@tvgsbejvaqbjf.bet>
        <165537087609.19905.821171947957640468.git@grubix.eu>
Date:   Thu, 16 Jun 2022 09:50:27 -0700
In-Reply-To: <165537087609.19905.821171947957640468.git@grubix.eu> (Michael
        J. Gruber's message of "Thu, 16 Jun 2022 11:14:36 +0200")
Message-ID: <xmqqsfo4v9gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6D28FD92-ED94-11EC-829B-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber <git@grubix.eu> writes:

> Johannes Schindelin venit, vidit, dixit 2022-06-15 16:50:40:
>> Hi Michael,
>
> Hallo Dscho!
>
>> On Tue, 14 Jun 2022, Michael J Gruber wrote:
>>=20
>> > 0527ccb1b5 ("add -i: default to the built-in implementation", 2021-1=
1-30)
>> > switched to the implementation which fixed to subtest. Mark them as
>> > expect_success now.
>>=20
>> Good catch!
> =20
> I'm no list regular anymore, but still a "next+ regular". While
> experimenting with my own patch I noticed something got fixed
> unexpectedly. That goes to show that these unexpected successes
> (from expect_failure) go unnoticed too easily. I had missed this on my
> regular rebuilds.

Thanks for being a "next+ regular".  They are giving us a valuable
service to catch bugs and questionable design decisions before they
hit the "master" branch.

> =C3=86var noticed this and has a better version of my patch, I think.

Yup.  Eventually we will make it even impossible to opt out of the
built-in variant, but until then, we'd need the conditional stuff.

Thanks.
