Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E63BAC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 19:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244712AbiHRTMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 15:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240608AbiHRTMb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 15:12:31 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB39C6537
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 12:12:29 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 76A5113AA97;
        Thu, 18 Aug 2022 15:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=DwxIKjhdTnoi
        J+kgkmAV8eRMg2Mkt0s1vgb9s58IpiI=; b=h6cDclc4YDVMSURZgDXxImG4PYEQ
        +UtafMR8RZCL4V15VIEzXBx5XMItkoX8fAFD0OcXZrO6+xdf7+8uWpWxNCOEQsa/
        UofGlU3i+tmGjMGkLW3iFEpuoOZDMfPkU3AtpF2yq45lJmS4NlWKe1rEGFgiur1i
        QqgQMxjeCmUgaes=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6DEDF13AA96;
        Thu, 18 Aug 2022 15:12:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BBD8413AA92;
        Thu, 18 Aug 2022 15:12:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, derrickstolee@github.com,
        johannes.schindelin@gmx.de, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v4 07/11] builtin/diagnose.c: create 'git diagnose' builtin
References: <pull.1310.v3.git.1660174473.gitgitgadget@gmail.com>
        <pull.1310.v4.git.1660335019.gitgitgadget@gmail.com>
        <b58d13325b2eaef32fac89fb2be8e29004560c45.1660335019.git.gitgitgadget@gmail.com>
        <220818.86edxd8k8q.gmgdl@evledraar.gmail.com>
Date:   Thu, 18 Aug 2022 12:12:24 -0700
In-Reply-To: <220818.86edxd8k8q.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 18 Aug 2022 20:43:22 +0200")
Message-ID: <xmqqzgg1nz6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1F21BC2-1F29-11ED-98DB-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Aug 12 2022, Victoria Dye via GitGitGadget wrote:
>
>> From: Victoria Dye <vdye@github.com>
>> [...]
>
> This is correct:
>
>> +'git diagnose' [(-o | --output-directory) <path>] [(-s | --suffix) <f=
ormat>]
>
> ...
>
>> +	N_("git diagnose [-o|--output-directory <path>] [-s|--suffix <format=
>]"),
>
> But this is not, it's missing () around the short v.s. long option, and
> we should have a space surrounding the "|" as well.

You are commenting on what appears inside N_() and I agree that it
should match the other one.

It is kind of sad that our usage strings do not allow proper
translation and instead force translaters to _know_ that they are
supposed to touch _only_ the placeholder strings (path and format in
this case).

Not your fault, or Victoria's, of course ;-)
