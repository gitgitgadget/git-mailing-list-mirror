From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: how to track changes of a file
Date: Mon, 16 Jun 2008 18:08:35 +0200
Message-ID: <48569003.6080406@viscovery.net>
References: <48564499.3050008@gmail.com> <485646F9.1030300@viscovery.net> <48568B76.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 16 18:09:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8HGw-0006pB-Si
	for gcvg-git-2@gmane.org; Mon, 16 Jun 2008 18:09:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751608AbYFPQIl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 12:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751564AbYFPQIl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 12:08:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:63544 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751107AbYFPQIk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 12:08:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1K8HG1-00010d-9N; Mon, 16 Jun 2008 18:08:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1165A6D9; Mon, 16 Jun 2008 18:08:37 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <48568B76.5050108@gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85200>

bill lam schrieb:
> Johannes Sixt wrote:
>> $ git rev-list -3 -- glinvc03.ijs
>>
>>
>> $ git show {23335c,31e4f2,b515f0}:glinvc03.ijs
> 
> Thank for you help, but these 2 command did not work, did I missing
> something? I I use git version 1.5.4.3 on linux.
> 
> $ git rev-list -3 -- glinvc03.ijs
> usage: git-rev-list [OPTION] <commit-id>... [ -- paths... ]

Sorry, should have been

$ git rev-list -3 HEAD -- glinvc03.ijs

But this is not intended for daily use anyway. You are better off using
git log family of commands. Eg. if you insist on a 1-commit-per-line
listing, you'd use

$ git log -3 --pretty=oneline -- glinvc03.ijs

> $ git show {23335c,31e4f2,b515f0}:glinvc03.ijs
> fatal: ambiguous argument '23335c:glinvc03.ijs': unknown revision or
> path not in the working tree.
> Use '--' to separate paths from revisions

My guess is that glinvc03.ijs lives in a subdirectory of your repo. Then
you must supply the complete path from the repository root:

$ git show {23335c,31e4f2,b515f0}:some/subdir/glinvc03.ijs

(No, this will not be changed.)

-- Hannes
