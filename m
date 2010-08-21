From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] format-patch: Update the `-3` example
Date: Sat, 21 Aug 2010 16:23:54 +0530
Message-ID: <20100821105351.GC31130@kytes>
References: <1282382819-25097-1-git-send-email-artagnon@gmail.com>
 <m3sk28nu24.fsf@localhost.localdomain>
 <20100821103404.GB31130@kytes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 21 12:56:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Omlk1-0003Rg-H3
	for gcvg-git-2@lo.gmane.org; Sat, 21 Aug 2010 12:56:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822Ab0HUKz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Aug 2010 06:55:57 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:56337 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751751Ab0HUKz4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Aug 2010 06:55:56 -0400
Received: by pwi7 with SMTP id 7so1398711pwi.19
        for <git@vger.kernel.org>; Sat, 21 Aug 2010 03:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=3IsxsB5XT6LS8ksFoWljwcbnBccx51b5MEpmB7cAhw0=;
        b=UE3iVv2aaQJHsIQZvH9jUi51tIhjwOyoCZKxTvE2wLmEhzqsH2/Y00vnGGx/IRzhPn
         9C69TYaCprsKD2xZoMfO/EueJNok67XXX2gW322Tu3CoyonPgAlFBpC1TiMNgXPN/wD8
         6b1mjvaIXv+f+7m8psq1DwbuUcJhaRHiNaytE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=hm9KklujqfiGl+025KNreqlJDTO0AV0SHm2h7VJzE4BbeyV6ekDUSNsLT2D9Dq5gw1
         YL/v9cHENf5UFZLHD9I7vA4GZFn6g4P3dsQ+5mGC/NhigMVWC7PicTyqmvkcNiaM00KN
         yLmi08K8LWCqpqGzzpxp2772LLkiGAku04YBk=
Received: by 10.142.217.4 with SMTP id p4mr2061184wfg.220.1282388155671;
        Sat, 21 Aug 2010 03:55:55 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id n2sm4721158wfl.1.2010.08.21.03.55.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 21 Aug 2010 03:55:53 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100821103404.GB31130@kytes>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154138>

Hi,

Ramkumar Ramachandra writes:
> Hi Jakub,
> 
> Jakub Narebski writes:
> > Works for me:
> > 
> >   5031:[gitweb/split@git]# git format-patch -3
> >   0001-gitweb-Prepare-for-splitting-gitweb.txt
> >   0002-gitweb-Create-Gitweb-Git-module.txt
> > 
> >   5034:[gitweb/split@git]# git version
> >   git version 1.7.2.1
> > 
> > 
> > The -3 is git-log option:
> > 
> >   -<n>   Limits the number of commits to show.
> > 
> > and also git-format-patch option:
> > 
> >   -<n>   Limits the number of patches to prepare.
> 
> Hm, doesn't work on the `pu` Git, but works on `master` -- I'm
> currently bisecting to find the problem. `git log -3` works
> though.

:facepalm:

Scratch out what I just said -- I just realized that `git format-patch
HEAD~3` handles merge commits, but `git format-patch -3` does
not. `git format-patch -3 HEAD~3` is even more confusing- should we
even advertise the `-<n>` option in format-patch?

-- Ram
