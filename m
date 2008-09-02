From: Jeff King <peff@peff.net>
Subject: Re: pack count on repo.or.cz
Date: Mon, 1 Sep 2008 21:56:37 -0400
Message-ID: <20080902015637.GA14765@coredump.intra.peff.net>
References: <7vsksjsbcc.fsf@gitster.siamese.dyndns.org> <20080902000037.GA11869@coredump.intra.peff.net> <20080902010410.GI10360@machine.or.cz> <20080902011433.GA12682@coredump.intra.peff.net> <7vod37s4hz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 03:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaLA3-0008HB-GU
	for gcvg-git-2@gmane.org; Tue, 02 Sep 2008 03:58:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbYIBB4l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 21:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752373AbYIBB4k
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 21:56:40 -0400
Received: from peff.net ([208.65.91.99]:4459 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271AbYIBB4k (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 21:56:40 -0400
Received: (qmail 10077 invoked by uid 111); 2 Sep 2008 01:56:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 01 Sep 2008 21:56:39 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Sep 2008 21:56:37 -0400
Content-Disposition: inline
In-Reply-To: <7vod37s4hz.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94640>

On Mon, Sep 01, 2008 at 06:47:36PM -0700, Junio C Hamano wrote:

> Hmm, I am slightly worried about doing so might defeat the whole point of
> making the sample repository a separate one from git.git hosted there.
> 
> The reason it is not a branch in git.git is because I did not want to
> contaminate the official git.git repository with commit objects in tree
> objects (aka gitlinks); it would deny access to clients older than 1.5.2.

Hrm. I had assumed they wouldn't be a problem because nothing actually
_referenced_ them, but I suppose it would break git-fsck on such
systems.

Anyway, I think "git repack -A" is a better solution (and presumably
there is some magic on the pruning end to make sure forks do the right
thing with loose objects).

-Peff
