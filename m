From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] MALLOC_CHECK: Allow checking to be disabled from config.mak
Date: Wed, 10 Oct 2012 18:46:36 +0100
Message-ID: <5075B47C.6030607@ramsay1.demon.co.uk>
References: <50706B54.8090004@ramsay1.demon.co.uk> <7vbogfquc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>,
	Elia Pinto <gitter.spiros@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 19:58:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TM0Xn-00087h-O8
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 19:58:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754255Ab2JJR55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 13:57:57 -0400
Received: from mdfmta009.mxout.tbr.inty.net ([91.221.168.50]:49567 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751733Ab2JJR54 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 13:57:56 -0400
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id D2CCC384080;
	Wed, 10 Oct 2012 18:57:53 +0100 (BST)
Received: from mdfmta009.tbr.inty.net (unknown [127.0.0.1])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP id 01A1738407C;	Wed, 10 Oct 2012 18:57:53 +0100 (BST)
Received: from [193.237.126.196] (unknown [193.237.126.196])	by mdfmta009.tbr.inty.net (Postfix) with ESMTP;	Wed, 10 Oct 2012 18:57:52 +0100 (BST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <7vbogfquc8.fsf@alter.siamese.dyndns.org>
X-MDF-HostID: 4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207419>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> The malloc checks can be disabled using the TEST_NO_MALLOC_CHECK
>> variable, either from the environment or command line of an
>> 'make test' invocation. In order to allow the malloc checks to be
>> disabled from the 'config.mak' file, we add TEST_NO_MALLOC_CHECK
>> to the environment using an export directive.
> 
> We would want to encourage people to test with cheap but effective
> checks when available.  I do not see "malloc: using debugging hooks"
> message anywhere when I run tests, but if you do, I'd rather see us
> check if we can tell glibc to stop doing so first without disabling
> the whole test.  Your patch feels like the first step to a slipperly
> slope whose destination would make us say "we get too many messages
> so let's do nothing in "make test" with this configuration." when
> taken to the extreme, and obviously we would not want to go there
> ;-).

[sorry for the late reply, I've been away ...]

Yes, but ... I really don't see that this patch would encourage anyone
to skip the malloc checks, who wasn't going to anyway! I didn't notice
much of an increase in the running time of the tests, so that wouldn't
discourage me. This idiotic message spewage is a different issue.
(the complete loss of terminal scroll-back is particularly annoying)

I had intended to run the tests with malloc checks enabled before
submitting patches, testing -rc* builds etc., but have them disabled
for day-to-day programming.

> Besides, doesn't a simple instruction to export TEST_NO_MALLOC_CHECK
> to your environment before running "make test" suffice?

Yes, so I can simply disable the malloc checks in my ~/.bashrc file.
However, it would be disappointing to have my config tweeks in two
places ... :(

I guess I can live with it ...

ATB,
Ramsay Jones
