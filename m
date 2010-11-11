From: Jan Hudec <bulb@ucw.cz>
Subject: Re: is it kosher for pre-commit to change what's staged?
Date: Thu, 11 Nov 2010 20:26:49 +0100
Message-ID: <20101111192648.GE30870@efreet.light.src>
References: <20101110170819.GA3031@gnu.kitenet.net>
 <7v1v6thrzc.fsf@alter.siamese.dyndns.org>
 <20101110200650.GA13439@burratino>
 <20101110204542.GA11201@gnu.kitenet.net>
 <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 11 20:26:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGcnR-0007ZI-5v
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 20:26:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756140Ab0KKT0w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 14:26:52 -0500
Received: from cuda1.bluetone.cz ([212.158.128.5]:35933 "EHLO
	cuda1.bluetone.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754545Ab0KKT0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 14:26:51 -0500
X-ASG-Debug-ID: 1289503608-07057ba70001-QuoKaX
Received: from efreet.light.src (152-31-80-78.praha.adsl.tmcz.cz [78.80.31.152]) by cuda1.bluetone.cz with ESMTP id BcPfG0ZbrsgnmUBz; Thu, 11 Nov 2010 20:26:48 +0100 (CET)
X-Barracuda-Envelope-From: bulb@ucw.cz
X-Barracuda-Apparent-Source-IP: 78.80.31.152
Received: from bulb by efreet.light.src with local (Exim 4.72)
	(envelope-from <bulb@ucw.cz>)
	id 1PGcnJ-0007fm-1r; Thu, 11 Nov 2010 20:26:49 +0100
X-ASG-Orig-Subj: Re: is it kosher for pre-commit to change what's staged?
Content-Disposition: inline
In-Reply-To: <AANLkTi=W_hwU=3PTTqE4R8Cg5T=GMdMfBsKQ1YE0HWRe@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Barracuda-Connect: 152-31-80-78.praha.adsl.tmcz.cz[78.80.31.152]
X-Barracuda-Start-Time: 1289503608
X-Barracuda-URL: http://212.158.128.5:8000/cgi-mod/mark.cgi
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5232 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=4.5 KILL_LEVEL=4.8 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.2.46349
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161296>

On Thu, Nov 11, 2010 at 01:17:04 +0300, Dmitry Potapov wrote:
> On Wed, Nov 10, 2010 at 11:45 PM, Joey Hess <joey@kitenet.net> wrote:
> >
> > That said, since git commit stages the whole large file into the index,
> > which is the kind of expensive operation git-annex exists to avoid,
> > it's still not very practical to intercept the commit like that. What
> > I ideally need is a hook that is run before git commit stages anything.
> 
> Then maybe you should look at git smudge&clean filters. They perform
> conversation between the working tree and the index.  Though I am not
> sure how well they work with big files.

The problem point is not big files, but whether they can change the file mode
associated with the entry, since in this case the tree contains a file, but
index should contain a symlink. Looking at the documentation, there does not
seem to be a way to do it.

It might be worth adding support for it now we have a use-case.

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
