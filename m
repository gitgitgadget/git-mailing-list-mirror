From: Mike Hommey <mh@glandium.org>
Subject: Re: git status in clean working dir
Date: Tue, 22 Jul 2008 08:18:07 +0200
Organization: glandium.org
Message-ID: <20080722061807.GA6714@glandium.org>
References: <0ttzeirft8.wl%bremner@pivot.cs.unb.ca> <7vy73ur6pz.fsf@gitster.siamese.dyndns.org> <7vtzeir68z.fsf@gitster.siamese.dyndns.org> <20080722044157.GA20787@sigill.intra.peff.net> <20080722053921.GA4983@glandium.org> <20080722060643.GA25023@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Bremner <bremner@unb.ca>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jul 22 08:19:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLBDl-0007k6-9d
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 08:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753869AbYGVGSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 02:18:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752073AbYGVGSX
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 02:18:23 -0400
Received: from vuizook.err.no ([194.24.252.247]:49074 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751958AbYGVGSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 02:18:22 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KLBCE-0002aX-97; Tue, 22 Jul 2008 08:18:08 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KLBCJ-0001nj-5Z; Tue, 22 Jul 2008 08:18:07 +0200
Content-Disposition: inline
In-Reply-To: <20080722060643.GA25023@sigill.intra.peff.net>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89445>

On Tue, Jul 22, 2008 at 02:06:43AM -0400, Jeff King wrote:
> On Tue, Jul 22, 2008 at 07:39:21AM +0200, Mike Hommey wrote:
> 
> > > This marks diff-files as FORBID_PAGER; I will leave it to others to
> > > fight about which commands should have it. But it doesn't make sense to
> > > mark "status" since some people obviously _want_ the paging there.
> > 
> > Why not "simply" forbid the pager when output is not a terminal ?
> 
> We already do that (see pager.c:53). The original poster still had a
> problem, but I don't know if it was for actual usage or simply a toy
> 
>   $ git status
>   $ echo $?
>   $ echo "why don't exit codes work in status?" | mail git@vger
> 
> question.

As you said in another branch of the thread, this part would be solved by
having parent/child being reverted.

Now, for the case where diff-files can have a pager if the user shoots
himself in the foot, if the output is not a terminal and pager.c already
does the right thing, I don't see where diff-files having a pager will
be a problem.

If diff-files' output is a terminal, it's obviously intended to be
displayed, be it in a script or not. But most of the time, its output
will be piped, thus not triggering the pager anyways.

And for diff-files' exit code, well, see the first paragraph.

Mike
