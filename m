Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBFEC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B786760FE6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 19:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347586AbhIMTou (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 15:44:50 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63568 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242877AbhIMTos (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 15:44:48 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 66C0115F729;
        Mon, 13 Sep 2021 15:43:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7O9+j0z6jvhp
        rKidxrTk0GZRZ5N7wI6Tu8nrzGXy97w=; b=upANNEGQHE7iwaaS07iDhOjZuSYo
        zwUGvOjUvtcltxNbI6i9ffqOz77s+f5ZaSdb/7xsylkhZoauPoZ7hg8dCM166EQc
        +232jWfpKN2/UtemG0UcI8ZCRw0GVKS1xoAQa4oOE3FMbgSbyDyIFDjjoC2D+GG3
        XeHVpMTXP5njXlE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5FD7D15F728;
        Mon, 13 Sep 2021 15:43:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BDEC815F725;
        Mon, 13 Sep 2021 15:43:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH 2/2] documentation: add documentation for 'git version'
References: <pull.1038.git.1631531218.gitgitgadget@gmail.com>
        <d3635cbfd6ef0d47ebf28c516476dcd0b718afd4.1631531219.git.gitgitgadget@gmail.com>
        <87r1ds4t3w.fsf@evledraar.gmail.com>
Date:   Mon, 13 Sep 2021 12:43:28 -0700
In-Reply-To: <87r1ds4t3w.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 13 Sep 2021 13:19:11 +0200")
Message-ID: <xmqq4kaofehr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: DEF0DEA2-14CA-11EC-999D-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> +Note that `git --version` is identical to `git version` because the
>> +former is internally converted into the latter.
>
> Probably better to just have a new section:
>
> SEE ALSO
> --------
>
> linkgit:git[1]'s `--version` option, which dispatches to this command.

Hmph, I am not sure if this is a good move.

If we are not giving any more information than what the reader has
already learned from this page, other than "git --version" does the
same thing, we probably do not want to do this.  By seeing also that
other page, the user will not learn anything new about "git version".

If a related "git --version-something-else" is described over there
and may fill the need the reader had when visiting this page, that
is a different story, but I do not think it is the case.

>> +OPTIONS
>> +-------
>> +--build-options::
>> +	Prints out additional information about how git was built for diagno=
stic
>> +	purposes.
>> +
>> +GIT
>> +---
>> +Part of the linkgit:git[1] suite
>
>
> It would also be good to update git.txt, which now says:
>
>     Prints the Git suite version that the git program came from
>
> To say e.g. "Dispatches to linkgit:git-version[1], prints the git
> program version".

This one may be a good idea, I think.

"git --version --build-options" also works and we do not want to
clutter git[1] with descriptions on suboptions of "git version".

If we are not doing so for the "--help" option in git[1], we should
do so as well.

Thanks.
