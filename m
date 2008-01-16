From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] treat any file with NUL as binary
Date: Tue, 15 Jan 2008 17:16:37 -0800
Message-ID: <7vve5ubmdm.fsf@gitster.siamese.dyndns.org>
References: <1200407309-10992-1-git-send-email-dpotapov@gmail.com>
	<7vsl0yd6r8.fsf@gitster.siamese.dyndns.org>
	<20080116011321.GD13984@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 02:17:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEwuF-0006u3-Ac
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 02:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbYAPBQ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 20:16:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYAPBQ6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 20:16:58 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45410 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777AbYAPBQ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 20:16:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E9D996DFA;
	Tue, 15 Jan 2008 20:16:54 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ACE56DF8;
	Tue, 15 Jan 2008 20:16:51 -0500 (EST)
In-Reply-To: <20080116011321.GD13984@dpotapov.dyndns.org> (Dmitry Potapov's
	message of "Wed, 16 Jan 2008 04:13:21 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70592>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Then it seems to me, Linus sounded more in favor of that change than
> against it. His main argument was against 'diff' heuristic, which he
> felt was not strict enough for CRLF translation: "It's *much* better
> to miss some CRLF translation than to do too much of it."

Yeah, you found the right one, and I agreed with the argument
back then, and I agree with it now.  I think NUL heuristics is a
good one and obviously it makes it tighter than what diff uses,
which should be what we are aiming for in this thread.
