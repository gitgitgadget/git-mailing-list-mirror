From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH EGIT Allow for git config to not error when lines have '/r' in them.]
Date: Mon, 12 Jan 2009 23:53:19 +0100
Message-ID: <200901122353.19408.robin.rosenberg.lists@dewire.com>
References: <142772020901071910ha95d53fo2454f8685908338c@mail.gmail.com> <200901102134.05652.robin.rosenberg@dewire.com> <20090112171045.GI10179@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Ryan Alberts <ralberts@gmail.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 12 23:55:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMVgH-0007qT-9S
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 23:54:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759910AbZALWx1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 17:53:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758429AbZALWxZ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 17:53:25 -0500
Received: from mail.dewire.com ([83.140.172.130]:28496 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759099AbZALWxW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 17:53:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id DBB0E147E5AC;
	Mon, 12 Jan 2009 23:53:20 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lW1QHLMRRGm1; Mon, 12 Jan 2009 23:53:20 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 646751484F41;
	Mon, 12 Jan 2009 23:53:20 +0100 (CET)
User-Agent: KMail/1.10.92 (Linux/2.6.27-11-generic; KDE/4.1.85; i686; ; )
In-Reply-To: <20090112171045.GI10179@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105409>

"Shawn O. Pearce" <spearce@spearce.org> wrote
> Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> > torsdag 08 januari 2009 04:10:05 skrev Ryan Alberts:
> > > I have attached a small fix for when a git config has /r lines in the file.
> > > I have to admit that I do not usually submit patches to the open source
> > > community and I am not very familiar with the process :-)  Please, please,
> > > let me know if I can do something different next time!
> > 
> > Back to the patch. I think we should only ignore \r (not /r, but could say CR in
> > a comment) before an LF. 
> 
> I disagree; ignoring CR anyplace in the file should be fine, unless
> it is within a double quoted value, in which case it should use
> the same rule that \n would use within the same region.
> 
> ' ', \n, \t all act the same with regards to being (mostly) ignored
> whitespace.  \r is no different.  Especially for anyone crazy enough
> to still be using a Mac style formatted file, with only CRs in it.

Those are copied from in to out in the repo config parser today. Why
should ' \r' be treated differently? Just CR (FF, Ctrl-G etc) is garbage, 
but CRLF is a well established line terminator.

-- robin
