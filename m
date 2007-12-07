From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC (take 3)] autoconf: Add test for OLD_ICONV (squelching compiler warning)
Date: Thu, 06 Dec 2007 23:26:02 -0800
Message-ID: <7v7ijr7yph.fsf@gitster.siamese.dyndns.org>
References: <alpine.LFD.0.9999.0712061628070.13796@woody.linux-foundation.org>
	<1196990840-1168-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Blake Ramsdell <blaker@gmail.com>,
	Wincent Colaiuta <win@wincent.com>,
	Pascal Obry <pascal@obry.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Arjen Laarhoven <arjen@yaph.org>,
	Brian Gernhardt <benji@silverinsanity.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 07 08:27:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Xbs-0001d6-7q
	for gcvg-git-2@gmane.org; Fri, 07 Dec 2007 08:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbXLGH0d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Dec 2007 02:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbXLGH0d
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Dec 2007 02:26:33 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:40191 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbXLGH0c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Dec 2007 02:26:32 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 800FA2BC7;
	Fri,  7 Dec 2007 02:26:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DBFD2BC5;
	Fri,  7 Dec 2007 02:26:09 -0500 (EST)
In-Reply-To: <1196990840-1168-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Fri, 7 Dec 2007 02:27:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67391>

Jakub Narebski <jnareb@gmail.com> writes:

> On Fri, 7 Dec 2007, Blake Ramsdell wrote:
>> On Dec 6, 2007 4:41 PM, Blake Ramsdell <blaker@gmail.com> wrote:
>>> On Dec 6, 2007 4:30 PM, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>>>> Umm. Why not just make the test be whether the following compiles cleanly?
>>>>
>>>>         #include <iconv.h>
>>>>
>>>>         extern size_t iconv(iconv_t cd,
>>>>           char **inbuf, size_t *inbytesleft,
>>>>           char **outbuf, size_t *outbytesleft);
>>>>
>>>> because if the compiler has seen a "const char **inbuf", then it  should
>>>> error out with a "conflicting types for 'iconv'" style message..
>>>
>>> Yeah, this is what I did:
>> 
>> My apologies. Your suggestion is completely different, and should work
>> without -Werror. Let me try that.
>
> Is something like the patch below what you wanted to try?

This looks sensible.  Will apply.
