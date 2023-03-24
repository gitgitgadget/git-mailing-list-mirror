Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521F6C6FD20
	for <git@archiver.kernel.org>; Fri, 24 Mar 2023 09:00:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbjCXJAQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Mar 2023 05:00:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjCXJAP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2023 05:00:15 -0400
Received: from bluemchen.kde.org (unknown [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37ECED2
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 02:00:12 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 4B1992426C
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 04:59:53 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfdH6-oWt-00
        for <git@vger.kernel.org>; Fri, 24 Mar 2023 09:59:52 +0100
Date:   Fri, 24 Mar 2023 09:59:52 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: clarify conditionals in todo_list_to_strbuf()
Message-ID: <ZB1miMcYWXWBvGbm@ugly>
Mail-Followup-To: git@vger.kernel.org
References: <20230323162235.995559-1-oswald.buddenhagen@gmx.de>
 <ZBy3aa+7RhnjJUaG@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZBy3aa+7RhnjJUaG@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 23, 2023 at 04:32:41PM -0400, Taylor Blau wrote:
>I dunno. I think seeing adjacent
>
>    if (item->command == TODO_ABC)
>
>and
>
>    if (item->command == TODO_XYZ)
>
>makes it clear that these two are mutually exclusive, since TODO_ABC !=
>TODO_XYZ.
>
no, because you have to prove to yourself that the queried value doesn't 
change in between. and so does the compiler, which may fail to 
tail-merge the embedded strbuf_addstr() calls as a consequence.

>Specifically: why not combine these two with if-statement that proceeds
>it? That might look something like: [...]
>
i don't see what you're referring to, so i guess you got confused about 
the location of the code in question?
