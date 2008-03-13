From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 08/16] t4200: use cut instead of sed
Date: Wed, 12 Mar 2008 21:52:18 -0700
Message-ID: <7vejaf1b0d.fsf@gitster.siamese.dyndns.org>
References: <cover.1205356737.git.peff@peff.net>
 <20080312213756.GI26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 05:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZfRD-00075g-Jd
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 05:53:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbYCMEw1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 00:52:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbYCMEw1
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 00:52:27 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49369 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYCMEw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 00:52:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 687362ECF;
	Thu, 13 Mar 2008 00:52:25 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id ACF022ECE; Thu, 13 Mar 2008 00:52:20 -0400 (EDT)
In-Reply-To: <20080312213756.GI26286@coredump.intra.peff.net> (Jeff King's
 message of "Wed, 12 Mar 2008 17:37:56 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77033>

Jeff King <peff@peff.net> writes:

> Some versions of sed (like the one on Solaris) don't like to
> match literal tabs, and simply print nothing. Instead, let's
> use cut.

> -sha1=$(sed -e 's/	.*//' .git/rr-cache/MERGE_RR)

This is a bit hard to believe.  On one of my ancient Sun box:

$ uname -a
SunOS sic.twinsun.com 5.8 Generic_117350-45 sun4u sparc SUNW,UltraSPARC-IIi-Engine
$ ls -l /bin/sed
-r-xr-xr-x   1 root     bin        28748 Aug  2  2005 /bin/sed

the above "sed" does not misbehave (/bin/sh does, of course, on $(...),
but that is a different story).
