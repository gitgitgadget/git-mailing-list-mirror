From: Enrico Weigelt <weigelt@metux.de>
Subject: Re: [long] worktree setup cases
Date: Thu, 21 Oct 2010 20:51:32 +0200
Message-ID: <20101021185132.GB28700@nibiru.local>
References: <20101020085859.GA13135@do> <20101020190709.GB10537@burratino> <AANLkTimzfxJFz2FRVCJ7b4+icXMxpQGNo0WGm_BXzXNy@mail.gmail.com> <20101021033042.GA1891@burratino> <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
Reply-To: weigelt@metux.de
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 21 21:00:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P90NM-00078O-VS
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 21:00:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757406Ab0JUTA2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 15:00:28 -0400
Received: from caprica.metux.de ([82.165.128.25]:58976 "EHLO
	mailgate.caprica.metux.de" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755875Ab0JUTA1 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 15:00:27 -0400
Received: from mailgate.caprica.metux.de (localhost.localdomain [127.0.0.1])
	by mailgate.caprica.metux.de (8.14.4/8.14.4) with ESMTP id o9LJ1t0I008965
	for <git@vger.kernel.org>; Thu, 21 Oct 2010 21:01:56 +0200
Received: (from uucp@localhost)
	by mailgate.caprica.metux.de (8.14.4/8.14.4/Submit) with UUCP id o9LJ1LvR008937
	for git@vger.kernel.org; Thu, 21 Oct 2010 21:01:21 +0200
Received: (from weigelt@localhost)
	by nibiru.metux.de (8.12.10/8.12.10) id o9LIpWnW002794
	for git@vger.kernel.org; Thu, 21 Oct 2010 20:51:32 +0200
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <AANLkTikwApJ2EtJNiOZPHVrz6seJNP-zEqzH_b62ksLf@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159540>

* Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:

> > Example:
> >
> > =A0repo =A0 =A0 =A0 =A0 =A0 /tmp/git/.git
> > =A0starting cwd =A0 /tmp/git/.git/objects/pack
>=20
> OK it's considered a bare repo, so no worktree.

Not necessarily: if config tells it's a non-bare repo, we could
assume, the worktree is where core.worktree tells (which per
default is "../" - relative to gitdir).

But currently it seems to be implemented as you said: running
git-status from within gitdir tells:

    "fatal: This operation must be run in a work tree"

That's not really bad, but sometimes a bit inconvenient.

> Also the "relative to $GIT_DIR" may be confusing. If $GIT_DIR points
> to a file that points to a true repo, then to which one it is
> relative?

Despite the fact that I doubt the usefulness of an .git file at
all, it IMHO should be interpreted as an kind of userland symlink.


cu
--=20
----------------------------------------------------------------------
 Enrico Weigelt, metux IT service -- http://www.metux.de/

 phone:  +49 36207 519931  email: weigelt@metux.de
 mobile: +49 151 27565287  icq:   210169427         skype: nekrad666
----------------------------------------------------------------------
 Embedded-Linux / Portierung / Opensource-QM / Verteilte Systeme
----------------------------------------------------------------------
