Return-Path: <SRS0=IU/p=Z2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A3EC2BC73
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9C20862
	for <git@archiver.kernel.org>; Wed,  4 Dec 2019 18:15:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KL0KwEw6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732001AbfLDSPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Dec 2019 13:15:05 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63492 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731992AbfLDSPD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Dec 2019 13:15:03 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 88F6332AEB;
        Wed,  4 Dec 2019 13:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=j+JdonKrEpWE
        fSEUwi9FhTNSPZQ=; b=KL0KwEw6A+E1uf64icENaW/zMaWP6+F9wRZK9SclH9/p
        1krJYZwqlfnfOiW0d89hGFNnY69fiICkydKYhPlkM2XEhDDqLLRnR8DtzJaQvT2i
        agwX/SIYw/ryPYcxRop7iJvOZ2fqEVXe7LF8cegY1CFhsPiz7A2W0URq3GtyKPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=qJq25C
        0ljI7pzIcKnF+mrBFNdVSvMLoyXhPBJT5Bic+9ZMDTBh/SmXP4k+GlIrFObEPMMp
        g8zMMPGf7+Wa/yHYrhpgI6W4Ldg0ZymIs2N3mlLewdmMSkzkRUXMMsPpJKIOS8BY
        VNWDMhSrFyTm8nBGK21OadMjY2llFoUj2+Qkw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6ACF432AE8;
        Wed,  4 Dec 2019 13:15:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9B68632ADC;
        Wed,  4 Dec 2019 13:14:59 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2019, #01; Mon, 2)
References: <xmqqpnh6yfrl.fsf@gitster-ct.c.googlers.com>
        <20191202210534.GA49785@generichostname>
        <xmqqy2vt5ppk.fsf@gitster-ct.c.googlers.com>
        <20191204061917.GB3381576@generichostname>
Date:   Wed, 04 Dec 2019 10:14:58 -0800
In-Reply-To: <20191204061917.GB3381576@generichostname> (Denton Liu's message
        of "Tue, 3 Dec 2019 22:19:17 -0800")
Message-ID: <xmqqwobc3ql9.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: FBC24204-16C1-11EA-9531-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> On Tue, Dec 03, 2019 at 08:38:47AM -0800, Junio C Hamano wrote:
>> Denton Liu <liu.denton@gmail.com> writes:
>>=20
>> > Ren=C3=A9 sent a v2 for the above commit here[2].
>> > ...
>> > [2]: https://lore.kernel.org/git/a56a4b33-61f8-d3a5-d85f-431c70b8f3e=
7@web.de/
>>=20
>> That is what has become ed254710 ("test: use test_must_be_empty F
>> instead of test_cmp empty F", 2019-11-27), I think.
>
> Hmm, perhaps it was human error on my part but I was pretty sure that I
> saw the `PIPE` when I was looking at the branch on GitHub. Maybe there
> was some issue related to whatever Elijah was experiencing earlier as
> well?
>
> Anyway, double-checking now, that commit looks correct to me. Sorry for
> the false alarm.

Thanks for checking.  Better to see occasional false alarms to
make me double check than letting mistakes fall through the cracks.
