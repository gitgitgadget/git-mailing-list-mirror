From: "Paul Umbers" <paul.umbers@gmail.com>
Subject: Re: Git Cygwin - unable to create any repository - help!
Date: Tue, 15 Jan 2008 14:59:52 -0700
Message-ID: <a5eb9c330801151359q5a474a83le36ae9076ad4e5c1@mail.gmail.com>
References: <20080114202932.GA25130@steel.home>
	 <a5eb9c330801141421g13c627e5x77afb357e2a78463@mail.gmail.com>
	 <20080115054807.GA3694@steel.home>
	 <a5eb9c330801150721t5da85295heacae2c5a5aad47e@mail.gmail.com>
	 <a5eb9c330801140921m63b1b8a9pe67bf6f0d2e58dba@mail.gmail.com>
	 <20080115200437.GB3213@steel.home>
	 <a5eb9c330801151212y30cf4f63r9c294ba33da2b8f@mail.gmail.com>
	 <20080115212022.GC3213@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 23:00:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEtpX-00047K-DP
	for gcvg-git-2@gmane.org; Tue, 15 Jan 2008 23:00:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755646AbYAOV7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 16:59:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755374AbYAOV7x
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 16:59:53 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:29052 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbYAOV7w (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 16:59:52 -0500
Received: by wa-out-1112.google.com with SMTP id v27so17375wah.23
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 13:59:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=ApAH9nU/WA/VhGxQ6bG+pM6P/5IDQbkS2Cm+jQ0vJok=;
        b=gAhVtbGijrCaxsuAi5L1cVBsNZAe+RyOES9QSVInHHa4XSgCUdECZMEz4bOvhzPbeRYf9aVpLOraEoJvO+O4LBBeRFFZTTiv38kTRGidoTXbdPWSurzuwj+KPe07OBVxBOs1Td9JzFZXfAu9OmjKmMH/9L4wrB5SbI6ndePLn04=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=e+TfRVeo/DI8S9QiIKLEKnUIAIwkl8Eg5z5/9zQPmyncVnLdpuEIqIwC8DWhBD6wKU4MBtnreV9898OgqLEjokCJiNl+ZADRVpLd4XjgUsCeIF6I9vOgMINLfsWPLYSO9EJEHUm2j7UT9CVf7s24DLCY6f6sx0Yhv5aC0Dy+/Ls=
Received: by 10.114.202.15 with SMTP id z15mr4991949waf.72.1200434392436;
        Tue, 15 Jan 2008 13:59:52 -0800 (PST)
Received: by 10.114.137.1 with HTTP; Tue, 15 Jan 2008 13:59:52 -0800 (PST)
In-Reply-To: <20080115212022.GC3213@steel.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70567>

Git version is 1.5.3.8.

On Jan 15, 2008 2:20 PM, Alex Riesen <raa.lkml@gmail.com> wrote:
> Paul Umbers, Tue, Jan 15, 2008 21:12:45 +0100:
> > >
> > > Does the object exists at all? Try
> > >
> > >     ls -l .git/d9/b06fceac52f6c24357e6a7f85c601088381152
> > >
> > > Is it possible to get a hold of this repo (just the .git directly
> > > after "git add .")? It would be interesting to see the nature of the
> > > corruption.
> > >
> > git ls (see below) returns nothing - it looks like the object doesn't
> > exist at all. I've attached a .zip of the entire test directory (one
>
> zip is a bit lying: it does not keep the attributes of the files the
> way cygwin programs see them. For instance, it not known whether the
> hooks (.git/hooks) where executable at the time.
>
> > text file plus .git). This is after "git init" followed by "git add ."
> >
> > What do you think?
>
> I think it has failed already at "git add". From looking at the code
> it is hard for the current git-add (builtin-add.c) to fail silently.
>
> Hmm... What "git version" returns for you? (the .git/config contains
> filemode=true, which cygwin breaks every time).
>
> Of course, it would be interesting to know if the current git works
> for you. Or the MinGW port:
>
>     http://code.google.com/p/msysgit/downloads/list
>
> It used to conflict with cygwin, though.
>
> If the current git fails, I'd suggest to instrument write_sha1_file in
> sha1_file.c and see if it really manages to create temporary file and
> rename it to sha1 file (that d9/b06fceac52f6c24357e6a7f85c601088381152).
> I suspect either rename or link failing silently (IOW, it fails to
> create the new name under objects/d9/ but returns 0(no error) anyway).
>
>



-- 
Computer Science is no more about computers than astronomy is about telescopes.
--- Edsger W. Dijkstra

Paul Umbers MSc MBCS MIAP
paul.umbers@gmail.com
