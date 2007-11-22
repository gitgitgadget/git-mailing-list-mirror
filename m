From: Wincent Colaiuta <win@wincent.com>
Subject: Re: [PATCH 3/4] Teach builtin-add to pass multiple paths to git-add--interactive
Date: Thu, 22 Nov 2007 12:02:17 +0100
Message-ID: <43664C66-59F9-4B12-B5FD-86011938EC07@wincent.com>
References: <C6E820C8-91E9-48B2-9219-377CA83163A7@wincent.com> <1195689773-28601-1-git-send-email-win@wincent.com> <1195689773-28601-2-git-send-email-win@wincent.com> <1195689773-28601-3-git-send-email-win@wincent.com> <1195689773-28601-4-git-send-email-win@wincent.com> <20071122090828.GC7153@sigill.intra.peff.net> <825BAB3C-FAB4-4A48-AB94-FAAF5B808CD1@wincent.com> <20071122103339.GA12692@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed	delsp=yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 22 12:03:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iv9qC-0001hB-H0
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 12:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXKVLDK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 06:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752085AbXKVLDJ
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 06:03:09 -0500
Received: from wincent.com ([72.3.236.74]:57274 "EHLO s69819.wincent.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752082AbXKVLDI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 06:03:08 -0500
Received: from cuzco.lan (localhost [127.0.0.1])
	(authenticated bits=0)
	by s69819.wincent.com (8.12.11.20060308/8.12.11) with ESMTP id lAMB2I0n011441;
	Thu, 22 Nov 2007 05:02:19 -0600
In-Reply-To: <20071122103339.GA12692@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65785>

El 22/11/2007, a las 11:33, Jeff King escribi=F3:

> On Thu, Nov 22, 2007 at 11:28:17AM +0100, Wincent Colaiuta wrote:
>
>>>> +	memcpy((void *)args + sizeof(const char *), argv, sizeof(const =20
>>>> char *) *
>>>> argc);
>>>
>>> The source for the memcpy (argv) is sometimes NULL. The standard =20
>>> forbids
>>> this, even when the size field is 0. I have no idea if any =20
>>> reasonable
>>> implementations actually care.
>>
>> Good point. I've now conditionalized the memcpy with an "if (argc > =
=20
>> 0)".
>> While I was at it I also got rid of the unneeded cast to void *.
>
> I don't think you need it if you do the other cleanup (since you will
> always be passing a valid argv pointer).

True, argv will never be NULL. We'll still be doing a zero-byte memcpy =
=20
though, which I guess is not a big deal here. I'll drop the conditional=
=2E

Cheers,
Wincent
