From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Dec 2008, #03; Sun, 21)
Date: Tue, 23 Dec 2008 12:34:40 -0500
Message-ID: <20081223173438.GA25699@coredump.intra.peff.net>
References: <7vr641pvid.fsf@gitster.siamese.dyndns.org> <20081223120534.GA21633@coredump.intra.peff.net> <alpine.DEB.1.00.0812231725270.30769@pacific.mpi-cbg.de> <20081223163811.GA25658@coredump.intra.peff.net> <alpine.DEB.1.00.0812231746250.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 23 18:36:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LFBAq-0000SV-Pj
	for gcvg-git-2@gmane.org; Tue, 23 Dec 2008 18:36:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751120AbYLWReq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Dec 2008 12:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbYLWReq
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Dec 2008 12:34:46 -0500
Received: from peff.net ([208.65.91.99]:3067 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751012AbYLWReq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Dec 2008 12:34:46 -0500
Received: (qmail 3340 invoked by uid 111); 23 Dec 2008 17:34:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 23 Dec 2008 12:34:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 23 Dec 2008 12:34:41 -0500
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0812231746250.30769@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103836>

On Tue, Dec 23, 2008 at 05:52:54PM +0100, Johannes Schindelin wrote:

> However, note that without something like core.notesref you will never be 
> able to have private and public notes.
> 
> And I very much want to have private notes _and_ public notes on the very 
> same commits of the very same branches.

Right. I think core.notesref doesn't go far enough, because it doesn't
provide a way to talk about notes from two sources at the same time.
Like:

  git log --pretty=format:'%N(my-private-notes:foo) %N(public-notes:bar)'

> I just wanted to fiddle a little bit with profiling, as I really do not 
> understand why the new notes perform that badly against the old notes, 
> even allowing for reading a complete, possibly huge tree into a hashmap.

I haven't looked closely at the latest series yet, so I can't comment.

> And while I am almost sure that there is a stupid bug lurking that will 
> kick the performance again, I think the basic design is sound, and it 
> should be easy to modify no matter which way you want to change the 
> behavior with regards to trees/blobs or refs.

I agree that the data structure is sound, so I can probably work on top
of what you posted, too. I was planning on doing git-notes in C, though.

-Peff
