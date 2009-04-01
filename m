From: Chris Johnsen <chris_johnsen@pobox.com>
Subject: Re: [PATCH] Documentation: use "spurious .sp" XSLT if
 DOCBOOK_SUPPRESS_SP is set
Date: Wed, 1 Apr 2009 07:19:08 -0500
Message-ID: <DDA1F213-D15C-49B3-90CB-557F9A465A6A@pobox.com>
References: <7vljql4586.fsf@gitster.siamese.dyndns.org>
 <1238575834-17838-1-git-send-email-chris_johnsen@pobox.com>
 <20090401103442.GD26181@coredump.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 01 14:22:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LozSY-0004AR-S1
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 14:22:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761839AbZDAMTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 08:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759378AbZDAMTx
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 08:19:53 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60418 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756492AbZDAMTw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 08:19:52 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A05F1A55A5;
	Wed,  1 Apr 2009 08:19:48 -0400 (EDT)
Received: from [192.168.1.241] (unknown [75.53.43.147]) (using TLSv1 with
 cipher AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4CCBDA55A4; Wed,
  1 Apr 2009 08:19:43 -0400 (EDT)
In-Reply-To: <20090401103442.GD26181@coredump.intra.peff.net>
X-Mailer: Apple Mail (2.753.1)
X-Pobox-Relay-ID: 64BF0F8A-1EB7-11DE-A5C2-32B0EBB1AA3C-07245699!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115377>

On 2009 Apr 1, at 05:34, Jeff King wrote:
> On Wed, Apr 01, 2009 at 03:50:34AM -0500, Chris Johnsen wrote:
>
>> The key revisions in the docbook SVN repo seem to be 5144 (before
>> docbook-xsl 1.69.1) and 6359 (before docbook-xsl 1.71.1).
>>
>> Testing done with asciidoc 8.3.1 and docbook-xsl 1.74.0.
>
> In the course of your SVN research, did you find the fixes between
> 1.73.1 and 1.74.3 that fixed the spacing issue? If so, I wonder if  
> it's
> worth backporting that fix to DOCBOOK_FIX_LIST_SPACING.

I guess you are referring to an issue different from the one created  
by using the "spurious .sp" simpara template, but I am not familiar  
with another one. If not, then I am confused. The new patch to avoid  
using the "spurious .sp" template fixes the list spacing in pu's git- 
cvsimport.1 when I generate it here (using docbook-xsl 1.74.0). For  
example, the extra blank line after "Problems related to timestamps:"  
goes away and a new blank line is inserted before "Problems related  
to branches:".

My poking around in the docbook SVN repo was largely limited to the  
manpages/block.xsl file since that is where the normal simpara  
template lives. If this other issue is list specific, it seems likely  
that fixes would be in manpages/lists.xsl. It looks like there have  
only been around ten commits to that lists.xsl since 1.73.1, but none  
of them jumped out at me as likely culprits unless the spacing you  
mean is indentation or "bullet"-to-text spacing (though my brain is  
tired right now).

-- 
Chris
