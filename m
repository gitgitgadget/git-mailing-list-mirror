From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Tue, 27 Nov 2007 21:17:10 +0700
Message-ID: <fcaeb9bf0711270617u5ccba66dx6278e322e8c376@mail.gmail.com>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site>
	 <fcaeb9bf0711230431x1b0432f6uc9472b2f67514463@mail.gmail.com>
	 <Pine.LNX.4.64.0711231428350.27959@racer.site>
	 <fcaeb9bf0711240608w2e5e0812me0e56c1f1a2f8c85@mail.gmail.com>
	 <Pine.LNX.4.64.0711271214230.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Nov 27 15:17:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix1Fu-0006jo-FE
	for gcvg-git-2@gmane.org; Tue, 27 Nov 2007 15:17:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754618AbXK0ORW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 09:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754731AbXK0ORW
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 09:17:22 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:10450 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbXK0ORV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 09:17:21 -0500
Received: by nf-out-0910.google.com with SMTP id g13so963530nfb
        for <git@vger.kernel.org>; Tue, 27 Nov 2007 06:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=uinqouTq3D2IYkMzsTM52NA+IX8s+fvYdpRilaaDCsI=;
        b=gWr8kN2zpZOfKWRaUsJmig4IBQPdTPID4kRl6v3GTzr/VBCBdFLLCexjXFQ1djIiMnikhdw3OlV3kIBNHEFtt2c2Alfrn8M6vS1fkC3LjIQlWYX50EIaWr7c9WLX2zgrwLldvQmnatJKdPVjTUYqDeAK/rjBnx5Q/otJWNgxWeQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hNOdJDLLC/pYfcPQBF+KPyDmU5N7rI6dk10g+vAA4gywfsz1nE2AZemqoaRE+QyxkmdSp8NwEdYzX1kQfr9+fdfQLPCb932qoWxGWX0qu+93ZphVip4sDaJBusyGCoZdWgArsHu/tUkJiy3jcJJ/k88qyzzoVKBsWDvuhIPhwbM=
Received: by 10.86.98.18 with SMTP id v18mr3880712fgb.1196173030183;
        Tue, 27 Nov 2007 06:17:10 -0800 (PST)
Received: by 10.86.83.6 with HTTP; Tue, 27 Nov 2007 06:17:10 -0800 (PST)
In-Reply-To: <Pine.LNX.4.64.0711271214230.27959@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66214>

On Nov 27, 2007 7:16 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Sat, 24 Nov 2007, Nguyen Thai Ngoc Duy wrote:
>
> > On Nov 23, 2007 9:31 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >
> > > On Fri, 23 Nov 2007, Nguyen Thai Ngoc Duy wrote:
> > >
> > > > Bundle is very handy for transferring a bunch of commits, but it
> > > > does not (cannot?) hold tags and branches.
> > >
> > > But they can!  Nothing prevents you from calling
> > >
> > >         git bundle create a1.bundle refs/tags/v1.0.0 refs/heads/next
> > >
> > > (At least this is the idea, haven't tested yet).
> >
> > It can store commits and heavy tags, but it won't restore tags to
> > refs/tags or advance branches.
>
> The idea is that you fetch them from the bundle.  So something like this
> should do what you want:
>
>         git fetch a1.bundle v1.0.0:refs/tags/v1.0.0
>
> Note that the automatic tag handling of git fetch kicks in with bundles
> just like with other fetch URLs (Unassuming Repository Locators).

Yes, you are right. Man, if I knew I could pass a bundle to git-fetch,
my life would have been much easier :(
-- 
Duy
