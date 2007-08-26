From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: Re: `git-rev-parse master` not referred to by any ref?
Date: Sun, 26 Aug 2007 09:52:51 -0400
Message-ID: <20070826135251.GB20243@fieldses.org>
References: <20070826134521.GA20243@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 26 15:53:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPIY8-000662-Ln
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 15:53:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751437AbXHZNww (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 09:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXHZNww
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 09:52:52 -0400
Received: from mail.fieldses.org ([66.93.2.214]:43322 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbXHZNww (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 09:52:52 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1IPIXr-0005kW-6x
	for git@vger.kernel.org; Sun, 26 Aug 2007 09:52:51 -0400
Content-Disposition: inline
In-Reply-To: <20070826134521.GA20243@fieldses.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56686>

On Sun, Aug 26, 2007 at 09:45:21AM -0400, J. Bruce Fields wrote:
> Any idea how I got into this situation?:
> 
> 	git$ git rev-parse master
> 	warning: refname 'master' is ambiguous.
> 	407c0c87e15b3cf60347f4fc0bcdb4d239de4163
> 	~/local/git$ git for-each-ref | grep master
> 	32ebe844c689d6e13e9875a0feefedca8dc1c6eb commit refs/heads/master
> 	e413074f1293e907d94af99330f0dd632a78b01f commit refs/remotes/linux-nfs/master
> 	0058a33a8eb5a8bfcfc5f5e769a2517cff4b73f1 commit refs/remotes/origin/master
> 	git$ git for-each-ref | grep 407c0
> 	git$ 

Oops, found it:

	git$ cat .git/master
	407c0c87e15b3cf60347f4fc0bcdb4d239de4163

--b.
