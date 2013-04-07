From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Sun, 7 Apr 2013 22:02:25 +0100
Message-ID: <20130407210225.GL2222@serenity.lan>
References: <CALkWK0kSF_q0o1V6BhO6X2jKAJQxNQ0c6MCi5o=jZdMwrba48g@mail.gmail.com>
 <20130407170201.GH2222@serenity.lan>
 <CALkWK0nSxfEzP7KHZxGjmBYD7pX5aa3CbMt1qAGrz4tonrtHhA@mail.gmail.com>
 <20130407175210.GI2222@serenity.lan>
 <CALkWK0n=vtPT7aFn9+T+bRxUpfXG+mYvV29YKC=_OAampQXJSA@mail.gmail.com>
 <20130407182112.GJ2222@serenity.lan>
 <5161BC33.8060707@web.de>
 <CALkWK0mBW63P0i6OhuujmAYO99pxLsS=ffFeqw8gBcBDgUpOPg@mail.gmail.com>
 <5161D3C5.9060804@web.de>
 <CALkWK0mNQesytoDwaVHb1cdY+EC=33WRCefpE03hwp_9za1Vbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 08 08:46:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UP5pT-0000sy-3k
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 08:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934349Ab3DGVCi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Apr 2013 17:02:38 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:38034 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934314Ab3DGVCh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Apr 2013 17:02:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B1927CDA580;
	Sun,  7 Apr 2013 22:02:36 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cd+-BKXcT+Kn; Sun,  7 Apr 2013 22:02:36 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id AB2CDCDA56C;
	Sun,  7 Apr 2013 22:02:28 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CALkWK0mNQesytoDwaVHb1cdY+EC=33WRCefpE03hwp_9za1Vbw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220376>

On Mon, Apr 08, 2013 at 02:19:10AM +0530, Ramkumar Ramachandra wrote:
> Jens Lehmann wrote:
> > * A link object has no unstaged counterpart that a file easily
> >   has. What would that mean for adding a submodule and then
> >   unstaging it (or how could we add a submodule unstaged, like
> >   you proposed in another email)?
> 
> Adding a submodule untracked (not unstaged) is possible, and is
> default: git clone gets the submodules, and you have to use git add to
> stage it.  I agree that you can't edit-link and have an unstaged
> change, but I really don't care about that.

I do.  I quite often use "git add -p" to sort things out and submodules
currently fit into that seamlessly: I can add the submodule and then
wait until later to commit it, without needing to either clone and
remember to "submodule add" later or commit and play with rebase.

Losing the ability to do that is a major usability regression as far as
I'm concerned.
