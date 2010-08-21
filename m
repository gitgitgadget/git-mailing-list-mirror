From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 22:19:03 +0530
Message-ID: <20100821164900.GD31130@kytes>
References: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
 <20100821103404.GB31130@kytes>
 <20100821105351.GC31130@kytes>
 <201008211659.38608.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 18:51:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmrHa-0007yD-Vu
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 18:51:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468Ab0HUQu6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 12:50:58 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:62609 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751089Ab0HUQu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 12:50:56 -0400
Received: by pwi7 with SMTP id 7so1489730pwi.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=VHr2uAhQk/Xn4EKqp5qe8KcqPfUk+ETVpI9pHgO5ktI=;
        b=cvxy8XQmPasThbY/BdDAa0nu55VmOalYOQ5Mymtsf4KdUvQTBzIsLWgGM2GJSQOoNQ
         rc7v2HYJrMbs1yq3FmOtzrzY8zeosilHxxxwgC5YJ636evHCUnJcqyUatg1V/FXeSITB
         2x2rk8kzMVSLD7f8kz6sPIVCwMNvBjDKhzHGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=l4CzvuwqOm3XwkvL2KAmmUCTkL+tkDimPCcog43ciNinnq4AZYkDdKwW7mayTEOqt2
         ejc336LmvaJ6Ds+X3HBUp9z9/AJ3YCXGWOvtn+rtKLuFaTuD5zXAXnQv3wQnlTtryjeH
         zsi/zt4xi+omKlYSDRv/oyyeXrfYZGBlP5dK0=
Received: by 10.114.53.4 with SMTP id b4mr3210834waa.190.1282409455608;
        Sat, 21 Aug 2010 09:50:55 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id g4sm7657723wae.14.2010.08.21.09.50.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 09:50:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008211659.38608.jnareb@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154145>

Hi Jakub,

Jakub Narebski writes:
> On Sat, 21 Aug 2010, Ramkumar Ramachandra wrote:
> > Ramkumar Ramachandra writes:
> > > Jakub Narebski writes:
> > > > Works for me:
> > > > 
> > > >   5031:[gitweb/split@git]# git format-patch -3
> > > >   0001-gitweb-Prepare-for-splitting-gitweb.txt
> > > >   0002-gitweb-Create-Gitweb-Git-module.txt
> > > > 
> > > >   5034:[gitweb/split@git]# git version
> > > >   git version 1.7.2.1
> > > > 
> > > > 
> > > > The -3 is git-log option:
> > > > 
> > > >   -<n>   Limits the number of commits to show.
> > > > 
> > > > and also git-format-patch option:
> > > > 
> > > >   -<n>   Limits the number of patches to prepare.
> > > 
> > > Hm, doesn't work on the `pu` Git, but works on `master` -- I'm
> > > currently bisecting to find the problem. `git log -3` works
> > > though.
> > 
> > :facepalm:
> > 
> > Scratch out what I just said -- I just realized that `git format-patch
> > HEAD~3` handles merge commits, but `git format-patch -3` does
> > not. `git format-patch -3 HEAD~3` is even more confusing- should we
> > even advertise the `-<n>` option in format-patch?
> 
> It looks like there is a conceptual bug in how git-format-patch works, 
> namely that '-<n>' is passed to rev-list / log generating machinery, 
> and it limits number of *commits* to consider; if some of those commits 
> are merge commits, which cannot be represented as patches, the number 
> of patches it generates is less than specified <n> (as you can see in 
> the example I have provided, where <n> == 3, and git-format-patch 
> generated 2 patches, not 3).  In extreme case (like 'pu') it can 
> generate no patch.
> 
> I am not sure what the solution should be.  We could either:
> 
> A. Update git-format-patch documentation to say 'commits' instead of
>    'patches', and perhaps also be loud about commits we are skipping,
>    so that my example would look e.g. like this:
> 
>      $ git format-patch -3
>      0001-gitweb-Prepare-for-splitting-gitweb.txt
>      0002-gitweb-Create-Gitweb-Git-module.txt
>      Skipping merge commit: Merge branch 'maint'

Thanks for the awesome explanation! A is definitely the way to go-
I'll start writing a patch immediately.

-- Ram
