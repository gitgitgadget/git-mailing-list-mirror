From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/2] cat-file: Fix an gcc -Wuninitialized warning
Date: Thu, 28 Mar 2013 18:48:43 +0000
Message-ID: <5154908B.1040801@ramsay1.demon.co.uk>
References: <5151F4EB.80909@ramsay1.demon.co.uk> <20130326193539.GB28244@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 19:52:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULHvl-0001oE-AO
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 19:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752768Ab3C1Svm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 14:51:42 -0400
Received: from mdfmta010.mxout.tbr.inty.net ([91.221.168.51]:53239 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751944Ab3C1Svl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Mar 2013 14:51:41 -0400
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id B17246F8302;
	Thu, 28 Mar 2013 18:51:40 +0000 (GMT)
Received: from mdfmta010.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP id 128706F82C1;
	Thu, 28 Mar 2013 18:51:40 +0000 (GMT)
Received: from [193.237.126.196] (unknown [193.237.126.196])
	by mdfmta010.tbr.inty.net (Postfix) with ESMTP;
	Thu, 28 Mar 2013 18:51:39 +0000 (GMT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <20130326193539.GB28244@sigill.intra.peff.net>
X-MDF-HostID: 3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219444>

Jeff King wrote:
> On Tue, Mar 26, 2013 at 07:20:11PM +0000, Ramsay Jones wrote:
> 
>> After commit cbfd5e1c ("drop some obsolete "x = x" compiler warning
>> hacks", 21-03-2013) removed a gcc specific hack, older versions of
>> gcc now issue an "'contents' might be used uninitialized" warning.
>> In order to suppress the warning, we simply initialize the variable
>> to NULL in it's declaration.
> 
> I'm OK with this, if it's the direction we want to go. But I thought the
> discussion kind of ended as "we do not care about these warnings on
> ancient versions of gcc; those people should use -Wno-error=uninitialized".

Hmm, I don't recall any agreement or conclusions being reached.
I guess I missed that!

> What version of gcc are you using? If it is the most recent thing
> reasonably available on msysgit, then I am more sympathetic. But if it's
> just an antique version of gcc, I am less so.

(see previous email for compiler versions).

I suppose it depends on what you consider antique. [I recently
downloaded the "first C compiler" from github. Yes, that is an
antique compiler! ;-)] I would call some of the compilers I use
"a bit mature." :-P

Hmm, so are you saying that this patch is not acceptable because
I used a compiler that is no longer supported?

ATB,
Ramsay Jones
