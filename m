From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: Project- vs. Package-Level Branching in Git
Date: Sat, 29 Jan 2011 20:42:59 +0100
Message-ID: <20110129194258.GE602@nibiru.local>
References: <14F4737F-E8E4-4E4E-A625-16CA63CF9EFF@shaggyfrog.com> <AANLkTinTRgzv0s9MTyM4TaOwVOmhwRckDqMfxrbsKVfm@mail.gmail.com> <15B7CA2E-C584-4563-B9E3-D80861CD9565@shaggyfrog.com> <m3tygt9xmn.fsf@localhost.localdomain>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 29 20:52:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PjGqm-0003hS-T3
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 20:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754715Ab1A2Twf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 14:52:35 -0500
Received: from caprica.metux.de ([82.165.128.25]:56388 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752634Ab1A2Twf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Jan 2011 14:52:35 -0500
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id p0TJn1ch009439
	for <git@vger.kernel.org>; Sat, 29 Jan 2011 20:49:01 +0100
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id p0TJmqfW009424
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:48:52 +0100
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id p0TJgxbj008865
	for git@vger.kernel.org; Sat, 29 Jan 2011 20:42:59 +0100
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <m3tygt9xmn.fsf@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-Terror: bin laden, kill bush, Briefbombe, Massenvernichtung, KZ, 
X-Nazi: Weisse Rasse, Hitlers Wiederauferstehung, 42, 
X-Antichrist: weg mit schaeuble, ausrotten, heiliger krieg, al quaida, 
X-Killer: 23, endloesung, Weltuntergang, 
X-Doof: wer das liest ist doof
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165669>

* Jakub Narebski <jnareb@gmail.com> wrote:

> That is only if lib{a,b,c} is _internal_ dependency.  In usual case
> project A might depend on library B *to be installed*, but it doesn't
> mean that source code of library B has to be in repository for project
> A.  And in usual case when project A depends on library B, it relies
> on library B public stable API (its build system might check if you
> have new enough library B installed).  If you depend on specific
> version of library, patched, that is your problem...

To make it more clear: 

At buildtime, a _package_ (not project!) "A" requires a already built
and installed package B in some sane place where the toolchain can find it.
On deployment of package "A", it has to be made sure that package "B"
is also deployed (eg. by a dependency-handling package manager).

These are two entirely separate stages in a software's lifecycle.
Buildtime and deployment dependencies may be different (even deployment
and runtime deps may differ).

> In the case of internal dependency, where you co-develop both project
> A and library B, it makes most sense to have separate repositories for
> A and for B, and tie them up using submodules or subtree merge.

I, personally, wouldn't use submodules - too complicated. Instead have
just one tree per package(-variant) and keep these completely separate.

> > I understand that Git was designed with a specific feature set in
> > mind -- to manage Linux kernel development -- and as such isn't
> > going to satisfy everyone. But I'm having trouble figuring out how
> > to integrate it as the SCM in my projects, which aren't organized
> > any differently than any other projects I've seen.
> 
> Well, you are braindamaged by your SCM ;-) ... just kidding.
> 
> Take a look how LibreOffice (Go-OOo), KDE, GNOME, GNU SourceMage Linux
> distribution organize their repositories -- all of them are highly
> modular / componentized.

Well, I wouldn't say LO is really modularized, yet. (but we're
working on that ...).
 

cu
-- 
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
