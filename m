From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: Wishlist for a bundle-only transport mode
Date: Thu, 22 Nov 2007 10:42:42 +0100
Message-ID: <8aa486160711220142w25e9c9b6vbafa34a287dde7eb@mail.gmail.com>
References: <8aa486160711210654p357ccd87i4809e0cda9471303@mail.gmail.com>
	 <200711211752.40264.jnareb@gmail.com>
	 <Pine.LNX.4.64.0711211658510.27959@racer.site>
	 <200711211811.34391.jnareb@gmail.com>
	 <Pine.LNX.4.64.0711211719330.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 22 10:43:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv8aM-0002iM-1M
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 10:43:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbXKVJmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 04:42:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXKVJmo
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 04:42:44 -0500
Received: from rn-out-0910.google.com ([64.233.170.191]:15450 "EHLO
	rn-out-0102.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751429AbXKVJmn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 04:42:43 -0500
Received: by rn-out-0102.google.com with SMTP id s46so3892850rnb
        for <git@vger.kernel.org>; Thu, 22 Nov 2007 01:42:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uBwtFSNEingNDWw8kTb6EhYzUmd34cz7oRd3+H39bVo=;
        b=V4TNGmNimxJ3D1UYrj/yvtYIc5OVFPCzUyfKihWPikfJMku0kagaL6bpbkzkiAFFeZbxNBlWTS7JTSppJbfc1C0HcYNhc48Mj/IpamocCA7SE/vTay7l2idHZAaklN8xTJGxOK9zY2STo5VB5XJPwLHr1z2zghsjvUmk6uTTMAY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q/E1jDxMHvLlEJqNToFP/bcfvqkVnKaIG5KCr2d0JYcJ+S6co3497pnVeTN+lWrsjgfsCGEAR5FlTkU6WsrCtBPGyjSHLVLAxzbtr9x0zJ///5d8zXdYu7aXjlIoOJyox0ILS76J4KHOlqdrv6CubtNYyQXktcQBzA0E4yBfJcA=
Received: by 10.150.49.15 with SMTP id w15mr1564409ybw.1195724562438;
        Thu, 22 Nov 2007 01:42:42 -0800 (PST)
Received: by 10.150.199.9 with HTTP; Thu, 22 Nov 2007 01:42:42 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711211719330.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65764>

On Nov 21, 2007 6:26 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Wed, 21 Nov 2007, Jakub Narebski wrote:
>
> > Johannes Schindelin wrote:
> > > On Wed, 21 Nov 2007, Jakub Narebski wrote:
> > >
> > >> That has the disadvantage of pushing to bundle when you make an error
> > >> in the lastpart of path to existing repository.
> > >
> > > As I wrote in another reply, I would not allow overwriting an existing
> > > file.
> >
> > > Specifying a non-existing file should be good enough.
> >
> > What I meant here that if you do "git push /some/path/to/rpeo.git", with
> > mistake in the last part of path to repository, you would end up with a
> > bundle, and you would have to really watch what happened to catch the
> > error.
>
> I use tab completion all the time, so this would not happen to me.  IMHO
> that is a lesser issue than to introduce a "protocol".
>
> > I'd rather use "git push bundle:///some/path/to/bundle" or "git push
> > --bundle bundlename" to catch errors better.

I would vote for the later, and a way to configure this in the config.

> >
> > Besides it should be IMHO be possible to overwrite bundle if you are
> > doing fast-forward push...
>
> Not as far as I can see.  A push there would see what the bundle has
> already, and put them into the new bundle as _prerequisites_.  So the
> bundle would lose information.

I prefer not to overwrite an existing bundle.

>
> BTW this was my gripe (that I decided not to make public earlier) with
> Santi's proposal to begin with: a push would not have any way to specify
> what the other side has already.  So I think "git push <bundle>" is the
> wrong way of creating a bundle.

Sorry but I do not understand this. I think this two lines could be equivalent:

git push --bundle bundle.bdl "refs/heads/master:refs/remotes/bundle/master"
git bundle create bundle.bdl refs/heads/master ^refs/remotes/bundle/master

>
> Except if we add some cunning strategy not to overwrite, ever, but to
> create <bundle>.<n> with an incrementing <n>.  But that might be too much.

That make sense.

Santi
