Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9EE41F406
	for <e@80x24.org>; Tue, 16 Jan 2018 11:48:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbeAPLsh (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jan 2018 06:48:37 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:35864 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750885AbeAPLsg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jan 2018 06:48:36 -0500
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3zLT4y4MVFz1qt0n;
        Tue, 16 Jan 2018 12:48:34 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 3zLT4y3hRMz1qr23;
        Tue, 16 Jan 2018 12:48:34 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id pLmVWy8ozGCN; Tue, 16 Jan 2018 12:48:33 +0100 (CET)
X-Auth-Info: SPf0uC98WiSoe7LCTih3AQDyQEMBPKc/3P3ARVnyfM9RQspEmx/A5MTU8raMDoZx
Received: from localhost (ppp-188-174-155-106.dynamic.mnet-online.de [188.174.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 16 Jan 2018 12:48:33 +0100 (CET)
Received: by localhost (Postfix, from userid 1000)
        id 827DD2C33EB; Tue, 16 Jan 2018 12:48:32 +0100 (CET)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Michael Giuffrida <michaelpg@chromium.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Michael Schubert <mschub@elegosoft.com>
Subject: Re: [BUG] git remote prune removes local tags, depending on fetch config
References: <CACi5S_39wNrbfjLfn0xhCY+uewtFN2YmnAcRc86z6pjUTjWPHQ@mail.gmail.com>
        <87tvvmiqn7.fsf@evledraar.gmail.com>
        <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
X-Yow:  Should I start with the time I SWITCHED personalities with a BEATNIK
 hair stylist or my failure to refer five TEENAGERS to a good OCULIST?
Date:   Tue, 16 Jan 2018 12:48:32 +0100
In-Reply-To: <CACi5S_33F7VVRYiBOQsxgg_ZPOg9ZvhLZ26bStYWiq7n96aeug@mail.gmail.com>
        (Michael Giuffrida's message of "Mon, 15 Jan 2018 18:14:30 -0800")
Message-ID: <874lnmkorz.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.0.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 15 2018, Michael Giuffrida <michaelpg@chromium.org> wrote:

> It doesn't seem like a useful feature -- you wouldn't expect `git
> fetch --prune` to remove your local branches that you were developing
> on, right?

Don't mix local and remote refs.  There is a reason why remote tracking
branches are put in a separate name space.  If you fetch the remote tags
into a separate name space (eg. refs/remote/tags/*:refs/tags/*) then
there is no conflict.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
