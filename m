From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] Allow git to use any HTTP authentication method.
Date: Mon, 28 Dec 2009 17:50:12 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912281745540.5582@cone.home.martin.st>
References: <200912281154.09442.lenaic@lhuard.fr.eu.org> <alpine.DEB.2.00.0912281406210.5582@cone.home.martin.st> <be6fef0d0912280412w58401f10n972f9198144cd580@mail.gmail.com> <20091228153701.GA2252@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	L?na?c Huard <lenaic@lhuard.fr.eu.org>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Dec 28 16:53:56 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPHur-000764-RA
	for gcvg-git-2@lo.gmane.org; Mon, 28 Dec 2009 16:53:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbZL1Puv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Dec 2009 10:50:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbZL1Puu
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Dec 2009 10:50:50 -0500
Received: from mta-out.inet.fi ([195.156.147.13]:39355 "EHLO jenni1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbZL1Puu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Dec 2009 10:50:50 -0500
Received: from [88.193.196.75] (88.193.196.75) by jenni1.inet.fi (8.5.014)
        id 4B17DDDA00F8C7CD; Mon, 28 Dec 2009 17:50:41 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20091228153701.GA2252@spearce.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135742>

On Mon, 28 Dec 2009, Shawn O. Pearce wrote:

> Uh, stupid question, but why must we enable this option?  I don't
> have to enable something in my browser before I use digest auth to
> visit a website, why do I need to enable it in git?
> 
> How does one use git clone with an http:// URL with digest
> authentication?  Its not obvious to the user that you would need
> to first export an obtuse environment variable to get something
> that should Just Work(tm).
> 
> Yes, I realize you may need to perform an extra HTTP request to
> start the transaction, but why aren't we doing that?  Isn't it only
> 1 additional request to discover the desired authentication method?

Initially when I added support for this, curl sessions weren't reused, so 
every single request had to be duplicated if authentication was used, 
adding quite a bit of overhead.

Now that sessions are reused properly, I tend to agree that this should be 
enabled automatically.

Any other opinions on this, Tay or Junio?

Should I send in a new patch that removes the http.authAny option and 
always enables this, or send a rewritten version of the patch that already 
is in 'next'?

// Martin
