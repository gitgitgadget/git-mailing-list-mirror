From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: [PATCH v2 24/25] register_ref(): make a copy of the bad reference SHA-1
Date: Thu, 30 May 2013 23:09:09 +0100
Organization: OPDS
Message-ID: <35D3DD46364C40A391B3DB72C7D18798@PhilipOakley>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> <1369472904-12875-25-git-send-email-mhagger@alum.mit.edu> <7vk3mhviaw.fsf@alter.siamese.dyndns.org> <51A7C9E8.10108@alum.mit.edu>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Jeff King" <peff@peff.net>, "Johan Herland" <johan@herland.net>,
	"Thomas Rast" <trast@inf.ethz.ch>, <git@vger.kernel.org>
To: "Michael Haggerty" <mhagger@alum.mit.edu>,
	"Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 31 00:09:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiB23-0000cx-9F
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 00:09:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758014Ab3E3WJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 18:09:11 -0400
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:37299 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754680Ab3E3WJI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 18:09:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArkNAHzNp1FOl3th/2dsb2JhbABaDoJ7MIh6tmIEAQMBfRd0gh4FAQEEAQgBAS4eAQEhBQYCAwUCAQMOBwECCSUUAQQaBgcXBgESCAIBAgMBh3YKCLsljjJqgn1hA4hohgWJeohyhyWCUT87
X-IronPort-AV: E=Sophos;i="4.87,773,1363132800"; 
   d="scan'208";a="429847251"
Received: from host-78-151-123-97.as13285.net (HELO PhilipOakley) ([78.151.123.97])
  by out1.ip02ir2.opaltelecom.net with SMTP; 30 May 2013 23:09:06 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226040>

From: "Michael Haggerty" <mhagger@alum.mit.edu>
Sent: Thursday, May 30, 2013 10:51 PM
> On 05/29/2013 06:53 PM, Junio C Hamano wrote:
>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>> [...]
>>> + current_bad_sha1 = xmalloc(20);
>>> + hashcpy(current_bad_sha1, sha1);
>>
>> This, together with 18/25, may hint that we want hashdup()?
>
> I thought about it, but was surprised that I could only find one or 
> two
> other places in the existing code that would use such a function.  But
> sure, I would be happy to submit a patch.
>
> I think hashdup() needn't be inline, so the definition can't go with 
> its
> cousins in cache.h.  There is no cache.c.  So where would be the best
> place to define hashdup()?  object.c?  sha1_name.c?
>
> While I'm at it, I think it would be nice to have constants like
>
> #define SHA1_LEN 20
> #define SHA1_HEX_LEN 40
>
> and start using those instead of magic numbers.  Any objections (or
> suggestions for better names)?
>

The first named constant should be fully qualified to the same extent as 
the second, perhaps:
    #define SHA1_BYTE_LEN 20

and perhaps with an alternate of (though HEX is just as good):
    #define SHA1_CHAR_LEN 40


> Michael
>
> -- 
> Michael Haggerty
> mhagger@alum.mit.edu
> http://softwareswirl.blogspot.com/
> --
Philip 
