From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Please support add -p with a new file, to add only part of the
 file
Date: Tue, 10 Jan 2012 14:29:26 -0800
Message-ID: <20120110222926.GB14895@leaf>
References: <20120109105134.1239.39047.reportbug@leaf>
 <20120109204721.GC23825@burratino>
 <87ty43fy7f.fsf@thomas.inf.ethz.ch>
 <7vpqer9znv.fsf@alter.siamese.dyndns.org>
 <20120110183833.GA15787@sigill.intra.peff.net>
 <7vd3ar9wto.fsf@alter.siamese.dyndns.org>
 <20120110193857.GA19665@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Wincent Colaiuta <win@wincent.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 10 23:29:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkkCL-0007AJ-4s
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 23:29:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756609Ab2AJW3i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 17:29:38 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:50195 "EHLO
	relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755920Ab2AJW3g (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 17:29:36 -0500
X-Originating-IP: 217.70.178.136
Received: from mfilter7-d.gandi.net (mfilter7-d.gandi.net [217.70.178.136])
	by relay3-d.mail.gandi.net (Postfix) with ESMTP id 8423EA8075;
	Tue, 10 Jan 2012 23:29:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at mfilter7-d.gandi.net
Received: from relay3-d.mail.gandi.net ([217.70.183.195])
	by mfilter7-d.gandi.net (mfilter7-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 8WbtGtFoNuni; Tue, 10 Jan 2012 23:29:34 +0100 (CET)
X-Originating-IP: 50.43.15.19
Received: from leaf (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id B3223A806E;
	Tue, 10 Jan 2012 23:29:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20120110193857.GA19665@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188297>

On Tue, Jan 10, 2012 at 02:38:57PM -0500, Jeff King wrote:
> On Tue, Jan 10, 2012 at 11:33:39AM -0800, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > >> Even if you start with "add -N", there won't be individual "hunks" you can
> > >> pick and choose from diffing emptiness and the whole new file, so you end
> > >> up using "edit hunk" interface.
> > >
> > > I don't think the main impetus for this is that people necessarily want
> > > to pick and choose hunks from added files.
> > 
> > Well, read the subject of your e-mail and tell me what it says ;-)
> 
> Heh. Oops.
> 
> Yes, I agree that "add -p" is not especially useful for that case, and
> the workflow I was describing is very different[1].

I've gotten used to editing diffs directly, and when I just want to
include subsets of a file on a chunk-by-chunk basis (for instance, one
new function but not another new function), I'd find it a lot easier and
less error-prone to "git add -p newfile" and edit a diff than to copy
the file aside, edit the original to delete pieces I don't want, add,
commit, and copy the file back.

Most importantly, I want to use "git add -p" because I know it'll
*never* modify my working copy, only the index.  I find that a useful
safety property.

Apart from that, it also means I have less mental state to track
("remember to copy the original file back later").

- Josh Triplett
