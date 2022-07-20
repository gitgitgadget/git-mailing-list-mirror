Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1582BC43334
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 17:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiGTRSy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 13:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238904AbiGTRSx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 13:18:53 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86CF85F98A
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 10:18:52 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 094EB1A42D6;
        Wed, 20 Jul 2022 13:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1MduqJNRMuzjNKwNTR2MzsIAGCgJ6TJcy9ihGJ
        s4tDc=; b=wLjlslM35Dbb68n5Mqx3/oghxWgA1N2FvUxxtGqLNvdQEkM2Yq6Wki
        CZZ1VQN3uEdSX3frEhog5V74T/+mo127rc2y2RObPzeyncoVRKmpRw7OmoGrPZW3
        tgimZ67jhSUyIUslrz8PkopyITGeQ1jHCb15+o5JYMUXUJeVMNAHg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 01B4E1A42D5;
        Wed, 20 Jul 2022 13:18:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A13391A42D3;
        Wed, 20 Jul 2022 13:18:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Baumann, Moritz" <moritz.baumann@sap.com>
Cc:     Moritz Baumann via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Tao Klerks <tao@klerks.biz>
Subject: Re: [PATCH] git-p4: fix crlf handling for utf16 files on Windows
References: <pull.1294.git.git.1658294873702.gitgitgadget@gmail.com>
        <xmqqilnr4vhn.fsf@gitster.g>
        <AS1PR02MB8185D1041A96B0384554EE32948E9@AS1PR02MB8185.eurprd02.prod.outlook.com>
Date:   Wed, 20 Jul 2022 10:18:47 -0700
In-Reply-To: <AS1PR02MB8185D1041A96B0384554EE32948E9@AS1PR02MB8185.eurprd02.prod.outlook.com>
        (Moritz Baumann's message of "Wed, 20 Jul 2022 16:32:51 +0000")
Message-ID: <xmqqh73b3doo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 04A62246-0850-11ED-BE05-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Baumann, Moritz" <moritz.baumann@sap.com> writes:

> Do you need me to resubmit the patch with an explanatory
> description? If so, I can try to summarize the above.

Yup.

Review comments are not a request to the authors to explain their
patches to reviewers.  Their primary purpose is to point out what
potential issues readers of the commit that would result by the
proposed patches may have.  So answering in your response to see if
your clarifications are understandable is very good, but please
consider it a preparation to write a better version (i.e. [PATCH
v2]).

Thanks for working on this fix.

