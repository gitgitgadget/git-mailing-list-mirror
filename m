From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/4] engine.pl: Fix a recent breakage of the buildsystem
 generator
Date: Fri, 22 Jan 2010 18:58:17 +0000
Message-ID: <4B59F549.8070308@ramsay1.demon.co.uk>
References: <4B575838.2010504@ramsay1.demon.co.uk> <4B576E38.5080604@pcharlan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, sschuberth@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: Pete Harlan <pgit@pcharlan.com>
X-From: git-owner@vger.kernel.org Fri Jan 22 21:05:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYPlK-00042P-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jan 2010 21:05:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753274Ab0AVUFm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jan 2010 15:05:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710Ab0AVUFm
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Jan 2010 15:05:42 -0500
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:58784 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752578Ab0AVUFl (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Jan 2010 15:05:41 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1NYPlE-0003Vb-eY; Fri, 22 Jan 2010 20:05:41 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4B576E38.5080604@pcharlan.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137777>

Pete Harlan wrote:
> On 01/20/2010 11:23 AM, Ramsay Jones wrote:
>> diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
>> index d506717..245af73 100644
>> --- a/contrib/buildsystems/engine.pl
>> +++ b/contrib/buildsystems/engine.pl
>> @@ -135,6 +135,11 @@ sub parseMakeOutput
>>              }
>>          } while($ate_next);
>>  
>> +        if ($text =~ /^test / && $text =~ /|| rm -f /) {
> 
> That test on the right needs to escape its pipes or it will always match.

Heh, well spotted!
As you may have already noticed, I copy/pasted the code from the comment
further down in this function, but didn't take enough care in doing so...
Oops! ;-)

The obvious solution, also suggested later by Sebastion, is to simply
remove the second regex from the test since it does not alter the
outcome (and still fixes the problem)...

ATB,
Ramsay Jones
