From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: git fetch -v not at all verbose?
Date: Thu, 21 Jan 2010 18:47:39 +0100
Message-ID: <201001211847.40003.trast@student.ethz.ch>
References: <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com> <20100121165737.GG19078@spearce.org> <20100121173010.GB16707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 18:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NY18F-0004Pg-C8
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 18:47:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753647Ab0AURrn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 12:47:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751673Ab0AURrn
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 12:47:43 -0500
Received: from gwse.ethz.ch ([129.132.178.237]:16443 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273Ab0AURrm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 12:47:42 -0500
Received: from CAS00.d.ethz.ch (129.132.178.234) by gws00.d.ethz.ch
 (129.132.178.237) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 21 Jan
 2010 18:47:41 +0100
Received: from thomas.localnet (129.132.153.233) by mail.ethz.ch
 (129.132.178.227) with Microsoft SMTP Server (TLS) id 8.2.213.0; Thu, 21 Jan
 2010 18:47:40 +0100
User-Agent: KMail/1.13.0 (Linux/2.6.31.8-0.1-desktop; KDE/4.4.59; x86_64; ; )
In-Reply-To: <20100121173010.GB16707@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137677>

On Thursday 21 January 2010 18:30:10 Michael S. Tsirkin wrote:
> On Thu, Jan 21, 2010 at 08:57:37AM -0800, Shawn O. Pearce wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > Hmm, no, but what is true is that I fetched several remotes
> > > that diverged significantly into the same local repository.
> > > Would that have same effect?
[...]
> > Hmm.  I wonder if we should try to shortcut the commit walking in
> > a case like this and just feed the tracking branches we already have.
> 
> Or for the case of 1,000s of commits ahead, git could try to implement a
> heuristic to reduce the number of commits sent. Currently all commits
> are sent in order, correct?  How about binary search like what git
> bisect does?

I had a patch for this ages ago (that combines exponential-stride
backwards search and later bisection), but it was shot down on grounds
of not working at times and code convolution and I forgot about it...

I can give this another shot, but it seems most of the code has moved
due to the transport handlers changes, so I'll first have to read into
it again.

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
