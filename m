From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Sun, 6 Jun 2010 18:08:00 -0400
Message-ID: <20100606220800.GD6993@coredump.intra.peff.net>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <4C08AD75.6040307@drmicha.warpmail.net>
 <7vfx10yfmn.fsf@alter.siamese.dyndns.org>
 <201006061101.02156.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Jun 07 00:08:10 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OLO0n-0003Ej-P7
	for gcvg-git-2@lo.gmane.org; Mon, 07 Jun 2010 00:08:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755309Ab0FFWIE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 18:08:04 -0400
Received: from peff.net ([208.65.91.99]:56963 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754396Ab0FFWID (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 18:08:03 -0400
Received: (qmail 12410 invoked by uid 107); 6 Jun 2010 22:08:11 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Jun 2010 18:08:11 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Jun 2010 18:08:00 -0400
Content-Disposition: inline
In-Reply-To: <201006061101.02156.j6t@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148550>

On Sun, Jun 06, 2010 at 11:01:02AM +0200, Johannes Sixt wrote:

> > Peff uses --textconv to show changes to the exif information on his
> > photo collections.  If he has any symlinks, and if he finds that
> > removal of "\No newline" is a regression and not an improvement,
> > what recourse does your patch give him?  Saying --no-textconv to
> > work around that regression is not a solution, isn't it?
> 
> Oh, I'm pretty sure that Peff wouldn't use --textconv on his
> repository if he cared that diffs contained complete reproducible
> information.

How did my name get dragged into this? ;P

No, I wouldn't use textconv if I cared that my diffs contained complete
reproducible information. But I think Junio's point is that the presence
of that information is valuable to some users to read, regardless of
applying patches. That is, I took his message to mean that he would want
to have this feature off, even for human viewing of the diff. And there
would be no way to turn off this feature, but not textconv.

I don't necessarily agree with that; I don't personally care when
viewing a symlink diff whether that line is there or not. But if there
are people who do, then you have left them with no way out.

-Peff
