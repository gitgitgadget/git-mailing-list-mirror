From: Jeff King <peff@peff.net>
Subject: Re: A note from the maintainer: Follow-up questions (MaintNotes)
Date: Mon, 31 Aug 2009 22:55:04 -0400
Message-ID: <20090901025504.GA23589@coredump.intra.peff.net>
References: <ac3d41850908301519s2cf8a45auf11fb4c9285c0cb5@mail.gmail.com>
 <7v8wgzla02.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Chanters <david.chanters@googlemail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 04:55:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiJWj-0005H4-LF
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 04:55:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751650AbZIACzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 22:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbZIACzI
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 22:55:08 -0400
Received: from peff.net ([208.65.91.99]:43621 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750938AbZIACzH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 22:55:07 -0400
Received: (qmail 29873 invoked by uid 107); 1 Sep 2009 02:55:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Mon, 31 Aug 2009 22:55:19 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 22:55:04 -0400
Content-Disposition: inline
In-Reply-To: <7v8wgzla02.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127516>

On Mon, Aug 31, 2009 at 06:38:37PM -0700, Junio C Hamano wrote:

>     a71f64a Merge branch 'pk/import-dirs' into pu
>     ce6cd39 Merge branch 'jh/cvs-helper' into pu
>     ...
>     2178d02 Merge branch 'jc/log-tz' into pu
>     ...
>     927d129 Merge branch 'lt/approxidate' into jch
>     35ada54 Merge branch 'tr/reset-checkout-patch' into jch
>     d82f86c Merge branch 'db/vcs-helper' (early part) into jch
> 
> So if you for example happen to be interested in jc/log-tz topic,
> you would do something like:
> 
>     $ git checkout -b jc/log-tz 2178d02^2
>     $ git log -p master..
> 
> to check out, and view what changes the topic introduces.

Another alternative: Thomas Rast wrote a handy script called
'git-resurrect' which does this for you. It's carried in the contrib/
section right now. I used it just the other day to pull out the
lt/approxidate topic branch, which I then built some follow-up patches
for. Usage is something like:

  # contrib scripts aren't installed by "make install",
  # so put it somewhere in your PATH
  $ cp contrib/git-resurrect.sh ~/bin/git-resurrect

  $ git resurrect -m lt/approxidate
  ** Candidates for lt/approxidate **
  931e8e2 [22 hours ago] fix approxidate parsing of relative months and years
  ** Restoring lt/approxidate to 931e8e2 fix approxidate parsing of relative months and years

-Peff
