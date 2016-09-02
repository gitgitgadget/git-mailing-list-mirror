Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D842F1F859
	for <e@80x24.org>; Fri,  2 Sep 2016 09:19:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751643AbcIBJTf (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 05:19:35 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:49664 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750873AbcIBJTf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 05:19:35 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 3sQYVC6FrRz3hkdS;
        Fri,  2 Sep 2016 11:19:31 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
        by mail.m-online.net (Postfix) with ESMTP id 3sQYVC1pgszvlQj;
        Fri,  2 Sep 2016 11:19:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
        with ESMTP id dOb1GVdRfqrr; Fri,  2 Sep 2016 11:19:30 +0200 (CEST)
X-Auth-Info: XDeV85ACIn3xmVaNQl5w2/oCTc7NC1LtItOBdVEkDxzXPuXJsyI4B5b93nzGwYxi
Received: from igel.home (ppp-88-217-12-130.dynamic.mnet-online.de [88.217.12.130])
        by mail.mnet-online.de (Postfix) with ESMTPA;
        Fri,  2 Sep 2016 11:19:30 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id E322D2C41E0; Fri,  2 Sep 2016 11:19:29 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: Should "git symbolic-ref -d HEAD" be forbidden?
References: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com>
X-Yow:  MY income is ALL disposable!
Date:   Fri, 02 Sep 2016 11:19:29 +0200
In-Reply-To: <xmqqpoonuy4n.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 01 Sep 2016 14:08:08 -0700")
Message-ID: <87wpiuy7z2.fsf@linux-m68k.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sep 01 2016, Junio C Hamano <gitster@pobox.com> wrote:

> I think we should.
>
> t1401 expects to be able to, but if you really do it:
>
> 	$ cd /tmp
> 	$ git init throwaway
>         $ cd throwaway
>         $ git symbolic-ref -d HEAD
>
> the setup machinery considers that you are no longer in a working
> tree that is controlled by a repository at .git/ because .git/ is
> no longer a valid repository, so you cannot even do
>
> 	$ git symbolic-ref HEAD refs/heads/master
>
> to recover.

git init recovers it, though.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
