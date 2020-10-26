Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 569F9C2D0A3
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B59222C8
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 18:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NKbIM5EF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1783210AbgJZSBY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 14:01:24 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56020 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1783101AbgJZSBP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 14:01:15 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5CE30907A7;
        Mon, 26 Oct 2020 14:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=TkfQ0ljrJmWe
        4wykoIL9ScVLj0c=; b=NKbIM5EFytx6YcotJI6M4X72SVh+Y+dQjYl5PdkN9umJ
        p9LhESrSZLlpeLCjJRLieY8dgoC01yNGSdMyZaHDDCl9reVV4Evku5pe+aYVCv+D
        MP8OZIDfSg0CDwMcp9yOk4rEtQgBoMCMRjgtkiJUs5o6aypsx/NfpnLz++w1DTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Kzp6nH
        Ak7magYZCOVCVWgE2VgOaCvwv6ysoGHJhBZQ1BUuJinLk5KtF1haOcjlo2D2jk9L
        Ox/eqZxLBkXyhvB2lj3BZ9KT5PkF9icoKjE14mxTrjv1B6W2EzECAjaVD1nUOVGX
        u2iTZBs7/pKSQs4WockhBW1bk+wVo7ojf3TA4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4B1FE907A6;
        Mon, 26 Oct 2020 14:01:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83146907A5;
        Mon, 26 Oct 2020 14:01:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.29.0-rc1
References: <xmqq7drzv1bn.fsf@gitster.c.googlers.com>
        <ce8f482f-9a78-6867-38ae-601bcc2c9f66@web.de>
        <xmqqmu0rqu8h.fsf@gitster.c.googlers.com>
        <61bafa3b-bd23-f01f-9a4a-c348b7588f37@web.de>
        <e135ac82-49f1-e06c-45d7-6b3b9f9837c6@web.de>
Date:   Mon, 26 Oct 2020 11:01:11 -0700
In-Reply-To: <e135ac82-49f1-e06c-45d7-6b3b9f9837c6@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Sat, 24 Oct 2020 19:52:49 +0200")
Message-ID: <xmqqtuugeujc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3BDBFB6A-17B5-11EB-A807-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 12.10.20 um 21:19 schrieb Ren=C3=A9 Scharfe:
>> Am 12.10.20 um 18:33 schrieb Junio C Hamano:
>>> If this "feature" were experimental and if the experiment turns out
>>> to be a failure, would we have a viable alternative definition?
>>>
>>> Perhaps "--add-file names an untracked file in the working tree and
>>> the single '--prefix' that is used for entries that come from the
>>> tree object is applied"?  Or perhaps remove --add-file entirely as a
>>> failed experiment?
>>
>> Removing --add-file entirely is certainly possible, but it's used in t=
he
>> Makefile now and I can't imagine what would make its disposal necessar=
y.
>>
>> Turning it into a standard OPT_STRING_LIST option for full untracked
>> paths and using the last --prefix value for all archive entries would =
be
>> a more straightforward UI and might be versatile enough.
>
> Here's how that would have looked, but it seems I'm too late.

I think the "unusual --prefix semantics" does not hurt that much.
If people can play funny games, they can, but if they do not want to
confuse themselves, they can just give a single --prefix at the very
beginning (or no --prefix at all of course), and then the semantics
they will get is the same as what this add-on patch gives, I think.

> The Makefile rules get a bit more fragile because the version files are
> special and the simpler --add-file forces us to create them at their
> actual place if not present, which can lead to problems (stuck version)
> if we don't delete them afterwards.  Avoiding that was the reason for
> the more complicated version that ended up in v2.29.  That fragility
> could be defused by teaching GIT-VERSION-GEN about version_is_generated=
.

Thanks for a thoughtful analysis, as usual.

