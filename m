From: Jeff King <peff@peff.net>
Subject: Re: cherry picking changesets instead of commits
Date: Wed, 28 May 2008 20:12:17 -0400
Message-ID: <20080529001216.GA17938@sigill.intra.peff.net>
References: <7f9d599f0805281106w746a0469u6c483d64cf75b823@mail.gmail.com> <7v1w3muw8j.fsf@gitster.siamese.dyndns.org> <190C4133-35C9-4CE0-816B-603B8F661A56@gmail.com> <7vod6qtgfs.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281242w5769a100s1153c2101992ff55@mail.gmail.com> <7v3ao2tawd.fsf@gitster.siamese.dyndns.org> <7f9d599f0805281414x6b97070ag7a1cc36f5d3c5a36@mail.gmail.com> <20080528223858.GA15107@sigill.intra.peff.net> <20080528224819.GA15252@sigill.intra.peff.net> <7vbq2qrni6.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Geoffrey Irving <irving@naml.us>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 29 02:13:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1VlV-0002xa-Cs
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 02:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbYE2AMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 20:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751829AbYE2AMU
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 20:12:20 -0400
Received: from peff.net ([208.65.91.99]:2562 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755453AbYE2AMT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 20:12:19 -0400
Received: (qmail 5210 invoked by uid 111); 29 May 2008 00:12:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 28 May 2008 20:12:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 May 2008 20:12:17 -0400
Content-Disposition: inline
In-Reply-To: <7vbq2qrni6.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83155>

On Wed, May 28, 2008 at 04:56:49PM -0700, Junio C Hamano wrote:

> First a bit offtopic to avoid duplicated work.  Please nobody waste your
> time sending s/See Also/SEE ALSO/ clean-up patch.  I've done that already.

It is much more widespread than that. We are very inconsistent with
section title capitalization. For man pages, it doesn't matter; asciidoc
makes them all upper case. However, they end up inconsistent in the html
versions. So if we care about this, then probably everything should be
fixed.

You can get a rough idea with:

  $ cd Documentation && perl -ne '
      print "$ARGV:$last" if
        /^-+$/ &&
        length == length($last) &&
        $last =~ /[a-z]/;
      $last = $_;
    ' git-*.txt

> Now, I do not think it is customary to say anything but the name of the
> manual page if you refer to one in SEE ALSO section.  I am wondering if we
> would want to remove the three-liner for consistency (but haven't done so,
> neither the short description of qgit and others in gitk manual page is
> gone yet).

It isn't how most of the pages are, but I think it is actually helpful.
And it's not as if "SEE ALSO" contents are supposed to be machine
parsable.

Though if the _reason_ that one needs to "see also" is not obvious,
perhaps it is better as part of the text of a different section (OTOH, I
think Geoffrey's patch was in response to your request to put it in the
"SEE ALSO").

-Peff
