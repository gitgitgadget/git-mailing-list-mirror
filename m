From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: Bug Report: git add
Date: Sun, 10 Apr 2011 13:59:21 +0530
Message-ID: <20110410082916.GA31330@kytes>
References: <4D9BA35E.6040204@dcook.org>
 <20110406055200.GA12547@kytes>
 <m31v1a4keq.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Darren Cook <darren@dcook.org>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 10 10:30:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q8q2J-00037K-Vn
	for gcvg-git-2@lo.gmane.org; Sun, 10 Apr 2011 10:30:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab1DJIaS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2011 04:30:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47426 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755255Ab1DJIaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2011 04:30:17 -0400
Received: by iwn34 with SMTP id 34so4699743iwn.19
        for <git@vger.kernel.org>; Sun, 10 Apr 2011 01:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=Y4G8dqmFI+dRBJ7m86lNntNqwow3pspeki7sy8PGbi4=;
        b=TFnHEWXoAD4JhaRsKVJH2NCuZ+CsYw2EXo2r+zPmYbOjQRtxct8a/8o2nBM6Cvihzv
         yRyjbIUdVVXMu/TUioekhv3Sx6G469AuvAJraKx+vbggX+ObLmqD5aGIvhla0gI+Zj1t
         Cll419Sz61B28wAcg2Zr1garxX6ffLhnmayow=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dx7PQsnJSI+vB134qTVWB2L48e3MlsfygnZEvv2BZA0WuSv5eZhCEDOzYNYGxMtXvv
         oJF3YkEvAU3NsXaRlnEEXzDNee8FkJsfEwfte/QNfCGuWvi++IPEnUauRR34/wGwOnMw
         YCZdgkUYTPceRxS1IUQEPAOX7BxLL22zOTIiA=
Received: by 10.43.62.10 with SMTP id wy10mr3810366icb.37.1302424216859;
        Sun, 10 Apr 2011 01:30:16 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id e9sm3288243ibb.66.2011.04.10.01.30.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 10 Apr 2011 01:30:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <m31v1a4keq.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171243>

Hi Jakub,

Jakub Narebski writes:
> Ramkumar Ramachandra <artagnon@gmail.com> writes:
> > Darren Cook writes:
> 
> > > PROBLEM: "git add" adds sub-directories without checking to see if there
> > > is already a git repository already there.
> > > 
> > > WHY BAD: This causes files to be in two repositories (leading to a mess
> > > if you don't notice for a while...)
> > > 
> > > ONE SOLUTION: When adding files from a directory (except root of the
> > > repository, of course) look for a .git subdirectory, and complain if
> > > found. Allow --force to override this.
> > 
> > This is a good suggestion.  It already has a way to handle gitlinks
> > (for submodules), so this seems like a very reasonable feature.
> 
> I just hope that a suboptimal workflow that I use won't stop working.
> 
> Currently I have TODO file in gitweb/ subdirectory, which is stored in
> gitweb/.git repository.  Still it doesn't prevent me from "git add"-ing
> e.g. 'gitweb/gitweb.perl' to git repository itself.

It shouldn't.  The idea is merely to make the porcelain show a
friendly warning, which can be overriden with a '--force'.

-- Ram
