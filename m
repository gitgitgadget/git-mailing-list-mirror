Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31F61F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 21:20:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751745AbdAYVU5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 16:20:57 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54365 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751374AbdAYVU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 16:20:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 77B2664157;
        Wed, 25 Jan 2017 16:20:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/1S3zxTB57Lf
        kD1isQpUaEtc+Dw=; b=L7cVXrg/AtxvoRB8+b4GwemVkPqnPyY/N3HsmkkIqGTm
        LoDqx73MBFXJss71zbGOalaLnCUuLrFViO4J6hCVcDcp5X/o3lc559xMIZr2jUJh
        ID/UcWaNTtQ2wogog72RsCRQMweviIPQpyFMQUqkctFShHiwTApFXDpwDEaLqMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=HOI7C9
        b9uLDC601At2sEW5Ic8LZ1ENbAuAClajjSmtKjDpX47FKIS0PayO7YMvWsoZA9wn
        bn1ygwNit01ktnkdXNq4l4Lq0z5hmTRR1VG6jvTYB+EVvCIqBZzvgFL/wHMKpFXP
        iT4tvcJrXjaFx1pIGeze4zcpumCdGMMHLAdnk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6F4B964156;
        Wed, 25 Jan 2017 16:20:55 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B56F264155;
        Wed, 25 Jan 2017 16:20:54 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Jeff King <peff@peff.net>, Thomas Gummerer <t.gummerer@gmail.com>,
        git@vger.kernel.org, Stephan Beyer <s-beyer@gmx.net>,
        Marc Strapetz <marc.strapetz@syntevo.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] Documentation/stash: remove mention of git reset --hard
References: <20170121200804.19009-1-t.gummerer@gmail.com>
        <20170121200804.19009-2-t.gummerer@gmail.com>
        <20170124201415.zzyg4vt35vflwjnb@sigill.intra.peff.net>
        <d327cfc5-2f0d-1a67-d5f5-b9b7a06f7570@gmail.com>
Date:   Wed, 25 Jan 2017 13:20:53 -0800
In-Reply-To: <d327cfc5-2f0d-1a67-d5f5-b9b7a06f7570@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 25 Jan 2017 14:02:32
 +0100")
Message-ID: <xmqqbmuualai.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 27E9A552-E344-11E6-ABDC-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>>> -	Save your local modifications to a new 'stash', and run `git reset
>>> -	--hard` to revert them.  The <message> part is optional and gives
>>> +	Save your local modifications to a new 'stash', and revert the
>>> +	the changes in the working tree to match the index.
>>> +	The <message> part is optional and gives
>>=20
>> Hrm. "git reset --hard" doesn't just make the working tree match the
>> index. It also resets the index to HEAD.  So either the original or yo=
ur
>> new description is wrong.
>>=20
>> I think it's the latter. We really do reset the index unless
>> --keep-index is specified.
>
> I wonder if it is worth mentioning that "saving local modifications"
> in 'git stash' means storing both the state of the worktree (of tracked
> files in it) _and_ the state of the index, before both get set to
> state of HEAD.

Yes, it is, I would say.
