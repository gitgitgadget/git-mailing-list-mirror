From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-diff on touched files: bug or feature?
Date: Thu, 02 Aug 2007 03:01:15 -0700
Message-ID: <7v1wemxnkk.fsf@assigned-by-dhcp.cox.net>
References: <vpqwswf8c1i.fsf@bauges.imag.fr>
	<7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net>
	<vpqhcni47ek.fsf@bauges.imag.fr>
	<7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Thu Aug 02 12:01:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGXUd-000289-OU
	for gcvg-git@gmane.org; Thu, 02 Aug 2007 12:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753107AbXHBKBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 06:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbXHBKBR
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 06:01:17 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:55826 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752473AbXHBKBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2007 06:01:16 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070802100115.JKFE1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 2 Aug 2007 06:01:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Wy1F1X0041kojtg0000000; Thu, 02 Aug 2007 06:01:15 -0400
In-Reply-To: <7vd4y6xnw4.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 02 Aug 2007 02:54:19 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54534>

Junio C Hamano <gitster@pobox.com> writes:

> Matthieu Moy <Matthieu.Moy@imag.fr> writes:
> ...
>> I've hit this while working on a project, doing a lot of modifications
>> through scripting (some regexp substitutions and such kinds of
>> things).
>
> I have to say that you are quite mistaken.
>
> Scripted style bulk modification that indiscriminately touch
> everbody but actually only modifies some, e.g. "perl -p -i", is
> a fine component of people's workflow, but that is *NOT* the
> norm.

Having said that, there is another lesson to take home from
this.

Quite honestly, a script that indiscriminately touches everybody
but only modifies a few is simply broken.  Think about "make".
"git diff" reporting many cache-dirty files is simply reminding
you the brokenness of such a script.
