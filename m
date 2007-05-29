From: "Han-Wen Nienhuys" <hanwenn@gmail.com>
Subject: Re: GIT on MinGW problem
Date: Tue, 29 May 2007 11:29:42 -0300
Message-ID: <f329bf540705290729q18b8ed10t5e61a65b75d3759@mail.gmail.com>
References: <1dbc01c79432$b4400a80$0200a8c0@AMD2500> <464534EE.30904@xs4all.nl>
	 <4656A304.AF39A0B6@eudaptics.com> <f3a2ke$9s7$1@sea.gmane.org>
	 <465C064F.B9CE9379@eudaptics.com> <465C1252.9020801@trolltech.com>
	 <465C184F.F6053C0C@eudaptics.com>
Reply-To: hanwen@xs4all.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Marius Storm-Olsen" <marius@trolltech.com>, git@vger.kernel.org
To: "Johannes Sixt" <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue May 29 16:29:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ht2hy-0005pM-At
	for gcvg-git@gmane.org; Tue, 29 May 2007 16:29:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbXE2O3v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 10:29:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751909AbXE2O3v
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 10:29:51 -0400
Received: from an-out-0708.google.com ([209.85.132.242]:17705 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750912AbXE2O3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 10:29:50 -0400
Received: by an-out-0708.google.com with SMTP id d31so528733and
        for <git@vger.kernel.org>; Tue, 29 May 2007 07:29:42 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fEUnLK7zQLvuUTqYFq8NK9+paITf4afxMMSVFsnBzNhA3Ly9MaTYtPr7gUzruDmxeez2pWY8PHfM68AuLKOHpYF2BW+bhldpd6h43bodMzGvX8hJu5OrDYl+YRjSYjrVJEmdfcyCkIm0tBquk3WSvMNY8Oqq+pC8v5eRuDOVuXI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UA2FeSCz/u3Tgcyhz50SUpgsrpJRk9drczsTbLTfdQXI8WGCEqBrvt3fSDuae6x0SP9aKq28jzjdlffko6WHy1mmWJzICRuLPqSsRkT+6jpy76fSKwbXvV+v/OS6WKa6Gt2AYOFVkmfojtPkTdOFIg+jiVtuBNGCyjiIxo5KE2k=
Received: by 10.100.94.3 with SMTP id r3mr5177181anb.1180448982463;
        Tue, 29 May 2007 07:29:42 -0700 (PDT)
Received: by 10.100.94.14 with HTTP; Tue, 29 May 2007 07:29:42 -0700 (PDT)
In-Reply-To: <465C184F.F6053C0C@eudaptics.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48693>

2007/5/29, Johannes Sixt <J.Sixt@eudaptics.com>:

> > I get that here too, no matter what I set the mount point to be, and
> > without the fstab file at all.
>
> When I inserted '/usr/bin/sort' I had checked for 'which sort' on my
> Linux and it gave me /usr/bin/sort. Now I see that /bin/sort is probably
> the canonical path to sort on any *nix. Will change that. But is this
> also true for 'find'?


I suggest that you add $PATH  appropriately (prepending /bin and
/usr/bin/ ) and then
let the OS figure it out. The other option is to write an autoconf
test to discover the proper path.


> > Also, the /bin/gitk.bat file should rather be
> >      @"%~d0%~p0wish84.exe" "%~d0%~p0gitk" %*
> > than the current hardcoded path. (Probably won't work with
> > command.com, but who uses that for development nowadays anyways, right ;-)
>
> Nice trick! But don't try this at home without parental guidance! It
> fills your screen with recursive console window invocations of itself.
>
> I put this into gitk.cmd (didn't try .bat):
>
> @start wish84.exe "%~d0%~p0gitk" %*
>
> assuming wish84 is in the PATH (which is probably a sane assumption
> because either it is part of the installer, in which case it should have
> set up the PATH, or you have Tcl/Tk installed for some other reason, in
> which case you will want to have it in the PATH, too).
>
> Futhermore, I like to have the GUI sent into the background
> automatically and without opening another console window, hence, the use
> of 'start'.

I'll have a look at this when I have time. What the hell is

%~d0%~p0

?

-- 
Han-Wen Nienhuys - hanwen@xs4all.nl - http://www.xs4all.nl/~hanwen
