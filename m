From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 2/2] git-filter-branch.sh: don't use --default when calling
 rev-list
Date: Thu, 31 Jan 2008 10:17:05 +0100
Message-ID: <47A19211.5090409@op5.se>
References: <47A109A7.1070502@nrlssc.navy.mil> <1201738186-28132-1-git-send-email-casey@nrlssc.navy.mil> <47A11317.2010409@nrlssc.navy.mil> <alpine.LSU.1.00.0801310048350.23907@racer.site> <47A125D9.2070105@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Jan 31 10:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKVa7-0006Yh-7S
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 10:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762046AbYAaJSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 04:18:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765651AbYAaJSm
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 04:18:42 -0500
Received: from mail.op5.se ([193.201.96.20]:49977 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754896AbYAaJSi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 04:18:38 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 99F681F0804A;
	Thu, 31 Jan 2008 10:18:36 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mVT+Xsc7wOb0; Thu, 31 Jan 2008 10:18:35 +0100 (CET)
Received: from clix.int.op5.se (unknown [192.168.1.155])
	by mail.op5.se (Postfix) with ESMTP id 986D91F0801E;
	Thu, 31 Jan 2008 10:18:31 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <47A125D9.2070105@nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72109>

Brandon Casey wrote:
> Johannes Schindelin wrote:
>> Hi,
>>
>> On Wed, 30 Jan 2008, Brandon Casey wrote:
>>
>>> This command requires a revision to be specified on the command line, so 
>>> remove '--default HEAD' from the arguments to git rev-list. They are 
>>> unnecessary.
>> But I thought that you wanted "git filter-branch --msg-filter=rot13" to 
>> work on HEAD by default?
> 
> I do. But isn't that inconsistent with "git filter-branch" does _not_ work
> on HEAD by default and instead prints out usage information?
> 
> If I do:
> 
> 	git filter-branch -d /tmp/git_temp
> 
> and it is successful, I think I would also expect this to succeed:
> 
> 	git filter-branch
> 
> So, I think the "operates on HEAD" by default is consistent with what other
> git tools do, but I think it is not consistent for filter-branch to sometimes
> operate on HEAD by default and sometimes error with usage information.
> 

Well, if there's no filter specified it has nothing to do, so erroring out
in the no-arguments-at-all case would be sensible.

OTOH, it would be better to error out for the no-filter case explicitly,
which would also cause the no-arguments case to error out.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
