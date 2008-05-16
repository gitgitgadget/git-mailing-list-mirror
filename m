From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Migrating a git repository to subversion
Date: Fri, 16 May 2008 15:53:08 +1200
Message-ID: <46a038f90805152053n43add2cbj8383c475772c3681@mail.gmail.com>
References: <42dc968d0805151608q2ed89fc8madcd8d341a4ed1df@mail.gmail.com>
	 <alpine.LFD.1.10.0805151952260.2941@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alf Mikula" <amikula@gmail.com>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 16 05:54:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jwr17-0006mz-Nk
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 05:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754621AbYEPDxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 23:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754226AbYEPDxJ
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 23:53:09 -0400
Received: from wf-out-1314.google.com ([209.85.200.172]:30515 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753575AbYEPDxI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 May 2008 23:53:08 -0400
Received: by wf-out-1314.google.com with SMTP id 27so673056wfd.4
        for <git@vger.kernel.org>; Thu, 15 May 2008 20:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Lz6xoiXM0mEAF1SYTqANzu8ZRBliQw2FukZvXPP+W4M=;
        b=yGFNtuJemhkQtNnQ9QzBpkMWa6sqzaNC/l0ty9oaT0lf+EJJiYfSxykTJCNJFJ21eeN+8YFInZk0JdPko0+0hb40o3lCm52Q5lNw7AbW3RFDMEluTV3wzi0TvuWRPvpX8PBPMRZKtSNA60PUe6fOAzDukyYFh7Ef1qrjOkJY4b0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pMas49t40a1DmPkxl3KCH3+FiphYAmHCU8whnVYoTnvvO/g/PtiXvxz7i+Wga8PGITkLHZuNXFHtd88V3y18TcMtjWyv2QN/NC5+/LZczeKxjPwfx2WNloNLBJEz5FzMn78HI2bE6vfiKUMRmhOF0a6Sa7/5PyDSq0+WQGKazWw=
Received: by 10.142.158.17 with SMTP id g17mr1316219wfe.234.1210909988096;
        Thu, 15 May 2008 20:53:08 -0700 (PDT)
Received: by 10.142.128.16 with HTTP; Thu, 15 May 2008 20:53:08 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0805151952260.2941@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82254>

On Fri, May 16, 2008 at 3:01 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Thu, 15 May 2008, Alf Mikula wrote:
>> Having said that, I want to demonstrate git's git<--->svn
>> capabilities, and currently everybody here has and understands
>> Subversion.  So, I want to initialize a Subversion repository with my
>> git history from my local git repository.  Here's what I tried:
>
> Hmm. I don't think there is any git2svn thing, but if your history is
> linear (which is really the only thing SVN can handle, since SVN doesn't
> really do "merges" in the git sense at all), you could just write some
> silly script to extract the patches one by one and commit them using SVN.

The git svn rebase trick described earlier does almost exactly what Alf wants.

> Or, and this gets extra points for being disgusting, use "git-cvsserver"
> to serve a remote CVS repo, then cvssuck to create a local CVS repo out of
> it, and then do cvs2svn to create a SVN repo. Ta-daa!

Ugh. Evil man.



m
-- 
 martin.langhoff@gmail.com
 martin@laptop.org -- School Server Architect
 - ask interesting questions
 - don't get distracted with shiny stuff - working code first
 - http://wiki.laptop.org/go/User:Martinlanghoff
