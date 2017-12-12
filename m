Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E2D11F406
	for <e@80x24.org>; Tue, 12 Dec 2017 22:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbdLLW6r (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Dec 2017 17:58:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55654 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752679AbdLLW6q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Dec 2017 17:58:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 241A5CB34E;
        Tue, 12 Dec 2017 17:58:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=amVGksSyKfUF
        ZuIwDGWn6Uodgu4=; b=hE+3f3qofIucq+xE0h8QpcsyTStQcF+Fy/w+NJafdN9y
        8tBH1ntSWCHfxWytFl/jIU3qSyVOZ7o+unCFm9Sy61CWn2ofkyA0jAdhPYViCYB/
        GhrpPBb/eVQcpO4CEIv+NsAtilgSpSySLVuvSRfhr4DXlRt7+mhtMqjqcLj2OXE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=LPdvgX
        ISsVp1fNRsVnHA6fNWtVEicLe0WImyccndNAa3+DYQg7SpA8Qc0KskkQURMMebgK
        A9TnTQklg/ODuLasZ6ISV3Z2kf7dPlFt8Q56uUAZR6sHpLdIeieR+EFmfr8fjycT
        +VLT+KBt0ddzosk+iVqOMg84gJ4IPmSC4oYbs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1A3E6CB34D;
        Tue, 12 Dec 2017 17:58:46 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7EEF8CB34C;
        Tue, 12 Dec 2017 17:58:45 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] Makefile: allow NO_DC_SHA1_SUBMODULE to be set in config.mak
References: <7272c221-c1b6-ca41-3be4-329275e94b8a@ramsayjones.plus.com>
        <xmqqk1xr204t.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4DFXYNZyU-QPrun2g4zTpt8u6yE6DsEGsQvOEhUNRd8Q@mail.gmail.com>
        <xmqq609bziz5.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 12 Dec 2017 14:58:44 -0800
In-Reply-To: <xmqq609bziz5.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 12 Dec 2017 14:20:30 -0800")
Message-ID: <xmqqy3m7y2mz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 01BA2E76-DF90-11E7-8119-575F0C78B957-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> I actually think that the block can go even further down, perhaps
>>> close to the run of choices "what variant are we building?" we make
>>> at around we have "ifdef NO_CURL".
>>>
>>> =C3=86var?
>>
>> Makes sense to me, do you want to squash this + your proposed edit &
>> I'll pick it up if there's another version, or I can re-submit.
>
> OK.  I'll squash in the 'move it further down' to the original
> commit that removed DC_SHA1_SUBMODULE and added NO_DC_SHA1_SUBMODULE
> when rebuilding 'pu' branch.
>
> Thanks.

Another minor thing I noticed (which I do not have any squashable
fix for) is that "make distclean" does not even work without
submodule or this environment, which feels a bit too excessive.  I
haven't tried to figure out how involved a fix for that would be yet
and I do not mind leaving it broken if it would be too much work.

