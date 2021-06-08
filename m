Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8B1C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D5ED61246
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:42:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbhFHGoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:44:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60447 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFHGoY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:44:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4A8CADE477;
        Tue,  8 Jun 2021 02:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tHCakM0reDbqm1YTCbMEvL5ORek0qLuVPWeCQf
        Zgp4A=; b=R67yWK90XWKo3zPK7QnWLjH5E1+TSUOmbmPZ16RpPCJXo/EFWSjtyz
        Ms5QC5uUEWmrZmLqxUtsmOaFrES8hIoEajmWC5kEfVs5iM8AdsMmHKs64Zgtyfde
        sDtNQicacsobDT1TJXKtsBruqh5yCifKDur4KruozfxwiBk4QvTTc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4137ADE476;
        Tue,  8 Jun 2021 02:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 92F29DE474;
        Tue,  8 Jun 2021 02:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH 0/6] [GSOC][RFC] ref-filter: add %(raw:textconv) and
 %(raw:filters)
References: <pull.972.git.1622884415.gitgitgadget@gmail.com>
Date:   Tue, 08 Jun 2021 15:42:29 +0900
In-Reply-To: <pull.972.git.1622884415.gitgitgadget@gmail.com> (ZheNing Hu via
        GitGitGadget's message of "Sat, 05 Jun 2021 09:13:28 +0000")
Message-ID: <xmqqtum8q2lm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B2A07094-C824-11EB-A26E-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> ZheNing Hu (6):
>   [GSOC] ref-filter: add obj-type check in grab contents
>   [GSOC] ref-filter: add %(raw) atom
>   [GSOC] ref-filter: use non-const ref_format in *_atom_parser()
>   [GSOC] ref-filter: add %(rest) atom and --rest option
>   [GSOC] ref-filter: teach grab_sub_body_contents() return value and err
>   [GSOC] ref-filter: add %(raw:textconv) and %(raw:filters)

I haven't gotten around looking at anything after the %(rest) one,
but 

https://github.com/git/git/runs/2770688471?check_suite_focus=true

seems to tell us that there is "size_t *" vs "ulong *" type
confusion, possibly around the textconv thing.


