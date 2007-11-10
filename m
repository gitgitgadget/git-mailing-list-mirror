From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Reducing the memory footprint
Date: Fri, 9 Nov 2007 20:05:30 -0500
Message-ID: <9e4733910711091705i6f77d05uc5ba04f668796a73@mail.gmail.com>
References: <9e4733910711091538h260fbcd2s5783f01e7db4b19a@mail.gmail.com>
	 <20071110005327.GH6212@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Brian Downing" <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 02:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqena-00041F-B6
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 02:06:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762270AbXKJBFd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 20:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762405AbXKJBFc
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 20:05:32 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:17170 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762365AbXKJBFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 20:05:31 -0500
Received: by rv-out-0910.google.com with SMTP id k20so605344rvb
        for <git@vger.kernel.org>; Fri, 09 Nov 2007 17:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=K//1auuoeqcll3EQcN07yQowsjB+2JwSpPj58E+KIZI=;
        b=An8xat9jfs21I909pxsj+4OTNaxeeSBIO1d/7DYEX+05gaWQ5ygsjEZoAggPGbYZGeCIxUFkyjBEhnnmz9rTValCeoh0ggRUocTe4//GLvZQcyhW2MrUpFNyTSI1JxQfEf/75HA1dW8sY23JxjYy/pbM3T7EIKyRDIXql+YHNiM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cxXyIocMMPxyy6l4aOKdzJfhO6qXAqqq36KdJ3W9zNRljIhCU+Fy/LpdtQp92bMB/ig60IPSVLTk+iG5zMIGsIoKJ9RyK6DH+5h9BjQrhY6WPTRjxyN5aUxuLQWoZc1ncJH0swz9s6M9ahEm/3AFc35Ph03gDl1To3Qb751aTg8=
Received: by 10.114.160.1 with SMTP id i1mr59547wae.1194656730832;
        Fri, 09 Nov 2007 17:05:30 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Fri, 9 Nov 2007 17:05:30 -0800 (PST)
In-Reply-To: <20071110005327.GH6212@lavos.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64294>

On 11/9/07, Brian Downing <bdowning@lavos.net> wrote:
> On Fri, Nov 09, 2007 at 06:38:00PM -0500, Jon Smirl wrote:
> > I'm using this config file:
> >
> > [pack]
> >         windowMemory = 1M
> >         deltaCacheSize = 1M
> >
> > And I have NO_MMAP compiled in.
> >
> > git is still using over 200MB of memory or address space, my process
> > gets killed either way.
>
> I'm assuming it's dying on repacking since you included the pack
> parameters.
>
> How big is your biggest object?  Even with pack.windowMemory, it still
> keeps the last object around to try and delta against (in other words,
> the window only shrinks to size 1), which means you have to have room
> for it and its delta index.

It's a Linux kernel repository. Git receive-pack is going over 200MB
and getting zapped.  I don't understand why the process is so large. I
am compiled with -DNO_MMAP.

I think I have a achieved a work around. I rsync'd in my last several
weeks of changes. Now I can 'git push' small amounts of changes
without getting killed.

I'm begging dreamhost to simply install git. Installed commands don't
get zapped.

-- 
Jon Smirl
jonsmirl@gmail.com
