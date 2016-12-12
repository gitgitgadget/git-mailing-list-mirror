Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3724206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 18:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753358AbcLLSdE (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 13:33:04 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64278 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752488AbcLLSdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 13:33:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD63558098;
        Mon, 12 Dec 2016 13:33:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=tSjV+gmUAIdh
        enwDcrZF/ufgZLI=; b=gXbDzNgbS6CjkAtZVGmIguChRR6KmSoqn6g6PcFEMc2T
        LDNTBgpQMPtYK11I9IR1djd2a1IOO6qy2lzUvKQtiGj8BjPMQj7ybn4BgjQG/xN7
        ODrzJHBwetp/MaeheimJbFk1aPRxVRKubL0PKethaWvt7tAfO2RoeTVRD8iBvUc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=KP2E3C
        SXJizCCa3K3QANBnP5da4PD6wB0MNMglhLygtljSfN3QrcsgCaAq3tXbN0F4tswz
        CEEHhwgqLKiHObbYK+HiP6Ypgg8Vc8fA2az2+UNSPiZl+upNvdFtxdev0/uLUhds
        FYfRmXKF4SLWm1abC4692t+3oO24i08WHQEPk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B441B58096;
        Mon, 12 Dec 2016 13:33:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3825D58094;
        Mon, 12 Dec 2016 13:33:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org
Subject: Re: [PATCH 1/3] update_unicode.sh: update the uniset repo if it exists
References: <1481499265-18361-1-git-send-email-dev+git@drbeat.li>
        <64bc846c-0304-dd7b-73bf-a6c3a4135381@web.de>
        <c96d013c38df7737cfd551a0fce87314@drbeat.li>
        <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de>
Date:   Mon, 12 Dec 2016 10:33:00 -0800
In-Reply-To: <ca10a51a-0fab-e4a4-8d7d-035673af4c06@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Mon, 12 Dec 2016 19:12:38
 +0100")
Message-ID: <xmqqr35dm203.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A027ED2-C099-11E6-B602-E98412518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> If I run ./update_unicode.sh on the latest master of
> https://github.com/depp/uniset.git , commit
> a5fac4a091857dd5429cc2d, I get a diff in unicode_width.h like
> this:
>
> -{ 0x0300, 0x036F },
>
> +{ 768, 879 },
>
> IOW, all hex values are printed as decimal values.
> Not a problem for the compiler, but for the human
> to check the unicode tables.
>
> So I think we should "pin" the version of uniset.

Sure, and I'd rather see the update-unicode.sh script moved
somewhere in contrib/ while at it.  Those who are interested in
keeping up with the unicode standard are tiny minority of the
developer population, and most of us would treat the built width
table as the source (after all, that is what we ship).

To be bluntly honest, I'd rather not to see "update-unicode.sh"
download and build uniset at all.  It's as if po/ hierarchy shipping
with its own script to download and build msgmerge--that's madness.
Needless to say, shipping the sources for uniset embedded in our
project tree (either as a snapshot-fork or as a submodule) is even
worse.  Those who want to muck with po/ are expected to have
msgmerge and friends.  Why not expect the same for those who want to
update the unicode width table?

I'd rather see a written instruction telling which snapshot to get
and from where to build and place on their $PATH in the README file,
sitting next to the update-unicode.sh script in contrib/uniwidth/
directory, for those who are interested in building the width table
"from the source", and the update-unicode.sh script to assume that
uniset is available.
