Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F58C7EE23
	for <git@archiver.kernel.org>; Wed, 17 May 2023 10:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjEQKAV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 06:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjEQKAR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 06:00:17 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A3D5B84
        for <git@vger.kernel.org>; Wed, 17 May 2023 03:00:10 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id B676623FEE;
        Wed, 17 May 2023 06:00:08 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pzDx2-95h-00; Wed, 17 May 2023 12:00:08 +0200
Date:   Wed, 17 May 2023 12:00:08 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
Message-ID: <ZGSlqAPwaLhgWm6v@ugly>
Mail-Followup-To: phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 10:05:51AM +0100, Phillip Wood wrote:
>On 28/04/2023 09:35, Oswald Buddenhagen wrote:
>> +		} else if (skip_prefix(msg.subject, "Revert \"", &orig_subject)) {
>> +			if (skip_prefix(orig_subject, "Revert \"", &orig_subject)) {
>
>I think it is probably worth adding
>
>	if (starts_with(orig_subject, "Revert \""))
>		strbuf_addstr(&msgbuf, "Revert \"");
>	else
>
>here to make sure that we don't end up with a subject starting "Revert 
>\"Reapply \"Revert ...".
>
i can't follow you.

how is the concern not covered by the subsequent comment?

>> +				/*
>> +				 * This prevents the generation of somewhat unintuitive (even if
>> +				 * not incorrect) 'Reapply "Revert "' titles from legacy double
>> +				 * reverts. Fixing up deeper recursions is left to the user.
>> +				 */

regards,
ossi
