From: Jeff King <peff@peff.net>
Subject: Re: merge, keeping the remote as a new file?
Date: Mon, 2 Mar 2009 01:45:19 -0500
Message-ID: <20090302064519.GA5635@coredump.intra.peff.net>
References: <81bfc67a0903011616w32ebdad9ofc096f5d1fd3174a@mail.gmail.com> <20090302041113.GA3094@coredump.intra.peff.net> <20090302063604.GA17245@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Mon Mar 02 07:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Le1vT-0003js-92
	for gcvg-git-2@gmane.org; Mon, 02 Mar 2009 07:46:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755535AbZCBGpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Mar 2009 01:45:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZCBGpY
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Mar 2009 01:45:24 -0500
Received: from peff.net ([208.65.91.99]:47651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752253AbZCBGpX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Mar 2009 01:45:23 -0500
Received: (qmail 4124 invoked by uid 107); 2 Mar 2009 06:45:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 02 Mar 2009 01:45:21 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 02 Mar 2009 01:45:19 -0500
Content-Disposition: inline
In-Reply-To: <20090302063604.GA17245@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111904>

On Mon, Mar 02, 2009 at 06:36:04AM +0000, Charles Bailey wrote:

> You can use git checkout-index --temp --stage=3 and then move it from
> the auto-generated temporary name into its new place.

Hmm. I was hoping there was something that would use the name "--theirs"
instead of the mysterious "stage level 3". But it's still nicer than the
"git show" I gave because of:

> Using a checkout variant instead of a show or a cat-file might be
> important if you are doing autocrlf or some other smudging.

Right. For some reason I was thinking that cat-file did not handle this
but "git show" did, but I just tested and it clearly doesn't. So yes,
you should definitely use checkout-index if you care about conversions.

-Peff
