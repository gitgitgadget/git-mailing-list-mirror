Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BDD31F424
	for <e@80x24.org>; Thu, 12 Apr 2018 11:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbeDLLwp (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Apr 2018 07:52:45 -0400
Received: from mail.javad.com ([54.86.164.124]:43855 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752017AbeDLLwn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Apr 2018 07:52:43 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 31DCB3FEF7;
        Thu, 12 Apr 2018 11:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523533962;
        bh=hNbNa1pz0P1CGKvlk7dUd5ZTX0EY54RcnsEBPU8EsJU=; l=1356;
        h=Received:From:To:Subject;
        b=H7XFuFa17VYT9V8FqaO4qd4gG4x9lcoPBtI4L9Qwp6moDdgVxFocEsD6OpNpC+RtX
         Oir0vYKCHscImCPhfQ5HaHEeTcPidDV/GGnoJfjhGtl+68eW0QmqdmA8SZb2yCCe/O
         NvJ0l3V3+iXeJK8BitmVZRUU1572hUfAqbx3KM44=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f6amM-0001gj-NA; Thu, 12 Apr 2018 14:52:38 +0300
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
Subject: Re: [PATCH v6 15/15] rebase -i --rebase-merges: add a section to the man page
References: <cover.1519680483.git.johannes.schindelin@gmx.de>
        <cover.1523362469.git.johannes.schindelin@gmx.de>
        <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
Date:   Thu, 12 Apr 2018 14:52:38 +0300
In-Reply-To: <a162afa761e3000eb60169fce7a50938888f80b4.1523362469.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Tue, 10 Apr 2018 14:30:30 +0200
        (DST)")
Message-ID: <87o9ioy73t.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> +------------
> +*   Merge branch 'report-a-bug'
> +|\
> +| * Add the feedback button
> +* | Merge branch 'refactor-button'
> +|\ \
> +| |/
> +| * Use the Button class for all buttons
> +| * Extract a generic Button class from the DownloadButton one
> +------------

Consider to put SHA1s into the diagram, as they are then used in
explanaitions. Hopefully I got them right here:

------------
*   6f5e4d Merge branch 'report-a-bug'
|\
| * abcdef Add the feedback button
* | a1b2c3 Merge branch 'refactor-button'
|\ \
| |/
| * 654321 Use the Button class for all buttons
| * 123456 Extract a generic Button class from the DownloadButton one
------------

Original explanation, just for reference, unchanged:

> +------------
> +label onto
> +
> +# Branch: refactor-button
> +reset onto
> +pick 123456 Extract a generic Button class from the DownloadButton one
> +pick 654321 Use the Button class for all buttons
> +label refactor-button
> +
> +# Branch: report-a-bug
> +reset refactor-button # Use the Button class for all buttons
> +pick abcdef Add the feedback button
> +label report-a-bug
> +
> +reset onto
> +merge -C a1b2c3 refactor-button # Merge 'refactor-button'
> +merge -C 6f5e4d report-a-bug # Merge 'report-a-bug'
> +------------

-- Sergey
