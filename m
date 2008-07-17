From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Patterns work unexpectedly with "git log" commit limiting
Date: Thu, 17 Jul 2008 01:17:33 -0700
Message-ID: <7vhcaoj55u.fsf@gitster.siamese.dyndns.org>
References: <20080717074706.GA5392@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Thu Jul 17 10:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJOhF-0003h1-LJ
	for gcvg-git-2@gmane.org; Thu, 17 Jul 2008 10:18:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752337AbYGQIRn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2008 04:17:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751659AbYGQIRm
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Jul 2008 04:17:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:33271 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbYGQIRl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2008 04:17:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B3BE6271DD;
	Thu, 17 Jul 2008 04:17:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 214D6271D7; Thu, 17 Jul 2008 04:17:35 -0400 (EDT)
In-Reply-To: <20080717074706.GA5392@mithlond.arda.local> (Teemu Likonen's
 message of "Thu, 17 Jul 2008 10:47:06 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1B3B078-53D8-11DD-8C1D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88817>

Teemu Likonen <tlikonen@iki.fi> writes:

>  1. Option order changes the behaviour. "git log" with
> ...
>  2. Internally --author= and --committer= fields contain more stuff than
> ...
>  3. What is the supposed behaviour of -F (--fixed-strings) when combined

I won't have time right now to comment on the previous three, because they
are not my code (meaning, I need to dig around before I can intelligently
answer -- maybe when I have free time).  What you expected does sound very
sensible, though.

>  4. Logical AND/OR operation.

The --grep and --author search of "log" family shares git-grep logical
expression engine, so if you somehow can come up with a way to pass --and
(or even better, --all-match) from the command line just like we can give
them to git-grep, searching with combinations of and/or/not should be doable.
