From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: How to restore changes to the remote master branch to its previous
 stage ?
Date: Sat, 07 Jun 2014 09:18:46 +0200
Message-ID: <5392BCD6.9070603@kdbg.org>
References: <1409256.vCu7BMQsbW@linux-wzza.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Arup Rakshit <aruprakshit@rocketmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 07 09:22:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WtAxR-0003PY-6o
	for gcvg-git-2@plane.gmane.org; Sat, 07 Jun 2014 09:22:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752759AbaFGHSu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Jun 2014 03:18:50 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:46562 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752753AbaFGHSu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Jun 2014 03:18:50 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 56F26130052;
	Sat,  7 Jun 2014 09:18:47 +0200 (CEST)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 7E83219F412;
	Sat,  7 Jun 2014 09:18:46 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <1409256.vCu7BMQsbW@linux-wzza.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251032>

Am 07.06.2014 08:07, schrieb Arup Rakshit:
> Hi,
> 
> I am working in a project, where I am using *Git*. Today, I have been advised  
> by my manager to do some change and it was an urgent request. I did the change 
> and tested also, All was working fine. The big mistake I did, all the changes I 
> made in the *master* branch without creating a topic a branch. So, once I done 
> with the changes I did *git push origin master* and the changed got merged to 
> *master* branch of the remote repository. I know this is not a good practice, 
> all happened accidentally. 
> 
> Now my question is in such a case, if I see, something wrong I pushed and 
> merged to the remote repo's *master* branch, how to restore it to its previous 
> stage using *git* ? 

Assuming that the remote master branch is tracked in your local
repository, the following should do it:

  git push origin origin/master@{1}:master

The plus forces a non-fast-forward push. See 'man gitrevisions' about
the foo@{1} syntax before you run the command.

-- Hannes
