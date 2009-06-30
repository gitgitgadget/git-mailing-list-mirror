From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] request-pull: do not paginate output of git commands
Date: Tue, 30 Jun 2009 09:32:44 -0700
Message-ID: <7vskhh8yxf.fsf@alter.siamese.dyndns.org>
References: <1246361606-20457-1-git-send-email-mmarek@suse.cz>
	<7vws6t8zhv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michal Marek <mmarek@suse.cz>
X-From: git-owner@vger.kernel.org Tue Jun 30 18:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLgGL-0002Jo-Am
	for gcvg-git-2@gmane.org; Tue, 30 Jun 2009 18:32:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZF3Qcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Jun 2009 12:32:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbZF3Qcm
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jun 2009 12:32:42 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44083 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751922AbZF3Qcm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jun 2009 12:32:42 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090630163245.MVUD18948.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Tue, 30 Jun 2009 12:32:45 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id AGYk1c00T4aMwMQ04GYkax; Tue, 30 Jun 2009 12:32:45 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=hoH3GwZHzGIA:10 a=ybZZDoGAAAAA:8
 a=RFi1w2cPN88ZGPHfelYA:9 a=0NsLDsaWTgVmQF2VHFm2eSzngGYA:4 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <7vws6t8zhv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's message of "Tue\, 30 Jun 2009 09\:20\:28 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122522>

Junio C Hamano <gitster@pobox.com> writes:

> Michal Marek <mmarek@suse.cz> writes:
>
>> git request-pull called inside a terminal prints part of the output to
>> the terminal and other parts are piped through the pager. Fix this.
>
> Hmph, I have always thought this was meant to be a feature.
>
> That is, you run it to yourself, instead of piping it to a file or "| mail
> torvalds", in order to sanity check before you actually do the latter.
> When the request is larger than a screenful, you would want a pager while
> reviewing.

Sorry, I take it back.

If it _were_ a single call to a paging command what I said may make sense,
but with many separate calls to shortlog, we wouldn't know which output is
too large (and uses pager).  I agree your patch makes things better.

I should have read your commit log message after finishing my coffee ;-)

Thanks.
