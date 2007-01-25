From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fetch-pack: remove --keep-auto and make it the default.
Date: Thu, 25 Jan 2007 13:32:40 -0800
Message-ID: <7vejpiaj2f.fsf@assigned-by-dhcp.cox.net>
References: <7v64b04v2e.fsf@assigned-by-dhcp.cox.net>
	<7v3b6439uh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701212234520.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vzm8ansrt.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701231129501.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0701231101040.3011@xanadu.home>
	<7v7ivbc3hj.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:32:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACD7-0003ZQ-Tq
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:32:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030588AbXAYVcm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030585AbXAYVcm
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:32:42 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:54960 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030588AbXAYVcl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:32:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070125213241.UAOC9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 25 Jan 2007 16:32:41 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FZXj1W00l1kojtg0000000; Thu, 25 Jan 2007 16:31:44 -0500
In-Reply-To: <Pine.LNX.4.63.0701250922260.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 25 Jan 2007 09:23:48 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37760>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Wed, 24 Jan 2007, Junio C Hamano wrote:
>
>>   Ok, how about this, on top of the previous ones?
>
> Thanks!
>
>> @@ -653,6 +663,8 @@ int main(int argc, char **argv)
>>  	struct stat st;
>>  
>>  	setup_git_directory();
>> +	setup_ident();
>> +	git_config(fetch_pack_config);
>
> Why do you need setup_ident()?

Because presumably you would be updating the reflog that records
who did the fetch?

But then we should do the same ignore_missing_committer_name()
we have in receive-pack to allow anonymous fetchers to fetch
from outside world, I guess.
