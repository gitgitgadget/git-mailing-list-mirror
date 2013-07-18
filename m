From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] Fix some sparse warnings
Date: Thu, 18 Jul 2013 18:58:40 +0100
Message-ID: <51E82CD0.8060302@ramsay1.demon.co.uk>
References: <51E431F1.6050002@ramsay1.demon.co.uk> <51E4E0C0.3060604@viscovery.net> <20130716062122.GA4964@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jul 18 22:28:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uzuob-0004AA-CX
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jul 2013 22:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934265Ab3GRU2g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jul 2013 16:28:36 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:50002 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933027Ab3GRU2f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jul 2013 16:28:35 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9EE2B1280AE;
	Thu, 18 Jul 2013 21:28:34 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id E5EB71280A6;
	Thu, 18 Jul 2013 21:28:33 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Thu, 18 Jul 2013 21:28:32 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
In-Reply-To: <20130716062122.GA4964@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230734>

Jeff King wrote:
> On Tue, Jul 16, 2013 at 07:57:20AM +0200, Johannes Sixt wrote:
> 
>> Am 7/15/2013 19:31, schrieb Ramsay Jones:
>>> Sparse issues three "Using plain integer as NULL pointer" warnings.
>>> Each warning relates to the use of an '{0}' initialiser expression
>>> in the declaration of an 'struct object_info'.
>>
>> I question the value of this warning. Initialization with '= {0}' is a
>> well-established idiom, and sparse should know about it. Also, plain 0
>> *is* a null pointer constant.
> 
> I agree with you. It's not a bug, and I think sparse is being overly
> picky here; it is missing the forest for the trees in interpreting the
> idiom.

Yes, last time this came up, I looked at writing a patch to sparse to
allow this without complaint. It's still on my sparse TODO list, but
even if I finished it tonight, it would take a while to get into a
released version of sparse. ;-)

> Still, it may be worth tweaking in the name of eliminating compiler
> noise, since it does not cost us very much to do so (and I believe we
> have done so in the past, too).
> 
> We could also ask people with sparse to turn off the "use NULL instead
> of 0" warning, but I think it _is_ a useful warning elsewhere (even
> though it is never a bug, it violates our style guidelines and may be an
> indication of a bug).

Indeed, if it wasn't for this, I would be happy to turn this warning off.

ATB,
Ramsay Jones
