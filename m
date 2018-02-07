Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C18D21F404
	for <e@80x24.org>; Wed,  7 Feb 2018 06:16:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753211AbeBGGQc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 01:16:32 -0500
Received: from mail.javad.com ([54.86.164.124]:35552 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753066AbeBGGQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 01:16:29 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 6C5C43E89E;
        Wed,  7 Feb 2018 06:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517984188;
        bh=Xlh2BoKt+hbfFiyqpaAZB0jKrFcBWx9iYqi4MblKEXM=; l=1169;
        h=Received:From:To:Subject;
        b=mD8neLgquykaW+vgzG0oRKWcnXbQFOK3L8Q/T0/ZTyswe3XgD2hhrkxwSN4zkdNde
         YhCxg7SLrASrFK93Yw26Mwy5btnwm25qGkUpck9ZUdFAEnoWdE9Zh36bHGEor//p6a
         xQDtzl9WkkXZFJmbFqPQfkHRD5A4g7SboEba8rfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517984188;
        bh=Xlh2BoKt+hbfFiyqpaAZB0jKrFcBWx9iYqi4MblKEXM=; l=1169;
        h=Received:From:To:Subject;
        b=mD8neLgquykaW+vgzG0oRKWcnXbQFOK3L8Q/T0/ZTyswe3XgD2hhrkxwSN4zkdNde
         YhCxg7SLrASrFK93Yw26Mwy5btnwm25qGkUpck9ZUdFAEnoWdE9Zh36bHGEor//p6a
         xQDtzl9WkkXZFJmbFqPQfkHRD5A4g7SboEba8rfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517984188;
        bh=Xlh2BoKt+hbfFiyqpaAZB0jKrFcBWx9iYqi4MblKEXM=; l=1169;
        h=Received:From:To:Subject;
        b=mD8neLgquykaW+vgzG0oRKWcnXbQFOK3L8Q/T0/ZTyswe3XgD2hhrkxwSN4zkdNde
         YhCxg7SLrASrFK93Yw26Mwy5btnwm25qGkUpck9ZUdFAEnoWdE9Zh36bHGEor//p6a
         xQDtzl9WkkXZFJmbFqPQfkHRD5A4g7SboEba8rfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517984188;
        bh=Xlh2BoKt+hbfFiyqpaAZB0jKrFcBWx9iYqi4MblKEXM=; l=1169;
        h=Received:From:To:Subject;
        b=mD8neLgquykaW+vgzG0oRKWcnXbQFOK3L8Q/T0/ZTyswe3XgD2hhrkxwSN4zkdNde
         YhCxg7SLrASrFK93Yw26Mwy5btnwm25qGkUpck9ZUdFAEnoWdE9Zh36bHGEor//p6a
         xQDtzl9WkkXZFJmbFqPQfkHRD5A4g7SboEba8rfQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1517984188;
        bh=Xlh2BoKt+hbfFiyqpaAZB0jKrFcBWx9iYqi4MblKEXM=; l=1169;
        h=Received:From:To:Subject;
        b=mD8neLgquykaW+vgzG0oRKWcnXbQFOK3L8Q/T0/ZTyswe3XgD2hhrkxwSN4zkdNde
         YhCxg7SLrASrFK93Yw26Mwy5btnwm25qGkUpck9ZUdFAEnoWdE9Zh36bHGEor//p6a
         xQDtzl9WkkXZFJmbFqPQfkHRD5A4g7SboEba8rfQ=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1ejJ1u-0001As-Bh; Wed, 07 Feb 2018 09:16:26 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 5/8] rebase: introduce the --recreate-merges option
References: <cover.1516225925.git.johannes.schindelin@gmx.de>
        <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
Date:   Wed, 07 Feb 2018 09:16:26 +0300
In-Reply-To: <71c42d6d3bb240d90071d5afdde81d1293fdf0ab.1516225925.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Thu, 18 Jan 2018 16:35:48 +0100
        (STD)")
Message-ID: <87k1vpqq85.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

[...]

> +--recreate-merges::
> +	Recreate merge commits instead of flattening the history by replaying
> +	merges. Merge conflict resolutions or manual amendments to merge
> +	commits are not preserved.

I wonder why you guys still hold on replaying "merge-the-operation"
instead of replaying "merge-the-result"? The latter, the merge commit
itself, no matter how exactly it was created in the first place, is the
most valuable thing git keeps about the merge, and you silently drop it
entirely! OTOH, git keeps almost no information about
"merge-the-operation", so it's virtually impossible to reliably replay
the operation automatically, and yet you try to.

IMHO that was severe mistake in the original --preserve-merges, and you
bring with you to this new --recreate-merges... It's sad. Even more sad
as solution is already known for years:

    bc00341838a8faddcd101da9e746902994eef38a
    Author: Johannes Sixt <j6t@kdbg.org>
    Date:   Sun Jun 16 15:50:42 2013 +0200
    
        rebase -p --first-parent: redo merge by cherry-picking first-parent change

and it works like a charm.

-- Sergey

