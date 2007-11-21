From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] avoid "defined but not used" warning for fetch_objs_via_walker
Date: Tue, 20 Nov 2007 23:10:53 -0800
Message-ID: <7v63zwhy4i.fsf@gitster.siamese.dyndns.org>
References: <20071118081722.GA31563@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Daniel Barkalow <barkalow@iabervon.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 21 08:11:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IujkU-0001DK-5K
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 08:11:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754354AbXKUHLA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 02:11:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbXKUHLA
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 02:11:00 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:57065 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754354AbXKUHK7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 02:10:59 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 05D302EF;
	Wed, 21 Nov 2007 02:11:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8890294B72;
	Wed, 21 Nov 2007 02:11:16 -0500 (EST)
In-Reply-To: <20071118081722.GA31563@sigill.intra.peff.net> (Jeff King's
	message of "Sun, 18 Nov 2007 03:17:23 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65606>

Jeff King <peff@peff.net> writes:

> Because this function is static and used only by the
> http-walker, when NO_CURL is defined, gcc emits a "defined
> but not used" warning.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> On master. I like to compile with -Werror to make sure I don't miss
> warnings as the compile scrolls by.
>
> This fix feels a little wrong, since the function isn't specific to http
> support, but hopefully the comment should be obvious if we ever add
> another similar commit walker that needs it.

Yeah, while I share your -Werror desire it sure feels a bit
dirty.  As it does not look like we will be taking any new
walkers, I think your patch is reasonable, though.
