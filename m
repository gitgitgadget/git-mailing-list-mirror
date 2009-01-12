From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH EGIT Allow for git config to not error when lines have
	'/r' in them.]
Date: Mon, 12 Jan 2009 09:10:45 -0800
Message-ID: <20090112171045.GI10179@spearce.org>
References: <142772020901071910ha95d53fo2454f8685908338c@mail.gmail.com> <200901102134.05652.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ryan Alberts <ralberts@gmail.com>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 18:12:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMQKf-0002uH-4l
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 18:12:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755416AbZALRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 12:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755419AbZALRKs
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 12:10:48 -0500
Received: from george.spearce.org ([209.20.77.23]:48421 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752235AbZALRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 12:10:48 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id E301838210; Mon, 12 Jan 2009 17:10:45 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200901102134.05652.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105357>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> torsdag 08 januari 2009 04:10:05 skrev Ryan Alberts:
> > I have attached a small fix for when a git config has /r lines in the file.
> > I have to admit that I do not usually submit patches to the open source
> > community and I am not very familiar with the process :-)  Please, please,
> > let me know if I can do something different next time!
> 
> Back to the patch. I think we should only ignore \r (not /r, but could say CR in
> a comment) before an LF. 

I disagree; ignoring CR anyplace in the file should be fine, unless
it is within a double quoted value, in which case it should use
the same rule that \n would use within the same region.

' ', \n, \t all act the same with regards to being (mostly) ignored
whitespace.  \r is no different.  Especially for anyone crazy enough
to still be using a Mac style formatted file, with only CRs in it.

-- 
Shawn.
