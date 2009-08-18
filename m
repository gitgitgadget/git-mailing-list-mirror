From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 12:30:36 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0908181147510.6044@xanadu.home>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 18:31:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdRaT-0001M4-Ht
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 18:31:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759316AbZHRQam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 12:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759042AbZHRQal
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 12:30:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:44174 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754669AbZHRQal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 12:30:41 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KOK00885Z7015C0@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 18 Aug 2009 12:30:37 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126411>

On Tue, 18 Aug 2009, Junio C Hamano wrote:

> Sebastian Schuberth <sschuberth@gmail.com> writes:
> 
> > On Tue, Aug 18, 2009 at 14:56, Artur Skawina<art.08.09@gmail.com> wrote:
> > ...
> >> I'd limit it to windows and any other ia32 platform that doesn't pick the
> >> bswaps itself; as is, it just adds an unnecessary hidden gcc dependency.
> >>
> >> Hmm, it's actually a gcc-4.3+ dependency, so it won't even build w/ gcc 4.2;
> >> something like this would be required: "(__GNUC__>=4 && __GNUC_MINOR__>=3)" .
> >
> > So, as you say the code makes no difference under Linux, would you be
> > OK with just testing for GCC 4.3+, and not for Windows? That would get
> > rid of the "hidden" GCC dependency and not make the preprocessor
> > checks overly complex. Moreover, limiting my patch to any "platform
> > that doesn't pick the bswaps itself" could possibly require
> > maintenance on compiler / CRT updates.
> 
> I would say that should be fine, but I'd let Linus and Nico to overrule me
> on this if they have any input.

Well...  Given that git already uses ntohl/htonl quite extensively in 
its core already, I'd suggest making this more globally available 
instead.


Nicolas
