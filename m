From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] bash: offer to show (un)staged changes
Date: Mon, 19 Jan 2009 19:28:02 +0100
Organization: glandium.org
Message-ID: <20090119182802.GA10914@glandium.org>
References: <1232240184-10906-1-git-send-email-trast@student.ethz.ch> <7vwsct2xd1.fsf@gitster.siamese.dyndns.org> <20090119172939.GA14053@spearce.org> <46a038f90901191000i250326e7k2184c149b70fcc8d@mail.gmail.com> <20090119181158.GH14053@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 19 20:11:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOysj-0004pS-EC
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 19:29:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755375AbZASS2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 13:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755164AbZASS2b
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 13:28:31 -0500
Received: from vuizook.err.no ([85.19.221.46]:34147 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754156AbZASS2a (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 13:28:30 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=jigen)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LOyrA-0006h0-4V; Mon, 19 Jan 2009 19:28:18 +0100
Received: from mh by jigen with local (Exim 4.69)
	(envelope-from <mh@jigen>)
	id 1LOyqw-0002s1-QC; Mon, 19 Jan 2009 19:28:02 +0100
Content-Disposition: inline
In-Reply-To: <20090119181158.GH14053@spearce.org>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Spam-Status: (score 0.1): No, score=0.1 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106381>

On Mon, Jan 19, 2009 at 10:11:58AM -0800, Shawn O. Pearce wrote:
> Martin Langhoff <martin.langhoff@gmail.com> wrote:
> > On Mon, Jan 19, 2009 at 12:29 PM, Shawn O. Pearce <spearce@spearce.org> wrote:
> > > ...  If we had
> > > an inotify sort of daemon to keep the data current so the prompt
> > > doesn't have to stat every source file on every display it would
> > > be reasonable, but we don't have such a thing yet for Git.
> > 
> > Note that inotify is not recursive and is a hog if you ask it to
> > monitor lots of dents.
> > 
> > I am not convinced that an inotify-enabled git is a good idea for
> > anything but small/mid-sized project. And such don't need it either.
> > 
> > In other words, the kernel's cache will outperform any userland
> > attempting to keep track of the fs via inotify.
> 
> *sigh*
> 
> I was hoping it would work well for the really huge repository case,
> like WebKit, where the stats against the work tree just kill the
> user space application.

I was hoping something like that too, especially for cold cache cases,
after resuming from hibernation, for instance, in which case the kernel
cache is empty and inotify tracking will help know if something changed.

Mike
