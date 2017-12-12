Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30A5E1F419
	for <e@80x24.org>; Tue, 12 Dec 2017 22:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752672AbdLLWUd (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 17:20:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53250 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752320AbdLLWUc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 17:20:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 204CDCA873;
        Tue, 12 Dec 2017 17:20:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=K6hRDwgsRojV
        10REoBFCVdV/F+Y=; b=iP/G8VFYxsk9+7KWO1gbW0+8r1jiz2nGweydW1CgqYNO
        xgY7YmaHeakQueM998ekIqfLF2e/Fdz/R5P+TlZgJJXltUyrhc+Ok2qeyILm7Nx+
        SmOHYIiE95lB6XQ+0d6zdFg5a4pnjkHezI7o30Geb36MzA7ZDINmO2Lrw6D2GCc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=NJP7i0
        +nKF+mENUGpAxwz3sspX2B+BqJ0ftpWIxGR2MpQfgthe5JLemmiTwBfC1kWtXJj3
        ++Or35/cVeJ5rvsB38nTZRrwP4qQbcRiff6RCmkM82RyY7OZpJea5CjiuDtCLNro
        4yCXf63eNiDwEz4qVLRJRSNtupffvAnSUpwLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 190BBCA871;
        Tue, 12 Dec 2017 17:20:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8EC8FCA86F;
        Tue, 12 Dec 2017 17:20:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
        <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4DFXYNZyU-QPrun2g4zTpt8u6yE6DsEGsQvOEhUNRd8Q@mail.gmail.com>
Date:   Tue, 12 Dec 2017 14:20:30 -0800
In-Reply-To: <CACBZZX4DFXYNZyU-QPrun2g4zTpt8u6yE6DsEGsQvOEhUNRd8Q@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 12 Dec
 2017 22:06:41
        +0100")
Message-ID: <xmqq609bziz5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: AA6F8FF8-DF8A-11E7-8156-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I actually think that the block can go even further down, perhaps
>> close to the run of choices "what variant are we building?" we make
>> at around we have "ifdef NO_CURL".
>>
>> =C3=86var?
>
> Makes sense to me, do you want to squash this + your proposed edit &
> I'll pick it up if there's another version, or I can re-submit.

OK.  I'll squash in the 'move it further down' to the original
commit that removed DC_SHA1_SUBMODULE and added NO_DC_SHA1_SUBMODULE
when rebuilding 'pu' branch.

Thanks.
