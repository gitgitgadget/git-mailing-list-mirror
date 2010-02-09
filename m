From: Markus Elfring <Markus.Elfring@web.de>
Subject: Re: Fix signal handler
Date: Tue, 09 Feb 2010 19:01:18 +0100
Message-ID: <4B71A2EE.8070708@web.de>
References: <4B684F5F.7020409@web.de> <20100202205849.GA14385@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 09 19:01:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NeuOx-0006st-4j
	for gcvg-git-2@lo.gmane.org; Tue, 09 Feb 2010 19:01:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab0BISB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2010 13:01:26 -0500
Received: from fmmailgate01.web.de ([217.72.192.221]:47739 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754995Ab0BISB0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2010 13:01:26 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate01.web.de (Postfix) with ESMTP id EE06F1467BF95;
	Tue,  9 Feb 2010 19:01:24 +0100 (CET)
Received: from [78.48.143.95] (helo=[192.168.1.202])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NeuOq-0005yM-00; Tue, 09 Feb 2010 19:01:24 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.1.5) Gecko/20091130 SUSE/3.0.0-1.1.1 Thunderbird/3.0
In-Reply-To: <20100202205849.GA14385@sigill.intra.peff.net>
X-Sender: Markus.Elfring@web.de
X-Provags-ID: V01U2FsdGVkX1/Bj/MPOyzeYtcmr8wqTYKuMFoheMH6frO5tEAG
	RAaYgFrWCCOkCOHJXuQo9XdPU+Vst64HhgaNIkz9rySblZDHIa
	dUy8pwJnrsxWVM1v4uuA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139427>


>
> If you can demonstrate a practical problem and provide a patch, then I
> am sure people would be happy to read it.
>   

I need a few further clarifications on this issue to choose a potential fix.

I have noticed that the variable "show_early_output" gets a value
assigned only at a few places in the source code. I wonder that the set
pointer is only used by the function "limit_list" to call the function
"log_show_early" on demand.
http://git.kernel.org/?p=git/git.git;a=blob;f=revision.c;h=3ba6d991f6e9789949c314c2981dfc6b208a6f66;hb=HEAD#l683

I find that a simple flag would be sufficient. I see no need to handle
different function pointers here. Do any objections exist to achieve the
same effect with the data type "sig_atomic_t"?

Regards,
Markus
