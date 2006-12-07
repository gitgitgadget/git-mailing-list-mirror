X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 15:33:16 +0100
Message-ID: <81b0412b0612070633i7aec43dse7a8beda64437103@mail.gmail.com>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 14:34:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=EennZh26e9TUHNyZjVTQU2e0WUDnhhlugsGa5j0Sm7aL2jcn9YpamlKJmNmRsi0lTgQPyXZ5meNJvs6gwINiq+v0Ppp5tNNF97+BlwDdGjmQ+JvZxvaCcprt0Ns7wKOVXJSTpDfvEtIscbXQN7wea5SqyDROmghqKeZ/dUUDID8=
In-Reply-To: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33582>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKJx-0007FZ-OU for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937957AbWLGOdy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937964AbWLGOdy
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:33:54 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:3392 "EHLO
 nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S937957AbWLGOdx (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 09:33:53 -0500
Received: by nf-out-0910.google.com with SMTP id o25so899253nfa for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 06:33:52 -0800 (PST)
Received: by 10.78.142.14 with SMTP id p14mr1438626hud.1165501996543; Thu, 07
 Dec 2006 06:33:16 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 7 Dec 2006 06:33:16 -0800 (PST)
To: "Brian Gernhardt" <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

On 12/7/06, Brian Gernhardt <benji@silverinsanity.com> wrote:
> When I pulled the most recent changes for git (de51faf), `make` began
> failing with the following messages:
>
> make -C perl PERL_PATH='/usr/bin/perl' prefix='/usr/local/stow/git' all
> Makefile out-of-date with respect to Makefile.PL /System/Library/Perl/
> 5.8.6/darwin-thread-multi-2level/Config.pm /System/Library/Perl/5.8.6/
> darwin-thread-multi-2level/CORE/config.h

Strange. You seem to have the old, generated Makefile you perl/
directory. Haven't your pull failed? If so, I suspect that

 rm perl/Makefile
 git reset --hard
 git pull git...

