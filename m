Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411141F576
	for <e@80x24.org>; Fri,  9 Feb 2018 06:50:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbeBIGu0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 01:50:26 -0500
Received: from mail.javad.com ([54.86.164.124]:50866 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbeBIGuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 01:50:25 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 5C15A41B94;
        Fri,  9 Feb 2018 06:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518159024;
        bh=/wAwTCvFl/XzTieigJUy/efpLX6jpLfHfhh7fldW+jc=; l=1946;
        h=Received:From:To:Subject;
        b=cTPWI4rcDeCZzTm9YVEeh3jo9fQ+6rzVP9GuuWdp/uVSpqaaUWQYBpn1O7cAgzceo
         SthaLRpVz15bFE5RoAUtaf1YgvyZuvMipAlrL73YpZcKcONA5LVEkQ12xbe8wXgBvC
         S7HuUQrqC3rLnJ7p7OU1B7yIGFlkRpCT+3nnd4Os=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518159024;
        bh=/wAwTCvFl/XzTieigJUy/efpLX6jpLfHfhh7fldW+jc=; l=1946;
        h=Received:From:To:Subject;
        b=cTPWI4rcDeCZzTm9YVEeh3jo9fQ+6rzVP9GuuWdp/uVSpqaaUWQYBpn1O7cAgzceo
         SthaLRpVz15bFE5RoAUtaf1YgvyZuvMipAlrL73YpZcKcONA5LVEkQ12xbe8wXgBvC
         S7HuUQrqC3rLnJ7p7OU1B7yIGFlkRpCT+3nnd4Os=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518159024;
        bh=/wAwTCvFl/XzTieigJUy/efpLX6jpLfHfhh7fldW+jc=; l=1946;
        h=Received:From:To:Subject;
        b=cTPWI4rcDeCZzTm9YVEeh3jo9fQ+6rzVP9GuuWdp/uVSpqaaUWQYBpn1O7cAgzceo
         SthaLRpVz15bFE5RoAUtaf1YgvyZuvMipAlrL73YpZcKcONA5LVEkQ12xbe8wXgBvC
         S7HuUQrqC3rLnJ7p7OU1B7yIGFlkRpCT+3nnd4Os=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1518159024;
        bh=/wAwTCvFl/XzTieigJUy/efpLX6jpLfHfhh7fldW+jc=; l=1946;
        h=Received:From:To:Subject;
        b=cTPWI4rcDeCZzTm9YVEeh3jo9fQ+6rzVP9GuuWdp/uVSpqaaUWQYBpn1O7cAgzceo
         SthaLRpVz15bFE5RoAUtaf1YgvyZuvMipAlrL73YpZcKcONA5LVEkQ12xbe8wXgBvC
         S7HuUQrqC3rLnJ7p7OU1B7yIGFlkRpCT+3nnd4Os=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ek2Vp-0004Jy-K6; Fri, 09 Feb 2018 09:50:21 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
Date:   Fri, 09 Feb 2018 09:50:21 +0300
In-Reply-To: <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:48 +0100
        (STD)")
Message-ID: <874lmqirma.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

[...]

> With this patch, the goodness of the Git garden shears comes to `git
> rebase -i` itself. Passing the `--recreate-merges` option will generate
> a todo list that can be understood readily, and where it is obvious
> how to reorder commits. New branches can be introduced by inserting
> `label` commands and calling `merge - <label> <oneline>`. And once this
> mode has become stable and universally accepted, we can deprecate the
> design mistake that was `--preserve-merges`.

This doesn't explain why you introduced this new --recreate-merges. Why
didn't you rather fix --preserve-merges to generate and use new todo
list format?

It doesn't seem likely that todo list created by one Git version is to
be ever used by another, right? Is there some hidden reason here? Some
tools outside of Git that use old todo list format, maybe?

Then, if new option indeed required, please look at the resulting manual:

--recreate-merges::
	Recreate merge commits instead of flattening the history by replaying
	merges. Merge conflict resolutions or manual amendments to merge
	commits are not preserved.

-p::
--preserve-merges::
	Recreate merge commits instead of flattening the history by replaying
	commits a merge commit introduces. Merge conflict resolutions or manual
	amendments to merge commits are not preserved.


Don't you think more explanations are needed there in the manual on
why do we have 2 separate options with almost the same yet subtly
different description? Is this subtle difference even important? How?

I also have trouble making sense of "Recreate merge commits instead of
flattening the history by replaying merges." Is it "<Recreate merge
commits by replaying merges> instead of <flattening the history>" or is it
rather "<Recreate merge commits> instead of <flattening the history by
replaying merges>?

-- Sergey
