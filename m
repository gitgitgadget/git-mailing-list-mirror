Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD34120986
	for <e@80x24.org>; Fri,  7 Oct 2016 14:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756061AbcJGOdT (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 10:33:19 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33368 "EHLO mx2.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752289AbcJGOdO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 10:33:14 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx2.imag.fr (8.13.8/8.13.8) with ESMTP id u97EVEfY017698
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 7 Oct 2016 16:31:16 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u97EVGcZ013174;
        Fri, 7 Oct 2016 16:31:16 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC] git.c: support "!!" aliases that do not move cwd
References: <20161006114124.4966-1-pclouds@gmail.com>
        <xmqq60p5l3om.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610071319520.35196@virtualbox>
        <CACsJy8ASc7Fxm5XDHFiX9E+bQ8s1MtmEHfc7bZY4C-_GEQr0og@mail.gmail.com>
        <vpqmvig5ns6.fsf@anie.imag.fr>
        <alpine.DEB.2.20.1610071611550.35196@virtualbox>
Date:   Fri, 07 Oct 2016 16:31:16 +0200
In-Reply-To: <alpine.DEB.2.20.1610071611550.35196@virtualbox> (Johannes
        Schindelin's message of "Fri, 7 Oct 2016 16:12:45 +0200 (CEST)")
Message-ID: <vpq37k844ej.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (mx2.imag.fr [129.88.30.17]); Fri, 07 Oct 2016 16:31:19 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u97EVEfY017698
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1476455481.20756@3rZq40d3ZxUprHeiMBu/Ow
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Matthieu,
>
> On Fri, 7 Oct 2016, Matthieu Moy wrote:
>
>> Another possibility: !(nocd), which leaves room
>> for !(keyword1,keyword2,...) if needed later. Also, it is consistent
>> with the :(word) syntax of pathspecs.
>
> But is this backwards-compatible? Don't we execute everything that comes
> after the exclamation mark as a command-line via shell, where the
> parentheses mean "open a subshell"?

Good point. I can imagine someone already having

[alias]
	foo = !(cd bar && $something) && $something_else

Your proposed (keyword)! is better.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
