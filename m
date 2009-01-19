From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 10:11:58 -0800
Message-ID: <20090119181158.GH14053@spearce.org>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <7vwsct2xd1.fsf@gitster.siamese.dyndns.org> <20090119172939.GA14053@spearce.org> <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 19:41:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOycm-0001t6-7o
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:13:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbZASSL7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752222AbZASSL7
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:11:59 -0500
Received: from george.spearce.org ([209.20.77.23]:52142 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751080AbZASSL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:11:58 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2924638210; Mon, 19 Jan 2009 18:11:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> On Mon, Jan 19, 2009 at 12:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > ...  If we had
> > an inotify sort of daemon to keep the data current so the prompt
> > doesn't have to stat every source file on every display it would
> > be reasonable, but we don't have such a thing yet for Git.
> 
> Note that inotify is not recursive and is a hog if you ask it to
> monitor lots of dents.
> 
> I am not convinced that an inotify-enabled git is a good idea for
> anything but small/mid-sized project. And such don't need it either.
> 
> In other words, the kernel's cache will outperform any userland
> attempting to keep track of the fs via inotify.

*sigh*

I was hoping it would work well for the really huge repository case,
like WebKit, where the stats against the work tree just kill the
user space application.

But if its only good for smaller sets of files, then yea, just
doing the stats on demand is going to be better than anything an
inotify daemon might be able to offer.

-- 
Shawn.
