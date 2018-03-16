Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69E4F1F404
	for <e@80x24.org>; Fri, 16 Mar 2018 20:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752699AbeCPUO6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 16:14:58 -0400
Received: from protibet.org ([31.31.78.41]:49808 "EHLO clime.cz"
        rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1750921AbeCPUO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 16:14:57 -0400
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Fri, 16 Mar 2018 16:14:57 EDT
Received: by clime.cz (Postfix, from userid 500)
        id 831782EDD; Fri, 16 Mar 2018 21:09:28 +0100 (CET)
From:   clime <clime7@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, paul@mad-scientist.net,
        phillip.wood@talktalk.net
Subject: Re: Git "branch properties"-- thoughts?
Date:   Fri, 16 Mar 2018 21:09:28 +0100
Message-Id: <1521230968-26591-1-git-send-email-clime7@gmail.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <xmqqo9kfs8ju.fsf@gitster-ct.c.googlers.com>
References: <xmqqo9kfs8ju.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>But for a generic branch like 'master', that arrangement would not
>work well, I am afraid.  You may have N copies of the same project,
>where the 'master' branch of each is used to work on separate topic.
>The focus of the 'master' branch of the overall project would be
>quite different from each of these copies you have, hence it is
>likely that it would be inappropriate to share the task list and
>stuff you would want to add to branch descriptions and branch
>properties between the shared repository's 'master' and any of your
>'master' in these N copies you have.
>
>So...

I think it could work in a way that other people branch properties
are only taken into account if you don't have your own properties of
those same names already set. In that case, git would initialize
your branch properties from the other branch of the same name and
inform you about it. Of course, you should always have a way to overwrite
any property to a value of your choice. So what you would be getting
from others were basically default values (inspired by
https://docs.python.org/3.5/library/stdtypes.html#dict.setdefault).

Would it work? This sounds pretty good to me. I would really love
to have a chance to implement this feature if people were
interested in it.

clime
