From: Mike Hommey <mh@glandium.org>
Subject: Re: 'setup_work_tree()' considered harmful
Date: Wed, 18 Jun 2008 11:05:27 +0200
Organization: glandium.org
Message-ID: <20080618090527.GA24254@glandium.org>
References: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 18 11:08:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8tdz-0001yW-3h
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 11:07:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbYFRJGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 05:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751962AbYFRJGw
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 05:06:52 -0400
Received: from vuizook.err.no ([194.24.252.247]:33302 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbYFRJGv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2008 05:06:51 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.67)
	(envelope-from <mh@glandium.org>)
	id 1K8tcc-00029L-L0; Wed, 18 Jun 2008 11:06:37 +0200
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1K8tbb-0006KB-WE; Wed, 18 Jun 2008 11:05:28 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85369>

On Mon, Jun 16, 2008 at 05:45:25PM -0700, Linus Torvalds wrote:
> ie note how it does one unnecessary "open()" less, but more importantly, 
> notice the difference between "/home/torvalds/kernel/.git/*" and ".git/*", 
> and realize that that second difference was the much more noticeable one.
> 
> And no, obviously the right fix is not to just comment out all of 
> "setup_work_tree()" (it will break stuff that depends on GIT_WORKTREE), 
> but I did that as a minimal example of showing what the bad effect of that 
> function is.
> 
> In general, I think we've gone in the wrong direction with a lot of the 
> "make_absolute_path" stuff. See above. 5% performance loss is not good.

Maybe using openat, fstatat, etc. when they are available, could be a
good thing, already, though it wouldn't help for other platforms.

Mike
