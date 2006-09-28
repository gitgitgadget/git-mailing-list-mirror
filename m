From: Andy Whitcroft <apw@shadowen.org>
Subject: Re: [PATCH] svnimport add support for parsing From lines for author
Date: Thu, 28 Sep 2006 11:58:22 +0100
Message-ID: <451BAACE.70005@shadowen.org>
References: <20060925110813.GA4419@shadowen.org>	<7v7izrtdtw.fsf@assigned-by-dhcp.cox.net>	<4518DC11.5050806@shadowen.org> <7vfyedj2j2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 28 12:58:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GStbQ-0006xD-Qx
	for gcvg-git@gmane.org; Thu, 28 Sep 2006 12:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161062AbWI1K6u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 06:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965309AbWI1K6t
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 06:58:49 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:28938 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S965308AbWI1K6t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 06:58:49 -0400
Received: from localhost ([127.0.0.1])
	by hellhawk.shadowen.org with esmtp (Exim 4.50)
	id 1GStas-0002lS-Ud; Thu, 28 Sep 2006 11:58:19 +0100
User-Agent: Thunderbird 1.5.0.5 (X11/20060812)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfyedj2j2.fsf@assigned-by-dhcp.cox.net>
X-Enigmail-Version: 0.94.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28000>

Junio C Hamano wrote:
> Andy Whitcroft <apw@shadowen.org> writes:
> 
>>>> Now that we have support for parsing Signed-off-by: for author
>>>> information it makes sense to handle From: as well.
>>> I take that you are referring to Sasha's change in ae35b304; I
>>> asked for actual svn users for ACK/NACK but I did not hear any.
>>> Can I understand that you use svnimport for real projects and
>>> are happy with Sasha's change? --- that would be an ack that
>>> would help me sleep better ;-).
>> Heh.  Yeah I am tracking a small SVN repository which is using the
>> kernel DCO.  we have From:/S-o-b: much as akpm uses in -mm.  This was
>> the result of seeing that change and wanting to see if it would pick up
>> our sign-offs.  It only seemed deficient in From: handling :).  It seems
>> to work well in practice for me.
> 
> Thanks.
> 
>>> I also wonder instead of piling up custom flags if it is better
>>> to let match-and-extract pattern be specified from the command
>>> line.
>> I did look at reusing the -S flag, such that -S would be S-o-b: handling
>> and -SS would be S-o-b: and From:, but this script is currently using
>> the old getopt implementation which doesn't record repeats.
>>
>> So you're proposing something more like:
>>
>>     git svn-import -S "Signed-off-by:" -S "From:" ...
>>
>> Again, we'll have to update the options handling to get that kind of
>> behaviour.  How would you feel about -SS in this context.
> 
> It was more of an idle speculation than a serious proposal.  I
> do not think there are too many different ways to record the
> authorship information, so having just two hardwired patterns -F
> and -S would be sufficient.  If there were, then string of -S
> options that specify the header-looking strings or match
> patterns would have made more sense.

This one didn't make it onto the git.git whats next page.  Not sure of
protocol in these matters, so I'll just ask.  Has this been rejected or
forgotten?

:)

-apw
