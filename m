From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase: add --signoff option
Date: Mon, 01 Oct 2007 01:20:28 -0700
Message-ID: <7vzlz3s0tv.fsf@gitster.siamese.dyndns.org>
References: <11911689111797-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Oct 01 10:20:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IcGW8-0007zT-PI
	for gcvg-git-2@gmane.org; Mon, 01 Oct 2007 10:20:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbXJAIUe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2007 04:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbXJAIUd
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Oct 2007 04:20:33 -0400
Received: from rune.pobox.com ([208.210.124.79]:42579 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbXJAIUd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2007 04:20:33 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id C645C13F604;
	Mon,  1 Oct 2007 04:20:54 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D0A713F603;
	Mon,  1 Oct 2007 04:20:52 -0400 (EDT)
In-Reply-To: <11911689111797-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Sun, 30 Sep 2007 18:15:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59588>

Steffen Prohaska <prohaska@zib.de> writes:

> When preparing a series of commits for upstream you may
> need to signoff commits if you forgot to do so earlier.
> This patch teaches git-rebase to signoff during rebase
> if you pass the option --signoff.
>
> Notes
> 1) --signoff cannot be used simultaneously with --interactive.
> 2) --signoff forces a rebase even if current path is a
>    descendant of <upstream>.
>
> Signed-off-by: Steffen Prohaska <prohaska@zib.de>

I do not think it is fatal for --signoff to be incompatible with
the "interactive" mode is fatal, but lack of mention in the
documentation is.  Also this would need test scripts to prevent
it from getting broken by future changes by others.  I'd like to
see ones that test at least the cases where (1) nobody has
sign-off, (2) you do not have sign-off but others do, and (3)
you already have sign-off at the end.

But I do like the general concept.
