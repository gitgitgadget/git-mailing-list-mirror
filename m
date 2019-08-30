Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F0521F461
	for <e@80x24.org>; Fri, 30 Aug 2019 19:45:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3Tpx (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Aug 2019 15:45:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56748 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727963AbfH3Tpx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Aug 2019 15:45:53 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DA98165B33;
        Fri, 30 Aug 2019 15:45:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zhxAcdZIQYbG
        H/VFYn056V1gBDw=; b=A6UE51Ljc5BwQH2oygQ1TX+0by1tj8ABUg9iUsjDxe/A
        eTQkDzvV8RD7oNHtn3oenzYIpQtBpEDeBFSVA4Jjjb1/JfqDd5wrulu7qaUEhmBB
        tUgvP0w9XVlYaiwfqYlgREzyl/Y6//yFSEeUAa7D6iQOe8zgPfxQ8eUswZ/+J18=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=Jq+9UQ
        nOVEFtOwoWhu4ua+RIxptSQ1S2Sh0QEmd6DrcCxm5zHDO3bzXG8giym9lVW2YKg5
        Z7w74NH06Bz7hOyc9Ym0sLvoWCf6gDlPYVG99JjqzsPpF+HO3s7uHiX50YcHowaw
        o3Ztgj96FcaLSIr7/fMRrEmxE51B3t60kJGY8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id ED26B165B31;
        Fri, 30 Aug 2019 15:45:52 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 60B7B165B2E;
        Fri, 30 Aug 2019 15:45:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH v2] merge-options.txt: clarify meaning of various ff-related options
References: <877e6x3bjj.fsf@osv.gnss.ru>
        <20190828155131.29821-1-newren@gmail.com>
        <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
Date:   Fri, 30 Aug 2019 12:45:51 -0700
In-Reply-To: <CAN0heSoqy4sCY8NUWKuEkXwe2XxnYAN6Mn2N75hYwfQ_5WGYdQ@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 28 Aug 2019 20:45:27
 +0200")
Message-ID: <xmqqef12xwr4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C632E2E6-CB5E-11E9-BA33-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

>> +--ff::
>> +       Whether to only allow resolving the merge as a fast forward
>> +       (only updating the branch pointer to match the merged branch
>> +       and not creating a merge commit), to never allow it (always
>> +       creating a merge commit), or to prefer it when possible.  The
>> +       default is --ff, except when merging an annotated (and
>
> It would be great if you'd write this as `--ff` so that it got
> monospaced in the rendered documentation. ...
> I'd also write `refs/tags/`, but I realize that you're just inheriting
> what is already here. ...

These comments may sound nitpicky at times, and some parts may be
beyond the scope of the discussion on the patch and are better left
for a later time, but the consistency is valuable.

Thanks for mentioning them; and it would be appreciated if these
suggesions are followed through after the dust settles.
