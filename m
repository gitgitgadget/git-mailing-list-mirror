Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A550A1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 12:44:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757453AbcG1MoY (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 08:44:24 -0400
Received: from zm-etu-ensimag-1.grenet.fr ([130.190.244.117]:52598 "EHLO
	zm-etu-ensimag-1.grenet.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757376AbcG1MoW convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 08:44:22 -0400
Received: from localhost (localhost [127.0.0.1])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4F6C6268F;
	Thu, 28 Jul 2016 14:44:19 +0200 (CEST)
Received: from zm-smtpout-1.grenet.fr ([127.0.0.1])
	by localhost (zm-smtpout-1.grenet.fr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FFz_k6Q0xBCm; Thu, 28 Jul 2016 14:44:19 +0200 (CEST)
Received: from zm-int-mbx1.grenet.fr (zm-int-mbx1.grenet.fr [130.190.242.140])
	by zm-smtpout-1.grenet.fr (Postfix) with ESMTP id 4018F2657;
	Thu, 28 Jul 2016 14:44:19 +0200 (CEST)
Date:	Thu, 28 Jul 2016 15:02:54 +0200 (CEST)
From:	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To:	phillip wood <phillip.wood@dunelm.org.uk>
Cc:	git@vger.kernel.org
Message-ID: <568300231.1133609.1469710974063.JavaMail.zimbra@ensimag.grenoble-inp.fr>
In-Reply-To: <222a3e5b-ff2c-799e-0fcb-cba23815019f@talktalk.net>
References: <222a3e5b-ff2c-799e-0fcb-cba23815019f@talktalk.net>
Subject: Re: Bug? git rebase -i --autostash fails to restore working files
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [130.190.242.136]
X-Mailer: Zimbra 8.0.9_GA_6191 (ZimbraWebClient - FF39 (Linux)/8.0.9_GA_6191)
Thread-Topic: Bug? git rebase -i --autostash fails to restore working files
Thread-Index: AgLsLs0OCVogLhzz1SA9ePUF7lnl7Q==
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Phillip,

Phillip Wood <phillip.wood@talktalk.net> writes:
> When running ‘git rebase -i --autostash’ if the editor fails then the
> rebase fails but stash is not applied so the working files are not
> restored. Running ‘git rebase --abort’ replies that there’s no rebase
> in progress. If you notice what’s happened it’s not a problem if you
> know to do ‘git stash apply <autostash id>’ but it’s confusing as
> normally the stash would be automatically applied. This happened to me
> when I messed up my editor configuration but you can reproduce it with
> 
> $ GIT_SEQUENCE_EDITOR=false git rebase -i --autostash HEAD^^
> Created autostash: ff960d4
> HEAD is now at f1b8af7 [git] Turn on rebase.missingCommitsCheck

[I'm happy to see rebase.missingCommitsCheck being used.]

> Could not execute editor
> 
> $ git rebase --abort
> No rebase in progress?

I remembered having read something about it recently and a quick
search confirmed it. It was corrected in commit 33ba9c6 (29/06/2016,
rebase -i: restore autostash on abort) that recently graduated to
master (on 19/07/2016 if I read the various "What's cooking"
correctly). So you will need to build git from source to have this
corrected.

> Best Wishes
> 
> Phillip

Thanks,
Rémi
