From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] Add -k/--keep-going option to mergetool
Date: Fri, 14 Nov 2008 11:21:50 -0500
Message-ID: <20081114162149.GA19312@coredump.intra.peff.net>
References: <1226580075-29289-1-git-send-email-charles@hashpling.org> <1226580075-29289-2-git-send-email-charles@hashpling.org> <1226580075-29289-3-git-send-email-charles@hashpling.org> <1226580075-29289-4-git-send-email-charles@hashpling.org> <20081114064756.GB11907@coredump.intra.peff.net> <491D7C38.7070906@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>, Theodore Ts'o <tytso@mit.edu>,
	William Pursell <bill.pursell@gmail.com>
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Fri Nov 14 17:23:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L11S7-0005jM-Pk
	for gcvg-git-2@gmane.org; Fri, 14 Nov 2008 17:23:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751635AbYKNQVx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Nov 2008 11:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751610AbYKNQVx
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Nov 2008 11:21:53 -0500
Received: from peff.net ([208.65.91.99]:1883 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751368AbYKNQVw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Nov 2008 11:21:52 -0500
Received: (qmail 1219 invoked by uid 111); 14 Nov 2008 16:21:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 14 Nov 2008 11:21:51 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Nov 2008 11:21:50 -0500
Content-Disposition: inline
In-Reply-To: <491D7C38.7070906@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100985>

On Fri, Nov 14, 2008 at 01:25:12PM +0000, Charles Bailey wrote:

> Previously, if you aborted a merge, you were left with the
> base/local/remote temporaries for the merge that you aborted.
> 
> To be honest, I found this a little irritating. The base, local and
> remote temporaries are inputs so are accessible from slots 1,2 and 3 of
> the index, and any intermediate output will be in the target file. You
> can git clean, but if you have other temporaries you need to keep, you
> end up having to manually clean them up in any case.
> 
> With --keep-going, the problem is compounded. If you make several passes
> through a list of complex merges you end up with fistfuls of these
> temporary trios in your working tree. It goes from slightly annoying to
> very irritating.

I agree; I have never found the temporary files left by mergetool from a
failed merge to be useful, and get a little annoyed that I have to "git
clean" them away afterwards. Even without --keep-going, I would often
look at and abort a merge several times before resolving it and end up
with several copies.

But I definitely think that is an issue for a separate patch, and one
that needs input from Ted and from other mergetool users.

-Peff
