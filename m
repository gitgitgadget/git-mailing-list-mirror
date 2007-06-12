From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [RFC][PATCH 10/10] Sparse: fix a "symbol 'weak_match' shadows
 an earlier one" warning
Date: Tue, 12 Jun 2007 18:43:25 +0100
Message-ID: <466EDB3D.4070302@ramsay1.demon.co.uk>
References: <4669D7BC.3060607@ramsay1.demon.co.uk> <7vr6olh7pb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 19:45:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyAQy-0003Dy-7h
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 19:45:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbXFLRpY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 13:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754434AbXFLRpY
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 13:45:24 -0400
Received: from anchor-post-33.mail.demon.net ([194.217.242.91]:2241 "EHLO
	anchor-post-33.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754200AbXFLRpX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 13:45:23 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-33.mail.demon.net with esmtp (Exim 4.42)
	id 1HyAQi-000F0Y-CZ; Tue, 12 Jun 2007 17:45:21 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7vr6olh7pb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49978>

Junio C Hamano wrote:
> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
> 
>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>> ---
>>  connect.c |    1 -
>>  1 files changed, 0 insertions(+), 1 deletions(-)
>>
>> diff --git a/connect.c b/connect.c
>> index da89c9c..d4051dd 100644
>> --- a/connect.c
>> +++ b/connect.c
>> @@ -179,7 +179,6 @@ static int count_refspec_match(const char *pattern,
>>  	for (weak_match = match = 0; refs; refs = refs->next) {
>>  		char *name = refs->name;
>>  		int namelen = strlen(name);
>> -		int weak_match;
>>  
>>  		if (namelen < patlen ||
>>  		    memcmp(name + namelen - patlen, pattern, patlen))
> 
> This one is an obvious bug.  

Indeed ;-)
Also, I'm guessing it does not bring your machine down like a house of cards.

... Essentially, it makes weak matches
> ignored.  Unfortunately this has been hiding a larger bug in the
> caller of this function.  I am refactoring the mess right now.
> 
Great. Hopefully it will also address the cygwin issue.

ATB

Ramsay Jones
