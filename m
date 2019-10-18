Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6EC771F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 23:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfJRXLd (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 19:11:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57555 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728582AbfJRXLd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 19:11:33 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AA852C7F7;
        Fri, 18 Oct 2019 19:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=PRNzi5Ls1/i4
        oNCvSM/HDCqRB1Q=; b=HtULJcBJ5VlSfUDE1JHFmu5P6+PPhTC50oLqdIp7ln2f
        TKadO0NhebxsVhz0rFxcWUldOhOQB1uC2uCooUeV2MKlfr6kGhJMKCT/9BCWdjJ+
        Y56gLhVW8Nw15BZzDQevrAGPmAJluklj+4SXhG4JWZrSPrcHqASdPF8OKoSiWlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=iZCYAr
        ic2l6/GNuoKKWgRtzWWMgl5J3TBYCzeDwZgdPTgbirFunLR/L9ddRUbXMJIUzMlV
        rvgtgvAcSbFsUeHWpzuT519HsDrzH0rcLtmbiw2esrdAkgalF/GjaEL/T8mvvHtC
        u1MhkpgUUlNc7O0+yIeUoC2nAceB0PK6cAbe0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 80EC92C7F6;
        Fri, 18 Oct 2019 19:11:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B45D62C7F5;
        Fri, 18 Oct 2019 19:11:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     GitList <git@vger.kernel.org>
Subject: Re: [PATCH v1] config/branch: state that <name>.merge is the remote ref
References: <20191016112822.1701-1-philipoakley@iee.email>
        <xmqqwod26dp7.fsf@gitster-ct.c.googlers.com>
        <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email>
Date:   Sat, 19 Oct 2019 08:11:29 +0900
In-Reply-To: <c96f4dbd-ebc6-b743-716e-e1e17333c06b@iee.email> (Philip Oakley's
        message of "Fri, 18 Oct 2019 21:53:02 +0100")
Message-ID: <xmqq8sphodi6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9F42D1F4-F1FC-11E9-989C-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> branch.<name>.merge::
> =C2=A0=C2=A0=C2=A0 Defines, for the local branch <name>, the upstream b=
ranch ref
> =C2=A0=C2=A0=C2=A0 _on the remote_ (as given by branch.<name>.remote).
> =C2=A0=C2=A0=C2=A0 The upstream ref may be different from the local bra=
nch ref.
>
> optionally s/different from/ same as/ ?

That "optionally" part is exactly why I said "upstream and remote
tracking names may or may not differ is irrelevant information".

>>      The name of the branch at the remote `branch.<name>.remote` that
>>      is used as the upstream branch for the given branch.  It tells
>>      `git fetch`, etc., which branch to merge and ...
>>
> If this, should we also say it (the key value) is that of the upstream
> branch _ref_?

Yeah, that makes it clear that readers should not write "master" and
use "refs/heads/master" instead.  It may even be more (technically)
correct to say just "ref" without branch (this ref does not have to
be a branch at the remote repository at all).  I am not sure if we
want to go that far to make it more correct and also make it hint
that using a non-branch ref is a valid configuration to readers, but
I agree it is a good idea to avoid saying "name" (which implies
that "master" is OK, which is not).

Thanks.


