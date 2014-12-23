From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] is_hfs_dotgit: loosen over-eager match of \u{..47}
Date: Tue, 23 Dec 2014 16:09:28 -0500
Message-ID: <20141223210928.GA13304@peff.net>
References: <20141223084536.GA25190@peff.net>
 <20141223201416.GA29365@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 23 22:09:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3Whx-0005Eh-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 23 Dec 2014 22:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbaLWVJ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2014 16:09:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:56800 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751078AbaLWVJ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2014 16:09:29 -0500
Received: (qmail 20449 invoked by uid 102); 23 Dec 2014 21:09:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 15:09:29 -0600
Received: (qmail 24136 invoked by uid 107); 23 Dec 2014 21:09:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 23 Dec 2014 16:09:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2014 16:09:28 -0500
Content-Disposition: inline
In-Reply-To: <20141223201416.GA29365@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261774>

On Tue, Dec 23, 2014 at 12:14:16PM -0800, Jonathan Nieder wrote:

> > +++ b/t/t1450-fsck.sh
> [...]
> > +		git fsck 2>err &&
> > +		cat err &&
> > +		! test -s err
> 
> Nit: if this said
> 
> 		test_line_count = 0 err
> 
> then the error message would be more obvious when it fails with
> --verbose.

Thanks, I actually considered adding a "test_file_is_empty" for that
reason, but empty line-count does the same thing.

-Peff
