From: Junio C Hamano <junkio@cox.net>
Subject: Re: quick bare clones taking longer?
Date: Thu, 10 May 2007 01:25:25 -0700
Message-ID: <7vejlpkruy.fsf@assigned-by-dhcp.cox.net>
References: <7virb1sm6h.fsf@assigned-by-dhcp.cox.net>
	<20070509.150256.59469756.davem@davemloft.net>
	<7v3b25siwk.fsf@assigned-by-dhcp.cox.net>
	<20070509.162301.48802460.davem@davemloft.net>
	<7vy7jxr35a.fsf@assigned-by-dhcp.cox.net>
	<7vd519r10c.fsf@assigned-by-dhcp.cox.net>
	<vpqtzul3xzm.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu May 10 10:25:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3xt-0007OT-7f
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755946AbXEJIZ2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756193AbXEJIZ2
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:25:28 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51499 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755946AbXEJIZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:25:27 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510082526.VJOW6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 04:25:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xLRS1W0051kojtg0000000; Thu, 10 May 2007 04:25:26 -0400
In-Reply-To: <vpqtzul3xzm.fsf@bauges.imag.fr> (Matthieu Moy's message of "Thu,
	10 May 2007 10:05:01 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46846>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> Junio C Hamano <junkio@cox.net> writes:
>
>>  get_repo_base() {
>> -	(cd "$1" && (cd .git ; pwd)) 2> /dev/null
>> +	(
>> +		cd "`/bin/pwd`" &&
>> +		cd "$1" &&
>> +		(
>> +			cd .git
>> +			pwd
>> +		)
>> +	) 2>/dev/null
>>  }
>
> Will this work on windows?

Is that a serious question?

If so, my answer is "I do not know, but the update is not any
more complex than the existing code -- both are perfectly fine
POSIX shell".  Besides, if there are enough users who care about
Windows, there must be some competent ones among them, and we
will hear from them soon enough with an improvement patch.

If not, welcome to my killfile ;-).

NB.  No, the last one is not serious.  I do not have a
killfile.
