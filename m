From: Andreas Ericsson <ae@op5.se>
Subject: Re: why the 'g' prefix on the SHA1 in git-describe output?
Date: Sat, 03 Nov 2007 16:18:54 +0100
Message-ID: <472C915E.8070205@op5.se>
References: <871wb7a53d.fsf@rho.meyering.net> <8c5c35580711030656h23d5910ah824de41a2cf4eafe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 03 16:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoKmL-00069f-OC
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 16:19:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754434AbXKCPTB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 11:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754431AbXKCPTA
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 11:19:00 -0400
Received: from mail.op5.se ([193.201.96.20]:43807 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754354AbXKCPTA (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 11:19:00 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 1F8561730713;
	Sat,  3 Nov 2007 16:18:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BKfLS5C1E1tP; Sat,  3 Nov 2007 16:18:05 +0100 (CET)
Received: from nox.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id E27C717306E6;
	Sat,  3 Nov 2007 16:18:04 +0100 (CET)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <8c5c35580711030656h23d5910ah824de41a2cf4eafe@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63281>

Lars Hjemli wrote:
> On Nov 3, 2007 1:25 PM, Jim Meyering <jim@meyering.net> wrote:
>> Can anyone tell me what motivated adding the 'g' prefix on the SHA1 in
>> git-describe output?
> 
> I'm not sure what _motivated_ the 'g', but currently git-rev-parse
> understands the output from git-describe _if_ the 'g' is present.
> 

It's been there since 908e5310b958619559d34b0b6da122f058faa47e, which
has the commit-subject 'Add a "git-describe" command'.

I think it'd be more trouble removing it now than it is to keep it,
since a lot of script depend on it being there for parsing out
versioning info in various autobuild- and release scripts.

If you want to change it, I'd suggest adding a "--no-sha1" option
that makes the entire "-g%s" part of the output go away, or
perhaps adding a --format="%v-%d-%g" (for the default behaviour).

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
