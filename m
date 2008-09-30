From: Andreas Ericsson <ae@op5.se>
Subject: Re: Git config not expanding user home directories
Date: Tue, 30 Sep 2008 12:49:30 +0200
Message-ID: <48E2043A.4000501@op5.se>
References: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailinglist <git@vger.kernel.org>
To: Tom Lanyon <tom@netspot.com.au>
X-From: git-owner@vger.kernel.org Tue Sep 30 12:50:52 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KkcoX-00053B-Cz
	for gcvg-git-2@gmane.org; Tue, 30 Sep 2008 12:50:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751845AbYI3Ktg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Sep 2008 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbYI3Ktg
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Sep 2008 06:49:36 -0400
Received: from mail.op5.se ([193.201.96.20]:37501 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751596AbYI3Ktf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Sep 2008 06:49:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 70E811B80049;
	Tue, 30 Sep 2008 12:40:52 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BxxOlBpCXw4P; Tue, 30 Sep 2008 12:40:49 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.22])
	by mail.op5.se (Postfix) with ESMTP id 3F80224B0008;
	Tue, 30 Sep 2008 12:40:49 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <F90667E7-6B06-4B34-B655-3C42ED236D9A@netspot.com.au>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97094>

Tom Lanyon wrote:
> Hi all,
> 
> Is it normal behavior that git (well at least git-svn) won't expand 
> ~user from .gitconfig?
> 

Yes. You could add a patch for that though. git-daemon does ~user
expansion since quite a long time back, so there's a function ready
for it. I'd do it by doing something like:

   git config --path section.key

so that scripts can get the user-expanded version as well. In-core
applications can call expand_path() or some such on their own, I
think.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
