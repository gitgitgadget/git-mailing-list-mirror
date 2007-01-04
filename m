From: "Horst H. von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: [RFC/PATCH] fail pull/merge early in the middle of conflicted merge
Date: Thu, 04 Jan 2007 13:31:02 -0300
Message-ID: <200701041631.l04GV2tf015536@laptop13.inf.utfsm.cl>
References: <ae@op5.se>
Cc: Junio C Hamano <junkio@cox.net>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 04 17:32:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2VVN-0007xz-Np
	for gcvg-git@gmane.org; Thu, 04 Jan 2007 17:31:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965029AbXADQbp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 11:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965031AbXADQbp
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 11:31:45 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:50098 "EHLO inti.inf.utfsm.cl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965029AbXADQbo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 11:31:44 -0500
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [200.1.19.201])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id l04GV3SZ024270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Jan 2007 13:31:03 -0300
Received: from laptop13.inf.utfsm.cl (laptop13.inf.utfsm.cl [127.0.0.1])
	by laptop13.inf.utfsm.cl (8.13.8/8.13.8) with ESMTP id l04GV2tf015536;
	Thu, 4 Jan 2007 13:31:02 -0300
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: Message from Andreas Ericsson <ae@op5.se> 
   of "Thu, 04 Jan 2007 16:37:56 BST." <459D1F54.1060709@op5.se> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.5  (beta27)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 04 Jan 2007 13:31:03 -0300 (CLST)
X-Virus-Scanned: ClamAV version 0.88.5, clamav-milter version 0.88.5 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35938>

Andreas Ericsson <ae@op5.se> wrote:
> Junio C Hamano wrote:
> > "Shawn O. Pearce" <spearce@spearce.org> writes:
> >
> >> Junio C Hamano <junkio@cox.net> wrote:
> >>> After a pull that results in a conflicted merge, a new user
> >>> often tries another "git pull" in desperation.  When the index
> >>> is unmerged, merge backends correctly bail out without touching
> >>> either index nor the working tree, so this does not make the
> >>> wound any worse.
> >> I've seen this many times too.  I don't understand why users cannot
> >> read output messages and realize the current command failed, but
> >> they don't.  *sigh*
> > That is not user's fault.  Tools should not make things worse
> > when run more than once after they failed, and we do not either,
> > so it is not a stupid behaviour on the user's part to do that.
> > We just need to make sure that it is more clear to the user that
> > pull after a conflicted pull is futile, which is what this patch
> > does.

> "Pulling is futile. Nothing will be assimilated" ?

:-)

Been there, done that. The messages git gives don't give a (at this point
probably panicked) newbie any clue what to try next, or how to go back.

Perhaps best would be to offer some way to undo all and then try again?

Also, if a manual fix of the merge is warranted, the message doesn't give
clear directions on what to do next. Sure, you edit the offending files to
your liking, then what? "git commit" shows a scary commit message, you
abort the edit and the merge is commited anyway.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                    Fono: +56 32 2654431
Universidad Tecnica Federico Santa Maria             +56 32 2654239
Casilla 110-V, Valparaiso, Chile               Fax:  +56 32 2797513
