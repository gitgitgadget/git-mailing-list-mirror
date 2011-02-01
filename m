From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] forbid full fetchspecs in git-pull
Date: Tue, 1 Feb 2011 23:23:47 +0300
Message-ID: <AANLkTi=YsYXTHT-3RgaFF38hwK7O6mt+Ba0bZvEHPEWM@mail.gmail.com>
References: <7vzkqh8vqw.fsf@alter.siamese.dyndns.org>
	<201101312255.59841.trast@student.ethz.ch>
	<AANLkTikxcd+gzeuJsQX1V5Wses8xWMnshdrOnYTvXgTq@mail.gmail.com>
	<201102011614.57366.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sean Estabrooks <seanlkml@sympatico.ca>,
	=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 01 21:23:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkMlW-0007db-Gn
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 21:23:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751942Ab1BAUXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 15:23:48 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:44870 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751837Ab1BAUXs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 15:23:48 -0500
Received: by qyk12 with SMTP id 12so7913553qyk.19
        for <git@vger.kernel.org>; Tue, 01 Feb 2011 12:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=s9wElTMGV+Ttz+siY24EbQa9wUjMqDpG62NMJhZm94Y=;
        b=TimsYR34XVL10SfV8MmhKVK0A5MWLD+XxXwdR8CLjuA0dTwgbiMMdHN5Ruh2pEmyrI
         2BHjw6VWR9Y8XL4k+bEu/scf7XLntfRfg73ueUw3dt6oiFhfaD0eyoOhylEWaR6od2At
         cA8Bo03dCmuzkZloCXj3m8z9MJn2+oDTecGmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=A1dVbqoNfzWPRg8zCM8Mdy3eaRK1auu1nO9V2EeQ/YEZw6FFEQE0agfSbxr6BfF4VY
         3cN9Wpvfdsh/lrIGgZLops7YjIt2wae5e4OxAOZmnlmj+1FIOWNs3GqGWPaSI2P92oRP
         EcOn1V9oSZxixtpWB2a3s3rkk5s7niD99gSqA=
Received: by 10.229.189.20 with SMTP id dc20mr5572681qcb.231.1296591827361;
 Tue, 01 Feb 2011 12:23:47 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Tue, 1 Feb 2011 12:23:47 -0800 (PST)
In-Reply-To: <201102011614.57366.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165853>

On Tue, Feb 01, 2011 at 04:14:57PM +0100, Thomas Rast wrote:
> Dmitry Potapov wrote:
> > As to disallowing ':' in refspec completely, I am not so sure... Not
> > that I think it is very useful, but also I don't see how it can hurt
> > someone provided that the target branch cannot be the current branch.
>_
> IRC experience shows that people, while on some topic branch, run
>_
>   git pull origin master:master
>_
> expecting it to "pull master into master" (or even worse with three
> different branch names).  So no, the current branch safeguard does
> not prevent the fundamental mistake.

I am not sure what you mean by three different branches names. You
referred to item 1, and I agree it is confusing, but it can be prevented
by the current branch safeguard.

and the current semantic of "git pull" is very clear:

"git pull repo refspec" = "git fetch repo refspec && git merge FETCH_HEAD"

IMHO, the full confusion was caused by incorrect information on github,
which was corrected a long time ago. Have you heard about any new
users who are confused by git-pull?

And if we really want to disallow ':' in git pull refspec then the
documentation should be corrected too. For instance, if there are
options to git fetch that make no sense if you cannot specify lbranch.
Also description of refspec should be corrected in git pull man page.


Dmitry
