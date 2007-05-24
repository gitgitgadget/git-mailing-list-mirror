From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:41:57 +0200
Message-ID: <8c5c35580705240541j7f632fc4lbd308c9386c2bde6@mail.gmail.com>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	 <20070524072945.GO28023@spearce.org>
	 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241039200.4648@racer.site>
	 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241201270.4648@racer.site>
	 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site>
	 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241315290.4648@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, "Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 24 14:42:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCdp-0004nG-QP
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:42:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755967AbXEXMmA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:42:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755444AbXEXMmA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:42:00 -0400
Received: from nz-out-0506.google.com ([64.233.162.225]:62143 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbXEXMl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:41:59 -0400
Received: by nz-out-0506.google.com with SMTP id n1so30486nzf
        for <git@vger.kernel.org>; Thu, 24 May 2007 05:41:58 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uLXH/tZDEzHKEVeaeILd67F1ybgNJZ3bG5VPf9pEnHIZ0vHIvdG77J/JcQu87uVnuxc90ptAR0oTOIROft5BSClMVc2zrpKzlOE0MIA7QQh+a+9e2LO3lTrKCNzqjNMKeZe3Z1AKliA20S0mSG/cCnZbIRD7HDD+IyqLX4WHxDA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YyXsJ7BCd9LauT4MRnk0mvKsik2SJkxRIB1cO2ajVRlWax4/u+PloJhMo8iKQb1WDQIz/m3fxGh0EHSfAhOcfk9kk3hkog5kLo5DHCX0obYoIzusMrzdXM1YSIk2r9EhFrir/zOU3lFgtHs0vb3lebJBsdasrRSg2t0sZBZzzCI=
Received: by 10.115.78.1 with SMTP id f1mr888178wal.1180010518056;
        Thu, 24 May 2007 05:41:58 -0700 (PDT)
Received: by 10.114.235.4 with HTTP; Thu, 24 May 2007 05:41:57 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705241315290.4648@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48253>

On 5/24/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Thu, 24 May 2007, Sven Verdoolaege wrote:
>
> > On Thu, May 24, 2007 at 12:31:33PM +0100, Johannes Schindelin wrote:
> > > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > > OK... so what should git-update-server-info put in this file for submodules?
> > > > Or, equivalently, what should be the output of ls-remote?
> > > >
> > > > Right now its a list of pairs of revs(sha1) and refs.
> > > > For submodules we want a connection between a submodule name
> > > > and one or more URLs where the submodule can be found.
> > > > How are you going to squeeze that into info/refs without confusing
> > > > older versions of git?
> > >
> > > I wonder if the "ref^{blub}" syntax could be used for that: change "blub"
> > > to the URL, or "sub:URL" or something.
> >
> > Just to be clear, would it look like the following?
> >
> > e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd      refs/heads/bernstein
> > c5c64e3fe48302f0c4581985f9c68d615f7bcb4e      refs/heads/master
> > 3fa7ded19a8da868d3af7c942f86358e6720f0c7      refs/heads/submodule
> > /home/sverdool/public_html/cloog.git  cloog^{URL}
> > http://www.liacs.nl/~sverdool/cloog.git       cloog^{URL}
>
> I was more thinking about something like this:
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7        refs/heads/submodule^{URL:/home/sverdool/public_html/cloog.git}
>
> But then, I haven't really thought about it deeply.

I think the whole point of the 'remote config' stuff is to get an
unversioned/out-of-tree .gitmodules file, right?

If so, one could put this file into the object db and refer to it with
something like 'refs/tags/subproject-config' or even
'refs/misc/subproject-config'. Both of these refs will be found by
ls-remote and point to the object containing the suggested subproject
configuration.

I actually do something similar with the release tarballs for cgit: try
  git ls-remote git://hjemli.net/pub/git/cgit
to see the references to the tarballs which are displayed on the cgit
summary page.

But then again, I might have completely misunderstood the problem...

--
larsh
