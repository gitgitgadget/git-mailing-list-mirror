From: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Subject: Re: Get rid of .git/branches/ and .git/remotes/?
Date: Tue, 22 Nov 2005 18:31:03 +0100
Message-ID: <200511221831.03954.Josef.Weidendorfer@gmx.de>
References: <Pine.LNX.4.63.0511201748440.14258@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0511200935081.13959@g5.osdl.org> <200511210026.30280.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Nov 22 18:33:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eebz6-0002Xo-1X
	for gcvg-git@gmane.org; Tue, 22 Nov 2005 18:31:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965026AbVKVRbI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 12:31:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVKVRbI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 12:31:08 -0500
Received: from mailout1.informatik.tu-muenchen.de ([131.159.0.18]:947 "EHLO
	mailout1.informatik.tu-muenchen.de") by vger.kernel.org with ESMTP
	id S965026AbVKVRbG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Nov 2005 12:31:06 -0500
Received: from dhcp-3s-40.lrr.in.tum.de (dhcp-3s-40.lrr.in.tum.de [131.159.35.40])
	by mail.in.tum.de (Postfix) with ESMTP id 3C8B72776
	for <git@vger.kernel.org>; Tue, 22 Nov 2005 18:31:05 +0100 (MET)
To: git@vger.kernel.org
User-Agent: KMail/1.9
In-Reply-To: <200511210026.30280.Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new/sophie/sophos at mailrelay1.informatik.tu-muenchen.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12558>

On Monday 21 November 2005 00:26, Josef Weidendorfer wrote:
> On Sunday 20 November 2005 19:09, Linus Torvalds wrote:
> > 	[branches.origin]
> > 		url = master.kernel.org:/pub/scm/git/git.git
> > 		pull = master:origin
> 
> Two things:
> * base names are case insensitive. Repository shortcuts are case
> sensitive (and head names, too)
> * to get rid of .git/branches/XXX, XXX has to be allowed as
> base name. But XXX can contain anything a head name can (including ".").
> 
> Not really a problem. Use the ' for ' syntax:
> 
> [remotes]
> 	url = master.kernel.org:/pub/scm/git/git.git for origin
> 	pull = master:origin for origin
> 
> Not really nice. We can not have "for" as head name.

What about another syntax for multivalue vars?
Proposed syntax:

  [remote:origin]
    url = master.kernel.org:/pub/scm/git/git.git
    pull = master:origin

For this, the parser could return
    remote.url = master.kernel.org:/pub/scm/git/git.git for origin
    remote.pull = master:origin for origin

By introducing such a scheme, multi-value vars would fit perfectly
for use for .git/remotes or .git/branches.

Josef
