From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] diff.c: convert builtin funcname patterns to
 extended regular expressions
Date: Thu, 18 Sep 2008 00:31:57 -0700
Message-ID: <7vfxnxzz82.fsf@gitster.siamese.dyndns.org>
References: <7v3ak06jzj.fsf@gitster.siamese.dyndns.org>
 <-f-gqL4SkA8Uh7hSuKT-JDY0g26jHn3fDQCE24MB1nKWUMLZWuSseg@cipher.nrlssc.navy.mil> <48D200D7.9080800@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	Arjen Laarhoven <arjen@yaph.org>,
	Mike Ralphson <mike.ralphson@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Jeff King <peff@peff.net>,
	Boyd Lynn Gerber <gerberb@zenez.com>,
	Git Mailing List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>,
	Johan Herland <johan@herland.net>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Thu Sep 18 09:36:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgE0w-0000cW-7G
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 09:33:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752628AbYIRHcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 03:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752081AbYIRHcO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 03:32:14 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62622 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYIRHcO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 03:32:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EFB3F62385;
	Thu, 18 Sep 2008 03:32:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EB2462381; Thu, 18 Sep 2008 03:31:59 -0400 (EDT)
In-Reply-To: <48D200D7.9080800@op5.se> (Andreas Ericsson's message of "Thu,
 18 Sep 2008 09:18:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E90C93D2-8553-11DD-8AF3-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96179>

Andreas Ericsson <ae@op5.se> writes:

> Can we issue a deprecation heads-up for the current "funcname"
> along with a "call for patterns" and then have "funcname" and
> "ereg_funcname" mean the same for a while until we obsolete
> ereg_funcname in favour of funcname, perhaps? I can't imagine
> anyone wanting to use posix regular expressions if extended
> ones are available everywhere.

I prefer not to obsolete anything, and that is one of the larger reasons
that I did not object to xfuncname at all.  It's shorter to spell than
ereg_funcname (and sweeter to the eye).

Even when in some future _everybody_ uses xfuncname and nobody you and I
know personally uses funcname anymore, I do not think it is worth the
hassle to change the semantics of "funcname".

For one thing, "xfuncname" is _not_ that ugly that people would wish they
could spell it just "funcname".

This reminds me of what Eric did to "commit" vs "dcommit".  "commit" was
renamed to "set-tree", and a command with a better semantics is called
"dcommit".  Perhaps not many people use "set-tree" and everybody keeps
typing "dcommit" these days, but it is not worth renaming it to "commit",
ever.
