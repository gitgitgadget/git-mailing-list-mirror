Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99DAC00140
	for <git@archiver.kernel.org>; Thu, 18 Aug 2022 18:17:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345382AbiHRSR6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Aug 2022 14:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbiHRSR5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2022 14:17:57 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E745BCE33F
        for <git@vger.kernel.org>; Thu, 18 Aug 2022 11:17:55 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 98CC913A3D9;
        Thu, 18 Aug 2022 14:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rmTKhLAtm3vB4ZvJ+1RT1VE1B4Z4220Nf/n1/5
        fPizw=; b=xnh9ge5hZ95lFtuqIGOZKpTMUyZCAlOoYLHKSregTWBrrYozJnlkLK
        MJSC4MHFyS7NWteiZCfZt0QEKe8654VbCymjItZIksYh0q221lfo17yl6rxTOYOt
        Fcs9ebmzV5g//GIEcINOckj/X/WGAmNCtfoTDQDVvn3/JnPzcjUs0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 90E6213A3D8;
        Thu, 18 Aug 2022 14:17:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EE48513A3D5;
        Thu, 18 Aug 2022 14:17:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Sergio via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sergei Krivonos <sergeikrivonos@gmail.com>
Subject: Re: [PATCH 2/2] Add Eclipse project settings files to .gitignore
References: <pull.1307.git.git.1660831231.gitgitgadget@gmail.com>
        <106a0563cfc29b75dbdbd54ce55140762e133539.1660831231.git.gitgitgadget@gmail.com>
        <Yv5wF0DxVe38ygap@tapette.crustytoothpaste.net>
Date:   Thu, 18 Aug 2022 11:17:52 -0700
In-Reply-To: <Yv5wF0DxVe38ygap@tapette.crustytoothpaste.net> (brian
        m. carlson's message of "Thu, 18 Aug 2022 17:00:07 +0000")
Message-ID: <xmqqa681pga7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 13CD9B94-1F22-11ED-AC6E-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> location).  For example, I do this with Vim-related files, and it
> applies to all repos on my system, such that other developers don't have
> to care what editor I use.
>
> However, Eclipse is a popular editor, so it may be that Junio really
> likes this change since it will benefit many people.

I am all for making new contributor's life better, and in this case,
NOT adding editor-specific patterns to OUR .gitignore contributes
better for that goal.  It will be a shame for us to make a move that
will keep our contributors unaware of what they can do with Git, and
in this case, lack of Eclipse specific patterns did trigger Sergio
to notice that these are not ignored, and learn that a better place
to do so is in $HOME/.gitignore, because it will help not only when
the contributor works on Git, but when the same contributor works on
anything using Eclipse.  Adding editor-specific patterns ourselves
robs such a learning opportunity from new contributors.

Thanks.
