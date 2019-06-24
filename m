Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43AED1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730849AbfFXRF1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:05:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52811 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726920AbfFXRF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:05:27 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F3D9B15D5BE;
        Mon, 24 Jun 2019 13:05:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Xzrd2qhbkseD
        nOU7tpVDZGJVWEA=; b=rz25oLzG0H7uNO3J0HK2cu8ouFDG+hoS9oqlKxDHaNYC
        qaRgo1VPFc1PMrw4fl3TxHIA+jZswjMB8CtR9NHwIsTsRTBgivjUyRX59gCLmWSQ
        HWhL/sOBWyfA1Nz5P+PcXvKfw9kE+XQVcpAoF3YQw2E2xUY/o4xaiFTEAIdCZEM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=lZL+CJ
        WVVganfEEVYROPQc9I/+fYJMW93LW+ZWPu8ajebsdrFAA8gA2P+6XXxV7FW9TrGi
        NN08iQgJT/LiGtan4wypekNaHx0dnY0HR2WNmDBx0s3g+hcUx7LmVsht57QjovNn
        JY8RDpXNlhbj33ij+WCGBZvtsmbSUfYWoJk9U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EA5B815D5BD;
        Mon, 24 Jun 2019 13:05:24 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4390515D5BC;
        Mon, 24 Jun 2019 13:05:24 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Andrey <ahippo@yandex.ru>
Cc:     "git\@vger.kernel.org" <git@vger.kernel.org>, luke@diamand.org
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
        <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net>
Date:   Mon, 24 Jun 2019 10:05:23 -0700
In-Reply-To: <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net> (Andrey's
        message of "Sat, 22 Jun 2019 05:46:50 -0400")
Message-ID: <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 41B75786-96A2-11E9-B404-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Andrey <ahippo@yandex.ru> writes:

> 20.06.2019, 00:35, "Junio C Hamano" <gitster@pobox.com>:
>> * am/p4-branches-excludes (2019-04-02) 8 commits
>> =C2=A0- git-p4: respect excluded paths when detecting branches
>> =C2=A0- git-p4: add failing test for "git-p4: respect excluded paths w=
hen detecting branches"
>> =C2=A0- git-p4: don't exclude other files with same prefix
>> =C2=A0- git-p4: add failing test for "don't exclude other files with s=
ame prefix"
>> =C2=A0- git-p4: don't groom exclude path list on every commit
>> =C2=A0- git-p4: match branches case insensitively if configured
>> =C2=A0- git-p4: add failing test for "git-p4: match branches case inse=
nsitively if configured"
>> =C2=A0- git-p4: detect/prevent infinite loop in gitCommitByP4Change()
>>
>> =C2=A0"git p4" update.
>>
>> =C2=A0Is this ready for 'next'?
>
> Junio,
>
> I haven't got any new feedback on the patch series in the past 2.5 mont=
hs.
> From my point of view, these are ready for next.

Thanks.  When I ask "Is this ready", I am asking for opinion(s) from
third-party, not self nomination ;-)

Let's merge it down to 'next' and to 'master' anyway.


