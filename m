Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92AAA1F404
	for <e@80x24.org>; Tue, 10 Apr 2018 14:52:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753935AbeDJOwF (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 10:52:05 -0400
Received: from mail.javad.com ([54.86.164.124]:59097 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753628AbeDJOwE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 10:52:04 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6717D3EC38;
        Tue, 10 Apr 2018 14:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523371923;
        bh=9j0hnIjSx2Nz3nZO6KXiNDJw9MxbX+EZz5Ol6ADOLtI=; l=853;
        h=Received:From:To:Subject;
        b=P55Q3dMGjk00saUt0rgGyOZ1mPSd6JkBhV7RBrftMlgEQvUprYULXV+WyYkBzJv5G
         Sxdn3NdlPaEHQr1u3RjBocQ3gBHNr5KnRUUIJAoA0oejgxR+yivc5Mshfoit8dHH/5
         yjt6+aIDxll2mrFpnA+uEQ6EZJQJ7dlDXQ7EqPik=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f5ucr-0006zh-Od; Tue, 10 Apr 2018 17:52:01 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 00/15] rebase -i: offer to recreate commit topology
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
Date:   Tue, 10 Apr 2018 17:52:01 +0300
In-Reply-To: <cover.1523362469.git.johannes.schindelin@gmx.de> (Johannes
        Schindelin's message of "Tue, 10 Apr 2018 14:29:23 +0200 (DST)")
Message-ID: <87tvsj6rn2.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Once upon a time, I dreamt of an interactive rebase that would not
> flatten branch structure, but instead recreate the commit topology
> faithfully.

[...]

> Think of --rebase-merges as "--preserve-merges done right".

Both option names seem to miss the primary point of the mode of
operation that you've formulated in the first sentence. I suggest to
rather call the new option in accordance to your description, say,
--no-flatten, --keep-topology, or --preserve-shape.

Besides, this way the option name will only specify one thing: _what_ it
is about, leaving out the _how_ part, that could vary and could then be
specified as option value or as another companion option(s), that is
usually considered to be an indication of a good design.

-- Sergey
