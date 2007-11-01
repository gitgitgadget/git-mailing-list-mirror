From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH 10/10] push: teach push to be quiet if local ref is strict
 subset of remote ref
Date: Thu, 01 Nov 2007 09:18:31 +0100
Message-ID: <47298BD7.2000902@op5.se>
References: <1193593581312-git-send-email-prohaska@zib.de>	<11935935812741-git-send-email-prohaska@zib.de>	<1193593581114-git-send-email-prohaska@zib.de>	<1193593581486-git-send-email-prohaska@zib.de>	<11935935812185-git-send-email-prohaska@zib.de>	<11935935822846-git-send-email-prohaska@zib.de>	<11935935821136-git-send-email-prohaska@zib.de>	<11935935823045-git-send-email-prohaska@zib.de>	<11935935821800-git-send-email-prohaska@zib.de>	<11935935823496-git-send-email-prohaska@zib.de>	<11935935821192-git-send-email-prohaska@zib.de>	<7vfxztm2dx.fsf@gitster.siamese.dyndns.org>	<52171BF7-50E2-473E-A0BD-CB64D38FD502@zib.de>	<7vejfcl8aj.fsf@gitster.siamese.dyndns.org>	<F5F68690-68A3-4AFC-A79C-FF02910F0359@zib.de>	<7v8x5jiseh.fsf@gitster.siamese.dyndns.org>	<B3C76DB8-076D-4C43-AC28-99119A05325C@z
  ib.de>	<7vve8nglrt.fsf@gitster.siamese.dyndns.org>	<B16F7DA1-E3E5-47A4-AFD3-6680741F38F1@zib.de> <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 09:20:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InVHa-0002lX-Nf
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 09:20:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754781AbXKAISl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 04:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754047AbXKAISk
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 04:18:40 -0400
Received: from mail.op5.se ([193.201.96.20]:59692 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753924AbXKAISi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 04:18:38 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DE2D817306A8;
	Thu,  1 Nov 2007 09:17:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4k3Y9utQnATj; Thu,  1 Nov 2007 09:17:46 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id A9EB417305A3;
	Thu,  1 Nov 2007 09:17:45 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <7vlk9jgeee.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62927>

Junio C Hamano wrote:
> Steffen Prohaska <prohaska@zib.de> writes:
> 
>>> You forgot a lot more important part.  Pushing into publishing
>>> repositories.  And the discussion is about git-push command.
>> Exactly, here are two examples:
>>
>> If you push only to publishing repositories that are read
>> only by others, you'll never encounter the problem that
>> 10/10 tried to solve. The publishing repository is never
>> changed by others. You are the only one who pushes to this
>> repository. Therefore the remote never advances unexpectedly.
> 
> Wrong.
> 
> People can and do work from more than one private repositories
> (I do).  In a sense, that is sharing the repository with
> oneself.
> 

I believe your troubles are alleviated a great deal by the fact
that you actually know when upstream has changes, and what those
changes are supposed to be. A communications breakdown with only
one person involved is sort of hard to imagine.

> (actually, shared repository people seem to
> prefer "fetch + rebase" over "pull" which is "fetch + merge").
> 

That's definitely true. The number of useless merge-commits we
have in our repos is annoying, and has twice made bisect a bit
troublesome for no good reason.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
