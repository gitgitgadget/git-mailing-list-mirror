From: Andreas Ericsson <ae@op5.se>
Subject: Re: [WIP PATCH] Add 'git fast-export', the sister of 'git fast-import'
Date: Wed, 21 Nov 2007 16:09:15 +0100
Message-ID: <47444A1B.4000907@op5.se>
References: <Pine.LNX.4.64.0711210336210.27959@racer.site> <4743E1D6.4010308@viscovery.net> <Pine.LNX.4.64.0711211209080.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 16:10:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IurCx-0005Gq-Dy
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 16:09:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755683AbXKUPJX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 10:09:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755622AbXKUPJX
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 10:09:23 -0500
Received: from mail.op5.se ([193.201.96.20]:44597 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753804AbXKUPJX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 10:09:23 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1387B1F08033;
	Wed, 21 Nov 2007 16:09:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r2GpTzmosm4A; Wed, 21 Nov 2007 16:09:19 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id C32F61F08025;
	Wed, 21 Nov 2007 16:09:18 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <Pine.LNX.4.64.0711211209080.27959@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65660>

Johannes Schindelin wrote:
> 
> P.S.: I'll try to read up on ptrint_t, as suggested by Shawn.

I can't find a reference to ptrint_t anywhere on either my system,
and the 10 first hits on Google finds it on typedef lines, most
commonly like this:

	typedef unsigned long ptrint_t;


I think ptrdiff_t is more portable. Here's the relevant entry
about ptrdiff_t from /usr/include/obstack.h on my system:

---%<---%<---%<---
/* We need the type of a pointer subtraction.  If __PTRDIFF_TYPE__ is
   defined, as with GNU C, use that; that way we don't pollute the
   namespace with <stddef.h>'s symbols.  Otherwise, include <stddef.h>
   and use ptrdiff_t.  */

#ifdef __PTRDIFF_TYPE__
# define PTR_INT_TYPE __PTRDIFF_TYPE__
#else
# include <stddef.h>
# define PTR_INT_TYPE ptrdiff_t
#endif
---%<---%<---%<---

MySQL seems to have botched that one though. It has this instead:

	typedef long          my_ptrdiff_t;

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
