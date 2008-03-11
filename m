From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: commit 0? (or: create new empty branch)
Date: Tue, 11 Mar 2008 14:08:10 +0100
Message-ID: <47D6843A.1030200@viscovery.net>
References: <20080311123004.GA27577@bit.office.eurotux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luciano Rocha <luciano@eurotux.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 14:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZ4Dv-0000CY-3J
	for gcvg-git-2@gmane.org; Tue, 11 Mar 2008 14:08:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbYCKNIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2008 09:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753403AbYCKNIN
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Mar 2008 09:08:13 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:10753 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753050AbYCKNIN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2008 09:08:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZ4CV-000693-KG; Tue, 11 Mar 2008 14:07:27 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id C13F06EF; Tue, 11 Mar 2008 14:08:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080311123004.GA27577@bit.office.eurotux.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76839>

Luciano Rocha schrieb:
> I'd like to create a new branch, without any pre-existing data, for
> purposes similar to git's html/man/.....
> 
> However, I've been unable to do that using the higher level tools.
> 
> Even starting from an empty git rep, I can't create a branch:
> 
> $ git init
> Initialized empty Git repository in .git/
> $ git branch empty
> fatal: Not a valid object name: 'master'.
> 
> How were the different git.git branches created?

There are two ways:

1. Plumbing level

  $ git symbolic-ref HEAD refs/heads/html
  $ rm .git/index
  ...commit new content...

2. Porcelain level

  $ mkdir ../html && cd ../html
  $ git init
  ...commit new content...
  $ cd -   # go back
  $ git fetch ../html master:html

-- Hannes
