From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More on git over HTTP POST
Date: Sat, 2 Aug 2008 14:08:28 -0700
Message-ID: <20080802210828.GE24723@spearce.org>
References: <48938539.9060003@zytor.com> <20080802205702.GA24723@spearce.org> <alpine.LRH.1.10.0808022257470.25900@yvahk3.pbagnpgbe.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Sat Aug 02 23:09:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPOLy-0001R3-TO
	for gcvg-git-2@gmane.org; Sat, 02 Aug 2008 23:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751516AbYHBVI3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Aug 2008 17:08:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751522AbYHBVI3
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Aug 2008 17:08:29 -0400
Received: from george.spearce.org ([209.20.77.23]:48083 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbYHBVI3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Aug 2008 17:08:29 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8430838420; Sat,  2 Aug 2008 21:08:28 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.LRH.1.10.0808022257470.25900@yvahk3.pbagnpgbe.fr>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91181>

Daniel Stenberg <daniel@haxx.se> wrote:
> On Sat, 2 Aug 2008, Shawn O. Pearce wrote:
>
>> Well, over git:// (or any protocol that wraps git:// like ssh) we 
>> assume a full-duplex channel.  Some proxy systems are able to do such a 
>> channel. HTTP however does not offer it.
>
> Yes it does. The CONNECT method is used to get a full-duplex channel to a 
> remote site through a HTTP proxy. The downside with that is of course 
> that most proxies are setup to disallow CONNECT to other ports than 443 
> (the https default port).

Ah, yes.  CONNECT.  Very few servers wind up supporting it I think.

I know one very big company who cannot use or support Git because
Git over HTTP is too slow to be useful.  They support other tools
like Subversion instead.  :-|

Really we just need smart protocol support in half-duplex RPC like
hpa was going after.  Then it doesn't matter what we serialize it
into, almost any RPC system will be useful.  Of course the only
one that probably matters in practice is HTTP.

-- 
Shawn.
