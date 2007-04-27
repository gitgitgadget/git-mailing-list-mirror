From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 4/4] server info: Add HEAD to info/refs
Date: Thu, 26 Apr 2007 21:36:00 -0700
Message-ID: <7vps5qph73.fsf@assigned-by-dhcp.cox.net>
References: <20070427020601.22991.13792.stgit@rover>
	<20070427020608.22991.29273.stgit@rover>
	<7vhcr2qxtj.fsf@assigned-by-dhcp.cox.net>
	<20070427042802.GW4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:36:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIBi-0006Iw-LW
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:36:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755293AbXD0EgD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:36:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755287AbXD0EgD
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:36:03 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:34056 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755293AbXD0EgB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:36:01 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070427043601.OAVV1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Fri, 27 Apr 2007 00:36:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id s4c01W00N1kojtg0000000; Fri, 27 Apr 2007 00:36:00 -0400
In-Reply-To: <20070427042802.GW4489@pasky.or.cz> (Petr Baudis's message of
	"Fri, 27 Apr 2007 06:28:02 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45685>

Petr Baudis <pasky@suse.cz> writes:

> On Fri, Apr 27, 2007 at 05:51:36AM CEST, Junio C Hamano wrote:
>> I always considered it was a bug that the native transport sends
>> SHA-1 of HEAD after dereferencing the symref, instead of saying
>> which branch it points at.
>
> Yes, you are right. That was what I was originally after, but then got
> sidetracked into working on something else and this easy bit was the
> only thing left done, so I just passed it along. :)
>
>> How about proceeding along these lines?
>
> Looks generally good.
>
>>  * We add native protocol extension to let upload-pack to say
>>    what HEAD symref points at, in addition to the SHA-1 HEAD
>>    points at.  Update peek-remote to show this information like
>>    this:
>> 
>> 	->refs/heads/master<TAB>HEAD<LF>
>>         0d5e6c97...<TAB>HEAD<LF>
>> 	...
>
> Yet another obscure syntax? Why not just reusing the actual ref: syntax?

Yup, ref: is fine.  Please make it so, but after 1.5.2 ;-).
