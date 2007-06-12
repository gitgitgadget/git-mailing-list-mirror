From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: [PATCH 5/5] Add gitmodules(5)
Date: Tue, 12 Jun 2007 21:10:48 +0200
Message-ID: <20070612191048.GX955MdfPADPa@greensroom.kotnet.org>
References: <20070611225918.GD4323@planck.djpig.de>
 <11816319211097-git-send-email-hjemli@gmail.com>
 <20070612080402.GQ955MdfPADPa@greensroom.kotnet.org>
 <8c5c35580706120127p649227d8gc706cb8b364d02b9@mail.gmail.com>
 <466E7A17.CEB0F196@eudaptics.com> <7vfy4xhu6p.fsf@assigned-by-dhcp.pobox.com>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <J.Sixt@eudaptics.com>, git@vger.kernel.org,
	Frank Lichtenheld <frank@lichtenheld.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 21:10:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyBlV-000582-99
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 21:10:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbXFLTKw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 15:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbXFLTKw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 15:10:52 -0400
Received: from psmtp03.wxs.nl ([195.121.247.12]:53327 "EHLO psmtp03.wxs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750980AbXFLTKv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 15:10:51 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by psmtp03.wxs.nl
 (iPlanet Messaging Server 5.2 HotFix 2.15 (built Nov 14 2006))
 with SMTP id <0JJJ003VHEM00T@psmtp03.wxs.nl> for git@vger.kernel.org; Tue,
 12 Jun 2007 21:10:49 +0200 (MEST)
Received: (qmail 2981 invoked by uid 500); Tue, 12 Jun 2007 19:10:48 +0000
In-reply-to: <7vfy4xhu6p.fsf@assigned-by-dhcp.pobox.com>
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49990>

On Tue, Jun 12, 2007 at 12:03:10PM -0700, Junio C Hamano wrote:
> Johannes Sixt <J.Sixt@eudaptics.com> writes:
> 
> > Lars Hjemli wrote:
> >> Multiple checkout paths for a single submodule will bring havoc on
> >> this plan, so I need to ask: what is the use-case for multiple
> >> checkout paths?
> >
> > A use-case is the admin directory in the KDE repository. It has:
> >
> > KDE (superproject)
> >  +- kdelibs (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir1
> >  |   +- ...
> >  +- kdebase (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir2
> >  |   +- ...
> >  +- kdenetwork (subproject)
> >  |   +- admin (subproject)
> >  |   +- subdir3
> >  |   +- ...
> >  ...
> 
> If these three instances of 'admin' are truly the same project
> created in multiple places in the directory hierarchy, what is
> the reason that it is not arranged like this instead?
> 
>     KDE
>      +- admin
>      +- kdelibs
>      |   +- subdir1
>      |   +- ...
>      +- kdebase
>      |   +- subdir2
>      |   +- ...
>      +- kdenetwork
>      |   +- subdir3
>      |   +- ...
>      ...
> 
> When kdelibs/subdir1 needs to access stuff in admin, instead of
> going to ../admin, it could very well go to ../../admin couldn't
> it?

In Hannes' example, kdelibs and kdebase are subprojects of their own.
Surely, you wouldn't want them to depend on something outside of
the (sub)project.

But even in a similar situation where the different parts do not
exist as separate projects, they may advance at a different pace
and therefore need different revisions of the same subproject.

skimo
