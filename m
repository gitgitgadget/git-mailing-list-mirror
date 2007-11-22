From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] Teach builtin-add to pass multiple paths to
	git-add--interactive
Date: Thu, 22 Nov 2007 05:33:40 -0500
Message-ID: <20071122103339.GA12692@sigill.intra.peff.net>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <1195689773-28601-3-git-send-email-win@wincent.com> <1195689773-28601-4-git-send-email-win@wincent.com> <20071122090828.GC7153@sigill.intra.peff.net> <825BAB3C-FAB4-4A48-AB94-FAAF5B808CD1@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Thu Nov 22 11:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9Nh-0001Gq-42
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 11:34:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751073AbXKVKdn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2007 05:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751053AbXKVKdn
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 05:33:43 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3323 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750920AbXKVKdm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2007 05:33:42 -0500
Received: (qmail 21738 invoked by uid 111); 22 Nov 2007 10:33:40 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 22 Nov 2007 05:33:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 22 Nov 2007 05:33:40 -0500
Content-Disposition: inline
In-Reply-To: <825BAB3C-FAB4-4A48-AB94-FAAF5B808CD1@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65773>

On Thu, Nov 22, 2007 at 11:28:17AM +0100, Wincent Colaiuta wrote:

>>> +	memcpy((void *)args + sizeof(const char *), argv, sizeof(const char *) * 
>>> argc);
>>
>> The source for the memcpy (argv) is sometimes NULL. The standard forbids
>> this, even when the size field is 0. I have no idea if any reasonable
>> implementations actually care.
>
> Good point. I've now conditionalized the memcpy with an "if (argc > 0)". 
> While I was at it I also got rid of the unneeded cast to void *.

I don't think you need it if you do the other cleanup (since you will
always be passing a valid argv pointer).

-Peff
