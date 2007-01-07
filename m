From: Christoph Hellwig <hch@infradead.org>
Subject: Re: How git affects kernel.org performance
Date: Sun, 7 Jan 2007 10:28:53 +0000
Message-ID: <20070107102853.GB26849@infradead.org>
References: <1166297434.26330.34.camel@localhost.localdomain> <1166304080.13548.8.camel@nigel.suspend2.net> <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net> <45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com> <Pine.LNX.4.64.0701062130260.3661@woody.osdl.org> <20070107085526.GR24090@1wt.eu> <45A0B63E.2020803@zytor.com> <20070107090336.GA7741@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>,
	webmaster@kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 11:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3VH8-0006Z3-FZ
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 11:29:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932480AbXAGK3J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 05:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932482AbXAGK3J
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 05:29:09 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:60211 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbXAGK3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 05:29:07 -0500
Received: from hch by pentafluge.infradead.org with local (Exim 4.63 #1 (Red Hat Linux))
	id 1H3VGn-0007JT-Gb; Sun, 07 Jan 2007 10:28:53 +0000
To: Willy Tarreau <w@1wt.eu>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Willy Tarreau <w@1wt.eu>, "H. Peter Anvin" <hpa@zytor.com>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	nigel@nigel.suspend2.net, "J.H." <warthog9@kernel.org>,
	Randy Dunlap <randy.dunlap@oracle.com>,
	Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
	kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Content-Disposition: inline
In-Reply-To: <20070107090336.GA7741@1wt.eu>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36149>

On Sun, Jan 07, 2007 at 10:03:36AM +0100, Willy Tarreau wrote:
> The problem is that I have no sufficient FS knowledge to argument why
> it helps here. It was a desperate attempt to fix the problem for us
> and it definitely worked well.

XFS does rather efficient btree directories, and it does sophisticated
readahead for directories.  I suspect that's what is helping you there.
