From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 0/2] Controversial blob munging series
Date: Mon, 23 Apr 2007 11:42:51 -0700
Message-ID: <7virbnexuc.fsf@assigned-by-dhcp.cox.net>
References: <11772221041630-git-send-email-junkio@cox.net>
	<Pine.LNX.4.64.0704231540580.8822@racer.site>
	<7vzm4zf1zx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704231933560.8822@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Apr 23 20:42:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hg3V2-00068u-2c
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 20:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161260AbXDWSmx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Apr 2007 14:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161326AbXDWSmx
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Apr 2007 14:42:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49512 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161260AbXDWSmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Apr 2007 14:42:52 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070423184252.GQSU1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 23 Apr 2007 14:42:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id qiir1W00G1kojtg0000000; Mon, 23 Apr 2007 14:42:51 -0400
In-Reply-To: <Pine.LNX.4.64.0704231933560.8822@racer.site> (Johannes
	Schindelin's message of "Mon, 23 Apr 2007 19:35:33 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45350>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Mon, 23 Apr 2007, Junio C Hamano wrote:
> ...
>> ... I am inclined to think that this is quite fundamental.  I
>> think you just fell into category who want "extended semantics"
>> Linus talked about in $gmane/45214:
>> 
>>   I suspect that this gets some complaining off our back, but I *also* 
>>   suspect that people will actually end up really screwing themselves with 
>>   something like this and then blaming us and causing a huge pain down the 
>>   line when we've supported this and people want "extended semantics" that 
>>   are no longer clean.
>> 
>> which is kind of dissapointing.

I think this was the biggest worry.  If even Dscho, who is among
a dozen people with the most intimate knowledge of git on the
planet, gets it wrong, I can almost guarantee that we will get
into the mess Linus predicted above.

>> Even if you somehow solved the issue of "stat" rule, I do not
>> know what your plans are to manage the blobs that you drop in
>> the object store.  The list of object names in the mail-index
>> file you are generating do not count as connectivity for the
>> purpose of fetch/push/fsck/prune.
>
> I had the idea to update a ref, which holds "trees" of message-id -> blob 
> pairs, and get updated at the same time.

I somehow thought this mailbox thing was because you wanted to
transfer mailboxes across repositories.  How would you prevent
that ref from getting out of sync with the mail-index file git
knows nothing about its involvement in connectivity?
