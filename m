From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 14:23:01 +0200
Message-ID: <200706121423.02127.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <466E7D7E.7BAB2FD@eudaptics.com> <8c5c35580706120412o516ec39p71332d23823d7389@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Johannes Sixt" <J.Sixt@eudaptics.com>,
	"Frank Lichtenheld" <frank@lichtenheld.de>,
	"Junio C Hamano" <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 14:23:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy5P2-0003AV-Cx
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 14:23:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751939AbXFLMXL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 08:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753360AbXFLMXL
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 08:23:11 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:38744 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751939AbXFLMXK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 08:23:10 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id 6F42C229A;
	Tue, 12 Jun 2007 14:23:08 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <8c5c35580706120412o516ec39p71332d23823d7389@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49955>

On Tuesday 12 June 2007, Lars Hjemli wrote:
> On 6/12/07, Johannes Sixt <J.Sixt@eudaptics.com> wrote:

> > > > KDE (superproject)
> > > >  +- kdelibs (subproject)
> > > >  |   +- admin (subproject)
> > > >  |   +- subdir1
> > > >  |   +- ...
> > > >  +- kdebase (subproject)
> > > >  |   +- admin (subproject)
> > > >  |   +- subdir2
> > > >  |   +- ...
> > > >  +- kdenetwork (subproject)
> > > >  |   +- admin (subproject)
> > > >  |   +- subdir3
> > > >  |   +- ...
> > > >  ...
> 
> In this case, I would assume that e.g. kdelibs contain a submodule
> entry for path admin in its index, accompanied by a .gitmodules file
> saying that the path admin is mapped to this or that submodule.

Exactly. That's just the "submodule" in "submodule" case we should
support, too.

> I 
> would not expect the KDE 'supersuperproject' to know about admin at
> all, neither in its index nor .gitmodules.

The admin submodule contains KDE specific things. So of course it
also would be a submodule in the grand whole KDE superduper module.
But that does not really matter.

However, to not have a lot of copies of the admin submodule
in

 .git/submodule/admin
 .git/submodule/kdelibs/.git/submodule/admin
 .git/submodule/kdebase/.git/submodule/admin
 .git/submodule/kdenetwork/.git/submodule/admin

the just suggested submodule.<name>.repopath to specify a repository
outside of .git/submodule to be shared by kdelibs,kdebase,... would
be fine.

Josef
