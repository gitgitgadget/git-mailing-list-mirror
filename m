Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE91A1F462
	for <e@80x24.org>; Tue, 28 May 2019 13:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727536AbfE1N5j (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 09:57:39 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52581 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbfE1N5j (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 09:57:39 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8B5D26AA42;
        Tue, 28 May 2019 09:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=gQtClbGKdAj4
        cIe1A7TTLGBcnTo=; b=fRVf9TmMiQXpXb96m21bgK1s5nExPSsMOmdQOss4yJKA
        oZGXnKpwaxC667ifcAoEN74Yd/yQXczV5yV/c6AuDmsHSdU77rNr+wLWKHfFDDl1
        NnI8Zc+Ccmo8i9u7g6KZwfjHslikFSO9nDkxW08ed6tNEpfoAOiVlhBn2WrWcb0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PQo4HN
        X0nshcM/NHjYBk+wmNSwxLMCDwVr078IoPdyDH/+AAqSPlKb9Ifif8rUWa37rtUd
        +6w6ekU6y8rtGOce8wK7+tD1Tt/cv+ym5fU9Vu/H1CRidPyZ6sNyhDLTOKq3cUyZ
        RoRvlrsT899fZz6z8ZTBayLWm+PDpPuhNCukk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8365F6AA41;
        Tue, 28 May 2019 09:57:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B48076AA3F;
        Tue, 28 May 2019 09:57:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Command to list <pattern> Branches on a specific Remote (i.e. select from rtb's)
References: <dcdff07d-77c7-8cb8-fa06-82acda5fe9ec@iee.org>
        <87lfz3vcbt.fsf@evledraar.gmail.com>
Date:   Tue, 28 May 2019 06:57:32 -0700
In-Reply-To: <87lfz3vcbt.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 18 May 2019 20:37:10 +0200")
Message-ID: <xmqqa7f6el6b.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8B65316C-8150-11E9-807F-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> That's:
>
>     git for-each-ref 'refs/remotes/<remote>/<pattern>'
>     git branch -a -l '<remote>/<pattern>'
>
> The latter will conflate <remote> with any local branches you happen to
> have prefixed with <remote>.

Wouldn't "branch -r -l <remote>/<pattern>" be without that downside?
Why use "-a"?
