From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Git:  CVS to Git import
Date: Fri, 11 Nov 2011 18:24:26 -0600
Message-ID: <20111112002426.GA6602@elie.hsd1.il.comcast.net>
References: <1321053453892-6987037.post@n2.nabble.com>
 <m3obwimdi1.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Jvsrvcs <jvsrvcs@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 12 01:24:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RP1Og-0002Dp-BK
	for gcvg-git-2@lo.gmane.org; Sat, 12 Nov 2011 01:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754742Ab1KLAYe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Nov 2011 19:24:34 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:34338 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754290Ab1KLAYd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2011 19:24:33 -0500
Received: by ggnb2 with SMTP id b2so4721931ggn.19
        for <git@vger.kernel.org>; Fri, 11 Nov 2011 16:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=lsrDh4I3g36CVinukw7HLBmduKlg0X4+xFZVtuG4UWU=;
        b=PPYfVMjgOEZP6fjkNhX7/Q4muI8oPxHz+n2UU7byu+IFi3n/+HoSSJzTnpa0kVqQxN
         miAH8gdXzqoWVE5nnv4c5kl/MmbJNZWn+TB4Apu+iT/azJHNOvVxhBUeA1BDnJjc6Oa2
         bOvL1UrUXoCfl/8LHhi0aNvBwj/7ziliF1xy8=
Received: by 10.236.200.130 with SMTP id z2mr303026yhn.25.1321057473100;
        Fri, 11 Nov 2011 16:24:33 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id d2sm14722880anm.6.2011.11.11.16.24.31
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Nov 2011 16:24:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <m3obwimdi1.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185297>

Hi,

Jakub Narebski wrote:
> Jvsrvcs <jvsrvcs@gmail.com> writes:

>> Git:  CVS to Git import
>> 
>> We are moving from CVS to Git and want to know if anyone has had any
>> experience there doing this and could share do's  / dont's, best practices
>> when doing the initial import.
[...]
> I think that Eric S Raymond "DVCS Migration Guide"
>
>    http://www.catb.org/esr/dvcs-migration-guide.html

That page says that "git cvsimport" tends to be your best bet.  But my
experience is exactly the opposite --- git-cvsimport can make a lot of
mistakes, some of them documented in the ISSUES section of its
manpage, and it is hard to notice until later.

I've have good experiences using cvs2git from
<git://repo.or.cz/cvs2svn.git> (but note that it does not support
incremental imports).

> and reposurgeon tool (to clean up conversion artifacts)
>
>    http://www.catb.org/esr/reposurgeon/

Last time I checked, reposurgeon loads the entire history in memory.
For projects with a longer history, "git filter-branch" might be a
better fit.

By the way, thanks for writing.  If your experience results in some
ideas for improving Documentation/gitcvs-migration.txt page, we'll
probably be happy to take them. :)

Good luck,
Jonathan
