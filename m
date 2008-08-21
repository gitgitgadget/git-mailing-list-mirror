From: Mike Hommey <mh@glandium.org>
Subject: Re: Push over WebDAV and hooks
Date: Thu, 21 Aug 2008 23:15:10 +0200
Organization: glandium.org
Message-ID: <20080821211510.GA18403@glandium.org>
References: <g8kgr5$e67$1@ger.gmane.org> <20080821201126.GY3483@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nikolai Prokoschenko <nikolai@prokoschenko.de>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 21 23:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWHWN-0000QK-Oo
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 23:16:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754302AbYHUVPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2008 17:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754228AbYHUVPk
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Aug 2008 17:15:40 -0400
Received: from vuizook.err.no ([194.24.252.247]:33266 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753678AbYHUVPj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2008 17:15:39 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1KWHV9-0005gd-6e; Thu, 21 Aug 2008 23:15:33 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1KWHUs-0004pK-Qz; Thu, 21 Aug 2008 23:15:10 +0200
Content-Disposition: inline
In-Reply-To: <20080821201126.GY3483@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93210>

On Thu, Aug 21, 2008 at 01:11:26PM -0700, Shawn O. Pearce wrote:
> Nikolai Prokoschenko <nikolai@prokoschenko.de> wrote:
> > I have a (bare) repository on my server. Since I need to access it from  
> > firewalled networks, I can't go with git protocol or SSH; I thought  
> > WebDAV is the way to go. However I've noticed that my hooks are not  
> > executed and could not really think of a way the could ever work, since  
> > WebDAV is essentially a virtual hard drive without any execution  
> > capability. So am I right, hooks aren't supposed to work with WebDAV and  
> > so I'd have to find a way to use SSH or git:// to push changes?
> 
> Correct.  Hooks can only be executed if you use SSH or git:// to push
> the changes, as there is no remote execution available via WebDAV.
> 
> That said if someone was really interested in this they could try
> to make hook CGIs and teach git-http-push how to execute them by
> sending a GET to the proper URL.  But then you are relying on the
> client to honor the hooks, and only newer clients (post that change)
> would support it.

One can surely set special PUT action scripts for some special files,
such as refs. But one needs to know how to write such action scripts
and to have enough apache/webserver priviledge to activate them.

Mike
