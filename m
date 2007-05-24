From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <sbejar@gmail.com>
Subject: Re: [RFC] Fourth round of support for cloning submodules
Date: Thu, 24 May 2007 14:23:25 +0200
Message-ID: <8aa486160705240523q7c8e2813x9e46efe16dea8321@mail.gmail.com>
References: <Pine.LNX.4.64.0705240039370.4113@racer.site>
	 <20070524072216.GE942MdfPADPa@greensroom.kotnet.org>
	 <20070524072945.GO28023@spearce.org>
	 <20070524073652.GH942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241039200.4648@racer.site>
	 <20070524105112.GI942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241201270.4648@racer.site>
	 <20070524111645.GK942MdfPADPa@greensroom.kotnet.org>
	 <Pine.LNX.4.64.0705241230410.4648@racer.site>
	 <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Junio C Hamano" <junkio@cox.net>, git@vger.kernel.org,
	"Martin Waitz" <tali@admingilde.org>,
	"Alex Riesen" <raa.lkml@gmail.com>
To: skimo@liacs.nl
X-From: git-owner@vger.kernel.org Thu May 24 14:23:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrCM0-0000DF-3F
	for gcvg-git@gmane.org; Thu, 24 May 2007 14:23:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755693AbXEXMX3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 08:23:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756718AbXEXMX2
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 08:23:28 -0400
Received: from an-out-0708.google.com ([209.85.132.248]:52556 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755693AbXEXMX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 08:23:27 -0400
Received: by an-out-0708.google.com with SMTP id d31so29048and
        for <git@vger.kernel.org>; Thu, 24 May 2007 05:23:26 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rCA85B81O7O5oS5MLZP6a9++MgZNeMJg7s1tJALUYH2eO6VYsxOH153MQiruVBT4rOpdZxpG0h6aOPdaeRRli2JdTjv40VYTIQyWikd2dp25v9aRyozGJ+eRNIkio4sglsfU3GcAQRKmLe6xXsSv6kOKdtYVfkyBnMGBQeM16Wk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=S2Vepjc7+5pJviscK08xGPfXeD8svLPkdPFwtQDbSw8wYU2NptFOlRQZ29Lw3rpV8ZlkO6I/gynHhfpRYh9iHAmHNfMI91FaaHsKnsrfZzMd7cuBeN7cdcdpQiJz4tdIRbqMZTryUyRo440GG9uiUtqVlZR9qbva18uGmRAFD1M=
Received: by 10.78.188.10 with SMTP id l10mr454111huf.1180009406042;
        Thu, 24 May 2007 05:23:26 -0700 (PDT)
Received: by 10.78.137.19 with HTTP; Thu, 24 May 2007 05:23:25 -0700 (PDT)
In-Reply-To: <20070524114354.GN942MdfPADPa@greensroom.kotnet.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48250>

On 5/24/07, Sven Verdoolaege <skimo@kotnet.org> wrote:
> On Thu, May 24, 2007 at 12:31:33PM +0100, Johannes Schindelin wrote:
> > On Thu, 24 May 2007, Sven Verdoolaege wrote:
> > > OK... so what should git-update-server-info put in this file for submodules?
> > > Or, equivalently, what should be the output of ls-remote?
> > >
> > > Right now its a list of pairs of revs(sha1) and refs.
> > > For submodules we want a connection between a submodule name
> > > and one or more URLs where the submodule can be found.
> > > How are you going to squeeze that into info/refs without confusing
> > > older versions of git?
> >
> > I wonder if the "ref^{blub}" syntax could be used for that: change "blub"
> > to the URL, or "sub:URL" or something.
>
> Just to be clear, would it look like the following?
>
> e8a6e39ecfbd391a54b9c3329fd3c6e33d745abd        refs/heads/bernstein
> c5c64e3fe48302f0c4581985f9c68d615f7bcb4e        refs/heads/master
> 3fa7ded19a8da868d3af7c942f86358e6720f0c7        refs/heads/submodule
> /home/sverdool/public_html/cloog.git    cloog^{URL}
> http://www.liacs.nl/~sverdool/cloog.git cloog^{URL}
>
> Is there no code out there that expects the "rev" part to be
> exactly 40 characters?
> Or do you propose we put the URL in a blob and put the object sha1
> in there.  If so, who's going to create these blobs for the git://
> and ssh:// protocols?  upload-pack?

There was a thread about adding symrefs to this as:

ref: refs/heads/master    HEAD
c5c64e3fe48302f0c4581985f9c68d615f7bcb4e        refs/heads/master

we could extend this for subproject support as:

subproject: kernel:URL    refs/heads/master
subproject: gcc:URL    refs/heads/master

And it allows to define different URL for different branches
(linux-2.6.git for master and linux-2.4.git for old, for example).

Just my 0.02 cents.

Santi

>
> Thanks for the discussion, btw.
> I hope we can come up with something that's acceptable to everyone.
>
> skimo
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
