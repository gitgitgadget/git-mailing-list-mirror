From: Andrew Wong <andrew.w@sohovfx.com>
Subject: Re: rebase -i reword runs pre-commit hook with curious results
Date: Thu, 02 Feb 2012 00:43:34 -0500
Message-ID: <4F2A2286.3090808@sohovfx.com>
References: <jgcc3q$mvl$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Neal Kreitzinger <neal@rsss.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 06:43:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RspSR-0001PC-QQ
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 06:43:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752817Ab2BBFni (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 00:43:38 -0500
Received: from smtp01.beanfield.com ([76.9.193.170]:55556 "EHLO
	smtp01.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751707Ab2BBFnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 00:43:37 -0500
X-Spam-Status: No
X-beanfield-mta01-MailScanner-From: andrew.w@sohovfx.com
X-beanfield-mta01-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta01-MailScanner: Found to be clean
X-beanfield-mta01-MailScanner-ID: 1RspSJ-000Ddb-C4
Received: from [24.246.58.202] (helo=ZanarkandMac.local)
	by mta01.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w@sohovfx.com>)
	id 1RspSJ-000Ddb-C4; Thu, 02 Feb 2012 00:43:35 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:9.0) Gecko/20111222 Thunderbird/9.0.1
In-Reply-To: <jgcc3q$mvl$1@dough.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189586>

On 12-02-01 4:50 PM, Neal Kreitzinger wrote:
> I'm confused on why and/or how interactive rebase runs the pre-commit hook
> when doing the reword command for commit (a).
When you do a "reword" in "rebase -i", it basically does a "cherry-pick" 
of that commit first, then it does a "commit --amend". And your 
pre-commit hook should've been run during the amend.
> IOW, the pre-commit hook does not get the same results as if I were doing a
> commandline git-commit of a modified index.
Does your pre-commit hook work when doing a "commit --amend"? I'm not 
sure if you can actually modify the author (or committer) date from 
inside a pre-commit hook.
