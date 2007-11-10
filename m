From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Reducing the memory footprint
Date: Sat, 10 Nov 2007 01:07:05 -0500
Message-ID: <9e4733910711092207p6d997750i5db997dfa125ef5d@mail.gmail.com>
References: <9e4733910711091538h260fbcd2s5783f01e7db4b19a@mail.gmail.com>
	 <20071110005327.GH6212@lavos.net>
	 <9e4733910711091705i6f77d05uc5ba04f668796a73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 07:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqjVK-0005vH-Sq
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 07:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbXKJGHY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 01:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751557AbXKJGHY
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 01:07:24 -0500
Received: from wa-out-1112.google.com ([209.85.146.176]:31400 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbXKJGHG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 01:07:06 -0500
Received: by wa-out-1112.google.com with SMTP id v27so842685wah
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 22:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=wBV6CAXh57cDXiZ6Uq3qTcq50dv2uPKjHGw+Th6/2wY=;
        b=bjwpNdSLrzmg2NpfaE8oi0WYmlrnu6B+hjq1hJ+/291JVPBQSMNt2d8SteuRzzdXKYIf7Hpp2KQ0RGJP8aGtmEz5fcxR0ITSHJmCG8FzaqzNFi3gnj4HrWELlXVy/VOu6gHIH5qu6YfSLVlAQOqsH9eDAlgFGpZC8SwrM7SsrtY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kHpjHJYJZDoo6NaxJgV0bTSNThbvnKiyp8DIUd34uOWxvrLZxD3OrERzlSCtoEdgrirzqwTDeK9eQ/hmv47oFusLivipFNDqsxL9ZwtddSJcMdfuYAggt0JC8uHiGSYshlDQdNnWlAJTD0kAswWEn/uiMnrhzA2CEN68LEYRZ9c=
Received: by 10.114.77.1 with SMTP id z1mr347009waa.1194674825864;
        Fri, 09 Nov 2007 22:07:05 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 22:07:05 -0800 (PST)
In-Reply-To: <9e4733910711091705i6f77d05uc5ba04f668796a73@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64307>

On 11/9/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> On 11/9/07, Brian Downing <bdowning@lavos.net> wrote:
> > On Fri, Nov 09, 2007 at 06:38:00PM -0500, Jon Smirl wrote:
> > > I'm using this config file:
> > >
> > > [pack]
> > >         windowMemory = 1M
> > >         deltaCacheSize = 1M
> > >
> > > And I have NO_MMAP compiled in.
> > >
> > > git is still using over 200MB of memory or address space, my process
> > > gets killed either way.
> >
> > I'm assuming it's dying on repacking since you included the pack
> > parameters.
> >
> > How big is your biggest object?  Even with pack.windowMemory, it still
> > keeps the last object around to try and delta against (in other words,
> > the window only shrinks to size 1), which means you have to have room
> > for it and its delta index.
>
> It's a Linux kernel repository. Git receive-pack is going over 200MB
> and getting zapped.  I don't understand why the process is so large. I
> am compiled with -DNO_MMAP.

I believe I must not have installed everything correctly with my
NO_MMAP build. After debugging for a while and fixing things I'm able
to do a push now in about 80MB of memory.

> I think I have a achieved a work around. I rsync'd in my last several
> weeks of changes. Now I can 'git push' small amounts of changes
> without getting killed.
>
> I'm begging dreamhost to simply install git. Installed commands don't
> get zapped.
>
> --
> Jon Smirl
> jonsmirl@gmail.com
>


-- 
Jon Smirl
jonsmirl@gmail.com
