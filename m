Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E3BE1F404
	for <e@80x24.org>; Tue, 27 Mar 2018 05:34:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751184AbeC0Fec (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Mar 2018 01:34:32 -0400
Received: from mail.javad.com ([54.86.164.124]:43988 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752106AbeC0FeE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Mar 2018 01:34:04 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id D01CA3EA25;
        Tue, 27 Mar 2018 05:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1522128844;
        bh=2HcXSJHFxYh5jg4n7qU6b39GiVRT2Fwrif1lqZdUTHY=; l=658;
        h=Received:From:To:Subject;
        b=V5bBr/gEC6zv11r6mlEmK7rGEeeEJ+pQ67ydHjuXOvK8iK+pDWtvhD7XVzn5Q5DIY
         L1j7mlG5Qb29StK77PFWvcwvjOOoXOGgWw77okFQhkHZ80haXEARspgrzzHHePv8kH
         TD0g/Bv7ury2gZS6vwBk6MWGQScMkCIvqfgmxFP0=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f0hFC-0000Cu-5L; Tue, 27 Mar 2018 08:34:02 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Igor Djordjevic <igor.d.djordjevic@gmail.com>, git@vger.kernel.org,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [RFC v2] Rebasing merges: a jorney to the ultimate solution (Road Clear)
References: <87y3jtqdyg.fsf@javad.com> <87r2oxe3o1.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803070742580.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <87vae8yq15.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803071450511.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <a0cc88d2-bfed-ce7b-1b3f-3c447d2b32da@gmail.com>
        <nycvar.QRO.7.76.6.1803111324390.20700@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <d18a6e73-ce6f-b4aa-8ead-7aaabddf454d@gmail.com>
        <87zi3dh53k.fsf@javad.com>
        <nycvar.QRO.7.76.6.1803261331340.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
Date:   Tue, 27 Mar 2018 08:34:02 +0300
In-Reply-To: <nycvar.QRO.7.76.6.1803261331340.77@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        (Johannes Schindelin's message of "Mon, 26 Mar 2018 13:33:20 +0200
        (DST)")
Message-ID: <874ll2gjzp.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Sergey,
>
> On Mon, 12 Mar 2018, Sergey Organov wrote:
>
>> [...]
>> 
>> Yet another consequence is that my approach will likely result in better
>> code reuse.
>
> This is a purely academic speculation. At least until somebody implements
> Phillip's method. Oh wait, I already started to implement it, and it was
> not exactly hard to implement:
>
> https://github.com/dscho/git/commit/26d2858800a4e0d3cc6313ddb54dd4d2ce516f31

Nice! Please see [1] for some recent relevant discussion.

[1] https://public-inbox.org/git/87efkn6s1h.fsf@javad.com/

-- Sergey
