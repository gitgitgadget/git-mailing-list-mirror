From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Trying to get GIT running on SCO OpenServer
Date: Wed, 23 Jan 2008 18:48:25 -0800
Message-ID: <7vodbcaqh2.fsf@gitster.siamese.dyndns.org>
References: <20080123212613.GN2230@yugib.highrise.ca>
	<alpine.LSU.1.00.0801232346010.5731@racer.site>
	<7vsl0oax42.fsf@gitster.siamese.dyndns.org>
	<4797F902.4000104@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Aidan Van Dyk <aidan@highrise.ca>, git@vger.kernel.org
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 03:49:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHs9c-0005xF-B8
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 03:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751085AbYAXCsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 21:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbYAXCsu
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 21:48:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33607 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbYAXCst (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 21:48:49 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id ECD7D1713;
	Wed, 23 Jan 2008 21:48:46 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A9FD1712;
	Wed, 23 Jan 2008 21:48:42 -0500 (EST)
In-Reply-To: <4797F902.4000104@zytor.com> (H. Peter Anvin's message of "Wed,
	23 Jan 2008 18:33:38 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71582>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>>> FWIW we had the same problem in MinGW, and Hannes Sixt solved it:
>>>
>>> http://repo.or.cz/w/git/mingw/j6t.git?a=commitdiff;h=b8e84a68f01a2386b2071e1bdc8e24de809a3f6d
>>>
>>> That might give you an idea how to solve the issue.  Maybe you even
>>> make a git patch out of it?  With a Makefile variable
>>> BROKEN_SNPRINTF=YesPlease, maybe?
>>
>> Hmmm.  Looking at that change makes me wonder if that solution
>> is Kosher.  The value of the va_list you pass to vsnprintf() is
>> unspecified after the call.
>>
>> It may be Ok as mingw-only "compatibility wrapper", but I think
>> you have to be a bit careful.  It is not a general solution for
>> any BROKEN_SNPRINTF.
>
> That's what va_copy() is for.

Yes.  See 4bf53833dbca666f61b5177977e96d453527db20 ;-)
