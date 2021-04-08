Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D0C9C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E7196115B
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 22:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbhDHWvr (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 18:51:47 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64004 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhDHWvq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 18:51:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E139B48AC;
        Thu,  8 Apr 2021 18:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zPip32HllCoB
        yqzOKkYQLmWJ3PU=; b=QUTM9Vr4v/XeoTbRD4XnwzkwKEu0ZkA9Zn7J69rFsij6
        IYSJIfQw0XfFA4bqwnOGiACh3ytfJTz81tptO1dkHJ5ZjHYgERxeneJPN+CW0JUT
        RHiAO1ewjrMvYmNOlu8kE1EDwG2CB8JXl8slXkMLoLEbUTWocKHZ/Mdrn5BByqo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=R2+VUo
        G0wPNg0KR0OENyJXnfySkaRyPIGypIZfsxOKi/e6uG/7pm8IW7Ks1pjxcc11tonp
        RtHZfI7oRH8v++jTrCOa+hRBkeKYhb4ZeqjfNFh71+xXOfR/5we6qcGdwSZLbZOh
        tUSF4Z0sEEW8aD+Lt6Vr3Sgwn/XEUjXNAlvBw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85EF5B48AA;
        Thu,  8 Apr 2021 18:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 182A7B48A9;
        Thu,  8 Apr 2021 18:51:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Georgios Kontaxis via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Georgios Kontaxis <geko1702+commits@99rst.org>
Subject: Re: [PATCH v6] gitweb: redacted e-mail addresses feature.
References: <pull.910.v5.git.1616817387441.gitgitgadget@gmail.com>
        <pull.910.v6.git.1616973963862.gitgitgadget@gmail.com>
        <87eefkieig.fsf@evledraar.gmail.com>
Date:   Thu, 08 Apr 2021 15:51:32 -0700
In-Reply-To: <87eefkieig.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 09 Apr 2021 00:43:19 +0200")
Message-ID: <xmqqblaoqtjf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F70EC92A-98BC-11EB-96B7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +sub hide_mailaddrs_if_private {
>> +	my $line =3D shift;
>> +	return $line unless gitweb_check_feature('email-privacy');
>> +	$line =3D~ s/<[^@>]+@[^>]+>/<redacted>/ig;
>
> The /i here is redundant, since you have nothing that'll case-fold on
> the LHS of the s///, doesn't harm anything either. Just a small note
> since it's new in v6...

True.  If it were left original version that was suggested during
the review, e.g.

	s/<[^@]+@[-.a-z0-9]+>/<red@cted>/ig;

the /i/ would have been needed, but without the "after the @-sign
should be a run of DNS-valid characters", I agree that there is no
need.

Thanks.  Will locally tweak.
