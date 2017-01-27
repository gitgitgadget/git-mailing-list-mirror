Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78521F437
	for <e@80x24.org>; Fri, 27 Jan 2017 18:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750718AbdA0STk (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jan 2017 13:19:40 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53950 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932552AbdA0SSk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2017 13:18:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 72D4F6189A;
        Fri, 27 Jan 2017 13:18:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=g5PJn/9koMGB
        n/lVzaIMfrIenW4=; b=n2vk0PC1zaQm5PXiqaHyz8hkbAGMamtCofxjXlELq7oj
        vJdtFBz/5ilrcvAGATPQZOrgS373l+JWs3k/JI+systisN19oJ3Tij5aj0lvAzv3
        H27wRq9Nl9M+EKZEo3JBXqiJYpwzPbazVMz5uI+BgiwE/kIaIcd3YiLxSknnqYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=GK/3Hg
        lBu0ZpEbvLMFLYj+C5c0Bo9dT331qfWlv0BgoVEFewNcWSxzw6Ag69tBQvmIbWkv
        yZY25LDnMKauQaUO2dg5EAVmtqA3peRy28fkokf8JHXD0NkuCnTcDqTpVjaPrSEg
        IgW0GbM0N1ubOUPAvE8fHuvTO6j05tbc41S3c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6ABBA61899;
        Fri, 27 Jan 2017 13:18:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CFEE761896;
        Fri, 27 Jan 2017 13:18:38 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] use absolute_pathdup()
References: <d94d742d-1247-ac35-c081-7db1f2178d34@web.de>
        <d15fdbb9-2a21-eeab-1fee-4a1553bd3bcb@web.de>
        <alpine.DEB.2.20.1701271121120.3469@virtualbox>
        <0555c0aa-fcb4-19fb-a533-c451e1e477e3@web.de>
Date:   Fri, 27 Jan 2017 10:18:37 -0800
In-Reply-To: <0555c0aa-fcb4-19fb-a533-c451e1e477e3@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 27 Jan 2017 16:39:39 +0100")
Message-ID: <xmqqlgtwz7r6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0665A758-E4BD-11E6-A26C-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Hi Dscho,
>
> Am 27.01.2017 um 11:21 schrieb Johannes Schindelin:
>> On Thu, 26 Jan 2017, Ren=C3=A9 Scharfe wrote:
>>> Apply the symantic patch for converting callers that duplicate the
>>
>> s/symantic/semantic/
>
> thank you!  I wonder where this came from.  And where my spellchecker
> went without as much as a farewell.  Reinstalled it now..
>
> Ren=C3=A9

Thanks.  I've already locally amended this.
