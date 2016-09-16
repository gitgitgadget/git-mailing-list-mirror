Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C93FF1FCA9
	for <e@80x24.org>; Fri, 16 Sep 2016 07:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756654AbcIPHZP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 03:25:15 -0400
Received: from mx1.imag.fr ([129.88.30.5]:45612 "EHLO mx1.imag.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752183AbcIPHZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 03:25:13 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
        by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u8G7P7DL009115
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
        Fri, 16 Sep 2016 09:25:07 +0200
Received: from anie (anie.imag.fr [129.88.42.32])
        by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u8G7P7uN003437;
        Fri, 16 Sep 2016 09:25:07 +0200
From:   Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To:     Anatoly Borodin <anatoly.borodin@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Potentially misleading color.* defaults explanation in git-config(1)
References: <nrfihd$a4o$1@blaine.gmane.org>
Date:   Fri, 16 Sep 2016 09:25:07 +0200
In-Reply-To: <nrfihd$a4o$1@blaine.gmane.org> (Anatoly Borodin's message of
        "Fri, 16 Sep 2016 01:40:01 +0000 (UTC)")
Message-ID: <vpqeg4k1f3g.fsf@anie.imag.fr>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 16 Sep 2016 09:25:07 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u8G7P7DL009115
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1474615510.57972@45+qzfXB2+YB+XvPf2rghw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Anatoly Borodin <anatoly.borodin@gmail.com> writes:

> Hi All!
>
> git-config(1) says:
>
>        color.branch
>            A boolean to enable/disable color in the output of git-branch(1).
>            May be set to always, false (or never) or auto (or true), in which
>            case colors are used only when the output is to a terminal.

So far, so good.

>            Defaults to false.

The truth is: Defaults to following color.ui, which used to default to
false but now defaults to auto.

My bad, I forgot to update these parts of the docs when changing the
default for color.ui (a while back already). Patch follows.

> (2)	git config color.branch false ; git branch

Unrelated from the question, but you could write

git -c color.branch=false git branch

to set a configuration value just for one command.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
