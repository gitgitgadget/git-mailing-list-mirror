From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 10/11] Fix warnings in nedmalloc when compiling with GCC 4.4.0
Date: Mon, 01 Jun 2009 09:33:20 -0700
Message-ID: <7vr5y3lxrj.fsf@alter.siamese.dyndns.org>
References: <1243786525-4493-1-git-send-email-prohaska@zib.de>
	<1243786525-4493-2-git-send-email-prohaska@zib.de>
	<1243786525-4493-3-git-send-email-prohaska@zib.de>
	<1243786525-4493-4-git-send-email-prohaska@zib.de>
	<1243786525-4493-5-git-send-email-prohaska@zib.de>
	<1243786525-4493-6-git-send-email-prohaska@zib.de>
	<1243786525-4493-7-git-send-email-prohaska@zib.de>
	<1243786525-4493-8-git-send-email-prohaska@zib.de>
	<1243786525-4493-9-git-send-email-prohaska@zib.de>
	<1243786525-4493-10-git-send-email-prohaska@zib.de>
	<1243786525-4493-11-git-send-email-prohaska@zib.de>
	<7vhbz0mmai.fsf@alter.siamese.dyndns.org>
	<alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org,
	Johannes Sixt <j6t@kdbg.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 01 18:33:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MBAS4-0000eI-6X
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 18:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754630AbZFAQdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 12:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753713AbZFAQdT
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 12:33:19 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:43263 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023AbZFAQdT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 12:33:19 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090601163321.FVME25927.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Mon, 1 Jun 2009 12:33:21 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id ygZL1b0084aMwMQ03gZLzl; Mon, 01 Jun 2009 12:33:20 -0400
X-Authority-Analysis: v=1.0 c=1 a=pJQHuwW63eoA:10 a=O6WTdPAIJOYA:10
 a=BuLlYUs4nyg05ef-U_cA:9 a=pPQtMjhi0hQ8dKqeZ9TjVf6UKJ4A:4 a=_RhRFcbxBZMA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.DEB.1.00.0906011054410.26154@pacific.mpi-cbg.de> (Johannes Schindelin's message of "Mon\, 1 Jun 2009 10\:57\:49 +0200 \(CEST\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120477>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > diff --git a/compat/nedmalloc/nedmalloc.c b/compat/nedmalloc/nedmalloc.c
>> > index a381a7d..60a4093 100644
>> > --- a/compat/nedmalloc/nedmalloc.c
>> > +++ b/compat/nedmalloc/nedmalloc.c
>> > @@ -34,7 +34,7 @@ DEALINGS IN THE SOFTWARE.
>> >  /*#define FULLSANITYCHECKS*/
>> >  
>> >  #include "nedmalloc.h"
>> > -#if defined(WIN32) && !defined(__MINGW32__)
>> > +#if defined(WIN32)
>> >   #include <malloc.h>
>> >  #endif
>> 
>> Can somebody enlighten me what this hunk is about, and how it helps GCC
>> 4.4?
>
> It helps in that malloc.h is included even if we happen to compile the 
> stuff as a MinGW program.  Otherwise necessary function declarations are 
> missing.
> ...
> Hopefully less so, now.

I wish enough information were in the commit log message from the
beginning.
