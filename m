From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove useless if-before-free tests.
Date: Mon, 18 Feb 2008 01:36:35 -0800
Message-ID: <7vwsp2ppwc.fsf@gitster.siamese.dyndns.org>
References: <871w7bz1ly.fsf@rho.meyering.net>
 <ee77f5c20802171409k2dee2c87v8d84eba111c3d506@mail.gmail.com>
 <87pruuy64v.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "David Symonds" <dsymonds@gmail.com>,
	"git list" <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Mon Feb 18 10:37:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR2RB-0005zX-Jo
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 10:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756318AbYBRJgr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756257AbYBRJgq
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 04:36:46 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:32877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756187AbYBRJgp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 04:36:45 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 50603431C;
	Mon, 18 Feb 2008 04:36:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 9DF96431B; Mon, 18 Feb 2008 04:36:37 -0500 (EST)
In-Reply-To: <87pruuy64v.fsf@rho.meyering.net> (Jim Meyering's message of
 "Mon, 18 Feb 2008 10:18:40 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74254>

Jim Meyering <jim@meyering.net> writes:

> It's a definite loss of portability if you can find a reasonable porting
> target for which free(NULL) fails.  But even if you do, the fix is
> not to reject the clean-up, but to amend it with a wrapper function.
> That encapsulates the work-around in one place rather than polluting
> all of those files.

As we already have unchecked free(ptr) in our code _anyway_,
there _technically_ is no reason to reject the clean-up patch.

We just need to find a quiescent time to do so so that actively
cooking patches in people's trees (and topics in 'next') won't
get needless conflicts.
