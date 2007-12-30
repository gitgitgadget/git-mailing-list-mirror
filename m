From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach revision walker about reflog ranges
Date: Sat, 29 Dec 2007 16:16:00 -0800
Message-ID: <7vve6h9gvz.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712300000170.14355@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Dec 30 01:16:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8lr5-0000rq-1P
	for gcvg-git-2@gmane.org; Sun, 30 Dec 2007 01:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbXL3AQI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 19:16:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752653AbXL3AQH
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 19:16:07 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38223 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752569AbXL3AQG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 19:16:06 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 21644543C;
	Sat, 29 Dec 2007 19:16:05 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id A1E3C5439;
	Sat, 29 Dec 2007 19:16:02 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712300000170.14355@wbgn129.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 30 Dec 2007 00:02:11 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69338>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Now you can ask for a revision range
>
> 	master@{2.weeks.ago..1.day.ago}
>
> or even something like
>
> 	HEAD@{20..yesterday}

You can _ask_ all you want, but it is not clear what it does
from this description.  I guess you are rewriting master@{A..B}
to master@{A}..master@{B}, but that is not clear from the commit
log nor documentation (did I even see a documentation patch?).

Also, I am not convinced that the rewrite gives the semantics
the users naturally expect from @{A..B}.  I would even suspect
that people would expect "git log master@{0..2}" to behave more
like "git show master@{0} master@{1} master@{2}".
