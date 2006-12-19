X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: branch rebase and push
Date: Tue, 19 Dec 2006 10:57:35 +0100
Organization: At home
Message-ID: <em8cti$nff$1@sea.gmane.org>
References: <45875EFC.5090408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
NNTP-Posting-Date: Tue, 19 Dec 2006 09:55:47 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Injected-Via-Gmane: http://gmane.org/
Original-Lines: 37
Original-X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-25-107.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34807>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gwbh5-0001wx-VE for gcvg-git@gmane.org; Tue, 19 Dec
 2006 10:55:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932734AbWLSJz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 04:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932740AbWLSJz3
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 04:55:29 -0500
Received: from main.gmane.org ([80.91.229.2]:59133 "EHLO ciao.gmane.org"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP id S932734AbWLSJz2
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 04:55:28 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43) id
 1Gwbgo-0001ud-Sw for git@vger.kernel.org; Tue, 19 Dec 2006 10:55:15 +0100
Received: from host-81-190-25-107.torun.mm.pl ([81.190.25.107]) by
 main.gmane.org with esmtp (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00 for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 10:55:14 +0100
Received: from jnareb by host-81-190-25-107.torun.mm.pl with local (Gmexim
 0.1 (Debian)) id 1AlnuQ-0007hv-00 for <git@vger.kernel.org>; Tue, 19 Dec 2006
 10:55:14 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

SungHyun Nam wrote:

> Can I push a branch after rebase?
> I got a error message:
>    error: remote 'refs/heads/br' is not a strict subset of local ref
>    'refs/heads/br'. maybe you are not up-to-date and need to pull first?
> 
> It worked fine if I did:
>   $ git checkout -b br
>   $ git pull . master
>   $ git checkout master
>   $ git pull
>   $ git push
> 
> But I got above error message if I did:
>   $ git checkout br
>   $ git rebase master
>   $ git checkout master
>   $ git pull
>   $ git push

The problem you have is with _push_, not branch, I think.

Does repository you pull from has rebased branch 'br'? If yes, is it
pulled with + in pull/fetch line? Perhaps (but read documentation first,
please) "git push --force" is what you want, provided that other side
doesn't forbid non fast-forward pushes.

Bu you usually don't rebase published branch (don't change history
of published branch). Equivalently, you don't publish rebased branch
until it is ready (or merged in ;-).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git

