From: Jeff King <peff@peff.net>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 17:14:30 -0500
Message-ID: <20091214221430.GA14158@coredump.intra.peff.net>
References: <1260822484.9379.53.camel@localhost>
 <20091214211142.GC9364@coredump.intra.peff.net>
 <1260825629.9379.56.camel@localhost>
 <20091214212343.GA11131@coredump.intra.peff.net>
 <1260827790.9379.59.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Eric Paris <eparis@redhat.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:14:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKJBj-0003GB-Jd
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 23:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758577AbZLNWOi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 17:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758565AbZLNWOi
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 17:14:38 -0500
Received: from peff.net ([208.65.91.99]:33529 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758556AbZLNWOh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 17:14:37 -0500
Received: (qmail 15188 invoked by uid 107); 14 Dec 2009 22:19:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 14 Dec 2009 17:19:09 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Dec 2009 17:14:30 -0500
Content-Disposition: inline
In-Reply-To: <1260827790.9379.59.camel@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135248>

On Mon, Dec 14, 2009 at 04:56:30PM -0500, Eric Paris wrote:

> So I zipped up just .git   1.2G.  I did a make clean and zipped up the
> whole repo  1.3G.
> 
> Just started pushing the 1.3G file.
> 
> Maybe having a .git directory that large is the problem?

It could be, but I doubt it. If you have a lot of loose objects that
could make things slow due to the disk access, but it is not likely to
use that much CPU time (we do have to zlib uncompress more, but
still...70 minutes is a lot).

-Peff
