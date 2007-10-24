From: Andreas Ericsson <ae@op5.se>
Subject: Re: intended use of "git --exec-path"?
Date: Wed, 24 Oct 2007 10:08:24 +0200
Message-ID: <471EFD78.6030206@op5.se>
References: <20071024043224.GR16291@srparish.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Scott Parish <sRp@srparish.net>
X-From: git-owner@vger.kernel.org Wed Oct 24 10:08:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IkbIA-0007bn-Pe
	for gcvg-git-2@gmane.org; Wed, 24 Oct 2007 10:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520AbXJXIIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Oct 2007 04:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbXJXII3
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Oct 2007 04:08:29 -0400
Received: from mail.op5.se ([193.201.96.20]:51503 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750911AbXJXII2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Oct 2007 04:08:28 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 2F43817306B0;
	Wed, 24 Oct 2007 10:07:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwL8dAAea03K; Wed, 24 Oct 2007 10:07:07 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id E643C1730695;
	Wed, 24 Oct 2007 10:07:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <20071024043224.GR16291@srparish.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62200>

Scott Parish wrote:
> "git --exec-path" presently prints out the highest priority path
> to find executable in. That's a what; i'm curious why and when it
> should be used. Basically i'm wondering if its still useful, and
> what, if anything, it should be printing.
> 

git supports having all its "helpers" in a separate path. Since
there were performance concerns with having scripts call the git
wrapper for every invocation of every git program, the --exec-path
option was added when the wrapper was rewritten in C.

Unless it's a very tight loop that runs non-builtin programs,
there's really no reason for scripts to use the git-whatever form
of commands, but the ability to do so should probably be retained
more or less forever. See 8e49d50388211a0f3e7286f6ee600bf7736f4814
for details.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
