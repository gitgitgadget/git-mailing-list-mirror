From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] autoconf: Add test for sys/select.h header file
Date: Fri, 25 Jan 2008 22:25:33 -0800
Message-ID: <7v8x2d3xya.fsf@gitster.siamese.dyndns.org>
References: <20080124183446.GJ30676@schiele.dyndns.org>
	<1201259981-7115-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Robert Schiele <rschiele@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 26 07:26:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIeUW-0007nq-Oe
	for gcvg-git-2@gmane.org; Sat, 26 Jan 2008 07:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752731AbYAZGZm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2008 01:25:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752539AbYAZGZm
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jan 2008 01:25:42 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:36411 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752449AbYAZGZl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2008 01:25:41 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 543C126F1;
	Sat, 26 Jan 2008 01:25:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C153026EF;
	Sat, 26 Jan 2008 01:25:35 -0500 (EST)
In-Reply-To: <1201259981-7115-1-git-send-email-jnareb@gmail.com> (Jakub
	Narebski's message of "Fri, 25 Jan 2008 12:19:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71763>

Jakub Narebski <jnareb@gmail.com> writes:

> Some systems like HP-UX don't have sys/select.h; the select stuff
> is already present in some other headef file (e.g. sys/time.h for
> HP-UX).
>
> Companion to
>   "some systems don't have (and need) sys/select.h"
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> It could be alternately just squashed together with
> "some systems don't have (and need) sys/select.h" by Robert Schiele.
>
> Robert, could you please check this patch on HP-UX? It does work
> correctly on Linux (which has sys/select.h).

The issue is not really about "do we have <sys/select.h>?" but
is about "do we need to include <sys/select.h> in order to
obtain declaration of select(2)?" so this is covering only a
half of the issue.  But I guess we will find out if the system
does not offer select(2) whether <sys/select.h> is included or
not, so this is not too bad.

Will apply.  I do not think it would have problems but even if
it does it is small and easy to revert before the final.

Thanks.
