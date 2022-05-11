Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FD0C433EF
	for <git@archiver.kernel.org>; Wed, 11 May 2022 22:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345386AbiEKWep (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 May 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232399AbiEKWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 May 2022 18:34:44 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75CD6210B95
        for <git@vger.kernel.org>; Wed, 11 May 2022 15:34:43 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74871192B13;
        Wed, 11 May 2022 18:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xGoFzbhpaEnFmEz4PewkXtXPgY/oXOpLqb/CrE
        BVM0I=; b=KUe0/3ZOK6j+akwuAJC3cVi4New6Bpq7SOtON6ntvqJB2ZDWIMOfDd
        4upxTZqz9OUprPoUu9Ljx/QTiCn5DQi/Im51FPiJz6WdTN+dCFxinIrXeSc014xN
        WQfiTUzNbMdEkfAl6MGmvBESLbF4LNuwEmZyRHdtK3ZCDptFv/3nE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 58F18192B12;
        Wed, 11 May 2022 18:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E8F28192B0E;
        Wed, 11 May 2022 18:34:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Glen Choo via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Huang Zou <huang.zou@schrodinger.com>,
        Josh Steadmon <steadmon@google.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] pull: only pass '--recurse-submodules' to subcommands
References: <pull.1262.git.git.1652138854255.gitgitgadget@gmail.com>
        <pull.1262.v2.git.git.1652210747614.gitgitgadget@gmail.com>
        <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com>
Date:   Wed, 11 May 2022 15:34:37 -0700
In-Reply-To: <deafd5db-6303-46b3-a5d5-b4117ba16781@gmail.com> (Philippe
        Blain's message of "Wed, 11 May 2022 18:30:27 -0400")
Message-ID: <xmqqzgjnhf5u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8AFD29A0-D17A-11EC-9AA0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>     pull: only pass '--recurse-submodules' to subcommands
>>     
>>     Thanks for the debugging help :)
>>     
>>     Changes since v1:
>>     
>>      * add a test that actually tests the precedence of the config values
>>        * I've kept the previous test; it has always worked, but it still
>>          seems like a useful smoke test
>>      * reworded the commit message slightly
>
> Thanks, this version looks good to me. I don't feel to strongly about the 
> title either, so as you wish :)

Perhaps

	pull: do not let submodule.recurse override fetch.recurseSubmodules

more clearly expresses what it wants to do (not passing the command
line option is "how" we achieve that goal)?
