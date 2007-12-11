From: Andreas Ericsson <ae@op5.se>
Subject: Re: v1.5.4 plans
Date: Tue, 11 Dec 2007 08:05:51 +0100
Message-ID: <475E36CF.7050207@op5.se>
References: <7vy7d43ptc.fsf@gitster.siamese.dyndns.org>	<7vabpg9x5k.fsf@gitster.siamese.dyndns.org>	<7vy7cwsi3p.fsf@gitster.siamese.dyndns.org>	<7vk5o6jbq9.fsf@gitster.siamese.dyndns.org>	<7v63zjgoel.fsf@gitster.siamese.dyndns.org>	<7vsl2i6ea4.fsf@gitster.siamese.dyndns.org>	<7vhcixtnm4.fsf@gitster.siamese.dyndns.org>	<7vfxye4yv7.fsf@gitster.siamese.dyndns.org>	<7vve78qhtf.fsf@gitster.siamese.dyndns.org>	<7vmysijhwq.fsf_-_@gitster.siamese.dyndns.org>	<20071210234941.GE22254@coredump.intra.peff.net> <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 08:06:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1zC4-0007QM-Lu
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 08:06:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbXLKHF4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 02:05:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbXLKHFz
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 02:05:55 -0500
Received: from mail.op5.se ([193.201.96.20]:49380 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbXLKHFz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 02:05:55 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id C610E1F08037;
	Tue, 11 Dec 2007 08:05:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zHBhxJug3Pgd; Tue, 11 Dec 2007 08:05:52 +0100 (CET)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 81FB81F08035;
	Tue, 11 Dec 2007 08:05:52 +0100 (CET)
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <7vtzmqhvgq.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67815>

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>>  - git-clean's handling of directory wildcards. I didn't get a response
>>    to
>>
>>      http://mid.gmane.org/20071206043247.GC5499@coredump.intra.peff.net
>>
>>    I suspect there are still some bugs lurking in there, but it's hard
>>    to say because I don't know what the behavior _should_ be (there are
>>    some test cases in that email).
> 
> The last time I looked at the "directory" side of builtin-clean.c, I had
> to quickly reach for my barf bag.  I never use "git clean" without "-n"
> and I never ever use "git clean" with "-d"; I do not have any idea what
> behaviour when given "-d" would be useful.


When you have a trash directory without any tracked files, clean will not
by default descend into that directory and thus won't remove neither files
nor directory. I frequently use one for automated testing, much like git's
trash repository, but the only time I do "git clean -d" is when building
things on a release-server with the repository checked out. It's faster
than "make distclean", and not all of our projects have a Makefile to begin
with. Tacking "git clean -d" at the end of test-scripts makes it simple to
remove all excess cruft in one go.

So in short, git clean -d can be useful. I have no idea when "git clean dir"
would be though.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
