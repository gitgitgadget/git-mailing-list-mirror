From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 15:40:52 +0200
Message-ID: <200706121540.52753.Josef.Weidendorfer@gmx.de>
References: <20070611225918.GD4323@planck.djpig.de> <200706121423.02127.Josef.Weidendorfer@gmx.de> <466E9469.5D6BD391@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Lars Hjemli <hjemli@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Junio C Hamano <gitster@pobox.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 15:41:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hy6cN-0003f4-15
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 15:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbXFLNlA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 09:41:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755490AbXFLNlA
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 09:41:00 -0400
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:39477 "EHLO
	mailout1.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755449AbXFLNk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 09:40:59 -0400
Received: from dhcp-3s-48.lrr.in.tum.de (dhcp-3s-48.lrr.in.tum.de [131.159.35.48])
	by mail.in.tum.de (Postfix) with ESMTP id A3FDB1A36;
	Tue, 12 Jun 2007 15:40:57 +0200 (MEST)
User-Agent: KMail/1.9.7
In-Reply-To: <466E9469.5D6BD391@eudaptics.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49960>

On Tuesday 12 June 2007, Johannes Sixt wrote:
> Josef Weidendorfer wrote:
> > However, to not have a lot of copies of the admin submodule
> > in
> > 
> >  .git/submodule/admin
> >  .git/submodule/kdelibs/.git/submodule/admin
> >  .git/submodule/kdebase/.git/submodule/admin
> >  .git/submodule/kdenetwork/.git/submodule/admin
> > 
> > the just suggested submodule.<name>.repopath to specify a repository
> > outside of .git/submodule to be shared by kdelibs,kdebase,... would
> > be fine.
> 
> This clearly shows that having the repositories of submodules in
> .git/submodule does not buy you enough to avoid duplication.

The .git/submodule space for sure is not flexible enough for all
possible use cases of submodules (as with KDE repo).
However, as default it seems fine to me.

IMHO sharing of the admin submodule repository should even be possible
if I have a clone of kdelibs and kdebase independent of the big
KDE superproject.

It would be nice to allow submodule.<name>.repopath configs globally
in ~/.gitconfig, and cloning kdelibs should automatically do the
right thing, ie. use the already available admin repo for the kdelibs
clone.

> (I don't see enough reason to place a repo for submodule X in project Y
> outside its "natural" checked-out directory in project Y. But then, I
> haven't followed the discussion.

To easily share the objects, branches and local modifications?

Currently a clone of a superproject always does a full copy of
any submodule databases because it is independent from any other
local git repository; in the KDE case you would get >4 admin copiess
if recursive cloning of submodules inside of submodules does that.

Josef
