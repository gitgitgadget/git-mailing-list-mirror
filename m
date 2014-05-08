From: John Keeping <john@keeping.me.uk>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is
 misleading
Date: Thu, 8 May 2014 23:16:48 +0100
Message-ID: <20140508221648.GC19464@serenity.lan>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
 <20140508213806.GA19464@serenity.lan>
 <xmqqvbtg0w65.fsf@gitster.dls.corp.google.com>
 <20140508221024.GB19464@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 09 00:23:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WiWiv-0002If-Ba
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 00:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755862AbaEHWXZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 May 2014 18:23:25 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:53573 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbaEHWXY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2014 18:23:24 -0400
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 May 2014 18:23:24 EDT
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id 1B1D720198;
	Thu,  8 May 2014 23:16:54 +0100 (BST)
X-Quarantine-ID: <ruOZdEzXQP6v>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.001
X-Spam-Level: 
X-Spam-Status: No, score=-1.001 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_40=-0.001] autolearn=no
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ruOZdEzXQP6v; Thu,  8 May 2014 23:16:53 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id A201E200BD;
	Thu,  8 May 2014 23:16:50 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20140508221024.GB19464@serenity.lan>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248456>

On Thu, May 08, 2014 at 11:10:24PM +0100, John Keeping wrote:
> On Thu, May 08, 2014 at 02:58:58PM -0700, Junio C Hamano wrote:
> > John Keeping <john@keeping.me.uk> writes:
> > 
> > > On a slight tangent, I tried this in a fairly young repository and got
> > > this (with master at v2.0.0-rc2-4-g1dc51c6):
> > >
> > > $ git blame Makefile | head -5
> > > 7a3fc144 (John Keeping      2013-12-26 17:37:53 +0000   1) REL_VERSION = v0.2
> > > 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   2) 
> > > 5c9829f9 (John Keeping      2013-07-29 17:03:26 +0100   3) # The default target is...
> > > ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   4) all::
> > > ^f7fae99 (John Keeping      2013-03-24 17:14:40 +0000   5) 
> > >
> > > f7fae99 is the initial commit in the repository, so shouldn't the last
> > > two lines blame to that, not a non-existent ancestor?
> > 
> > It is not saying f7fae99^, is it?  It is debatable if it is correct
> > to mark the root commit as a boundary, but that is what it is
> > showing, I think.  In other words, "this line hasn't changed since
> > the inception of the project".
> 
> Yes, it's marking it as a boundary but I'm not convinced that's correct.

But it is intentional.  I get the output I expect if I use
`git blame --root`.
