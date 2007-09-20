From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rev-list --bisect: Fix best == NULL case.
Date: Thu, 20 Sep 2007 00:08:00 -0700
Message-ID: <7vhclplsq7.fsf@gitster.siamese.dyndns.org>
References: <20070920072301.689b96c9.chriscool@tuxfamily.org>
	<7vmyvhltpy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 09:08:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYG92-0001SN-IV
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 09:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759642AbXITHIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 03:08:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759641AbXITHII
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 03:08:08 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759254AbXITHIG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 03:08:06 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 7A6611386BA;
	Thu, 20 Sep 2007 03:08:24 -0400 (EDT)
In-Reply-To: <7vmyvhltpy.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Wed, 19 Sep 2007 23:46:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58760>

Junio C Hamano <gitster@pobox.com> writes:

> The patch makes sense.  In fact you can crash any released
> version like this:
>
>     $ git rev-list --bisect v1.5.2..v1.5.0
>
> I'll need to apply a moral equivalent to 'maint'.

I spoke too fast.  This is not broken in any released version.

Only with the patch from somebody that broke it with commit
ce0cbad7727457854d631a6314d9aee7c837cb65 (rev-list --bisect:
Move finding bisection into do_find_bisection.), the "empty set"
case would segfault ;-).
