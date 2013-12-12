From: Andreas Krey <a.krey@gmx.de>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 18:17:56 +0100
Message-ID: <20131212171756.GA6954@inner.h.apk.li>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com> <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Raymond <esr@thyrsus.com>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 18:18:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vr9tv-0001Hj-R1
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 18:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751886Ab3LLRSJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 12:18:09 -0500
Received: from continuum.iocl.org ([217.140.74.2]:51245 "EHLO
	continuum.iocl.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751530Ab3LLRSH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 12:18:07 -0500
Received: (from krey@localhost)
	by continuum.iocl.org (8.11.3/8.9.3) id rBCHHuQ07352;
	Thu, 12 Dec 2013 18:17:56 +0100
Content-Disposition: inline
In-Reply-To: <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
X-message-flag: What did you expect to see here?
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239229>

On Thu, 12 Dec 2013 08:42:25 +0000, Martin Langhoff wrote:
...
>  - run a cvs to git import at time T, resulting in repo G
>  - make commits to cvs repo
>  - run cvs to git import at time T1, pointed to G, and the import tool
> will only add the new commits found in cvs between T and T1.

I'm pretty sure that being given only G the incremental approach wouldn't
work - some extra state would be required.

But anyway, the replacement question is a) how fast the cvs-fast-export is
and b) whether its output is stable, that is, if the cvs repo C yields
a git repo G, will then C with a few extra commits yield G' where every
commit in G (as identified by its SHA1) is also in G', and G' additionally
contains the new commits that were made to the CVS repo.

If that is the case you effectively have an incremental mode, except that
it's not quite as fast.

At least that would be good enough for us - we ended up running a
filter-branch on the resulting history, and that takes some time anyway.

...
> The cvsimport+cvsps combo does a reasonable (though imperfect) job on
> 'flying fish' CVS histories _and that is what most projects evolved to
> use_. If other cvs import tools can handle crazy histories, hats off
> to them. But careful with knifing cvsps!

It won't magically disappear from your machine, and you have been warned. :-)

Andreas

-- 
"Totally trivial. Famous last words."
From: Linus Torvalds <torvalds@*.org>
Date: Fri, 22 Jan 2010 07:29:21 -0800
