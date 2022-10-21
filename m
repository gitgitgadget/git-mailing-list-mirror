Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56829C433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 05:52:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiJUFwc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 01:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiJUFwb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 01:52:31 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39CF232E5C
        for <git@vger.kernel.org>; Thu, 20 Oct 2022 22:52:26 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E1E81BA1DD;
        Fri, 21 Oct 2022 01:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Q5iCG0mpPqFHavp+Y7XB0nd+oC1QoupB3GN5g+
        OSKZM=; b=Zyrqb3SRrvNgxmgNuoV8ajW0Fmvq+6FPRknsQjZy2LWnGHZfF4hgqd
        9aas/bAYarapLPOu9wHmOSkqPyebC51jPDVQO+/wvwp2LMKJu1OOAGDwzD8Y1VDG
        SXoRuJhNfq600Br3wfQL9y9rTX1kVwyyK1yMMqB3hjL4is+ABv9jU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 19D841BA1DC;
        Fri, 21 Oct 2022 01:52:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 34F201BA1DB;
        Fri, 21 Oct 2022 01:52:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Yehuda Katz <yehuda@ymkatz.net>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: Change in behavior of included safe.directory in system config
References: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
Date:   Thu, 20 Oct 2022 22:52:22 -0700
In-Reply-To: <CAGBAQ45f6D=XsyiOmumpAnE+OxQpuZXhMsVegrHKsxaN5mc3eQ@mail.gmail.com>
        (Yehuda Katz's message of "Fri, 21 Oct 2022 01:19:12 -0400")
Message-ID: <xmqqzgdpoh9l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88A0AF42-5104-11ED-8448-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Yehuda Katz <yehuda@ymkatz.net> writes:

> There seems to be some change in behavior, either to included files or
> to safe.directory between Git 2.36.0 and 2.38.0. I don't see any
> explanation in the release notes.
>
> I push out a system configuration with a configuration management tool
> which is why it is in a separate file.
> If I put the safe.directory configuration in the main system config,
> it works. I don't understand why this is because the value is still
> shown when running a config list.
>
> Basic config:
> [root@myhost myproject]# pwd
> /opt/myproject
> [root@myhost myproject]# cat /etc/gitconfig
> [include]
>         path = /etc/gitconfig.d/myproject

Is this

  https://lore.kernel.org/git/pull.1360.v2.git.git.1665683027912.gitgitgadget@gmail.com/

perhaps?  Can you try the version of Git from my 'next' branch?
