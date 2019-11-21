Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D642AC432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 964B220715
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 00:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YLpnT8uV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfKUA0l (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:26:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56065 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbfKUA0l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 19:26:41 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50241339D3;
        Wed, 20 Nov 2019 19:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rCsTgq7VTXxS
        ELesdLUBVOWgaXA=; b=YLpnT8uVxCeqoc7vTjbkXV1/ULwcytP1dlkChJ32tgfA
        pge1fO+xtNR83ZfWoOsWHVWtExWn5p/SjAPRyS6Hx8fDLX+Lng0U3lCAnl+C/QWK
        WIVcWzLsSVgBrw8WV0ChLHR6bhEtgyZ/vF2VscME3w9nqEMgmLwxQU1oQ/wCAQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=rYrpnu
        kfpy/9TOh+zSYr/hBwNl6nGZaZQGQKQheovlblQm2ghOx0r+ODGUHEOFEpG5pdAj
        sMV3c+gPL281P8AmD7CVuub4vcenlwx8W8PUjO/Aog3vSiI2lr0vBUb7KEofDr5C
        ahKawfN5jsdG79tS9WAvWLNP2hCsC+tTMu4qk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 47513339D2;
        Wed, 20 Nov 2019 19:26:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A2B94339D1;
        Wed, 20 Nov 2019 19:26:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v3 1/1] ci(osx): use new location of the `perforce` cask
References: <pull.400.v2.git.1571316454.gitgitgadget@gmail.com>
        <pull.400.v3.git.1571789978.gitgitgadget@gmail.com>
        <9d80e845bf923c4543c49f9947aacb10c59ff6ce.1571789978.git.gitgitgadget@gmail.com>
        <20191118221804.GA23183@szeder.dev>
        <nycvar.QRO.7.76.6.1911192155140.15956@tvgsbejvaqbjf.bet>
        <xmqqk17ve45s.fsf@gitster-ct.c.googlers.com>
        <20191120225439.GA18277@szeder.dev>
Date:   Thu, 21 Nov 2019 09:26:37 +0900
In-Reply-To: <20191120225439.GA18277@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Wed, 20 Nov 2019 23:54:39 +0100")
Message-ID: <xmqq5zjeaxc2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 953C332C-0BF5-11EA-B43D-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Wed, Nov 20, 2019 at 10:18:39AM +0900, Junio C Hamano wrote:
>> ...
>> computes and outputs diffstat, which would only grow as the time
>> goes by and the repository cast in stone in the CI build image
>> becomes more and more stale relative to the upstream repository in
>> the outside world.
>
> Minor clarification: I, too, thought that the CI build images are cast
> in stone, but the Travis CI build images are definitely not (don't
> know about Azure Pipelines), but receive smaller updates from time to
> time, including updates to their Homebrew database.  Such a recent
> update necessitated commit 7d4733c501 (ci: fix GCC install in the
> Travis CI GCC OSX job, 2019-10-24).  I contacted Travis CI support
> about it, and they confirmed.

I do recall that their images are moving targets and updates to them
did disrupt our tasks in the past.  How about

    ..., which would grow as the repository that comes with the CI
    build image goes stale relative to ...

to tone it down?

Thanks.
