From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [FEATURE REQUEST] git-svn format-patch
Date: Tue, 15 Jan 2008 16:19:43 -0800
Message-ID: <7vhched3kw.fsf@gitster.siamese.dyndns.org>
References: <c0f2d4110801150559x155ffabaj6bea52715522a070@mail.gmail.com>
	<alpine.DEB.1.00.0801151444180.5289@eeepc-johanness>
	<c0f2d4110801150758t68714570y83e1e74acbb67325@mail.gmail.com>
	<alpine.LNX.1.00.0801151728120.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Chris Ortman <chrisortman@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 01:20:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JEw1A-0001X4-Lk
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 01:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbYAPAUE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 19:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750702AbYAPAUE
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 19:20:04 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41725 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbYAPAUD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 19:20:03 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EE2DA1AD6;
	Tue, 15 Jan 2008 19:20:00 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 431011AD1;
	Tue, 15 Jan 2008 19:19:56 -0500 (EST)
In-Reply-To: <alpine.LNX.1.00.0801151728120.13593@iabervon.org> (Daniel
	Barkalow's message of "Tue, 15 Jan 2008 18:11:37 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70583>

Daniel Barkalow <barkalow@iabervon.org> writes:

> When --no-prefix is used, we should probably do:
>
> Index: <filename>
>
> instead of
>
> diff --git <filename> <filename>
>
> If nothing else, --no-prefix generates patches that git-apply can't apply 
> but thinks that it should be able to because of the "diff --git" line.

While I do not necessarily agree with that "Index: <filename>"
thing, I think dropping "--git" from there is probably a good
idea, as that is clearly not "--git" patch meant to be fed to
git-apply.

Actually I vaguely recall somebody suggested that we drop
"--git" if any nonstandard --src-prefix and --dst-prefix, but
sorry I do not recall the details (I am a bit sick today).  I
guess somehow we did not heed that wise advise and accepted the
change as-is, and that new feature ended up with a half-baked
hack that did not consider its consequences X-<.
