From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC] Allow curl to rewind the RPC read buffer at any
 time
Date: Wed, 2 Dec 2009 11:32:43 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912021130300.5582@cone.home.martin.st>
References: <25718488.post@talk.nabble.com>  <20091127234110.7b7e9993.rctay89@gmail.com>  <alpine.DEB.2.00.0912011208160.5582@cone.home.martin.st>  <alpine.DEB.2.00.0912011236360.5582@cone.home.martin.st>  <20091201161428.GC21299@spearce.org> 
 <alpine.DEB.2.00.0912011914270.30348@tvnag.unkk.fr> <be6fef0d0912011803u2ec9ab1bsa167cf59de4dd47c@mail.gmail.com> <alpine.DEB.2.00.0912021011430.19179@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	Nicholas Miell <nmiell@gmail.com>, gsky51@gmail.com,
	Clemens Buchacher <drizzd@aon.at>,
	Mark Lodato <lodatom@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Wed Dec 02 10:32:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFlZx-0008PP-U4
	for gcvg-git-2@lo.gmane.org; Wed, 02 Dec 2009 10:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753546AbZLBJcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Dec 2009 04:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753485AbZLBJcq
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Dec 2009 04:32:46 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:39193 "EHLO jenni2.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753431AbZLBJcp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Dec 2009 04:32:45 -0500
Received: from [88.193.196.75] (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4A7770910478B288; Wed, 2 Dec 2009 11:32:49 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <alpine.DEB.2.00.0912021011430.19179@tvnag.unkk.fr>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134318>

On Wed, 2 Dec 2009, Daniel Stenberg wrote:

> On Wed, 2 Dec 2009, Tay Ray Chuan wrote:
> 
> > According to Martin, Expect: 100-continue is not working due to libcurl.
> 
> Right, that is/was a bug in how libcurl behaves when the application itself
> has set the "Expect: 100-continue" header. Martin has provided a fix for that
> for the next libcurl version though, but that won't make a lot of existing
> users happy.
> 
> Thinking about this particular problem, what is the motivation for git to
> forcily add that header in the first place? I mean, libcurl does add the
> header by itself when it thinks it is necessary and then it handles it
> correctly.

As far as I saw, the reason for it being manually added is that curl 
actually didn't add it automatically in that case. That was the reason for 
the second patch/rfc thread that I sent to curl-library (where postsize == 
0, as in unknown, didn't trigger the addition of any Expect header).

// Martin
