From: Jeff King <peff@peff.net>
Subject: Re: Bad objects error since upgrading GitHub servers to 1.6.1
Date: Wed, 28 Jan 2009 13:16:19 -0500
Message-ID: <20090128181619.GG8863@coredump.intra.peff.net>
References: <20090128020220.GE1321@spearce.org> <7v3af4yvmu.fsf@gitster.siamese.dyndns.org> <20090128033020.GF1321@spearce.org> <7v1vuoxcxk.fsf@gitster.siamese.dyndns.org> <20090128044150.GI1321@spearce.org> <7vd4e7x5ov.fsf@gitster.siamese.dyndns.org> <20090128075515.GA1133@coredump.intra.peff.net> <7vfxj3vos2.fsf@gitster.siamese.dyndns.org> <20090128081745.GA2172@coredump.intra.peff.net> <20090128161652.GK1321@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	PJ Hyett <pjhyett@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jan 28 19:18:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LSEzN-0004rV-Ag
	for gcvg-git-2@gmane.org; Wed, 28 Jan 2009 19:18:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965AbZA1SQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2009 13:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753389AbZA1SQW
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Jan 2009 13:16:22 -0500
Received: from peff.net ([208.65.91.99]:37885 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752979AbZA1SQV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2009 13:16:21 -0500
Received: (qmail 24447 invoked by uid 107); 28 Jan 2009 18:16:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Wed, 28 Jan 2009 13:16:30 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2009 13:16:19 -0500
Content-Disposition: inline
In-Reply-To: <20090128161652.GK1321@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107558>

On Wed, Jan 28, 2009 at 08:16:53AM -0800, Shawn O. Pearce wrote:

> > But what is more important is that your repository _is_ corrupted,
> 
> Depends.  If the SHA-1 came from the remote side during send-pack,

Sorry, there is a critical typo in there. I meant to say "_if_ your
repository is corrupted" (and I have no idea how I ended up not only
omitting a word, but emphasizing the wrong one, so I can only suspect
the typo was in my brain and not my fingers).

So basically I agree with everything you said.

> Yup, I agree.  But as you and Junio have already pointed out, C Git
> can miss some types of corruption because the revision machinary has
> some gaps.  *sigh*
> 
> I'd really like to see those gaps closed.  But I don't have a good
> enough handle on the code structure of the C Git revision machinary
> to do that myself in a short period of time.  I know JGit's well...
> but that's only because I wrote it.  ;-)

I would like to see them closed, too. But keep in mind that this may
actually be a harder form of corruption to achieve than something like
just flipping some bits. Once the objects are in a packfile, you are
unlikely to lose a single or a small number of objects. But like with
any type of corruption, it is infrequent enough that it is hard to say
which is more common or "worse".

-Peff
