Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 476BE208B4
	for <e@80x24.org>; Wed,  2 Aug 2017 15:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbdHBPhV (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Aug 2017 11:37:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55917 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751914AbdHBPhT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Aug 2017 11:37:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 603809A4A5;
        Wed,  2 Aug 2017 11:37:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=GLf2mSTXduyI
        N83vo2rN4G5aCWI=; b=Fe/0B73BQ665ozszRhDUAP0RP3HfPp/nWSjMdBf2Shp8
        0R68xiO3ZXSZYGjLGYEaecI5D+RT8/Nj/rxx2UhwxlZf9Eu2eanXeAaWqD+rdYsh
        FhP87ZGd6fgeFdL2CpZGQpVO9wx5oIfiP5tNKjdDRX7kdMr/it9PecfKdrCHtBs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=XI2dpF
        Sdgjd4hNRSdkJxdemtUjFyCJdip3zUG3EsC/WLegASm864CRL2CARRByGNVzmUia
        Qnd1f804UJ/kOzbGT+3pi2X9PoQcLM2wKDQi3osxtpr2UhV+pwGABZcLVbBBPHDY
        aNNWBuVltDIo3PIcsK4LHY3GhN1cqR2aDC/mo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 568FA9A4A4;
        Wed,  2 Aug 2017 11:37:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 82D3B9A4A3;
        Wed,  2 Aug 2017 11:37:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [RFC] The correct and consistent alternative to quote a command ?
References: <8256C530C7DE43D7BC72BFB327DF4726@PhilipOakley>
        <20170730161816.2412-1-kaarticsivaraam91196@gmail.com>
        <CAGZ79kYg9jQ3kaKnNEJCH9fde=ar1KPiUr7=X+TguNc0Twqdzg@mail.gmail.com>
        <1501603171.1671.8.camel@gmail.com>
        <CAGZ79kY_NdBe1QjJWrLUkfDOk8Zrnopa945F1xBq=WFDNpRWMg@mail.gmail.com>
        <1501676577.1957.4.camel@gmail.com>
Date:   Wed, 02 Aug 2017 08:37:16 -0700
In-Reply-To: <1501676577.1957.4.camel@gmail.com> (Kaartic Sivaraam's message
        of "Wed, 02 Aug 2017 17:52:57 +0530")
Message-ID: <xmqqo9rydlqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7721A122-7798-11E7-ADC8-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kaartic Sivaraam <kaarticsivaraam91196@gmail.com> writes:

> On Tue, 2017-08-01 at 10:38 -0700, Stefan Beller wrote:
>> On Tue, Aug 1, 2017 at 8:59 AM, Kaartic Sivaraam wrote:
>> > I assume you mean the consistency in quoting i.e., you're expecting =
the
>> > patch to use (") instead of (') for quoting. Correct me, if I'm wron=
g.
>>=20
>> Actually I did not imply any expectation on the outcome, because I
>> do not know what the consistency end game looks like for this issue.
>>=20
>> So maybe we'd want to go with the currently most used way?
> On scanning through Documentation/SubmittingPatches, I saw that most of
> the commands were quoted using double quotes and chose to use it for
> this patch.=C2=A0I'm not sure if it's the right one to use.

After reading the patch before seeing the above, I also came to the
conclusion that the above is exactly what you are aiming at, and I
thought that was a reasonable thing to do.

