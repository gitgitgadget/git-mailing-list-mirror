From: Federico Lucifredi <federico@canonical.com>
Subject: Re: Git Bug report
Date: Wed, 05 Oct 2011 14:32:40 -0400
Organization: Canonical USA
Message-ID: <1317839560.20904.20.camel@skyplex>
References: <1317763443.17036.15.camel@skyplex>
	 <4E8BF519.8090509@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 05 20:33:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBWHU-0003DH-FM
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 20:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934065Ab1JESdT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 14:33:19 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55129 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933573Ab1JESdS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 14:33:18 -0400
Received: from [12.53.206.2] (helo=[10.12.24.178])
	by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71)
	(envelope-from <federico@canonical.com>)
	id 1RBWHM-00047s-Pw; Wed, 05 Oct 2011 18:33:17 +0000
In-Reply-To: <4E8BF519.8090509@viscovery.net>
X-Mailer: Evolution 2.32.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182874>

On Wed, 2011-10-05 at 08:11 +0200, Johannes Sixt wrote:
> >> federico@skyplex:/etc$ git log
> >> fatal: Not a git repository (or any of the parent directories): .git
> > 
> > with correct access permissions, everything works as expected.
> 
> And the correct error message is...?

".git: permission denied" -- no need to be fatal (there could
be ../.git, etc - fatal comes only if those don't exist). 

It could fail silently if one of the parents exists, but in the fatal
scenario, I should be told that it was by permission denied. Currently,
I am told there is no git repo where I know there to be one, which means
"what happened to my repo" is the next question in the user's head.
"it's there but it is broke" is the subtext one gets from this error. it
should be "it is there, I cannot get to it".

> >> drwx------   8 root root      4096 2011-10-03 16:53 .git
> 
> Assuming that you expected something like this:
> 
> fatal: .git: permission denied
> 
> it is hard to argue that a directory that happens to be named .git, but
> was sealed by its owner should be assumed to be a git repository, albeit
> one that we do not have access to. "Not a git repository" is an equally
> justifyable error message, IMHO.

An error message should help resolve the error in question, not grade
the user's smarts. Here I as a user had an expectation that there was a
git repository for /etc ("I set up one!") and figured the permission
issue with my own wits (well, I did not need to because it was /etc, but
in the general perm-denied case I would have had to), by looking at the
dir because the message gave me no useful information on the cause of
the problem.

Thanks -Federico
-- 

_________________________________________
-- "'Problem' is a bleak word for challenge" - Richard Fish
(Federico L. Lucifredi) - federico at canonical.com - GnuPG 0x4A73884C
