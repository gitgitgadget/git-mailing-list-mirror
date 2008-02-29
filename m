From: "Maxim Gordienko" <mgordienko@gmail.com>
Subject: Re: [GIT-P4] usage under Windows
Date: Fri, 29 Feb 2008 21:48:58 +0300
Message-ID: <96c268400802291048u31a2d8b6ub1726ade941afb8c@mail.gmail.com>
References: <96c268400802212244g7fd2de2bj6c1b7022885c8e89@mail.gmail.com>
	 <47C5E4EC.1060003@trolltech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Marius Storm-Olsen" <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Fri Feb 29 19:49:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVAIc-0007AX-I1
	for gcvg-git-2@gmane.org; Fri, 29 Feb 2008 19:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760565AbYB2StB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Feb 2008 13:49:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760682AbYB2StB
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Feb 2008 13:49:01 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:12300 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753674AbYB2StA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Feb 2008 13:49:00 -0500
Received: by ug-out-1314.google.com with SMTP id z38so437827ugc.16
        for <git@vger.kernel.org>; Fri, 29 Feb 2008 10:48:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=Ecqk/xd3lzdVNDaUSKrpupnMhyOpDYm5/9g36snbyEA=;
        b=e4eceW9oWhv+Gf26gsaLMMXn81nSs1BLsERWJn3Z1n2dQ6d9RR4hxgvuhI+sLdbVzg9nhZ/qq2iayOdEc8sq24vdzQByolr8DOWQrvBULvFDVyizWKou4WLf0sBLSlee4MS9MAOw97It+5ojooSGUYWGOer+1/Th7ngGbfqF/es=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZRFkVve0BSEWktd4Ao84y9eZkhWeqged6yZU4uXnjzgXY78VtnKfOdgj/KtanIZDqGaIduyXXYDY3BXu9rRijbs224XmcC2LDr6uXNIYpxogyxDm4mZXviCKIVBsl/Fl0candy+awSQTIGxbqO6UDSWbv3qpXVpthqSvl844Mo0=
Received: by 10.67.115.1 with SMTP id s1mr1899422ugm.74.1204310938160;
        Fri, 29 Feb 2008 10:48:58 -0800 (PST)
Received: by 10.66.252.19 with HTTP; Fri, 29 Feb 2008 10:48:58 -0800 (PST)
In-Reply-To: <47C5E4EC.1060003@trolltech.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75550>

Thank you, Marius for detailed instructions!
Now everything except submitting back to perforce works like a charm.
Perforce complains about git-p4 checkout is not under it's root

Synchronizing p4 checkout...
executing p4 sync ...
Path 'c:/tmp/p42/main\...' is not under client's root 'c:\p4'.

if I move checkout under perforce root git-p4 unable to create patch.
Have you encounter such errors?
Thank you!

On Thu, Feb 28, 2008 at 1:32 AM, Marius Storm-Olsen
<marius@trolltech.com> wrote:
> Maxim Gordienko wrote:
> > What are best practices to use git-p4 under windows?
> > What p4 client should i use, native or cygwin one? Is any special
> > perforce client configuration required?
>  > What python distribution is preferred, included in cygwin or active
> python?
>
> Depends on what your system is. Are you using Git under Cygwin or MSys?
> If you're using Cygwin normally, it's probably wise to use the cygwin
> version of perforce too.
>
> Here's what I do:
>     1) Use MSys Git. It's faster. (http://code.google.com/p/msysgit/)
>     2) Use native Perforce. It's faster.
>     3) Get Python from python.org. There's a binary installer.
>
> > Where i need to put imported directory under perforce client' root or
> > in any other place?
>
> In perforce create your client spec somewhere where you don't see it.
> You never need to touch these files, but they are needed to be able to
> submit back to the perforce depot, if you need that. For cloning a
> perforce depot, you don't need a checkout (git-p4 used 'p4 print' to get
> the files directly)
>
> Keep in mind to always rebase your patches before submitting back to a
> Perforce depot, since merges can be represented properly. So, a good
> work practice is to
>    1) Clone perforce branch
>    2) work, work, commit, work, commit...
>    3) git p4 rebase
>    4) git p4 submit
>
> Good luck!
>
> --
> .marius
>
>
