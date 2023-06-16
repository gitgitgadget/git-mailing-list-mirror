Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79687EB64D7
	for <git@archiver.kernel.org>; Fri, 16 Jun 2023 20:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjFPUEB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jun 2023 16:04:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjFPUEA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2023 16:04:00 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05362133
        for <git@vger.kernel.org>; Fri, 16 Jun 2023 13:03:58 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id D4C9623FB4;
        Fri, 16 Jun 2023 16:03:56 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1qAFfo-dVY-00; Fri, 16 Jun 2023 22:03:56 +0200
Date:   Fri, 16 Jun 2023 22:03:56 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Nadav Goldstein <nadav.goldstein96@gmail.com>
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
Message-ID: <ZIzALOe8GBsNGIhR@ugly>
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
 <xmqqjzw3qry6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqjzw3qry6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 16, 2023 at 09:42:41AM -0700, Junio C Hamano wrote:
>"Nadav Goldstein via GitGitGadget" <gitgitgadget@gmail.com> writes:
>> In this patch, we introduce a new subcommand preserve to
>> git stash. The purpose of this subcommand is to save the
>> current changes into the stash and then immediately re-apply
>> those changes to the working directory.
>
>Why a new subcommand, not a new option to "push"?  Adding a new
>subcommand would mean it would be another unfamiliar thing users
>need to learn, as opposed to a slight variation of what they are
>already familiar with.
>
to be fair, there's also `apply` and not `pop --keep`.

of course, `preserve` seems a bit unspecific, but `save` and `create` 
are already taken.

>>     If the community will approve, I will modify the patch to include 
>>     help
>>     messages for the new subcommand
>
>Please don't think this way.  If the new feature is not worth
>completing to document and tests for your own use, it is not worth
>community's time to review or "approve" it.
>
for one's own use, one usually wouldn't do the polishing.

>Instead, we try to send a patch that is already perfected, with tests 
>and docs,
>
it's nice when "we" do that, but i think that this is a somewhat too 
one-sided committment to *ask* for.

>in order to improve the chance reviewers will understand the new 
>feature and its motivation better when they review the patch.
>
i think one can achieve that without doing the full monty.
that's what the design-driven process is for, after all. the crux is at 
what contribution size one considers it "worth it", but you can be sure 
that drive-by contributors have a significantly lower threshold than 
regulars.

i'm not saying that nadav succeeded, but a focus on final artifacts 
alone is unlikely to have changed anything.

regards,
ossi
