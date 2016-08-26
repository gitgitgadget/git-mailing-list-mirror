Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8E801FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 16:20:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754487AbcHZQUE (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 12:20:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65064 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751321AbcHZQUE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 12:20:04 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BC1ED36C00;
        Fri, 26 Aug 2016 12:20:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7lX3lDA4gnDl
        geK9Xe2TbzrzzGg=; b=Sa6/R9lY7T+31ASdvngJcD8e2YsCiXJnVu1ZHr6GpRre
        xtVk+wBpsB2aMZe6O+3Di9bG1sEQxJh2+o61znC7iEeBN5Y4jd5FcmcC2AHvNR73
        yZ9lj32GRcWopclxqeQoSGYA1WA8Dj6pVmWj3AyZJ+CNjm7lMAF54FbyF3DBV4E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gxtck4
        7347U9hbEWYapebG3QNqsziLzdus51HkmGcAiM425WcFBnHvN8ocGhSDPTKF8k7s
        pLtexjYGzoven5vk1yjcrfW2GzMzUbKE8eAhQ+aDWm/5Mr8P8gWbkwoqFt8GVAbY
        LKPxKeVnMOKf37RuZMVphYD6iBrtbmkH5RJv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 90B4236BFD;
        Fri, 26 Aug 2016 12:20:02 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3432C36BF8;
        Fri, 26 Aug 2016 12:20:01 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        GitList <git@vger.kernel.org>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH v6 06/12] doc: revisions: single vs multi-parent notation comparison
References: <20160811215035.4108-1-philipoakley@iee.org>
        <20160812234522.7792-1-philipoakley@iee.org>
        <20160812234522.7792-3-philipoakley@iee.org>
        <6b37851f-0f2f-0379-c10e-52f7da6b7110@gmail.com>
Date:   Fri, 26 Aug 2016 09:19:58 -0700
In-Reply-To: <6b37851f-0f2f-0379-c10e-52f7da6b7110@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 26 Aug 2016 17:30:59
 +0200")
Message-ID: <xmqqwpj3ijtd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: F057309A-6BA8-11E6-8540-51057B1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> W dniu 13.08.2016 o 01:45, Philip Oakley pisze:
>
>> +'HEAD{caret}2{caret}@', however you cannot say 'HEAD{caret}@{caret}2'=
.
>
> Though I do wonder if it is implementation limitation, or if it is some=
thing
> inherent in the notation, namely that <rev>^@ and <rev>^! resolve (the =
former
> at least in general, though not for every <rev>) to more than one revis=
ion
> specifier.

I think that the answer you are giving to the question is the latter,
and I tend to agree with you.

You could define: A^@ followed by <anything> means first expand A^@,
and then apply that <anything> to each and every one in the resulting
set.  But some may be merges and while others not.  It is unclear
what should happen to A^@^2 when one of A's parents has only one
parent.  In some use cases, it would be convenient if parents of A
to which the <anything> operation cannot be applied, but in other
use cases, it would be convenient if the whole thing caused an error.
The notation is not detailed/rich enough to express the distinction.


