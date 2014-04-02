From: Mike Hommey <mh@glandium.org>
Subject: Re: fast-import deltas
Date: Wed, 2 Apr 2014 13:13:46 +0900
Message-ID: <20140402041346.GB15690@glandium.org>
References: <20140401102554.GA32231@glandium.org>
 <20140401114502.GA15549@sigill.intra.peff.net>
 <20140401130703.GA1479@glandium.org>
 <20140401131512.GA19321@sigill.intra.peff.net>
 <A0BF7D05-E351-4A5B-8F0F-DD0FAD391656@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Thu Apr 03 12:35:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WVeI6-0006sp-0k
	for gcvg-git-2@plane.gmane.org; Thu, 03 Apr 2014 11:50:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754482AbaDBENx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Apr 2014 00:13:53 -0400
Received: from ks3293202.kimsufi.com ([5.135.186.141]:50324 "EHLO
	zenigata.glandium.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754218AbaDBENw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Apr 2014 00:13:52 -0400
Received: from glandium by zenigata.glandium.org with local (Exim 4.82)
	(envelope-from <glandium@glandium.org>)
	id 1WVCYc-0004Cw-G0; Wed, 02 Apr 2014 13:13:46 +0900
Content-Disposition: inline
In-Reply-To: <A0BF7D05-E351-4A5B-8F0F-DD0FAD391656@quendi.de>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245685>

On Wed, Apr 02, 2014 at 01:29:13AM +0200, Max Horn wrote:
> 
> On 01.04.2014, at 15:15, Jeff King <peff@peff.net> wrote:
> 
> > On Tue, Apr 01, 2014 at 10:07:03PM +0900, Mike Hommey wrote:
> > 
> >>> For my own curiosity, how does this differ from what is in
> >>> contrib/remote-helpers/git-remote-hg?
> >> 
> >> contrib/remote-helpers/git-remote-hg does a local mercurial clone
> >> before doing the git conversion. While this is not really a problem
> >> for most mercurial projects, it tends to be slow with big ones,
> >> like the firefox source code. What I'm aiming at is something that
> >> can talk directly to a remote mercurial server.
> > 
> > Ah, that makes sense. Thanks for explaining.
> 
> 
> Hm, myself, I am not quite convinced. Yes, there is an overhead, but
> it is one-time (well, the space overhead is not, but Mike only
> mentioned time, not space).

I didn't mention it, but it definitely is a factor. As for the
performance factor, it certainly is more than a one-time overhead.

> I wonder if it is really worth the effort
> to start yet another project on this... Moreover, I don't see a
> fundamental reason why one could not modify git-remote-hg to work this
> way.

The way git-remote-hg works is fundamentally different to how one can
directly get and push stuff to a remote mercurial server. As such, there
is not much value in the current git-remote-hg code for that purpose.
Also, I'm currently prototyping something to see whether what I think
should work really works. Starting from the current git-remote-hg code
would add useless constraints to the prototype.

Mike
