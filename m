Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30925C433FE
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 20:43:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbiJNUnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 16:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJNUnA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 16:43:00 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D28108263
        for <git@vger.kernel.org>; Fri, 14 Oct 2022 13:42:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 035E1160866;
        Fri, 14 Oct 2022 16:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bexKdsQC8lXVSnSVaKsOAhKLX3w6s8TFvX5Tey
        7hwew=; b=ueeIsJs4zYB3Wl2pM/YchCoAmKxyP89VY43yoow9aobg9NWnHtp2qV
        4b5CiuH6yYE8QysUCAqduEni6Xmx4qyr4rof2MsMnHkoG6i0nF3HC5OOUrE1kOj+
        OkfH1gS9FqUIqt6FJrzX9/YQEOoOwmhSroiMOX6VvhoUGAAJaQ82g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC4AF160865;
        Fri, 14 Oct 2022 16:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C70A160864;
        Fri, 14 Oct 2022 16:42:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, nsengaw4c <nsengiyumvawilberforce@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH v3] [OUTREACHY] t1002: modernize outdated conditional
References: <pull.1362.v2.git.git.1665733647421.gitgitgadget@gmail.com>
        <pull.1362.v3.git.git.1665734502591.gitgitgadget@gmail.com>
        <xmqqv8om9yaz.fsf@gitster.g>
        <f064ce46-8ed0-a9c1-8df5-5c258677d95f@github.com>
        <CAPig+cT=bJ7BP9CDh5-oYYF376vVxsh7E0UAE_QN0wfAgR3AAg@mail.gmail.com>
        <xmqqh7068bta.fsf@gitster.g>
        <692dbb0d-a3f9-7e12-c868-fffc8df4678b@iee.email>
Date:   Fri, 14 Oct 2022 13:42:56 -0700
In-Reply-To: <692dbb0d-a3f9-7e12-c868-fffc8df4678b@iee.email> (Philip Oakley's
        message of "Fri, 14 Oct 2022 21:19:54 +0100")
Message-ID: <xmqqzgdy6srz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8FAF768-4C00-11ED-AACA-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I just want to throw in that because GitHub takes the PR & comitts
> verbatim, but Git itself works via email, you can add description
> portions to commits, and I believe the PR part, by add a line containing
> just three dashes `---` followed by the additional descriptive note text
> which won't be used when `am` (apply mailbox) is used.

Yup, if you are absolutely sure you won't interact with others in
any way other than e-mailed patches, it is a great trick to use.
