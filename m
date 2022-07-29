Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6221BC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 22:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239493AbiG2WDR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiG2WDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 18:03:16 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802708BAB1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 15:03:15 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1B74F1A718F;
        Fri, 29 Jul 2022 18:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=KPzoJv5sGz5B
        0jerVfFDSe7NJWqt0uYX8CX0I56PQxg=; b=cnzvTMUX4cz2lB+eprwSB7zFODkN
        Az21VUljNu1RqfrBKUJr0bXH8lxvLq1JtqP9ChZo+06faotEH4ucYxd8fVTAsJmZ
        mnHl/2aqCtY5SHo8vrKX+fL5Aaz6Js8UDjp9xvPIAlS/M6ymOp4EfKkFkUj/gJcT
        DfIVigGW52XlWP0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 152241A718D;
        Fri, 29 Jul 2022 18:03:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BC7251A718C;
        Fri, 29 Jul 2022 18:03:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Matheus Tavares <matheus.bernardino@usp.br>
Subject: Re: [PATCH v2 9/9] docs: add CONFIGURATION sections that fuzzy map
 to built-ins
References: <cover.1657819649.git.matheus.bernardino@usp.br>
        <cover-v2-0.9-00000000000-20220729T081959Z-avarab@gmail.com>
        <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
Date:   Fri, 29 Jul 2022 15:03:10 -0700
In-Reply-To: <patch-v2-9.9-91689154926-20220729T081959Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 29 Jul
 2022 10:25:55
        +0200")
Message-ID: <xmqqlesb4lwh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3CC6223E-0F8A-11ED-83CE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Add a CONFIGURATION section to the documentation of various built-ins,
> for those cases where the relevant config/NAME.txt doesn't map only to
> one git-NAME.txt. In particular:
>
>  * config/blame.txt: used by git-{blame,annotate}.txt. Since the
>    git-annotate(1) documentation refers to git-blame(1) don't add a
>    "CONFIGURATION" section to git-annotate(1), only to git-blame(1)>

s/>/./ I think.

>  * config/branch.txt: maps to both git-checkout.txt and
>    git-switch.txt (but nothing else).

s|/branch.txt|/checkout.txt|, I think.

>  * config/init.txt: should be included in git-init(1) and
>    git-clone(1).
>
>  * config/column.txt: We should ideally mention the relevant subset of
>    this in git-{branch,clean,status,tag}.txt, but let's punt on it for
>    now. We will when we eventually split these sort of files into
>    e.g. config/column.txt and
>    config/column/{branch,clean,status,tag}.txt, with the former
>    including the latter set.
>
> Things that are being left out, and why:
>
>  * config/remote.txt: let's not include this in
>    git-{fetch,remote,push}.txt etc. for now, various options there
>    change their behavior.

Leaving some stuff out is fine, but I am not sure I understand
(note: I didn't say "I agree with") the reasoning.  I take "various
options there" to mean the configuration variables described in
config/remote.txt file?  If these variables affect the behaviour of
commands like fetch, remote, and push, isn't it more reason to
include the description of them?

