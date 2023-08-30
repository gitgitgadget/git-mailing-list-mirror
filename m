Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E834C83F21
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbjH3S3a (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243012AbjH3KGx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 06:06:53 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4444E1B0
        for <git@vger.kernel.org>; Wed, 30 Aug 2023 03:06:50 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3D9E22433D;
        Wed, 30 Aug 2023 06:06:48 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qbI63-xnQ-00; Wed, 30 Aug 2023 12:06:47 +0200
Date:   Wed, 30 Aug 2023 12:06:47 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5] send-email: prompt-dependent exit codes
Message-ID: <ZO8Ut3t2ns1lj/pM@ugly>
References: <xmqq5y5msmc0.fsf@gitster.g>
 <20230821170720.577835-1-oswald.buddenhagen@gmx.de>
 <xmqq3501bbmf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq3501bbmf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 05:46:32PM -0700, Junio C Hamano wrote:
>Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>
>> Proposed content for RelNotes:
>>
>>  * "git send-email" now reports interactive cancellation via a distinct
>>    non-zero exit status. Callers which do not consider this situation an
>>    error need to be adjusted.
>
>If we still want to deliberately break folks with this change, we
>should not blame users for becoming accustomed to the traditional
>behaviour and pretend as if burdening them to change their scripts
>is within our rights.  We should be a lot more apologetic in the
>backward compatibility notes than what you wrote in the above.
>
i find this deference mind-boggling.

i'm sure you're somewhat cautious because you're on the frontline when 
people complain, and *someone* will _always_ complain when things 
change.  however, it's completely unreasonable to let this dictate one's 
possibilities. there is a trade-off between the cost of change and the 
cost of non-change.

>Given that the users have
>lived with the current behaviour practically forever in Git's
>timescale and that not changing the default and letting them "live
>with" the status quo cannot cause any serious problem, I cannot
>stand behind such a default change myself.
>
the exit code really only matters when there is a wrapper which decides 
significant follow-up actions based on it (that is, doesn't exit right 
afterwards anyway). i don't think many such scripts exist for 
git-send-email. those which do will most likely suppress interaction.
which is why nobody else complained yet. and also why likely nobody will 
complain if we change it. the few people that will notice at all will 
most likely welcome the change, as i would.

>It should be a new feature that is opt-in,
>
do as you like, but i won't spend the time on roughly doubling the size 
of the patch, nor on dealing with this being an opt-in (i don't want a 
hard dep on a new git version in the near term), and i won't contribute 
to sabotaging the discovery of hidden bugs.

>just like any other new and useful feature..
>
not reporting a significant event is a bug.

>Subject: [PATCH] SQUASH???
>
yes, please.

regards
