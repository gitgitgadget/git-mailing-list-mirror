From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] t6013: replace use of 'tac' with equivalent Perl
Date: Mon, 01 Sep 2008 14:56:34 +0200
Message-ID: <48BBE682.2070000@op5.se>
References: <1220212998-90810-1-git-send-email-benji@silverinsanity.com> <1220221897-6081-1-git-send-email-trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Brian Gernhardt <benji@silverinsanity.com>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Sep 01 14:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka8yT-0005HS-Gp
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 14:57:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750842AbYIAM4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 08:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbYIAM4f
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 08:56:35 -0400
Received: from mail.op5.se ([193.201.96.20]:47602 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750737AbYIAM4f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 08:56:35 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 34F8F24B0B24;
	Mon,  1 Sep 2008 15:01:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YBnVQobqiFsx; Mon,  1 Sep 2008 15:01:47 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.184])
	by mail.op5.se (Postfix) with ESMTP id 411E51B800B0;
	Mon,  1 Sep 2008 15:01:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <1220221897-6081-1-git-send-email-trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94580>

Thomas Rast wrote:
> 'tac' is not available everywhere, so substitute the equivalent Perl
> code 'print reverse <>'.  Noticed by Brian Gernhardt.
> 
> Signed-off-by: Thomas Rast <trast@student.ethz.ch>
> ---
> 
> Thanks for pointing this out.  However, I tried to avoid hardcoding
> those results by recommendation of t/README (last paragraph):
> 
>   ... If all the test scripts hardcoded the object IDs like
>   t0000-basic.sh does, that defeats the purpose of t0000-basic.sh,
>   which is to isolate that level of validation in one place.  Your
>   test also ends up needing updating when such a change to the
>   internal happens, so do _not_ do it and leave the low level of
>   validation to t0000-basic.sh.
> 
> So I would favour this fix.  I think this should be ok because we
> depend on Perl anyway.
> 

If it isn't, you could always do
	sed '1!G;h;$!d'
or
	sed -n '1!G;h;$p'
instead.

Both of them are very portable indeed.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
