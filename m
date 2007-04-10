From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 19:23:31 +0200
Message-ID: <200704101923.31404.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> <200704101828.37453.Josef.Weidendorfer@gmx.de> <81b0412b0704100950s32645423r439d04197ee8cd78@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Junio C Hamano" <junkio@cox.net>
To: "Alex Riesen" <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 01:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbK4H-0006rm-7G
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 19:23:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753186AbXDJRXl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 13:23:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753174AbXDJRXj
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 13:23:39 -0400
Received: from tuminfo2.informatik.tu-muenchen.de ([131.159.0.81]:37364 "EHLO
	tuminfo2.informatik.tu-muenchen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753186AbXDJRXi (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Apr 2007 13:23:38 -0400
Received: from dhcp-3s-51.lrr.in.tum.de (dhcp-3s-51.lrr.in.tum.de [131.159.35.51])
	by mail.in.tum.de (Postfix) with ESMTP id D54CF28DB;
	Tue, 10 Apr 2007 19:23:36 +0200 (MEST)
User-Agent: KMail/1.9.6
In-Reply-To: <81b0412b0704100950s32645423r439d04197ee8cd78@mail.gmail.com>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay2.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44150>

On Tuesday 10 April 2007, Alex Riesen wrote:
> On 4/10/07, Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> > On Tuesday 10 April 2007, Linus Torvalds wrote:
> > > ...
> > > +     if (resolve_gitlink_ref(ce->name, "HEAD", sha1) < 0)
> > > +             return 0;
> > > +     return hashcmp(sha1, ce->sha1);
> >
> > So this does mean that the SHA1 of a gitlink entry corresponds
> > to the commit in the subproject?
> 
> Right.
> 
> > I wonder if it is not useful to be able to add some attribute(s)
> > to a gitlink, i.e. first reference a gitlink object in the superproject,
> > which then references the submodule commit, and also holds some
> > further attributes. These attributes can not be put into the subproject,
> > as it should be independent.
> 
> These attributes can be put into a file in superproject tree and
> checked in at the same as the gitlink. No real need for introducing
> another object type (right now there is no gitlink object type, just
> an entry in tree with special mode).

Like... .gitattributes ? ;-)
Ok, this could work; however, there of course is the possibility of
inconsistencies when e.g. manually moving subprojects around.

How is consistency ensured for .gitattributes ?
I see that for .gitignore consistency, the user is responsible.

Josef
