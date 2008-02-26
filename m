From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: "Contributors never merge" and preserving history
Date: Tue, 26 Feb 2008 08:41:10 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802260831220.14934@woody.linux-foundation.org>
References: <slrnfs5pfh.lkc.jgoerzen@katherina.lan.complete.org> <alpine.LFD.1.00.0802251202380.14934@woody.linux-foundation.org> <slrnfs8749.prc.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Tue Feb 26 17:42:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU2sY-0005r8-83
	for gcvg-git-2@gmane.org; Tue, 26 Feb 2008 17:42:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbYBZQl1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 11:41:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753853AbYBZQl1
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 11:41:27 -0500
Received: from smtp1.linux-foundation.org ([207.189.120.13]:55290 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754018AbYBZQl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Feb 2008 11:41:26 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1QGfAlm010596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 26 Feb 2008 08:41:11 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m1QGfAFQ030413;
	Tue, 26 Feb 2008 08:41:10 -0800
In-Reply-To: <slrnfs8749.prc.jgoerzen@katherina.lan.complete.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-3.057 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75150>



On Tue, 26 Feb 2008, John Goerzen wrote:
> 
> I do have a question about the point you make above though.  I'm not
> quite understanding what you're saying here.  Technically speaking,
> the end result of a merge where you pulled from me would be identical
> to a merge where I pulled from you.

Yes. Except for where the end result is!

That's kind of the point. If you're developing a driver, your tree is the 
"driver tree". But if you keep pulling from me, now it's no longer a 
driver tree, it's a "driver and Linus' code tree".

> Moreover, say I'm pretty far down on the seniority list, kernel-wise.  
> Do you expect subsystem maintainers to honor a request from me to pull 
> from my tree, even if they've never heard of me before, or would you 
> think they'd only want git format-patch output?

It probably depends on the submaintainer. But you're absolutely right that 
at least early on, most of them will want just emailed patches. And for 
that, the "fetch + rebase" model is the better one.

HOWEVER.

What happens with me is that I personally prefer patches from people if

 - they are "single" patches at a time (not necessarily just one, but at 
   most a couple at a time)

 - I've really never worked with you before

but if you have a real patch-series with more than (say) 4-5 patches, and 
I've seen patches from you before, _and_ you have a clean git tree, at 
that point I'd more likely actually already prefer a git pull if you can 
just describe your patches well enough in the email.

[ Of course, when it comes to me personally, another big requirement is 
  that I don't feel like you're going past some subsystem maintainer.

  It's not that I am a strict hierarchical person, it's that when it comes 
  to most subsystems I often don't feel competent enough to make the 
  decision, so I want things to go through submaintainers simply because 
  it's an extra layer of "filters".

  So the things I'd take through git are things that are either really 
  obvious or things I'd take anyway for other reasons. Those things are 
  seldom "patch series", but it happens.. ]

So at least judging by my own preferences, I don't think the barrier to 
doing a git merge is actually all that high. The *biggest* barrier may 
indeed be that I can happily do a "git pull", but if it doesn't look like 
a clean topic branch, I'd probably undo it.

			Linus
