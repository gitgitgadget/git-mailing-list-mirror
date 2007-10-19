From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] allow git to use the PATH for finding subcommands and
 help docs
Date: Fri, 19 Oct 2007 16:34:26 +0200
Message-ID: <4718C072.2070505@viscovery.net>
References: <20071019065931.GB1463@srparish.net> <47185DAF.7060809@viscovery.net> <20071019130402.GD1463@srparish.net> <4718AF48.9020607@viscovery.net> <20071019141805.GE1463@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Fri Oct 19 18:35:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iiuoi-00048P-KE
	for gcvg-git-2@gmane.org; Fri, 19 Oct 2007 18:35:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758290AbXJSQfJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Oct 2007 12:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758257AbXJSQfJ
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Oct 2007 12:35:09 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:38978 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758014AbXJSQfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Oct 2007 12:35:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IiuoF-0001UP-CC; Fri, 19 Oct 2007 18:34:51 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 37A69546; Fri, 19 Oct 2007 16:34:26 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20071019141805.GE1463@srparish.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61731>

Scott Parish schrieb:
> On Fri, Oct 19, 2007 at 03:21:12PM +0200, Johannes Sixt wrote:
> 
>>  Scott Parish schrieb:
>>> I have a situation where software for a distribution is installed
>>> into a fake "prefix" and then moved to one of several potential
>>> places to be used by users. Given that the final location isn't
>>> static, i can't depend on builtin_exec_path. I'd really like users
>>> to be able to get started with git as easily as possible. With the
>>> current setup, they would have to create and maintain either an
>>> GIT_EXEC_PATH or an alias for including --exec-path, as well as a
>>> MANPATH and PERL5LIB. This seem like an unnessisary burden.
>>  Interesting. How does this compare to this 2-patch-series:
>>
>>  http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=e479ea2f911b8c70a269ba59372a4fef90f8907c
>>  http://repo.or.cz/w/git/mingw.git?a=commitdiff;h=00a4ff4f3f8ec7e6b3ac15456f00b22b03f438ae
>>
>>  which I had come up with to accomplish something very similar
>>  (on Windows). Your approach looks superior, but I hadn't gone
>>  into depths, yet.
> 
> I know very little about what's available on windows. Looking at
> your code, it looks like the command isn't passed in in argv[0] and
> that it contains the windows style path seperators. My code currently
> assumes that PATH is a colon separated list, and that directories
> are separated with '/'. How should these assumptions change for
> windows?

The question is rather whether my patches would be sufficient to also 
achieve your requirements. They turn bultin_exec_path into a non-constant 
that derives exec-path from argv[0] (which on Windows happens to be 
available in the global _pgmptr). Isn't this enough, or at least the essence 
of what you need?

(How to get to the value of _pgmptr, ie. argv[0], on non-Windows is a 
secondary matter.)

-- Hannes
