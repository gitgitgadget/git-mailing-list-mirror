Return-Path: <SRS0=cWmm=5W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED380C2BA17
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EDD620678
	for <git@archiver.kernel.org>; Mon,  6 Apr 2020 18:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="J+cHVEvH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgDFSBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:01:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58128 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgDFSBh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 14:01:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0373CBF80B;
        Mon,  6 Apr 2020 14:01:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=D4hBnHGdl8SH
        P4/lBk/18UznhMw=; b=J+cHVEvHbnfufGF/GMLn1LxuNSrgyCUZcPK11BwBXCOB
        IiMmbpqVJiojWfJgax5t4Pt3U87ynHaRdO8cD+3b3BTAgKCgFMlIxHNvE62NXfLy
        pQ4ORRvXTDT6pLEKY7yDyTNtNhal0LMmE0eu1LaHAwdrbwG0AT2iYuTrrkckCrc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=PYOHIs
        P1HZ2/zVFaKUVBrzFWIbkXTsgPOovDZ1uA//J53rJ+WvfmuTe9hHm1DCRW8fHZgL
        t/xLnd6TOf+18QSKsAiZe1mZe8GgpseVGrEqK0GiOkrnoBIGMyV50YNLeURzQfbM
        pv6qhdVIfYBh+NrN8OWbB/jruMrfljKTUWLk8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDFEEBF80A;
        Mon,  6 Apr 2020 14:01:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DC6FFBF807;
        Mon,  6 Apr 2020 14:01:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?VG9tw6HFoSBQcm9jaMOhemth?= <tomas.prochazka5d@gmail.com>,
        git@vger.kernel.org, tomas.volf@showmax.com
Subject: Re: Fwd: Q: use '-C' flag with 'git config --global'
References: <CA+Sgv42V+xfoJVoFpPkWREXT0yuKZDeMDEGa3y8NDVU-4D1iYA@mail.gmail.com>
        <CA+Sgv42bOAaRBX99EpgpnSkGXFCWFpED7hwdwkWmPSOKuL1VBg@mail.gmail.com>
        <20200406130524.GA1276@coredump.intra.peff.net>
Date:   Mon, 06 Apr 2020 11:01:31 -0700
In-Reply-To: <20200406130524.GA1276@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 6 Apr 2020 09:05:24 -0400")
Message-ID: <xmqq4ktwwl1g.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A621666A-7830-11EA-82BF-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Apr 06, 2020 at 10:48:06AM +0200, Tom=C3=A1=C5=A1 Proch=C3=A1zk=
a wrote:
>
>> [includeIf "gitdir:~/Workspace/Showmax/"]
>>    path =3D ~/Workspace/Showmax/.gitconfig
>> [...]
>> I get correct email setting if I run command without `--global` flag.
>> But What I understand from the [`git-config`
>> docs](https://git-scm.com/docs/git-config#_description) if no flag is
>> passed the values are read from system, global and local.
>
> Right, I'd expect that to work, but...
>
>> If I run commands one by one, No returns the ~correct~ expected email:
>>=20
>> ~ $ git -C <pwd/to/showmax/project> config --system user.email
>> ~ $ git -C <pwd/to/showmax/project> config --global user.email
>> tomas.prochazka5d@gmail.com
>> ~ $ git -C <pwd/to/showmax/project> config --local user.email
>
> There's another difference when asking to read from a specific file:
> includes are not turned on by default. Try
>
>   git -C ... config --global --includes user.email
>
> This is covered briefly in git-config(1):
>
>   --[no-]includes
>     Respect include.* directives in config files when looking up values=
.
>     Defaults to off when a specific file is given (e.g., using --file,
>     --global, etc) and on when searching all config files.
>
> This can be confusing, but was necessary to keep compatibility with
> scripted manipulations of those files when includes were introduced.

So, in short, the mention of -C in the report was red herring and it
was all about --(system|global|local)?
