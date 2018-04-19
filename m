Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 697981F424
	for <e@80x24.org>; Thu, 19 Apr 2018 11:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeDSLw0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 07:52:26 -0400
Received: from mail.javad.com ([54.86.164.124]:49727 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751150AbeDSLwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Apr 2018 07:52:25 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 7AC883E992;
        Thu, 19 Apr 2018 11:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524138744;
        bh=JSyD/RvyNbSlVARjWZ7LhsA0d7yxf9N/XE0zo3tSBPg=; l=811;
        h=Received:From:To:Subject;
        b=g8rVXWzok+tYpk2KLURgGgigsB9E9y+/VD/hWJgOZSYPA9mkJwKWTYZJ7qUpxrN9l
         vaKpdEEIakP7xRL+Xw3pdd7HM3OCj1v9p2n3CEiH+qp85ao0on0PwPwsfE6BDSQnLw
         eHbwJuu2iQp39iYuUL3UPFTKjeU+6V7TqZsEcc+M=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1524138744;
        bh=JSyD/RvyNbSlVARjWZ7LhsA0d7yxf9N/XE0zo3tSBPg=; l=811;
        h=Received:From:To:Subject;
        b=g8rVXWzok+tYpk2KLURgGgigsB9E9y+/VD/hWJgOZSYPA9mkJwKWTYZJ7qUpxrN9l
         vaKpdEEIakP7xRL+Xw3pdd7HM3OCj1v9p2n3CEiH+qp85ao0on0PwPwsfE6BDSQnLw
         eHbwJuu2iQp39iYuUL3UPFTKjeU+6V7TqZsEcc+M=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f986w-0005PT-Qa; Thu, 19 Apr 2018 14:52:22 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2018, #02; Tue, 17)
References: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com>
Date:   Thu, 19 Apr 2018 14:52:22 +0300
In-Reply-To: <xmqqzi22tlfx.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 17 Apr 2018 15:07:46 +0900")
Message-ID: <87604nza4p.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

[...]

>
> * js/rebase-recreate-merge (2018-04-11) 15 commits
[...]
>  "git rebase" learned "--rebase-merges" to transplant the whole
>  topology of commit graph elsewhere.
>
>  This looked more or less ready for 'next'.  Please stop me if there
>  are remaining issues I forgot about.

It seems this is currently in inconsistent state. Despite the new name
of the option, it still doesn't rebase merges. It rather recreates them
from scratch, and Johannes is hopefully still working on implementation
of proper rebasing.

In addition, for what it's worth, I'm cooking a review of the problems
of the suggested UI. I believe the UI of this new feature is seriously
mis- and/or under- developed and is not suitable as is for the core Git.

-- Sergey
