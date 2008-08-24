From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] allow user aliases for the --author parameter
Date: Sun, 24 Aug 2008 13:21:46 -0400
Message-ID: <20080824172145.GA25553@coredump.intra.peff.net>
References: <g8jbvd$18k$1@ger.gmane.org> <20080821200255.GB27705@coredump.intra.peff.net> <48AE786C.20201@fastmail.fm> <20080822165047.GA3339@sigill.intra.peff.net> <7vzln492pc.fsf@gitster.siamese.dyndns.org> <8F4F767F-3D7B-4358-AAD3-8E2BC7EA108D@simplicidade.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <michaeljgruber+gmane@fastmail.fm>,
	Alex Riesen <fork0@users.sourceforge.net>, git@vger.kernel.org
To: Pedro Melo <melo@simplicidade.org>
X-From: git-owner@vger.kernel.org Sun Aug 24 19:23:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJIl-00089L-ER
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:22:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYHXRVt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751992AbYHXRVt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:21:49 -0400
Received: from peff.net ([208.65.91.99]:2880 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751752AbYHXRVs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:21:48 -0400
Received: (qmail 12579 invoked by uid 111); 24 Aug 2008 17:21:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 24 Aug 2008 13:21:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 24 Aug 2008 13:21:46 -0400
Content-Disposition: inline
In-Reply-To: <8F4F767F-3D7B-4358-AAD3-8E2BC7EA108D@simplicidade.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93534>

On Sun, Aug 24, 2008 at 10:19:20AM +0100, Pedro Melo wrote:

>>         one = "!sh -c 'git show -s --pretty=\"format:%h (%s, %ai\"  
>> \"$@\" | sed -e \"s/ [012][0-9]:[0-5][0-9]:[0-5][0-9] [-+][0-9][0-9] 
>> [0-9][0-9]$/)/\"' -"
>
> Can you explain this one? It seems a bit like git describe, but it misses 
> a single char at the beggining?
>
> git (master) $ git one
> 2ebc02d (Start 1.6.1 cycle, 2008-08-17)
>
> git (master) $ git describe
> v1.6.0-2-g2ebc02d

The 'g' character is not part of the sha1, but just a prefix used by git
describe. The point of this alias is to refer (in email or other
writing) to commits. Obviously just the sha1 would be sufficient, but
the subject and date of the commit gives the reader some context without
them having to plug it into git-show.

-Peff
