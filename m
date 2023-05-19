Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C448C7EE26
	for <git@archiver.kernel.org>; Fri, 19 May 2023 07:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjESHwV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 May 2023 03:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjESHwF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 May 2023 03:52:05 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648611730
        for <git@vger.kernel.org>; Fri, 19 May 2023 00:51:39 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 85007240DB;
        Fri, 19 May 2023 03:51:29 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pzutd-kKV-00; Fri, 19 May 2023 09:51:29 +0200
Date:   Fri, 19 May 2023 09:51:29 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [not even design notes yet] teaching rerere to remember removal?
Message-ID: <ZGcqgR5RimHJiwFv@ugly>
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqq353ts2qt.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqq353ts2qt.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 18, 2023 at 03:18:02PM -0700, Junio C Hamano wrote:
>So I am wondering what should be used as the record of "if the other
>branch made this change, we have seen this conflict already, and we
>know it is safe to resolve it to remove the path".
>
i suppose i may be missing the obvious, but why not just treat the 
removal as a full diff (like a traditional patch would do) and remember 
the resolution accordingly like any other conflict?

the key to making this useful is presenting followup conflicts in a 
sensible way that highlights where they actually are, but that would be 
useful regardless - i often run into this while rebasing, where finding 
that one line that i added to a bigger section that was (re-)moved 
requires so much attention that i instead look at the original patch 
rather than the conflict to see what it was. (note that i'm using diff3 
markers.)

regards,
ossi
