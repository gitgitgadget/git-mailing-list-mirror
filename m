From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: size_t vs "unsigned long"
Date: Wed, 3 Oct 2007 23:19:59 +0200
Message-ID: <200710032320.00263.wielemak@science.uva.nl>
References: <7vabr0djqr.fsf@gitster.siamese.dyndns.org> <20071003204801.GC28188@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:20:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBe2-0006Q0-Aj
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:20:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753684AbXJCVUa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:20:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753796AbXJCVU3
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:20:29 -0400
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:4842 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753630AbXJCVU3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:20:29 -0400
Received: from ct.xs4all.nl (ct.xs4all.nl [82.92.39.12])
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id l93LK16w022410;
	Wed, 3 Oct 2007 23:20:01 +0200 (CEST)
	(envelope-from wielemak@science.uva.nl)
User-Agent: KMail/1.9.5
In-Reply-To: <20071003204801.GC28188@artemis.corp>
Content-Disposition: inline
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59886>

On Wednesday 03 October 2007 22:48, Pierre Habouzit wrote:
> On Wed, Oct 03, 2007 at 08:30:04PM +0000, Junio C Hamano wrote:
> > Traditionally, inside git, we have used the length of things
> > with "unsigned long" for pretty much anything, except where we
> > wanted the length exactly sized we used int32_t, uint64_t and
> > friends.
> >
> > A few places pass pointer to unsigned long as the second
> > parameter to strbuf_detach(), triggering type mismatch warnings.
> > An easy way out is to change strbuf_detach() to take a pointer
> > to ulong but I think it is going backwards.  Most places that
> > use "unsigned long" can safely be converted (and made more
> > correct) to use size_t.
>
>   Well, afaict, on every linux archs I know of, unsigned longs and
> size_t are the same. Though, I don't know if that holds for the msys
> port, and if that does not holds, then a s/unsigned long/size_t/ would
> help them. Else, for consistency sake, I believe the change is a good
> one.

Surely on the Microsoft 64-bit compilers size_t is 64-bits and long is
32-bits.  Don't blame me, I'm just the messenger that learned the hard
way ...

	--- Jan
