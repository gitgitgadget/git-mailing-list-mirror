From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v8 00/12] Add interpret-trailers builtin
Date: Thu, 27 Mar 2014 08:53:25 +0100 (CET)
Message-ID: <20140327.085325.427007668629327512.chriscool@tuxfamily.org>
References: <20140326215858.11352.89243.chriscool@tuxfamily.org>
	<xmqq4n2kh86k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, johan@herland.net, josh@joshtriplett.org,
	tr@thomasrast.ch, mhagger@alum.mit.edu, dan.carpenter@oracle.com,
	greg@kroah.com, peff@peff.net, sunshine@sunshineco.com,
	ramsay@ramsay1.demon.co.uk
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Mar 27 08:53:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WT583-00030T-Oz
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 08:53:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263AbaC0Hx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 03:53:29 -0400
Received: from mail-1y.bbox.fr ([194.158.98.14]:51375 "EHLO mail-1y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbaC0Hx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 03:53:28 -0400
Received: from localhost (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-1y.bbox.fr (Postfix) with ESMTP id A60056E;
	Thu, 27 Mar 2014 08:53:26 +0100 (CET)
In-Reply-To: <xmqq4n2kh86k.fsf@gitster.dls.corp.google.com>
X-Mailer: Mew version 6.3 on Emacs 23.3 / Mule 6.0 (HANACHIRUSATO)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245262>

From: Junio C Hamano <gitster@pobox.com>

> Christian Couder <chriscool@tuxfamily.org> writes:
> 
>> Until now git commit has only supported the well known
>> "Signed-off-by: " trailer, that is used by many projects like
>> the Linux kernel and Git.
>>
>> It is better to implement features for these trailers first in a
>> new command rather than in builtin/commit.c, because this way the
>> prepare-commit-msg and commit-msg hooks can reuse this command.
> 
> The "first" is somewhat questionable.
> 
> It is better to keep builtin/commit.c uncontaminated by any more
> hard-wired logic, like what we have for the signed-off-by line.  Any
> new things can and should be doable in hooks, and this filter would
> help writing these hooks.
> 
> And that is why the design goal of the filter is to make it at least
> as powerful as the built-in logic we have for signed-off-by lines;
> that would allow us to later eject the hard-wired logic for
> signed-off-by line from the main codepath, if/when we wanted to.
> 
> Alternatively, we could build a library-ish API around this filter
> code and replace the hard-wired logic for signed-off-by line with a
> call into that API, if/when we wanted to, but that requires (in
> addition to the "at least as powerful as the built-in logic") that
> the implementation of this stand-alone filter can be cleanly made
> into a reusable library, so that is a bit higher bar to cross than
> "everything can be doable with hooks" alternative.

Ok, I will try to improve this part of the Rationale section.

Thanks,
Christian.
