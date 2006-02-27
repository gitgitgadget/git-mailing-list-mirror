From: Rutger Nijlunsing <rutger@nospam.com>
Subject: Re: NT directory traversal speed on 25K files on Cygwin
Date: Mon, 27 Feb 2006 19:45:44 +0100
Organization: M38c
Message-ID: <20060227184544.GB13195@nospam.com>
References: <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <20060226231701.GA11961@nospam.com> <4402C40D.2010805@op5.se>
Reply-To: git@wingding.demon.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@wingding.demon.nl, Christopher Faylor <me@cgf.cx>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 27 19:46:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDnNV-0000CK-7A
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 19:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751558AbWB0Spq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Feb 2006 13:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbWB0Spq
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Feb 2006 13:45:46 -0500
Received: from post-25.mail.nl.demon.net ([194.159.73.195]:40954 "EHLO
	post-25.mail.nl.demon.net") by vger.kernel.org with ESMTP
	id S1751515AbWB0Spp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Feb 2006 13:45:45 -0500
Received: from wingding.demon.nl ([82.161.27.36]:48693)
	by post-25.mail.nl.demon.net with esmtp (Exim 4.51)
	id 1FDnNQ-0005I4-Ow; Mon, 27 Feb 2006 18:45:44 +0000
Received: from rutger by wingding.demon.nl with local (Exim 4.60)
	(envelope-from <rutger@wingding.demon.nl>)
	id 1FDnNQ-0004Or-AQ; Mon, 27 Feb 2006 19:45:44 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <4402C40D.2010805@op5.se>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16873>

On Mon, Feb 27, 2006 at 10:19:09AM +0100, Andreas Ericsson wrote:
> Rutger Nijlunsing wrote:
> >On Sun, Feb 26, 2006 at 02:55:52PM -0500, Christopher Faylor wrote:
> >
> >>On Thu, Feb 23, 2006 at 03:07:07PM +0100, Alex Riesen wrote:
> >>
> >>>filesystem is slow and locked down, and exec-attribute is NOT really
> >>>useful even on NTFS (it is somehow related to execute permission and
> >>>open files.  I still cannot figure out how exactly are they related).
> >>
> >>Again, it's not clear if you're talking about Windows or Cygwin but
> >>under Cygwin, in the default configuration, the exec attribute means the
> >>same thing to cygwin as it does to linux.
> >
> >
> >I don't know about native Windows speed, but comparing NutCracker with
> >Cygwin on a simple 'find . | wc -l' already gives a clue that looking
> >at Cygwin to benchmark NT file inspection IO will give a skewed
> >picture:
> >
> 
> Well, naturally. Cygwin is a userland implementation of a sane 
> filesystem on top of a less sane one. File IO is bound to be slower when 
> one FS is emulated on top of another. I think cygwin users are aware of 
> this and simply accept the speed-for-sanity tradeoff. I know I would.

MKS NutCracker tries to solve the same issues as Cygwin tries to
solve. But maybe less sane, I don't know. But a simple 'find' is
several times faster than a Cygwin 'find'. Yes, very
unscientific. Just as unscientific as 'git is slow on Windows,
therefore Windows IO is slow'.

I'm not saying Cygwin is bad (actually, I'm installing on every
Windows PC I get my hand on ;), but using Cygwin for all file IO
instead of native Windows IO makes git a magnitude slower on Windows
than could-be. So a small portability layer with a function like
'given all filenames with all mtimes' might help, or we could look at
why Cygwin is slower in this case. Alas my Windows profiling skills
aren't that good...

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------------- eludias ed dse.nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------
