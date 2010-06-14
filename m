From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git.pm: better error message
Date: Mon, 14 Jun 2010 03:10:46 -0400
Message-ID: <20100614071046.GA5639@sigill.intra.peff.net>
References: <1276477222-21465-1-git-send-email-book@cpan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: "Philippe Bruhat (BooK)" <book@cpan.org>
X-From: git-owner@vger.kernel.org Mon Jun 14 09:10:58 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OO3ov-0002Rt-Uj
	for gcvg-git-2@lo.gmane.org; Mon, 14 Jun 2010 09:10:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436Ab0FNHKv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jun 2010 03:10:51 -0400
Received: from peff.net ([208.65.91.99]:36639 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755420Ab0FNHKv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jun 2010 03:10:51 -0400
Received: (qmail 15331 invoked by uid 107); 14 Jun 2010 07:11:03 -0000
Received: from adsl-99-133-187-56.dsl.bltnin.sbcglobal.net (HELO sigill.intra.peff.net) (99.133.187.56)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 14 Jun 2010 03:11:03 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Jun 2010 03:10:46 -0400
Content-Disposition: inline
In-Reply-To: <1276477222-21465-1-git-send-email-book@cpan.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149080>

On Mon, Jun 14, 2010 at 03:00:22AM +0200, Philippe Bruhat (BooK) wrote:

> -d doesn't set $! if the directory doesn't exist

Really?

  $ perl -e '-d "bogus" or die "fail: $!"'
  fail: No such file or directory at -e line 1.

On the other hand:

  $ touch file
  perl -e '-d "file" or die "fail: $!"'
  fail:  at -e line 1.

So perhaps it is best not to rely on $!. Also, this is with perl 5.10.
Is it different with other versions?

-Peff
