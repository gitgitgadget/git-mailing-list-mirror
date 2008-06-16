From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to track changes of a file
Date: Mon, 16 Jun 2008 12:56:57 +0200
Message-ID: <485646F9.1030300@viscovery.net>
References: <48564499.3050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 12:57:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8CPI-00033v-Aj
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 12:57:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751875AbYFPK46 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 06:56:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751855AbYFPK46
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 06:56:58 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38329 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808AbYFPK45 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 06:56:57 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K8COO-00030o-Bh; Mon, 16 Jun 2008 12:56:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 23A246D9; Mon, 16 Jun 2008 12:56:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48564499.3050008@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85175>

bill lam schrieb:
> I want to see what had been done to a particular file, so I started with
> the log,
> 
> $ git-log --no-color glinvc03.ijs |grep commit |head -3
> commit 23335cf4acadb9f09410f106adbcc2b190fe9c70
> commit 31e4f2c519caa9afa2e29ed8ffb40deb62aa972f
> commit b515f020d05f2967a7283751c8dd3740de7136a4

All you neede here probably was just

$ git rev-list -3 -- glinvc03.ijs

> I want to know how to,
> 1. cat the content this file for these 3 versions

$ git show {23335c,31e4f2,b515f0}:glinvc03.ijs

> 2. show the differences between versions,

$ git log -p -2 -- glinvc03.ijs

> I use vim to view man page, and git-log without redirection will invoke
> vim as a man viewer.  Does git-log always use man?  Without the
> --no-color option there will be some "33m" prepending to some lines, is
> there any global setting to turn off color in git-log?

You have set PAGER=vim in your .profile? Then put

GIT_PAGER=less; export GIT_PAGER

there, too.

-- Hannes
