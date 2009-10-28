From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: sp/smart-http topic
Date: Wed, 28 Oct 2009 07:47:26 -0700
Message-ID: <20091028144726.GA17602@spearce.org>
References: <7veiovly35.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 15:48:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N39of-0004L2-4l
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 15:48:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbZJ1OrX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 10:47:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754264AbZJ1OrX
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 10:47:23 -0400
Received: from george.spearce.org ([209.20.77.23]:41022 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994AbZJ1OrW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 10:47:22 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 023B3381D3; Wed, 28 Oct 2009 14:47:26 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7veiovly35.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131468>

Junio C Hamano <gitster@pobox.com> wrote:
> 
> * sp/smart-http (2009-10-14) 17 commits
>  - Smart fetch over HTTP: client side
...
> What's the doneness of this series?

Not done yet.  I want to respin once more before it hits next.

I've picked up a number of test related changes from Clemens
Buchacher and Tay Ray Chuan, plus some suggestions from the latter
were fixed up in the WebDAV code.

John "warthog9" Hawley and I were spending some time yesterday to
try to figure out why smart HTTP serving off kernel.org was giving
me only 300 KiB/sec during clone, but git-daemon was giving me 12
MiB/sec for the same server and repository.

Peff noticed the TCP windows for smart HTTP were ~16 KiB in size,
but with git-daemon were ~200 KiB on size.  John and I are pretty
sure this is the throughput problem, but we haven't found why the
window is so much smaller under smart HTTP.

We also need proper tests for smart HTTP.  I haven't had time to
write tests yet, and the ones that were proposed for t5540-http-push
aren't suitable because you have to run the test suite twice in
order to test both WebDAV and smart HTTP push for the same build.

-- 
Shawn.
