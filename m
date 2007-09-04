From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Calculating tree nodes
Date: Tue, 4 Sep 2007 11:33:36 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709041131030.28586@racer.site>
References: <9e4733910709031913q278cb9dbp441756afb28607c6@mail.gmail.com> 
 <20070904025153.GS18160@spearce.org>  <9e4733910709032026s7f94eed9h25d5165840cc38d2@mail.gmail.com>
  <Pine.LNX.4.64.0709040439070.28586@racer.site> 
 <9e4733910709032054y4407ce62o6b21935502bfacdb@mail.gmail.com> 
 <46a038f90709032121v54454c6fi500ee15497eec85c@mail.gmail.com>
 <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 04 12:34:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISVjG-0002DD-KT
	for gcvg-git@gmane.org; Tue, 04 Sep 2007 12:33:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860AbXIDKdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 4 Sep 2007 06:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752535AbXIDKdu
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Sep 2007 06:33:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:33744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752521AbXIDKdt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Sep 2007 06:33:49 -0400
Received: (qmail invoked by alias); 04 Sep 2007 10:33:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 04 Sep 2007 12:33:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19dKKsn2x5d3HziRH2fxDWN9XYOcWOSaV41AtaOf7
	UeDrcOYa6Fm43L
X-X-Sender: gene099@racer.site
In-Reply-To: <9e4733910709032237y65ccafdai4889078533908fb0@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57546>

Hi,

On Tue, 4 Sep 2007, Jon Smirl wrote:

> In my scheme the path info is moved into the file object nodes and the 
> SHA list is in the commit node.

And how should this "SHA list" be any different from a single tree object, 
except that you now merge it with the commit object?

Really, go back to the mail Martin mentioned.  Having all objects in one 
list kills performance.

> Diffing two trees in the scheme is quite fast. Just get their commit
> objects into RAM and compare the lists of SHAs.

No, it is not fast.  Just loading the complete list into RAM is likely 
much, much slower than a simple diff _right_ _now_.

Hth,
Dscho
