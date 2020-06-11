Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD760C433DF
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97C7520691
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 15:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2nLy2mg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728484AbgFKPOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:14:49 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62859 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728344AbgFKPOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 11:14:49 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B49B65D7CD;
        Thu, 11 Jun 2020 11:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=uvYDGDDOgZPi
        9V2KK80BFrc1Q8o=; b=d2nLy2mgc154l8HUQQ6sMXs8mnseVoCJIjsl2QKLBMAj
        QbBhwbJhg10ib7XoLvVBy5qloFscPCi7g40tLLjy67ava8pq6RnMXFJDpbLp9RRS
        9XvVGS+IQSshurk2LwX9zd1hMlA6xQ+aGmDAUOnCYlAe75Cp8k0aTeL35Rk6q+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=eM9ld1
        QQ47hN2wA9isl3GZXEM5giyqALb0tnLyWESu1Am5qhx20Nh5O6zm5+GT4iqKnWh7
        dOyzhk1Z+gVp6JKJhMRvQLqDWpHooqY6rdgVeSMUZ00qke6dPQKQ381A6P5r80fD
        5Ud7Sh5BQ+eosI4HkUXjnrgw8BQgiZbgrqP2U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AC2765D7CC;
        Thu, 11 Jun 2020 11:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2E2CD5D7CB;
        Thu, 11 Jun 2020 11:14:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Don Goodman-Wilson <don@goodman-wilson.com>,
        Michal =?utf-8?Q?Such?= =?utf-8?Q?=C3=A1nek?= 
        <msuchanek@suse.de>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Subject: Re: Rename offensive terminology (master)
References: <CAOAHyQwyXC1Z3v7BZAC+Bq6JBaM7FvBenA-1fcqeDV==apdWDg@mail.gmail.com>
        <20200505231641.GH6530@camp.crustytoothpaste.net>
        <nycvar.QRO.7.76.6.2006091126540.482@ZVAVAG-DN14RQO.ybpnyqbznva>
        <20200611115215.GQ21462@kitsune.suse.cz>
        <CAGA3LAfpoXDQryOPGg3g-4brpUcSAhL_2VOw8oy6D2ffp64hag@mail.gmail.com>
        <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com>
Date:   Thu, 11 Jun 2020 08:14:44 -0700
In-Reply-To: <f27450d8-59a1-dc0b-f741-c8c883b95fe0@gmail.com> (Derrick
        Stolee's message of "Thu, 11 Jun 2020 08:52:25 -0400")
Message-ID: <xmqqlfktbpnf.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 48558B02-ABF6-11EA-9218-C28CBED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 6/11/2020 7:59 AM, Don Goodman-Wilson wrote:
>> On Thu, Jun 11, 2020 at 1:52 PM Michal Such=C3=A1nek <msuchanek@suse.d=
e> wrote:
>>> Indeed, the flexibility to choose the name of the default branch can =
be
>>> helpful for projects with specific naming, especially non-english
>>> speaking projects.
>>>
>>> To that end I would suggest adding -b argument to git init to be able=
 to
>>> choose the default branch name per project. This should select the
>>> initial branch name and also write the it as the default branch name =
in
>>> the repo configuration (if git continues to treat the default branch
>>> specially).
>>>
>>> This can be used in documentation to use the new name immediately
>>> without breaking existing workflows that rely on the 'master' branch.
>>=20
>> I _really_ like this idea (and your reasoning). Seconded.
>
> Yes, adding a -b|--branch option would be an excellent addition to
> the config option.

In the ideal world, users should be able to just set
init.defaultBranchName in ~/.gitconfig once and forget about it.
But it is expected that some projects and their tools may heavily
depend on the assumption that the primary branch is called 'master'.
Giving a command line override like "init -b" (and do not forget to
do the same for "clone" as necessary) is a good escape hatch for
members of such projects.

Good.
