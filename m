From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] block-sha1/sha1.c: silence compiler complaints by casting
 void* to uintptr_t
Date: Fri, 14 Aug 2009 19:44:38 -0500
Message-ID: <5HEgWEs64y4Ty7FnekstRP8Q71pNi_FTweLbMhYWc6zoZBA4jkJqpQ@cipher.nrlssc.navy.mil>
References: <alpine.LFD.2.00.0908130017080.10633@xanadu.home> <_-0l9qI_nKm-VVtKlL5hzen4bhcyRmiZ1z4jSmKK1LwECXueziRDzSTyacEehOkoqsfYIaEUlds@cipher.nrlssc.navy.mil> <alpine.DEB.1.00.0908150207270.8306@pacific.mpi-cbg.de> <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, nico@cam.org,
	gitster@pobox.com, git@vger.kernel.org,
	Brandon Casey <drafnel@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Aug 15 02:45:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mc7Oi-00007L-UW
	for gcvg-git-2@gmane.org; Sat, 15 Aug 2009 02:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbZHOApT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 20:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753963AbZHOApS
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 20:45:18 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:48580 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbZHOApS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 20:45:18 -0400
Received: by mail.nrlssc.navy.mil id n7F0icuV029575; Fri, 14 Aug 2009 19:44:38 -0500
In-Reply-To: <alpine.LFD.2.01.0908141714040.3162@localhost.localdomain>
X-OriginalArrivalTime: 15 Aug 2009 00:44:38.0459 (UTC) FILETIME=[917F28B0:01CA1D41]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125970>

Linus Torvalds wrote:
> I suspect it might as well be cast to "const char *", and then 
> hopefully you only need one cast.
> 
> So maybe it could be written as
> 
> 	data = (const char *) data + len;
> 
> instead, and avoid the second cast (because the assignment should be ok, 
> since it's assigning back to a "const void *").

Yep, that's enough.  It produces an identical binary on all platforms
except Solaris x86 using SUNWspro compiler.

-brandon
