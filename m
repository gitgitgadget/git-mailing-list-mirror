Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8C9C04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 17:02:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIWRCA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 13:02:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIWRB6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 13:01:58 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A106E128885
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 10:01:57 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA8E9151AC0;
        Fri, 23 Sep 2022 13:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ob7uL8vP8wgk
        Fa0dQeH7f9QPjW25ZwVEU57mpaGCpBo=; b=rjzDJfeKyVk98VR0GuL/yZfnI1b0
        6HnQZPV7M9A/FpBY0ztyn1K6aiDTHe4cUwYhTCsO2SjQW2ydyOyRlGYhxVkpvjXi
        Lm9Jwhje4Oqa7fFOOWv3he6wErp8q85FR65nn+kg0T8aia4dCIemFmd/9+8wRlpG
        KfucTVzuqDTNqzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7AD8F151ABC;
        Fri, 23 Sep 2022 13:01:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D0C19151ABA;
        Fri, 23 Sep 2022 13:01:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2] cmd-list.perl: fix identifying man sections
References: <220923.86wn9u4joo.gmgdl@evledraar.gmail.com>
        <20220923080733.1995862-1-martin.agren@gmail.com>
Date:   Fri, 23 Sep 2022 10:01:54 -0700
In-Reply-To: <20220923080733.1995862-1-martin.agren@gmail.com> ("Martin
        =?utf-8?Q?=C3=85gren=22's?= message of "Fri, 23 Sep 2022 10:07:33 +0200")
Message-ID: <xmqqtu4yuirh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6DD27CB2-3B61-11ED-AA3D-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We attribute each documentation text file to a man section by finding a
> line in the file that looks like "gitfoo(<digit>)". Commit cc75e556a9
> ("scalar: add to 'git help -a' command list", 2022-09-02) updated this
> logic to look not only for "gitfoo" but also "scalarfoo". In doing so,
> it forgot to account for the fact that after the updated regex has foun=
d
> a match, the man section is no longer to be found in `$1` but now lives
> in `$2`.
>
> This makes our git(1) manpage look as follows:
>
>   Main porcelain commands
>        git-add(git)
>            Add file contents to the index.

Thanks.  Will queue.
